import 'package:flutter/material.dart';
import 'package:student_mental_health/screens/questionnaire_screen/question.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

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
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Sofia Pro',
                fontSize: 23,
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
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              questionList[currentQuestionIndex].questionText,
              style: const TextStyle(
                color: primaryColor,
                fontFamily: 'Sofia Pro',
                fontSize: 38,
                fontWeight: FontWeight.w500,
              ),
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
      width: 300,
      margin: const EdgeInsets.symmetric(vertical: 10),
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
}
