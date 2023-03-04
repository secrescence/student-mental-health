import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StudentsResults extends StatefulWidget {
  const StudentsResults({super.key});

  @override
  State<StudentsResults> createState() => _StudentsResultsState();
}

class _StudentsResultsState extends State<StudentsResults> {
  Stream<QuerySnapshot>? userAppointmentStream;
  String priorityView = '';
  String userIdView = '';
  String fullNameView = '';
  String dateOfAppointmentDocId = '';
  String studentIdView = '';
  String userPriorityView = '';
  String grandMeanView = '';

  bool viewStudentResult = true;
  bool listViewStudentResult = true;

  int currentIndex = 0;
  final List<String> labels = ['Pending', 'Ongoing', 'Completed'];

  List<StudentResultData>? _results;
  TooltipBehavior? _tooltipBehavior;
  String? highestCategory;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);

    getData();
    super.initState();
  }

  getData() async {
    await DatabaseService().getUserAppointment().then((snapshot) {
      setState(() {
        userAppointmentStream = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: adminContentBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Student\'s Results',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sofia Pro'),
          ),
        ),
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //     onPressed: (() {
        //       //TODO: Add back button functionality
        //     }),
        //     icon: const Icon(
        //       Icons.arrow_back_ios,
        //       color: Color(0xFF000000),
        //     )),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            // margin: const EdgeInsets.symmetric(vertical: 10),
            child: StreamBuilder<QuerySnapshot>(
              stream: userAppointmentStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitChasingDots(
                      color: primaryColor,
                      size: 50,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }

                return ListView(
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    // final String fullName =
                    //     '${data['firstName']} ${data['lastName']}';
                    if (data['status'] == null) {
                      return const SizedBox.shrink();
                    }

                    final String userId = data['appointedUser'];
                    final String priority = data['userAppointedPriority'];

                    return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return const Center(
                            child: SpinKitChasingDots(
                              color: primaryColor,
                              size: 50,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }

                        Map<String, dynamic> userData =
                            snapshot.data!.data() as Map<String, dynamic>;

                        String fullName =
                            '${userData['firstName']} ${userData['lastName']}';
                        String studentId = userData['studentId'];
                        String userPriority;
                        if (userData['priority'] == 'high priority') {
                          userPriority = 'High';
                        } else if (userData['priority'] == 'mid priority') {
                          userPriority = 'Mid';
                        } else {
                          userPriority = 'Low';
                        }

                        //stream for the student's result
                        return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(userId)
                                .collection('questionnaireResult')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData ||
                                  snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                return const Center(
                                  child: SpinKitChasingDots(
                                    color: primaryColor,
                                    size: 50,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: Text('Something went wrong'),
                                );
                              }

                              final List<Map<String, dynamic>>
                                  studentResultData = snapshot.data!.docs
                                      .map((doc) =>
                                          doc.data() as Map<String, dynamic>)
                                      .toList();

                              // grandMeanView = studentResultData[1]['grandMean'];

                              return Visibility(
                                visible: viewStudentResult,
                                replacement: Visibility(
                                  visible: listViewStudentResult,
                                  replacement: viewStudentResultWidget(),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 20),
                                            child: IconButton(
                                                onPressed: () => setState(() {
                                                      viewStudentResult = true;
                                                    }),
                                                icon: const Icon(
                                                    Icons.arrow_back_ios)),
                                          ),
                                          const Spacer(),
                                          const Text(
                                            'Result\'s History',
                                            style: TextStyle(
                                              fontFamily: 'Sofia Pro',
                                              fontSize: 20,
                                            ),
                                          ),
                                          const SizedBox(width: 150),
                                          const Spacer(flex: 1),
                                        ],
                                      ),
                                      const Divider(),
                                      SizedBox(
                                          width: 1350,
                                          height: 650,
                                          child: ListView.builder(
                                            itemCount: studentResultData.length,
                                            itemBuilder: (context, index) {
                                              Map<String, dynamic> data =
                                                  studentResultData[index];
                                              grandMeanView = data['grandMean']
                                                  .toStringAsFixed(1);

                                              return ListTile(
                                                onTap: () async {
                                                  setState(() {
                                                    listViewStudentResult =
                                                        false;
                                                    fullNameView = fullName;
                                                    userIdView = userId;
                                                    priorityView = priority;
                                                    dateOfAppointmentDocId =
                                                        document.id;
                                                    studentIdView = studentId;
                                                    userPriorityView =
                                                        userPriority;
                                                  });

                                                  List<StudentResultData>?
                                                      results =
                                                      await _getResults(
                                                          userIdView);
                                                  setState(() {
                                                    _results = results;
                                                  });

                                                  String category =
                                                      await _getHighestCategory(
                                                          userIdView);
                                                  setState(() {
                                                    highestCategory = category;
                                                  });
                                                },
                                                title: Row(
                                                  children: [
                                                    const SizedBox(width: 30),
                                                    Text(
                                                      data['dateAnswered'],
                                                      style: const TextStyle(
                                                        fontFamily: 'Sofia Pro',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    const SizedBox(width: 30),
                                                  ],
                                                ),
                                                trailing: const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 50),
                                                  child: Text(
                                                    'view',
                                                    style: TextStyle(
                                                      fontFamily: 'Sofia Pro',
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          )),
                                    ],
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        //TODO to be implemented

                                        setState(() {
                                          viewStudentResult = false;
                                        });
                                      },
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5),
                                      title: Row(
                                        children: [
                                          const SizedBox(width: 50),
                                          Text(fullName,
                                              style: const TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          const Spacer(),
                                          const SizedBox(width: 50),
                                        ],
                                      ),
                                      subtitle: Row(
                                        children: [
                                          const SizedBox(width: 50),
                                          Text(
                                            priority,
                                            style: TextStyle(
                                              fontFamily: 'Sofia Pro',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: priority == 'high priority'
                                                  ? Colors.red
                                                  : priority == 'low priority'
                                                      ? Colors.green
                                                      : Colors.amber,
                                            ),
                                          ),
                                          const SizedBox(width: 50),
                                        ],
                                      ),
                                      trailing: const Padding(
                                        padding: EdgeInsets.only(right: 50),
                                        child: Text(
                                          'view',
                                          style: TextStyle(
                                            fontFamily: 'Sofia Pro',
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      height: 0,
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget viewStudentResultWidget() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: IconButton(
                  onPressed: () => setState(() {
                        listViewStudentResult = true;
                      }),
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
            const Spacer(),
            Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: ElevatedButton(
                    style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all<Size>(const Size(85, 35)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          phoneFieldButtonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    onPressed: () {
                      DateTime currentDate = DateTime.now();
                      String formattedDate =
                          DateFormat('MM-dd-yyyy').format(currentDate);
                      print(formattedDate); // output: 02-18-2023
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.print, size: 16),
                        SizedBox(width: 5),
                        Text(
                          'Print',
                          style:
                              TextStyle(fontSize: 14, fontFamily: 'Sofia Pro'),
                        ),
                      ],
                    ))),
            const SizedBox(width: 20),
          ],
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 30, top: 10),
          child: Text(
            'Name: $fullNameView',
            style: const TextStyle(
              fontFamily: 'Sofia Pro',
              fontSize: 19,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 30, top: 10),
          child: Text(
            'Student ID: $studentIdView',
            style: const TextStyle(
              fontFamily: 'Sofia Pro',
              fontSize: 19,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              // height: 500,
              width: 500,
              child: SfCircularChart(
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                  RadialBarSeries<StudentResultData, String>(
                    dataSource: _results,
                    xValueMapper: (StudentResultData result, _) =>
                        result.category,
                    yValueMapper: (StudentResultData result, _) => result.score,
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.8),
                        )),
                    enableTooltip: true,
                    maximumValue: 6,
                    radius: '90%',
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
            const SizedBox(width: 200),
            Container(
              height: 300,
              width: 350,
              child: Card(
                child: Column(
                  children: [
                    Text(
                      'Overall Result',
                      style: const TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Grand Mean: $grandMeanView',
                      style: const TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontSize: 19,
                      ),
                    ),
                    Text(
                      'Priority: $userPriorityView',
                      style: const TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ],
    );
  }

  Future<List<StudentResultData>?> _getResults(String userViewId) async {
    final Map<String, dynamic>? data =
        await DatabaseService(uid: userViewId).getQuestionnaireResult();
    if (data != null) {
      return [
        StudentResultData('Nonacceptance',
            twoDecimalPlace(data['categoryNonacceptanceMEAN'])),
        StudentResultData('Goals', twoDecimalPlace(data['categoryGoalsMEAN'])),
        StudentResultData(
            'Impulse', twoDecimalPlace(data['categoryImpulseMEAN'])),
        StudentResultData(
            'Awareness', twoDecimalPlace(data['categoryAwarenessMEAN'])),
        StudentResultData(
            'Strategies', twoDecimalPlace(data['categoryStrategiesMEAN'])),
        StudentResultData(
            'Clarity', twoDecimalPlace(data['categoryClarityMEAN'])),
      ];
    } else {
      return null;
    }
  }

  Future _getHighestCategory(String userViewId) async {
    final Map<String, dynamic>? data =
        await DatabaseService(uid: userViewId).getQuestionnaireResult();
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

class StudentResultData {
  StudentResultData(this.category, this.score);
  final String category;
  final double score;
}
