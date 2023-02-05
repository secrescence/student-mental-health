import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/custom_snackbar.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Stream<QuerySnapshot>? scheduleStream;

  // controllers
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getListOfSchedule();
    super.initState();
  }

  getListOfSchedule() async {
    await DatabaseService().getSchedules().then((snapshot) {
      setState(() {
        scheduleStream = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: adminContentBGColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (() {
                //TODO: Add back button functionality
              }),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF000000),
              )),
          bottom: const TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 1.5, color: Colors.white70),
              // insets: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            labelColor: primaryColor,
            labelStyle: TextStyle(
              fontSize: 15,
              fontFamily: 'Sofia Pro',
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              Tab(
                text: 'Add Schedule',
              ),
              Tab(text: 'Pending Appointments'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              width: double.infinity,
              // height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      alignment: Alignment.topLeft,
                      child: const Text('Schedule',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Sofia Pro',
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Spacer(),
                          SizedBox(width: 30),
                          Text('Date',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                              )),
                          Spacer(),
                          Text('Time',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                              )),
                          SizedBox(width: 30),
                          Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 420,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: scheduleStream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return const Center(
                              child: SpinKitSpinningLines(
                                color: primaryColor,
                                size: 50,
                              ),
                            );
                          }
                          List<DocumentSnapshot> schedule = snapshot.data!.docs;
                          if (schedule.isEmpty) {
                            return const Center(
                              child: Text(
                                'No schedule available',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Sofia Pro',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: schedule.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data = schedule[index].data()
                                  as Map<String, dynamic>;
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        const SizedBox(width: 35),
                                        Text(data['date'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Sofia Pro',
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const Spacer(),
                                        Text(data['time'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Sofia Pro',
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const SizedBox(width: 40),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        splashColor: primaryColor,
                        backgroundColor: primaryColor,
                        elevation: 5,
                        onPressed: () => _addScheduleForm(),
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(child: Text('Pending Appointments Content')),
          ],
        ),
      ),
    );
  }

  void _addScheduleForm() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Add Schedule",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontFamily: 'Sofia Pro',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Form(
            key: _formKey,
            child: SizedBox(
              height: 400,
              width: 700,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Select Date:',
                          style: TextStyle(fontFamily: 'Sofia Pro')),
                      const SizedBox(width: 10),
                      SizedBox(
                        child: SizedBox(
                          height: 70,
                          width: 300,
                          child: TextFormField(
                            decoration: textInputDeco.copyWith(
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    top: 0, right: 7, bottom: 0, left: 8),
                                child: Icon(Icons.date_range),
                              ),
                              suffixIconColor: primaryColor,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 8),
                              ),
                              errorMaxLines: 1,
                              errorStyle: const TextStyle(
                                  height: 0,
                                  color: Colors.transparent,
                                  fontSize: 0),
                              contentPadding: const EdgeInsets.all(0),
                              suffixIconConstraints:
                                  const BoxConstraints(maxHeight: 35),
                            ),
                            controller: dateController,
                            readOnly: true,
                            onTap: () => _selectDate(context),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Select Time:',
                          style: TextStyle(fontFamily: 'Sofia Pro')),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 70,
                        width: 300,
                        child: TextFormField(
                          decoration: textInputDeco.copyWith(
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(
                                  top: 0, right: 7, bottom: 0, left: 8),
                              child: Icon(Icons.more_time),
                            ),
                            suffixIconColor: primaryColor,
                            errorMaxLines: 1,
                            errorStyle: const TextStyle(
                                height: 0,
                                color: Colors.transparent,
                                fontSize: 0),
                            contentPadding: const EdgeInsets.all(0),
                            suffixIconConstraints:
                                const BoxConstraints(maxHeight: 35),
                          ),
                          controller: timeController,
                          readOnly: true,
                          onTap: () {
                            _selectTime(context);
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 15),
                      Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () => _submitButton(),
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all<Size>(
                                  const Size(100, 35)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  primaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ),
                            child: const Text('Submit',
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'Sofia Pro')),
                          )),
                      const SizedBox(width: 20),
                      Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              nextScreenPop(context);
                              dateController.clear();
                              timeController.clear();
                            },
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all<Size>(
                                  const Size(100, 35)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  primaryColor),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ),
                            child: const Text('Cancel',
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'Sofia Pro')),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _submitButton() async {
    if (_formKey.currentState!.validate()) {
      nextScreenPop(context);
      await DatabaseService()
          .addSchedule(dateController.text, timeController.text);
      dateController.clear();
      timeController.clear();
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2030));
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        dateController.text = DateFormat('MM-dd-yyyy').format(picked);
      });
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        timeController.text =
            '${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')}';
      });
    }
  }
}
