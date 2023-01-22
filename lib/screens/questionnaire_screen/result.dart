import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  List<QuestionnaireResult>? _results;

  @override
  void initState() {
    _getResults().then((results) {
      setState(() {
        _results = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 35),
              height: MediaQuery.of(context).size.height * 0.6,
              child: SfCircularChart(
                title: ChartTitle(
                    text: 'Your Results',
                    textStyle: const TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    )),
                legend: Legend(
                  textStyle: const TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  iconHeight: 23,
                  iconWidth: 23,
                  position: LegendPosition.bottom,
                ),
                series: <CircularSeries>[
                  RadialBarSeries<QuestionnaireResult, String>(
                    dataSource: _results,
                    xValueMapper: (QuestionnaireResult result, _) =>
                        result.category,
                    yValueMapper: (QuestionnaireResult result, _) =>
                        result.score,
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.8),
                        )),
                    enableTooltip: true,
                    maximumValue: 5,
                    radius: '90%',
                    innerRadius: '10%',
                    cornerStyle: CornerStyle.bothCurve,
                    trackOpacity: 0.7,
                    gap: '3%',
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ",
                style: TextStyle(
                  fontFamily: 'Sofia Pro',
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Continue',
              onPressed: () {},
              color: phoneFieldButtonColor,
            )
          ],
        ),
      ),
    );
  }

  Future<List<QuestionnaireResult>?> _getResults() async {
    final Map<String, dynamic>? data =
        await DatabaseService(uid: FirebaseAuth.instance.currentUser?.uid)
            .fetchQuestionnaireResult();
    if (data != null) {
      return [
        QuestionnaireResult('Nonacceptance',
            twoDecimalPlace(data['categoryNonacceptanceMEAN'])),
        QuestionnaireResult(
            'Goals', twoDecimalPlace(data['categoryGoalsMEAN'])),
        QuestionnaireResult(
            'Impulse', twoDecimalPlace(data['categoryImpulseMEAN'])),
        QuestionnaireResult(
            'Awareness', twoDecimalPlace(data['categoryAwarenessMEAN'])),
        QuestionnaireResult(
            'Strategies', twoDecimalPlace(data['categoryStrategiesMEAN'])),
        QuestionnaireResult(
            'Clarity', twoDecimalPlace(data['categoryClarityMEAN'])),
      ];
    } else {
      return null;
    }
  }

  twoDecimalPlace(double value) {
    String cut = value.toStringAsFixed(2);
    double cutDouble = double.parse(cut);
    return cutDouble;
  }
}

class QuestionnaireResult {
  QuestionnaireResult(this.category, this.score);
  final String category;
  final double score;
}
