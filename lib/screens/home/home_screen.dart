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
  bool isDatePickerOpened = true;
  int startingDayOfSelectedMonth = -1;
  int startingDayOfSelectedMonthCopy = -1;
  String selectedMonth = "";
  int selectedMonthIndex = -1;
  int selectedYear = DateTime.now().year;
  List<int> years = [];

  List<List<String>> months = [
    ["JAN", "31"],
    ["FEB", "28"],
    ["MAR", "31"],
    ["APR", "30"],
    ["MAY", "31"],
    ["JUN", "30"],
    ["JUL", "31"],
    ["AUG", "31"],
    ["SEPT", "30"],
    ["OCT", "31"],
    ["NOV", "30"],
    ["DEC", "31"],
  ];

  List<String> days = [
    "SUN",
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT",
  ];
  @override
  void initState() {
    selectedMonth = months[0].first;
    selectedMonthIndex = DateTime.now().month;
    selectedYear = DateTime.now().year;
    for (int i = 0; i < 240; i++) {
      years.add(1900 + i);
    }
    calculateDay(1, selectedMonthIndex, selectedYear);
    super.initState();
  }

  void calculateDay(int day, int month, int year) {
    int yearCopy = year;
    List<int> magicNumber = [0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5];
    List<int> magicNumberLeapYear = [6, 2, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5];
    int initialYear = (yearCopy / 100).floor();
    int lastYear = yearCopy % 100;
    int step3 = (lastYear / 4).floor();
    int step2;
    if (initialYear >= 20) {
      step2 = 6;
    } else {
      step2 = 0;
    }
    bool isLeapYear = false;
    if (yearCopy % 100 == 0) {
      isLeapYear = yearCopy % 400 == 0;
    } else {
      isLeapYear = yearCopy % 4 == 0;
    }

    print("$day, ${magicNumber[month - 1]}, $step2, $step3, $lastYear");
    int output = 0;
    if (isLeapYear) {
      output = day + magicNumberLeapYear[month - 1] + step2 + step3 + lastYear;
    } else {
      output = day + magicNumber[month - 1] + step2 + step3 + lastYear;
    }
    print("Total: $output");
    int finalOutput = output % 7;
    print(finalOutput);
    print(int.parse(months[(month - 1)][1]));
    print(int.parse(months[(month - 1)][1]) + finalOutput);
    setState(() {
      startingDayOfSelectedMonth = finalOutput;
      startingDayOfSelectedMonthCopy = finalOutput;
    });
  }

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
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                DropdownButton<String>(
                                  value: selectedMonth,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedMonth = value!;
                                      for (int i = 0; i < months.length; i++) {
                                        if (value == months[i][0]) {
                                          selectedMonthIndex = i + 1;
                                          calculateDay(1, selectedMonthIndex,
                                              selectedYear);
                                          break;
                                        }
                                      }
                                    });
                                  },
                                  items: months.map<DropdownMenuItem<String>>(
                                      (List<String> value) {
                                    return DropdownMenuItem<String>(
                                      value: value[0],
                                      child: Text(value[0]),
                                    );
                                  }).toList(),
                                ),
                                DropdownButton<String>(
                                  value: selectedYear.toString(),
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  onChanged: (String? value) {
                                    setState(() {
                                      calculateDay(
                                          1, selectedMonthIndex, selectedYear);
                                      selectedYear = int.parse(value!);
                                    });
                                  },
                                  items: years.map<DropdownMenuItem<String>>(
                                      (int value) {
                                    return DropdownMenuItem<String>(
                                      value: value.toString(),
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                crossAxisSpacing: 7.0,
                                mainAxisSpacing: 7.0,
                              ),
                              itemCount: 7,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(50.0),
                                    // border: Border.all(width: 1.0, color: Colors.),
                                  ),
                                  child: Text(
                                    days[index],
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Divider(),
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                crossAxisSpacing: 7.0,
                                mainAxisSpacing: 7.0,
                              ),
                              itemCount:
                                  int.parse(months[selectedMonthIndex - 1][1]) +
                                      startingDayOfSelectedMonthCopy,
                              itemBuilder: (context, index) {
                                if (startingDayOfSelectedMonth > 0) {
                                  --startingDayOfSelectedMonth;
                                  return SizedBox();
                                }
                                return GestureDetector(
                                  onTap: () {

                                    String days = "", months = "";
                                    int day = index + 1;
                                    if ((day) <= 9) {
                                      days = "0$day";
                                    } else {
                                      days = "$day";
                                    }
                                    if (selectedMonthIndex <= 9) {
                                      months = "0$selectedMonthIndex";
                                    } else {
                                      months = "$selectedMonthIndex";
                                    }
                                    setState(() {
                                      
                                      _dateController.text =
                                          "$days/$months/$selectedYear";
                                      // _chosenDateTime = DateTime.parse("$days/$months/$selectedYear");
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      border: Border.all(
                                          width: 1.0, color: Colors.black),
                                    ),
                                    child: Text(
                                      "${(index + 1) - startingDayOfSelectedMonthCopy}",
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            // CalendarDatePicker(
                            //   onDateChanged: (DateTime value) {
                            //     String days = "", months = "";
                            //     if (value.day <= 9) {
                            //       days = "0${value.day}";
                            //     }else {
                            //       days = "${value.day}";
                            //     }
                            //     if (value.month <= 9) {
                            //       months = "0${value.month}";
                            //     }else {
                            //       months = "${value.month}";
                            //     }
                            //     setState(() {
                            //       _dateController.text =
                            //           "$days/$months/${value.year}";
                            //       _chosenDateTime = value;
                            //     });
                            //   },
                            //   lastDate: DateTime.now(),
                            //   firstDate: DateTime.now()
                            //       .subtract(Duration(days: 25000)),
                            //   initialDate: DateTime.now(),
                            // ),
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
