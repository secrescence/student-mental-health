import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/screens/questionnaire_screen/result_overall.dart';
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

  //category description
  String nonAcceptanceDescription =
      'tendency to have negative secondary emotional responses to one\'s negative emotions, or nonacceptingreactions to one\'s distress.';
  String goalsDescription =
      'difficulties concentrating and accomplishing tasks when experiencing negative emotions.';
  String impulseDescription =
      'difficulties remaining in control of one\'s behavior when experiencing negative emotions.';
  String awarenessDescription =
      'tendency to attend to and acknowledge emotions.';
  String strategiesDescription =
      'the belief that there is little that can be done to regulate emotions effectively, once an individual is upset.';
  String clarityDescription =
      'the extent to which individuals know (and are clear about) the emotions they are experiencing.';

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 25),
                child: Text('Results',
                    style: TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                          text:
                              'This test measure the level of your awareness, acceptance of emotion, understanding and your ability to act in desired ways regardless of your emotional state. The highest score result in the category: ',
                          style: const TextStyle(
                            fontFamily: 'Sofia Pro',
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'NONACCEPTANCE, ',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                              ),
                            ),
                            const TextSpan(
                              text: 'GOALS, ',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                              ),
                            ),
                            const TextSpan(
                              text: 'IMPULSE, ',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                              ),
                            ),
                            const TextSpan(
                              text: 'AWARENESS, ',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                              ),
                            ),
                            const TextSpan(
                              text: 'STRATEGIES, ',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                              ),
                            ),
                            const TextSpan(
                              text: 'CLARITY ',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                              ),
                            ),
                            const TextSpan(
                              text: 'is the certain area you should work on.',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                              ),
                            ),
                            const TextSpan(text: '\n\n'),
                            const TextSpan(
                                text: 'In your case your highest category is '),
                            TextSpan(
                              text: highestCategory?.toUpperCase(),
                              style: const TextStyle(
                                color: phoneNumberInOtpColor,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  '. We have gathered resources you can explore later on.',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, left: 10, bottom: 0),
                child: SfCircularChart(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  tooltipBehavior: _tooltipBehavior,
                  onTooltipRender: (tooltipArgs) {
                    tooltipArgs.text = tooltipArgs.text!.split(' ')[0];
                  },
                  title: ChartTitle(
                      borderWidth: 8,
                      text: 'Visual Summary',
                      alignment: ChartAlignment.near,
                      textStyle: const TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
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
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.8),
                          )),
                      enableTooltip: true,
                      maximumValue: 5,
                      radius: '100%',
                      innerRadius: '10%',
                      cornerStyle: CornerStyle.bothCurve,
                      trackOpacity: 0.7,
                      gap: '3%',
                      selectionBehavior: SelectionBehavior(
                          enable: true, unselectedOpacity: 0.4),
                      onPointTap: (pointInteractionDetails) {},
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 35, bottom: 20, top: 20),
                child: const Text('Find out more about the categories:',
                    style: TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              ExpandableNotifier(
                child: Card(
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: ScrollOnExpand(
                    child: ExpandablePanel(
                        theme: const ExpandableThemeData(
                          iconSize: 30,
                          iconColor: primaryColor,
                          expandIcon: Icons.arrow_right,
                          collapseIcon: Icons.arrow_drop_down,
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToCollapse: true,
                          tapBodyToExpand: true,
                        ),
                        header: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Category Description',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        collapsed: const SizedBox.shrink(),
                        expanded: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                categoryDescription('Nonacceptance\n\n',
                                    '$nonAcceptanceDescription\n'),
                                categoryDescription(
                                    'Goals\n\n', '$goalsDescription\n'),
                                categoryDescription(
                                    'Impulse\n\n', '$impulseDescription\n'),
                                categoryDescription(
                                    'Awareness\n\n', '$awarenessDescription\n'),
                                categoryDescription('Strategies\n\n',
                                    '$strategiesDescription\n'),
                                categoryDescription(
                                    'Clarity\n\n', '$clarityDescription\n'),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              CustomButton(
                text: 'Next',
                onPressed: () async {
                  await DatabaseService(
                          uid: FirebaseAuth.instance.currentUser?.uid)
                      .userDoneWithResults();
                  if (!mounted) return;
                  nextScreen(context, const ResultOverall());
                },
                color: phoneFieldButtonColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryDescription(String title, String description) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontFamily: 'Sofia Pro',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: description,
            style: const TextStyle(
              fontFamily: 'Sofia Pro',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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

  //end of class
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
