import 'package:datepicker/constants.dart';
import 'package:datepicker/screens/home/components/custom_button.dart';
import 'package:datepicker/screens/home/components/custom_date_input.dart';
import 'package:datepicker/screens/home/components/validators.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _dateController = TextEditingController();
  final FocusNode _dateFocusNode = FocusNode();
  DateTime? _chosenDateTime;
  final GlobalKey<FormState> _key = GlobalKey();
  bool isSlashAddedAt2 = false;
  bool isSlashAddedAt5 = false;
  bool _isValidDate = false;
  bool isDatePickerOpened = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10.0),
            const Text("Select Date"),
            Form(
              key: _key,
              autovalidateMode: _isValidDate
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUserInteraction,
              child: CustomDateTextField(
                controller: _dateController,
                hintText: "dd/mm/yyyy",
                keyboardType: TextInputType.datetime,
                focusNode: _dateFocusNode,
                onChanged: (val) {
                  int length = _dateController.text.length;
                  if (length < 5) {
                    setState(() {
                      isSlashAddedAt5 = false;
                    });
                  }
                  if (length < 2) {
                    setState(() {
                      isSlashAddedAt2 = false;
                    });
                  }

                  if (length == 2 || length == 5) {
                    if (!isSlashAddedAt2 && length == 2) {
                      _dateController.text += "/";
                      _dateController.selection = TextSelection.fromPosition(
                          TextPosition(offset: length + 1));
                      setState(() {
                        isSlashAddedAt2 = true;
                      });
                    }
                    if (!isSlashAddedAt5 && length == 5) {
                      _dateController.text += "/";
                      _dateController.selection = TextSelection.fromPosition(
                          TextPosition(offset: length + 1));
                      setState(() {
                        isSlashAddedAt5 = true;
                      });
                    }
                  }
                },
                onEditingComplete: () {},
                onSaved: (date) {
                  _chosenDateTime = DateTime.parse(date!);
                },
                validator: (date) => Validators().validateDate(date!),
                onSuffixIconClick: () {
                  setState(() {
                    isDatePickerOpened = !isDatePickerOpened;
                  });
                },
              ),
            ),
            Stack(
              children: <Widget>[
                //! Other Widgets
                Container(
                  height: 150.0,
                  // width: size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Implementation:\n1. Custom Own Mask Input\n2. Only Digits are Allowed\n3. Responsive in Web & Mobile\n4. Date Selector doesn't affect other widgets.\n5. No Packages Used.\n6. Custom Date Validation Implemented.",
                    textAlign: TextAlign.start,
                  ),
                ),

                isDatePickerOpened
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(
                          children: <Widget>[
                            CalendarDatePicker(
                              onDateChanged: (DateTime value) {
                                String days = "", months = "";
                                if (value.day <= 9) {
                                  days = "0${value.day}";
                                }else {
                                  days = "${value.day}";
                                }
                                if (value.month <= 9) {
                                  months = "0${value.month}";
                                }else {
                                  months = "${value.month}";
                                }
                                setState(() {
                                  _dateController.text =
                                      "$days/$months/${value.year}";
                                  _chosenDateTime = value;
                                });
                              },
                              lastDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(Duration(days: 25000)),
                              initialDate: DateTime.now(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isDatePickerOpened = false;
                                      });
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isDatePickerOpened = false;
                                      });
                                    },
                                    child: const Text(
                                      "Ok",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
