import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/screens/counseling_page.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/screens/questionnaire_screen/question.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  double grandMean = 0;
  double totalScore = 0;
  double categoryNonacceptance = 0;
  double categoryNonacceptanceMEAN = 0;
  double categoryGoals = 0;
  double categoryGoalsMEAN = 0;
  double categoryImpulse = 0;
  double categoryImpulseMEAN = 0;
  double categoryAwareness = 0;
  double categoryAwarenessMEAN = 0;
  double categoryStrategies = 0;
  double categoryStrategiesMEAN = 0;
  double categoryClarity = 0;
  double categoryClarityMEAN = 0;
  Answer? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      //backgroundColor: const Color.fromARGB(255, 5, 50, 80),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _questionWidget(),
          _answerList(),
          _nextButton(),
        ]),
      ),
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Question ${currentQuestionIndex + 1}/${questionList.length.toString()}",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: const Color(0xFF50B2B5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            questionList[currentQuestionIndex].questionText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
          .map(
            (ans) => _answerButton(ans),
          )
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: isSelected ? const Color(0xFF50B2B5) : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () {
          if (selectedAnswer == null) {
            switch (answer.category) {
              case 'NONACCEPTANCE':
                {
                  categoryNonacceptance += answer.score;
                }
                break;
              case 'GOALS':
                {
                  categoryGoals += answer.score;
                }
                break;
              case 'IMPULSE':
                {
                  categoryImpulse += answer.score;
                }
                break;
              case 'AWARENESS':
                {
                  categoryAwareness += answer.score;
                }
                break;
              case 'STRATEGIES':
                {
                  categoryStrategies += answer.score;
                }
                break;
              case 'CLARITY':
                {
                  categoryClarity += answer.score;
                }
                break;
              default:
            }
            setState(() {
              totalScore += answer.score;
              selectedAnswer = answer;
            });
          }
        },
        child: Text(answer.answerText),
      ),
    );
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          backgroundColor: const Color(0xFF1D3557),
        ),
        onPressed: () {
          if (isLastQuestion) {
            //display score
            setState(() {
              grandMean = totalScore / 36;
              categoryNonacceptanceMEAN = categoryNonacceptance / 6;
              categoryGoalsMEAN = categoryGoals / 5;
              categoryImpulseMEAN = categoryImpulseMEAN / 6;
              categoryAwarenessMEAN = categoryAwareness / 6;
              categoryStrategiesMEAN = categoryStrategies / 8;
              categoryClarityMEAN = categoryClarity / 5;
              DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .questionnaireResult(
                      grandMean,
                      categoryNonacceptanceMEAN,
                      categoryGoalsMEAN,
                      categoryImpulseMEAN,
                      categoryAwarenessMEAN,
                      categoryStrategiesMEAN,
                      categoryClarityMEAN);
            });
            showGeneralDialog(
                context: context,
                barrierDismissible: false,
                barrierColor: Colors.white,
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return _showScoreDialog();
                });
          } else {
            //next question
            setState(() {
              selectedAnswer = null;
              currentQuestionIndex++;
            });
          }
        },
        child: Text(isLastQuestion ? "Submit" : "Next"),
      ),
    );
  }

  _showScoreDialog() {
    // bool _showText = true;
    // Future.delayed(const Duration(seconds: 2)).then((value) {
    //   setState(() {
    //     _showText = false;
    //   });
    // });
    // bool articleVids = false;
    // bool counseling = false;
    String resultMessage = '';
    bool articleButtonVisible = false;
    bool counselingButtonVisible = false;

    if (grandMean >= 4) {
      resultMessage = 'We found out that you need help. We suggest that...';
      counselingButtonVisible = !counselingButtonVisible;
    } else if (grandMean >= 3.5 && grandMean <= 3.9) {
      resultMessage = 'You need to counseling owrayt';
      counselingButtonVisible = !counselingButtonVisible;
      articleButtonVisible = !articleButtonVisible;
    } else if (grandMean <= 3.49) {
      resultMessage = 'we suggest you Articles lang';
      articleButtonVisible = !articleButtonVisible;
    }
    //String title = isPassed ? "Passed " : "Failed";
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 10,
          height: MediaQuery.of(context).size.height - 80,
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Result',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
              const SizedBox(height: 15),
              Text(
                resultMessage,
                style: const TextStyle(
                    color: Color(0xFF50B2B5),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //go to Articles Vids
                  Visibility(
                    visible: articleButtonVisible,
                    child: Container(
                      padding: articleButtonVisible && !counselingButtonVisible
                          ? const EdgeInsets.only(left: 50)
                          : null,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(85, 40),
                            backgroundColor: const Color(0xFF1D3557),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19),
                            )),
                        child: const Text('Articles and Videos'),
                        onPressed: () {
                          nextScreen(context, const CounselingPage());
                          // setState(() {
                          //   currentQuestionIndex = 0;
                          //   totalScore = 0;
                          //   grandMean = 0;
                          //   categoryAwareness = 0;
                          //   categoryClarity = 0;
                          //   categoryImpulse = 0;
                          //   categoryGoals = 0;
                          //   categoryNonacceptance = 0;
                          //   categoryStrategies = 0;
                          //   selectedAnswer = null;
                          // });
                        },
                      ),
                    ),
                  ),

                  //go to Counselling
                  Visibility(
                    visible: true,
                    child: Container(
                      padding: counselingButtonVisible && !articleButtonVisible
                          ? const EdgeInsets.only(right: 50)
                          : null,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(85, 40),
                            backgroundColor: const Color(0xFF1D3557),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19),
                            )),
                        child: const Text('Counseling'),
                        onPressed: () {
                          nextScreen(context, const CounselingPage());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    // return AlertDialog(
    //   title: Text(
    //     "Score is $totalScore grand mean $grandMean",
    //     style: const TextStyle(color: Colors.greenAccent),
    //   ),
    //   content: ElevatedButton(
    //     child: const Text("Restart"),
    //     onPressed: () {
    //       Navigator.pop(context);
    //       setState(() {
    //         currentQuestionIndex = 0;
    //         totalScore = 0;
    //         categoryAwareness = 0;
    //         categoryClarity = 0;
    //         categoryImpulse = 0;
    //         categoryGoals = 0;
    //         categoryNonacceptance = 0;
    //         categoryStrategies = 0;
    //         selectedAnswer = null;
    //       });
    //     },
    //   ),
    // );
  }
}
