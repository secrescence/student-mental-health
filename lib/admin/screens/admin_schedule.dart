import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/loading_admin.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AdminSchedule extends StatefulWidget {
  const AdminSchedule({super.key});

  @override
  State<AdminSchedule> createState() => _AdminScheduleState();
}

class _AdminScheduleState extends State<AdminSchedule> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  String forDocId = '';

  Stream<QuerySnapshot>? scheduleStream;

  //dropdown
  final List<String> _timeList = [
    '9:00 AM',
    '10:00 AM',
    '2:00 PM',
    '3:00 PM',
  ];
  String? _selectedTimeValue;

  String time = '';

  // controllers
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Container(
                  alignment: Alignment.center,
                  child: const Text('Schedule',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Sofia Pro',
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(height: 30),
                Row(
                  children: const [
                    Spacer(),
                    SizedBox(width: 40),
                    Text('Date',
                        style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'Sofia Pro',
                          fontWeight: FontWeight.w400,
                        )),
                    SizedBox(width: 20),
                    Spacer(),
                    Text('Time',
                        style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'Sofia Pro',
                          fontWeight: FontWeight.w400,
                        )),
                    SizedBox(width: 70),
                    Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 350,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: scheduleStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingAdmin();
                      }
                      List<DocumentSnapshot> schedule = snapshot.data!.docs;
                      if (schedule.isEmpty) {
                        return Container(
                          alignment: Alignment.center,
                          height: 600,
                          child: const Text(
                            'No schedule yet.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Sofia Pro'),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: schedule.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              schedule[index].data() as Map<String, dynamic>;
                          return Column(
                            children: [
                              const Divider(
                                height: 0,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    // const SizedBox(width: 35),
                                    Text(data['date'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Sofia Pro',
                                          fontWeight: FontWeight.w400,
                                        )),
                                    const Spacer(),
                                    Text(data['time'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Sofia Pro',
                                          fontWeight: FontWeight.w400,
                                        )),
                                    // const SizedBox(width: 40),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('appointments')
                                            .doc(schedule[index].id)
                                            .delete();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 0,
                                thickness: 1,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    splashColor: primaryColor,
                    backgroundColor: primaryColor,
                    elevation: 5,
                    onPressed: () => _addScheduleForm(),
                    child: const Icon(Icons.add),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
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
                        height: 70,
                        width: 280,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0, right: 0, bottom: 0, left: 5),
                          child: TextFormField(
                            decoration: textInputDeco.copyWith(
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    top: 0, right: 8, bottom: 0, left: 2),
                                child: Icon(Icons.date_range),
                              ),
                              suffixIconColor: primaryColor,
                              suffixIconConstraints:
                                  const BoxConstraints(maxHeight: 20),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    top: 0, right: 10.5, bottom: 0, left: 2),
                              ),
                              prefixIconConstraints:
                                  const BoxConstraints(maxHeight: 20),
                              errorMaxLines: 1,
                              errorStyle: const TextStyle(
                                  height: 0,
                                  color: Colors.transparent,
                                  fontSize: 0),
                              contentPadding: const EdgeInsets.all(0),
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
                        width: 280,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0, right: 0, bottom: 0, left: 5),
                          child: DropdownButtonFormField(
                            icon: const Icon(Icons.schedule),
                            iconEnabledColor: primaryColor,
                            iconDisabledColor: primaryColor,
                            focusColor: Colors.transparent,
                            elevation: 0,
                            decoration: textInputDeco.copyWith(
                              contentPadding: const EdgeInsets.all(0),
                              prefixIconConstraints:
                                  const BoxConstraints(maxHeight: 20),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    top: 0, right: 10.5, bottom: 0, left: 2),
                              ),
                              suffixIconConstraints:
                                  const BoxConstraints(maxHeight: 20),
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    top: 0, right: 8, bottom: 0, left: 2),
                              ),
                            ),
                            value: _selectedTimeValue,
                            items: _timeList
                                .map((e) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: e,
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: SizedBox(
                                          child: Text(e),
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: ((value) {
                              setState(() {
                                _selectedTimeValue = value;
                              });
                            }),
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
                              _selectedTimeValue = null;
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

      await DatabaseService().addSchedule(
          context: context,
          date: dateController.text,
          forDocId: forDocId,
          time: _selectedTimeValue!);

      dateController.clear();
      _selectedTimeValue = null;
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
        dateController.text = DateFormat('MMMM d, y').format(picked);
        forDocId = DateFormat('MM-dd-yyyy').format(picked);
      });
    }
  }

  // _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: _selectedTime,
  //     builder: (context, child) {
  //       return MediaQuery(
  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
  //         child: child ?? Container(),
  //       );
  //     },
  //   );
  //   if (picked != null) {
  //     setState(() {
  //       _selectedTime = picked;
  //       timeController.text =
  //           '${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')}';
  //     });
  //   }
  // }
}
