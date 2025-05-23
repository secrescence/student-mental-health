import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/screens/questionnaire_screen/question.dart';
import 'package:student_mental_health/screens/questionnaire_screen/result_categories.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Questionnaire extends StatefulWidget {
  const Questionnaire({super.key});

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
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
        leading: IconButton(
          onPressed: () {
            setState(() {
              currentQuestionIndex--;
            });
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF000000),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            _questionWidget(),
            const SizedBox(height: 30),
            _answerList(),
          ],
        ),
      ),
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Sofia Pro',
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
              children: <TextSpan>[
                const TextSpan(text: 'Question '),
                TextSpan(
                    text:
                        '${currentQuestionIndex + 1}/${questionList.length.toString()}',
                    style: const TextStyle(color: primaryColor)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            questionList[currentQuestionIndex].questionText,
            style: const TextStyle(
              color: primaryColor,
              fontFamily: 'Sofia Pro',
              fontSize: 40,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
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
      margin: const EdgeInsets.symmetric(vertical: 8.5, horizontal: 20),
      height: 60,
      child: ElevatedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(
              color: Colors.black87,
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            isSelected ? primaryColor : Colors.white,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
              isSelected ? Colors.white : Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        onPressed: () async {
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
            if (selectedAnswer != null) {
              // print(
              //     'selectedAnswer: ${selectedAnswer!.answerText} and category: ${answer.category} and score: ${answer.score} and total scrore is: $totalScore');

              //if last question then save the result
              if (currentQuestionIndex == questionList.length - 1) {
                setState(() {
                  grandMean = totalScore / 36;
                  categoryNonacceptanceMEAN = categoryNonacceptance / 6;
                  categoryGoalsMEAN = categoryGoals / 5;
                  categoryImpulseMEAN = categoryImpulse / 6;
                  categoryAwarenessMEAN = categoryAwareness / 6;
                  categoryStrategiesMEAN = categoryStrategies / 8;
                  categoryClarityMEAN = categoryClarity / 5;
                });
                await DatabaseService(
                        uid: FirebaseAuth.instance.currentUser!.uid)
                    .questionnaireResult(
                  grandMean,
                  categoryNonacceptanceMEAN,
                  categoryGoalsMEAN,
                  categoryImpulseMEAN,
                  categoryAwarenessMEAN,
                  categoryStrategiesMEAN,
                  categoryClarityMEAN,
                );

                //user progress in the app
                await DatabaseService(
                        uid: FirebaseAuth.instance.currentUser!.uid)
                    .userDoneWithQuestionnaire();
                await DatabaseService(
                        uid: FirebaseAuth.instance.currentUser!.uid)
                    .dateDoneWithQuestionnaire();
                //what priority is the user
                if (grandMean > 4) {
                  await DatabaseService(
                          uid: FirebaseAuth.instance.currentUser!.uid)
                      .isResultHighOrMidOrLow('isHighPriority');
                  if (!mounted) return;
                  await DatabaseService(
                          uid: FirebaseAuth.instance.currentUser!.uid)
                      .appointUser(context, '1');
                } else if (grandMean >= 3.5 && grandMean <= 3.9) {
                  await DatabaseService(
                          uid: FirebaseAuth.instance.currentUser!.uid)
                      .isResultHighOrMidOrLow('isMidPriority');
                  if (!mounted) return;
                  await DatabaseService(
                          uid: FirebaseAuth.instance.currentUser!.uid)
                      .appointUser(context, '2');
                } else if (grandMean < 3.49) {
                  await DatabaseService(
                          uid: FirebaseAuth.instance.currentUser!.uid)
                      .isResultHighOrMidOrLow('isLowPriority');
                }
                if (!mounted) return;
                nextScreenReplace(context, const ResultCategories());
              } else {
                Future.delayed(const Duration(milliseconds: 800), () {
                  setState(() {
                    selectedAnswer = null;
                    currentQuestionIndex++;
                  });
                });
              }
            }
          }
        },
        child: Text(
          answer.answerText,
          style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Sofia Pro',
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
