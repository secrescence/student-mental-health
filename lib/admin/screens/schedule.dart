import 'package:flutter/material.dart';
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

  int incrementForDateOfAppointment = 1;

  // controllers
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  //   @override
  // void initState() {
  //   getListOfSchedule();
  //   super.initState();
  // }

  // getListOfSchedule() async {
  //   await DatabaseService().getSchedulesOfDateNow().then((value) {
  //     if (value == null) {
  //       setState(() {
  //         listOfSchedule = value;
  //       });
  //     } else {
  //       setState(() {
  //         scheduleIsNotEmpty = false;
  //       });
  //     }
  //   });
  // }

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
            // Container(
            //   width: 100,
            //   child: Card(
            //     child: Column(
            //       children: [
            //         Container(
            //           padding: const EdgeInsets.all(8),
            //           alignment: Alignment.centerLeft,
            //           child: Text('Schedule'),
            //         ),
            //         Table(
            //           children: [
            //             TableRow(
            //               children: [
            //                 SizedBox(width: 20),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text("Date"),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text("Time"),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text("Status"),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 700,
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            alignment: Alignment.centerLeft,
                            child: const Text('Schedule',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Sofia Pro',
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                          Table(
                            children: const [
                              TableRow(
                                children: [
                                  SizedBox(width: 20),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Date",
                                        style: TextStyle(
                                          fontFamily: 'Sofia Pro',
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Time",
                                        style: TextStyle(
                                          fontFamily: 'Sofia Pro',
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Status",
                                        style: TextStyle(
                                          fontFamily: 'Sofia Pro',
                                        )),
                                  ),
                                ],
                              ),
                              // TableRow(
                              //   children: [],
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 40, right: 10),
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      splashColor: primaryColor,
                      backgroundColor: primaryColor,
                      elevation: 5,
                      onPressed: () => _addScheduleForm(),
                      child: const Icon(Icons.add),
                    ),
                  )
                ],
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
              fontSize: 16,
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
                children: <Widget>[
                  Row(
                    children: [
                      const Text('Select Date:',
                          style: TextStyle(fontFamily: 'Sofia Pro')),
                      const SizedBox(width: 10),
                      SizedBox(
                        child: SizedBox(
                          height: 50,
                          width: 150,
                          child: TextFormField(
                            decoration: textInputDeco.copyWith(
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    top: 0, right: 7, bottom: 0, left: 7),
                                child: Icon(Icons.date_range),
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
                    children: [
                      const Text('Select Time:',
                          style: TextStyle(fontFamily: 'Sofia Pro')),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: TextFormField(
                          decoration: textInputDeco.copyWith(
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(
                                  top: 0, right: 7, bottom: 0, left: 7),
                              child: Icon(Icons.more_time),
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
                  const SizedBox(height: 30),
                  Row(
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
      setState(() {
        incrementForDateOfAppointment++;
      });

      //  await DatabaseService()
      //                     .getUidScheduleOfDateNow(dateController.text.trim(),incrementForDateOfAppointment)
      //                     .then((value) async {
      //                   if (value == null || value.isEmpty) {
      //                     setState(() {
      //                       incrementForDateOfAppointment = 1;
      //                     });
      //                     await DatabaseService().addSchedule(dateController.text,
      //       timeController.text, incrementForDateOfAppointment);
      //                   } else {
      //                     setState(() {
      //                       incrementForDateOfAppointment++;
      //                     });
      //                     await DatabaseService().addSchedule(
      //                         schedule, incrementForDateOfAppointment);
      //                     print('w');
      //                   }
      //                 });
      //                 await DatabaseService()
      //                     .getAllSchedules()
      //                     .then((value) => print(value));

      await DatabaseService().addSchedule(dateController.text,
          timeController.text, incrementForDateOfAppointment);
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2030));
    if (picked != null && picked != _selectedDate) {
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
