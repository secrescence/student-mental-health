import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  DateTime firstDayOfMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime lastDayOfMonth =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: adminContentBGColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width / 2.75,
                        height: 270,
                        child: Column(
                          children: [
                            const Text(
                              'Overview',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                'Completed',
                                style: TextStyle(
                                  fontFamily: 'Sofia Pro',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('appointments')
                                    .where('status', isEqualTo: 'completed')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return Container(
                                      height: 15,
                                    );
                                  }

                                  int completedCount =
                                      snapshot.data!.docs.length;

                                  if (completedCount == 0) {
                                    return Container(
                                      height: 15,
                                    );
                                  }

                                  return SfLinearGauge(
                                    showTicks: false,
                                    showLabels: false,
                                    animateAxis: true,
                                    axisTrackStyle: const LinearAxisTrackStyle(
                                        thickness: 13,
                                        edgeStyle: LinearEdgeStyle.bothCurve,
                                        borderColor: Colors.transparent,
                                        color: Colors.transparent),
                                    barPointers: <LinearBarPointer>[
                                      LinearBarPointer(
                                        value: completedCount.toDouble(),
                                        thickness: 13,
                                        edgeStyle: LinearEdgeStyle.bothCurve,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xffA9DCA8),
                                                Color(0xff55B764),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                    markerPointers: <LinearMarkerPointer>[
                                      LinearWidgetPointer(
                                        value: completedCount.toDouble(),
                                        position: LinearElementPosition.outside,
                                        child: Text(
                                          '$completedCount',
                                          style: const TextStyle(
                                            color: Color(0xff55B764),
                                            fontFamily: 'Sofia Pro',
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            const SizedBox(height: 20),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Ongoing',
                                style: TextStyle(
                                  fontFamily: 'Sofia Pro',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('appointments')
                                    .where('status', isEqualTo: 'ongoing')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return Container(
                                      height: 15,
                                    );
                                  }

                                  int ongoingCount = snapshot.data!.docs.length;

                                  if (ongoingCount == 0) {
                                    return Container(
                                      height: 15,
                                    );
                                  }

                                  return SfLinearGauge(
                                    showTicks: false,
                                    showLabels: false,
                                    animateAxis: true,
                                    axisTrackStyle: const LinearAxisTrackStyle(
                                        thickness: 13,
                                        edgeStyle: LinearEdgeStyle.bothCurve,
                                        borderColor: Colors.transparent,
                                        color: Colors.transparent),
                                    barPointers: <LinearBarPointer>[
                                      LinearBarPointer(
                                        value: ongoingCount.toDouble(),
                                        thickness: 13,
                                        edgeStyle: LinearEdgeStyle.bothCurve,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xfffff192),
                                                Color(0xffffd400),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                    markerPointers: <LinearMarkerPointer>[
                                      LinearWidgetPointer(
                                        value: ongoingCount.toDouble(),
                                        position: LinearElementPosition.outside,
                                        child: Text(
                                          '$ongoingCount',
                                          style: const TextStyle(
                                            color: Color(0xffffd400),
                                            fontFamily: 'Sofia Pro',
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            const SizedBox(height: 20),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Pending',
                                style: TextStyle(
                                  fontFamily: 'Sofia Pro',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('appointments')
                                    .where('status', isEqualTo: 'pending')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return Container(
                                      height: 15,
                                    );
                                  }
                                  final appointments = snapshot.data!.docs;
                                  final appointedUsers = appointments.map(
                                      (appointment) =>
                                          appointment.get('appointedUser'));

                                  final nonEmptyAppointedUsers = appointedUsers
                                      .where((user) => user != '');
                                  final pendingCount =
                                      nonEmptyAppointedUsers.length;

                                  if (pendingCount == 0) {
                                    return Container(
                                      height: 15,
                                    );
                                  }

                                  return SfLinearGauge(
                                    showTicks: false,
                                    showLabels: false,
                                    animateAxis: true,
                                    axisTrackStyle: const LinearAxisTrackStyle(
                                        thickness: 13,
                                        edgeStyle: LinearEdgeStyle.bothCurve,
                                        borderColor: Colors.transparent,
                                        color: Colors.transparent),
                                    barPointers: <LinearBarPointer>[
                                      LinearBarPointer(
                                        value: pendingCount.toDouble(),
                                        thickness: 13,
                                        edgeStyle: LinearEdgeStyle.bothCurve,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xffDCA8A8),
                                                Color(0xffB85757),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                    markerPointers: <LinearMarkerPointer>[
                                      LinearWidgetPointer(
                                        value: pendingCount.toDouble(),
                                        position: LinearElementPosition.outside,
                                        child: Text(
                                          '$pendingCount',
                                          style: const TextStyle(
                                            color: Color(0xffB85757),
                                            fontFamily: 'Sofia Pro',
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width - 1110,
                        height: 270,
                        child: Column(
                          children: [
                            const Text(
                              'Student\'s Results',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 70),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collectionGroup(
                                              'questionnaireResult')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData ||
                                            snapshot.data == null) {
                                          return Column(
                                            children: const [
                                              Text(
                                                '0',
                                                style: TextStyle(
                                                  fontFamily: 'Sofia Pro',
                                                  fontSize: 45,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'Low Priority',
                                                style: TextStyle(
                                                  fontFamily: 'Sofia Pro',
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          );
                                        }

                                        final results = snapshot.data!.docs;
                                        final getLowPriority = results
                                            .where((result) =>
                                                result.get('isLowPriority') ==
                                                true)
                                            .length;
                                        final lowPriorityCount = getLowPriority;

                                        return Column(
                                          children: [
                                            Text(
                                              '$lowPriorityCount',
                                              style: const TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontSize: 45,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Text(
                                              'Low Priority',
                                              style: TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                  const SizedBox(width: 50),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collectionGroup(
                                              'questionnaireResult')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData ||
                                            snapshot.data == null) {
                                          return Column(
                                            children: const [
                                              Text(
                                                '0',
                                                style: TextStyle(
                                                  fontFamily: 'Sofia Pro',
                                                  fontSize: 45,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'Mid Priority',
                                                style: TextStyle(
                                                  fontFamily: 'Sofia Pro',
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          );
                                        }

                                        final results = snapshot.data!.docs;
                                        final getMidPriority = results
                                            .where((result) =>
                                                result.get('isMidPriority') ==
                                                true)
                                            .length;
                                        final midPriorityCount = getMidPriority;

                                        return Column(
                                          children: [
                                            Text(
                                              '$midPriorityCount',
                                              style: const TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontSize: 45,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Text(
                                              'Mid Priority',
                                              style: TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                  const SizedBox(width: 50),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collectionGroup(
                                              'questionnaireResult')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData ||
                                            snapshot.data == null) {
                                          return Column(
                                            children: const [
                                              Text(
                                                '0',
                                                style: TextStyle(
                                                  fontFamily: 'Sofia Pro',
                                                  fontSize: 45,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'High Priority',
                                                style: TextStyle(
                                                  fontFamily: 'Sofia Pro',
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          );
                                        }

                                        final results = snapshot.data!.docs;
                                        final getHighPriority = results
                                            .where((result) =>
                                                result.get('isHighPriority') ==
                                                true)
                                            .length;
                                        final highPriorityCount =
                                            getHighPriority;

                                        return Column(
                                          children: [
                                            Text(
                                              '$highPriorityCount',
                                              style: const TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontSize: 45,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Text(
                                              'High Priority',
                                              style: TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: 380,
                    child: Column(
                      children: [
                        const Text(
                          'Monthly Report',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where('dateSignedUpUsingEmailOnly',
                                      isGreaterThanOrEqualTo:
                                          Timestamp.fromDate(firstDayOfMonth))
                                  .where('dateSignedUpUsingEmailOnly',
                                      isLessThanOrEqualTo:
                                          Timestamp.fromDate(lastDayOfMonth))
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return Container(
                                    height: 15,
                                  );
                                }

                                final getData = snapshot.data!.docs;
                                final usedTheApp = getData
                                    .where((result) =>
                                        result.get(
                                            'isUserSingedInUsingEmailOnly') ==
                                        true)
                                    .length;
                                final usedTheAppCount = usedTheApp;

                                final tookQuestionnaire = getData
                                    .where((result) =>
                                        result.get(
                                            'isUserDoneWithQuestionnaire') ==
                                        true)
                                    .length;
                                final tookQuestionnaireCount =
                                    tookQuestionnaire;

                                return StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('appointments')
                                        .where('status', isEqualTo: 'completed')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData ||
                                          snapshot.data == null) {
                                        return Container(
                                          height: 15,
                                        );
                                      }

                                      int visitedGuidanceCount =
                                          snapshot.data!.docs.length;

                                      return SfCartesianChart(
                                        // title: ChartTitle(text: 'Internet Users - 2016'),
                                        plotAreaBorderWidth: 0,

                                        /// X axis as category axis placed here.
                                        primaryXAxis: CategoryAxis(
                                          majorGridLines:
                                              const MajorGridLines(width: 0),
                                        ),
                                        primaryYAxis: NumericAxis(
                                            minimum: 0,
                                            maximum: 80,
                                            isVisible: false,
                                            labelFormat: '{value} Students'),
                                        series: <
                                            ColumnSeries<ChartSampleData,
                                                String>>[
                                          ColumnSeries<ChartSampleData, String>(
                                            dataSource: <ChartSampleData>[
                                              ChartSampleData(
                                                  category:
                                                      'Overall no. of students that used the app',
                                                  value: usedTheAppCount,
                                                  color: primaryColor),
                                              ChartSampleData(
                                                  category:
                                                      'No. of students who took the questionnaire',
                                                  value: tookQuestionnaireCount,
                                                  color: primaryColor),
                                              ChartSampleData(
                                                  category:
                                                      'No. of students that visit the Guidance office',
                                                  value: visitedGuidanceCount,
                                                  color: primaryColor),
                                            ],
                                            xValueMapper:
                                                (ChartSampleData data, _) =>
                                                    data.category as String,
                                            yValueMapper:
                                                (ChartSampleData data, _) =>
                                                    data.value,
                                            pointColorMapper:
                                                (ChartSampleData data, _) =>
                                                    data.color,
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                                    isVisible: true),
                                          )
                                        ],
                                        // tooltipBehavior: _tooltipBehavior,
                                      );
                                    });
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///Chart sample data
class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData({
    this.category,
    this.value,
    this.color,
  });

  final dynamic category;
  final num? value;
  final dynamic color;
}
