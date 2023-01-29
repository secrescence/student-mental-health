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
                    height: 500,
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
              height: 180,
              width: 250,
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
                                suffixIcon: const Icon(Icons.date_range)),
                            controller: dateController,
                            readOnly: true,
                            onTap: () => _selectDate(context),
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
                                suffixIcon: const Icon(Icons.more_time)),
                            controller: timeController,
                            readOnly: true,
                            onTap: () {
                              _selectTime(context);
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () => _submitButton(),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                              const Size(100, 35)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              phoneFieldButtonColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        child: const Text('Submit',
                            style: TextStyle(
                                fontSize: 14, fontFamily: 'Sofia Pro')),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _submitButton() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        incrementForDateOfAppointment++;
      });
      DatabaseService().addSchedule(dateController.text, timeController.text,
          incrementForDateOfAppointment);
    } else {
      errorSnackbar(context, 'Oops', 'Date and Time cannot be empty');
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
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        timeController.text =
            '${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')}';
      });
    }
  }
}
