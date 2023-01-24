import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/screens/auth/onboarding.dart';
import 'package:student_mental_health/screens/questionnaire_screen/result_overall.dart';
import 'package:student_mental_health/screens/welcome_screen/your_privacy_matters.dart';
import 'package:student_mental_health/service/auth_service.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:core';

class ResultCategories extends StatefulWidget {
  const ResultCategories({super.key});

  @override
  State<ResultCategories> createState() => _ResultCategoriesState();
}

class _ResultCategoriesState extends State<ResultCategories> {
  List<QuestionnaireResult>? _results;
  TooltipBehavior? _tooltipBehavior;
  String? highestCategory;

  @override
  void initState() {
    _getResults().then((results) {
      setState(() {
        _results = results;
      });
    });
    _tooltipBehavior = TooltipBehavior(enable: true);
    _getHighestCategory().then((category) {
      setState(() {
        highestCategory = category;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        //   // automaticallyImplyLeading: false,
        //   leading: IconButton(
        //     onPressed: () {
        //       AuthService().signOut().then(
        //           (value) => nextScreenReplace(context, const Onboarding()));
        //     },
        //     icon: const Icon(
        //       Icons.logout,
        //       color: Color(0xFF000000),
        //     ),
        //   ),
        // ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
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
                  iconHeight: 19,
                  iconWidth: 19,
                  position: LegendPosition.right,
                  padding: 7,
                  itemPadding: 12,
                  isResponsive: true,
                ),
                tooltipBehavior: _tooltipBehavior,
                onTooltipRender: (tooltipArgs) {
                  tooltipArgs.text = tooltipArgs.text!.split(' ')[0];
                },
                margin: const EdgeInsets.symmetric(horizontal: 10),
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
                    radius: '100%',
                    innerRadius: '10%',
                    cornerStyle: CornerStyle.bothCurve,
                    trackOpacity: 0.7,
                    gap: '3%',
                    selectionBehavior:
                        SelectionBehavior(enable: true, unselectedOpacity: 0.4),
                    onPointTap: (pointInteractionDetails) {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                '$highestCategory is your highest category',
                style: const TextStyle(
                  fontFamily: 'Sofia Pro',
                  fontSize: 19,
                ),
              ),
            ),
            const SizedBox(height: 100),
            CustomButton(
              text: 'Next',
              onPressed: () {
                nextScreen(context, const ResultOverall());
              },
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
            .getQuestionnaireResult();
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

  Future _getHighestCategory() async {
    final Map<String, dynamic>? data =
        await DatabaseService(uid: FirebaseAuth.instance.currentUser?.uid)
            .getQuestionnaireResult();
    if (data != null) {
      double nonacceptance = twoDecimalPlace(data['categoryNonacceptanceMEAN']);
      double goals = twoDecimalPlace(data['categoryGoalsMEAN']);
      double impulse = twoDecimalPlace(data['categoryImpulseMEAN']);
      double awareness = twoDecimalPlace(data['categoryAwarenessMEAN']);
      double strategies = twoDecimalPlace(data['categoryStrategiesMEAN']);
      double clarity = twoDecimalPlace(data['categoryClarityMEAN']);

      List<double> categories = [
        nonacceptance,
        goals,
        impulse,
        awareness,
        strategies,
        clarity
      ];

      Map<String, double> categoryValues = {
        "Nonacceptance": nonacceptance,
        "Goals": goals,
        "Impulse": impulse,
        "Awareness": awareness,
        "Strategies": strategies,
        "Clarity": clarity
      };

      double maxValue = categories.reduce((a, b) => a > b ? a : b);
      String maxCategory = categoryValues.keys
          .firstWhere((key) => categoryValues[key] == maxValue);
      return maxCategory;
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

class MaxValueWithCategory {
  final double maxValue;
  final String maxCategory;

  MaxValueWithCategory(this.maxValue, this.maxCategory);
}

class QuestionnaireResult {
  QuestionnaireResult(this.category, this.score);
  final String category;
  final double score;
}
