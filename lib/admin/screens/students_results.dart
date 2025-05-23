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
  String yearAndDepartmentView = '';
  String userPriorityView = '';
  String grandMeanView = '';

  bool viewStudentResult = true;

  int currentIndex = 0;
  final List<String> labels = ['Pending', 'Ongoing', 'Completed'];

  List<StudentResultData>? _results;
  TooltipBehavior? _tooltipBehavior;
  String? highestCategory;

  String categoryNonacceptance = '';
  String categoryGoals = '';
  String categoryImpulse = '';
  String categoryAwareness = '';
  String categoryStrategies = '';
  String categoryClarity = '';

  String nonAcceptanceDescription =
      'Nonacceptance - tendency to have negative secondary emotional responses to\none\'s negative emotions, or nonacceptingreactions to one\'s distress.';
  String goalsDescription =
      'Goals - difficulties concentrating and accomplishing tasks when experiencing\nnegative emotions.';
  String impulseDescription =
      'Impulse - difficulties remaining in control of one\'s behavior when experiencing\nnegative emotions.';
  String awarenessDescription =
      'Awareness - tendency to attend to and acknowledge emotions.';
  String strategiesDescription =
      'Strategies - the belief that there is little that can be done to regulate emotions\neffectively, once an individual is upset.';
  String clarityDescription =
      'Clarity - the extent to which individuals know (and are clear about) the emotions\nthey are experiencing.';

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: adminContentBGColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            // margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Visibility(
                  visible: viewStudentResult,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        alignment: Alignment.center,
                        child: const Text('Student\'s Results',
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'Sofia Pro',
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                Visibility(
                  visible: viewStudentResult,
                  replacement: Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20, top: 20),
                              child: IconButton(
                                  onPressed: () => setState(() {
                                        viewStudentResult = true;
                                      }),
                                  icon: const Icon(Icons.arrow_back_ios)),
                            ),
                            const Spacer(),
                            //TODO Print Button

                            // Container(
                            //     alignment: Alignment.centerRight,
                            //     padding:
                            //         const EdgeInsets.only(left: 20, top: 20),
                            //     child: ElevatedButton(
                            //         style: ButtonStyle(
                            //           fixedSize:
                            //               MaterialStateProperty.all<Size>(
                            //                   const Size(85, 35)),
                            //           foregroundColor:
                            //               MaterialStateProperty.all<Color>(
                            //                   Colors.white),
                            //           backgroundColor:
                            //               MaterialStateProperty.all<Color>(
                            //                   phoneFieldButtonColor),
                            //           shape: MaterialStateProperty.all<
                            //               RoundedRectangleBorder>(
                            //             RoundedRectangleBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(7),
                            //             ),
                            //           ),
                            //         ),
                            //         onPressed: () {
                            //           DateTime currentDate = DateTime.now();
                            //           String formattedDate =
                            //               DateFormat('MM-dd-yyyy')
                            //                   .format(currentDate);
                            //           print(
                            //               formattedDate); // output: 02-18-2023
                            //         },
                            //         child: Row(
                            //           children: const [
                            //             Icon(Icons.print, size: 16),
                            //             SizedBox(width: 5),
                            //             Text(
                            //               'Print',
                            //               style: TextStyle(
                            //                   fontSize: 14,
                            //                   fontFamily: 'Sofia Pro'),
                            //             ),
                            //           ],
                            //         ))),
                            // const SizedBox(width: 20),
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
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 30, top: 10),
                          child: Text(
                            'Year & Department: $yearAndDepartmentView',
                            style: const TextStyle(
                              fontFamily: 'Sofia Pro',
                              fontSize: 19,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Spacer(),
                                    SizedBox(
                                      width: 500,
                                      child: SfCircularChart(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        tooltipBehavior: _tooltipBehavior,
                                        onTooltipRender: (tooltipArgs) {
                                          tooltipArgs.text =
                                              tooltipArgs.text!.split(' ')[0];
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
                                          overflowMode:
                                              LegendItemOverflowMode.wrap,
                                          iconHeight: 19,
                                          iconWidth: 19,
                                          position: LegendPosition.right,
                                          padding: 7,
                                          itemPadding: 12,
                                          isResponsive: true,
                                        ),
                                        series: <CircularSeries>[
                                          RadialBarSeries<StudentResultData,
                                              String>(
                                            dataSource: _results,
                                            xValueMapper:
                                                (StudentResultData result, _) =>
                                                    result.category,
                                            yValueMapper:
                                                (StudentResultData result, _) =>
                                                    result.score,
                                            dataLabelSettings:
                                                DataLabelSettings(
                                                    isVisible: true,
                                                    textStyle: TextStyle(
                                                      fontFamily: 'Sofia Pro',
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.8),
                                                    )),
                                            enableTooltip: true,
                                            maximumValue: 6,
                                            radius: '90%',
                                            innerRadius: '10%',
                                            cornerStyle: CornerStyle.bothCurve,
                                            trackOpacity: 0.7,
                                            gap: '3%',
                                            selectionBehavior:
                                                SelectionBehavior(
                                                    enable: true,
                                                    unselectedOpacity: 0.4),
                                            onPointTap:
                                                (pointInteractionDetails) {},
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 200),
                                    SizedBox(
                                      height: 300,
                                      width: 350,
                                      child: Card(
                                        elevation: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 7),
                                              const Text(
                                                'Overall Result',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: 'Sofia Pro',
                                                  fontSize: 22,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              RichText(
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                    fontFamily: 'Sofia Pro',
                                                    fontSize: 19,
                                                  ),
                                                  children: [
                                                    const TextSpan(
                                                      text: 'Grand Mean: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: grandMeanView,
                                                      style: const TextStyle(
                                                        fontFamily: 'Sofia Pro',
                                                        fontSize: 19,
                                                        color:
                                                            Color(0xFF3B61E8),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              RichText(
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                    fontFamily: 'Sofia Pro',
                                                    fontSize: 19,
                                                  ),
                                                  children: [
                                                    const TextSpan(
                                                      text: 'Priority: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: userPriorityView,
                                                      style: TextStyle(
                                                        fontFamily: 'Sofia Pro',
                                                        fontSize: 19,
                                                        color: userPriorityView ==
                                                                'High'
                                                            ? Colors.red
                                                            : userPriorityView ==
                                                                    'Low'
                                                                ? Colors.green
                                                                : Colors.amber,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              const Text(
                                                'Category:',
                                                style: TextStyle(
                                                  fontFamily: 'Sofia Pro',
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontFamily: 'Sofia Pro',
                                                        fontSize: 18,
                                                      ),
                                                      children: [
                                                        const TextSpan(
                                                          text:
                                                              'Nonacceptance - ',
                                                          style: TextStyle(),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              categoryNonacceptance,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Sofia Pro',
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontFamily: 'Sofia Pro',
                                                        fontSize: 18,
                                                      ),
                                                      children: [
                                                        const TextSpan(
                                                          text: 'Goals - ',
                                                          style: TextStyle(),
                                                        ),
                                                        TextSpan(
                                                          text: categoryGoals,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Sofia Pro',
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontFamily: 'Sofia Pro',
                                                        fontSize: 18,
                                                      ),
                                                      children: [
                                                        const TextSpan(
                                                          text: 'Impulse - ',
                                                          style: TextStyle(),
                                                        ),
                                                        TextSpan(
                                                          text: categoryImpulse,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Sofia Pro',
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontFamily: 'Sofia Pro',
                                                        fontSize: 18,
                                                      ),
                                                      children: [
                                                        const TextSpan(
                                                          text: 'Awareness - ',
                                                          style: TextStyle(),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              categoryAwareness,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Sofia Pro',
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontFamily: 'Sofia Pro',
                                                        fontSize: 18,
                                                      ),
                                                      children: [
                                                        const TextSpan(
                                                          text: 'Strategies - ',
                                                          style: TextStyle(),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              categoryStrategies,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Sofia Pro',
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontFamily: 'Sofia Pro',
                                                        fontSize: 18,
                                                      ),
                                                      children: [
                                                        const TextSpan(
                                                          text: 'Clarity - ',
                                                          style: TextStyle(),
                                                        ),
                                                        TextSpan(
                                                          text: categoryClarity,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Sofia Pro',
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer()
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Category Description',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: 'Sofia Pro',
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          nonAcceptanceDescription,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Sofia Pro'),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          goalsDescription,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Sofia Pro'),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          impulseDescription,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Sofia Pro'),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          awarenessDescription,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Sofia Pro'),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          strategiesDescription,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Sofia Pro'),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          clarityDescription,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Sofia Pro'),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Grand Mean Scale',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Sofia Pro',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '3.49 - below = ',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Sofia Pro',
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'low priority\n',
                                                style: TextStyle(
                                                  height: 1.5,
                                                  fontSize: 18,
                                                  fontFamily: 'Sofia Pro',
                                                ),
                                              ),
                                              TextSpan(
                                                text: '3.5 - 3.9 = ',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Sofia Pro',
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'mid priority\n',
                                                style: TextStyle(
                                                  height: 1.5,
                                                  fontSize: 18,
                                                  fontFamily: 'Sofia Pro',
                                                ),
                                              ),
                                              TextSpan(
                                                text: '4 - above = ',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Sofia Pro',
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'high priority',
                                                style: TextStyle(
                                                  height: 1.5,
                                                  fontSize: 18,
                                                  fontFamily: 'Sofia Pro',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    const Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('isUserDoneWithQuestionnaire',
                                isEqualTo: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: viewStudentResult ? 300 : 400),
                                const SpinKitChasingDots(
                                    color: primaryColor, size: 50),
                                const SizedBox(height: 20),
                                const Text(
                                  'Loading...',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: primaryColor,
                                    fontFamily: 'Sofia Pro',
                                  ),
                                ),
                              ],
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Container(
                              alignment: Alignment.center,
                              height: 650,
                              child: const Text(
                                'No results yet.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Sofia Pro'),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              height: 650,
                              child: const Text(
                                'Something went wrong.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Sofia Pro'),
                              ),
                            );
                          }

                          return Column(
                            children: [
                              const SizedBox(height: 5),
                              ListView(
                                shrinkWrap: true,
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data() as Map<String, dynamic>;

                                  String userId = data['uid'];

                                  return StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userId)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container();
                                      } else if (snapshot.data == null ||
                                          snapshot.data!.data() == null ||
                                          !snapshot.hasData) {
                                        return Container(
                                          alignment: Alignment.center,
                                          height: 650,
                                          child: const Text(
                                            'No data.',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontFamily: 'Sofia Pro'),
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Container(
                                          alignment: Alignment.center,
                                          height: 650,
                                          child: const Text(
                                            'Something went wrong.',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontFamily: 'Sofia Pro'),
                                          ),
                                        );
                                      }

                                      Map<String, dynamic> userData =
                                          snapshot.data!.data()
                                              as Map<String, dynamic>;

                                      String fullName =
                                          '${userData['firstName']} ${userData['lastName']}';
                                      String studentId = userData['studentId'];
                                      String yearAndDepartment =
                                          '${userData['year']} - ${userData['department']}';

                                      return StreamBuilder<DocumentSnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userId)
                                              .collection('questionnaireResult')
                                              .doc(userId)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Container();
                                            } else if (snapshot.data == null ||
                                                snapshot.data!.data() == null ||
                                                !snapshot.hasData) {
                                              return Container(
                                                alignment: Alignment.center,
                                                height: 650,
                                                child: const Text(
                                                  'No data.',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontFamily: 'Sofia Pro'),
                                                ),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Container(
                                                alignment: Alignment.center,
                                                height: 650,
                                                child: const Text(
                                                  'Something went wrong.',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontFamily: 'Sofia Pro'),
                                                ),
                                              );
                                            }

                                            Map<String, dynamic>
                                                questionnaireData =
                                                snapshot.data!.data()
                                                    as Map<String, dynamic>;

                                            String grandMean =
                                                questionnaireData['grandMean']
                                                    .toStringAsFixed(1);
                                            String nonacceptance =
                                                questionnaireData[
                                                        'categoryNonacceptanceMEAN']
                                                    .toStringAsFixed(1);
                                            String goals = questionnaireData[
                                                    'categoryGoalsMEAN']
                                                .toStringAsFixed(1);
                                            String impulse = questionnaireData[
                                                    'categoryImpulseMEAN']
                                                .toStringAsFixed(1);
                                            String awareness =
                                                questionnaireData[
                                                        'categoryAwarenessMEAN']
                                                    .toStringAsFixed(1);
                                            String strategies =
                                                questionnaireData[
                                                        'categoryStrategiesMEAN']
                                                    .toStringAsFixed(1);
                                            String clarity = questionnaireData[
                                                    'categoryClarityMEAN']
                                                .toStringAsFixed(1);
                                            String userPriority =
                                                questionnaireData[
                                                            'isHighPriority'] ==
                                                        true
                                                    ? 'High'
                                                    : questionnaireData[
                                                                'isLowPriority'] ==
                                                            true
                                                        ? 'Low'
                                                        : 'Mid';
                                            String priority = questionnaireData[
                                                        'isHighPriority'] ==
                                                    true
                                                ? 'high priority'
                                                : questionnaireData[
                                                            'isLowPriority'] ==
                                                        true
                                                    ? 'low priority'
                                                    : 'mid priority';

                                            return Column(
                                              children: [
                                                const Divider(
                                                  height: 0,
                                                  thickness: 1,
                                                ),
                                                ListTile(
                                                  onTap: () async {
                                                    setState(() {
                                                      viewStudentResult = false;
                                                      fullNameView = fullName;
                                                      // userIdView = userId;
                                                      priorityView = priority;
                                                      dateOfAppointmentDocId =
                                                          document.id;
                                                      studentIdView = studentId;
                                                      yearAndDepartmentView =
                                                          yearAndDepartment;

                                                      grandMeanView = grandMean;
                                                      categoryNonacceptance =
                                                          nonacceptance;
                                                      categoryGoals = goals;
                                                      categoryImpulse = impulse;
                                                      categoryAwareness =
                                                          awareness;
                                                      categoryStrategies =
                                                          strategies;
                                                      categoryClarity = clarity;
                                                      userPriorityView =
                                                          userPriority;
                                                    });

                                                    List<StudentResultData>?
                                                        results =
                                                        await _getResults(
                                                            userId);
                                                    setState(() {
                                                      _results = results;
                                                    });

                                                    String category =
                                                        await _getHighestCategory(
                                                            userId);
                                                    setState(() {
                                                      highestCategory =
                                                          category;
                                                    });
                                                  },
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5),
                                                  title: Row(
                                                    children: [
                                                      const SizedBox(width: 50),
                                                      Text(fullName,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Sofia Pro',
                                                            fontSize: 18,
                                                          )),
                                                      const Spacer(),
                                                      const SizedBox(width: 50),
                                                    ],
                                                  ),
                                                  subtitle: Row(
                                                    children: [
                                                      const SizedBox(width: 50),
                                                      Text(
                                                        questionnaireData[
                                                                    'isHighPriority'] ==
                                                                true
                                                            ? 'high priority'
                                                            : questionnaireData[
                                                                        'isLowPriority'] ==
                                                                    true
                                                                ? 'low priority'
                                                                : 'mid priority',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Sofia Pro',
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: questionnaireData[
                                                                      'isHighPriority'] ==
                                                                  true
                                                              ? Colors.red
                                                              : questionnaireData[
                                                                          'isLowPriority'] ==
                                                                      true
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .amber,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 50),
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
                                                ),
                                                const Divider(
                                                  height: 0,
                                                  thickness: 1,
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
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
                        viewStudentResult = true;
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
            SizedBox(
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
            SizedBox(
              height: 300,
              width: 350,
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 7),
                      const Text(
                        'Overall Result',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: 'Sofia Pro',
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Sofia Pro',
                            fontSize: 19,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Grand Mean: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: grandMeanView,
                              style: const TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontSize: 19,
                                color: Color(0xFF3B61E8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Sofia Pro',
                            fontSize: 19,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Priority: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: userPriorityView,
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontSize: 19,
                                color: userPriorityView == 'High'
                                    ? Colors.red
                                    : userPriorityView == 'Low'
                                        ? Colors.green
                                        : Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Category:',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontSize: 18,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Nonacceptance - ',
                                  style: TextStyle(),
                                ),
                                TextSpan(
                                  text: categoryNonacceptance,
                                  style: const TextStyle(
                                    fontFamily: 'Sofia Pro',
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontSize: 18,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Goals - ',
                                  style: TextStyle(),
                                ),
                                TextSpan(
                                  text: categoryGoals,
                                  style: const TextStyle(
                                    fontFamily: 'Sofia Pro',
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontSize: 18,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Impulse - ',
                                  style: TextStyle(),
                                ),
                                TextSpan(
                                  text: categoryImpulse,
                                  style: const TextStyle(
                                    fontFamily: 'Sofia Pro',
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontSize: 18,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Awareness - ',
                                  style: TextStyle(),
                                ),
                                TextSpan(
                                  text: categoryAwareness,
                                  style: const TextStyle(
                                    fontFamily: 'Sofia Pro',
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontSize: 18,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Strategies - ',
                                  style: TextStyle(),
                                ),
                                TextSpan(
                                  text: categoryStrategies,
                                  style: const TextStyle(
                                    fontFamily: 'Sofia Pro',
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontSize: 18,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Clarity - ',
                                  style: TextStyle(),
                                ),
                                TextSpan(
                                  text: categoryClarity,
                                  style: const TextStyle(
                                    fontFamily: 'Sofia Pro',
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer()
          ],
        ),
        Row(
          children: [
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Sofia Pro',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  nonAcceptanceDescription,
                  style: const TextStyle(fontSize: 14, fontFamily: 'Sofia Pro'),
                ),
                const SizedBox(height: 10),
                Text(
                  goalsDescription,
                  style: const TextStyle(fontSize: 14, fontFamily: 'Sofia Pro'),
                ),
                const SizedBox(height: 10),
                Text(
                  impulseDescription,
                  style: const TextStyle(fontSize: 14, fontFamily: 'Sofia Pro'),
                ),
                const SizedBox(height: 10),
                Text(
                  awarenessDescription,
                  style: const TextStyle(fontSize: 14, fontFamily: 'Sofia Pro'),
                ),
                const SizedBox(height: 10),
                Text(
                  strategiesDescription,
                  style: const TextStyle(fontSize: 14, fontFamily: 'Sofia Pro'),
                ),
                const SizedBox(height: 10),
                Text(
                  clarityDescription,
                  style: const TextStyle(fontSize: 14, fontFamily: 'Sofia Pro'),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Grand Mean Scale',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Sofia Pro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '3.49 - below = ',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Sofia Pro',
                        ),
                      ),
                      TextSpan(
                        text: 'low priority\n',
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 18,
                          fontFamily: 'Sofia Pro',
                        ),
                      ),
                      TextSpan(
                        text: '3.5 - 3.9 = ',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Sofia Pro',
                        ),
                      ),
                      TextSpan(
                        text: 'mid priority\n',
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 18,
                          fontFamily: 'Sofia Pro',
                        ),
                      ),
                      TextSpan(
                        text: '4 - above = ',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Sofia Pro',
                        ),
                      ),
                      TextSpan(
                        text: 'high priority',
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 18,
                          fontFamily: 'Sofia Pro',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            const Spacer(),
          ],
        )
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
