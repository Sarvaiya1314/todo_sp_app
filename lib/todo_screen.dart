import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_sp_app/res/common/app_button.dart';
import 'package:todo_sp_app/res/common/app_container.dart';
import 'package:todo_sp_app/res/common/text_filed.dart';
import 'package:todo_sp_app/res/constant/app_strings.dart';

import 'model/app_todo_model.dart';

class AddToDoScreen extends StatefulWidget {
  final List<ToDoModel>? toDoList;
  final int? index;
  const AddToDoScreen({
    Key? key,
    this.toDoList,
    this.index,
  }) : super(key: key);

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  bool? dateIsSelect = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  bool? timeIsSelect = false;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    debugPrint("picked ---->> $selectedDate");
    debugPrint("picked ---->> $picked");

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateIsSelect = true;
      setState(() {});
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    debugPrint("picked ---->> $selectedTime");
    debugPrint("picked ---->> $picked");

    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      timeIsSelect = true;
      setState(() {});
    }
  }

  List<ToDoModel> toDoList = [];
  SharedPreferences? prefs;

  setInstant() async {
    prefs = await SharedPreferences.getInstance();
  }

  setData() {
    List<String> data = [];

    for (int i = 0; i < toDoList.length; i++) {
      data.add(jsonEncode(toDoList[i].toJson()));
    }
    debugPrint(data.toString());
    prefs!.setStringList('keys', data);
  }

  @override
  void initState() {
    toDoList = widget.toDoList!;
    if (widget.index != null) {
      titleController.text = toDoList[widget.index!].title!;
      desController.text = toDoList[widget.index!].des!;
      selectedDate = DateFormat('d/M/y').parse(toDoList[widget.index!].date!);
      dateIsSelect = true;
      var hour = toDoList[widget.index!].time!.split(" ").first.split(":").first;
      var minute = toDoList[widget.index!].time!.split(" ").first.split(":")[1];
      selectedTime = TimeOfDay(hour: int.parse(hour), minute: int.parse(minute));
      timeIsSelect = true;
    }
    setInstant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          const Text(
            "To Do Screen",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                children: [
                  AppTextField(
                    controller: titleController,
                    hintText: AppStings.enterTitle,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () => selectDate(context),
                        child: AppContainer(
                          icon: Icons.date_range,
                          hintText: dateIsSelect! ? DateFormat.yMd().format(selectedDate) : "Select Date",
                          isData: dateIsSelect!,
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () => selectTime(context),
                        child: AppContainer(
                          icon: Icons.timelapse,
                          hintText: timeIsSelect! ? selectedTime.format(context) : "Select Time",
                          isData: timeIsSelect!,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  AppTextField(controller: desController, hintText: "Description", isDes: true),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      if (widget.index != null) {
                        toDoList[widget.index!] = ToDoModel(
                          title: titleController.text,
                          date: DateFormat.yMd().format(selectedDate),
                          time: selectedTime.format(context),
                          des: desController.text,
                        );
                      } else {
                        toDoList.add(
                          ToDoModel(
                            title: titleController.text,
                            date: DateFormat.yMd().format(selectedDate),
                            time: selectedTime.format(context),
                            des: desController.text,
                          ),
                        );
                      }
                      setData();
                      Navigator.pop(context, toDoList);
                    },
                    child: const AppButton(
                      width: 150,
                      title: "add to do",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:todo_app/home_screen.dart';
//
// class TodoScreen extends StatefulWidget {
//   const TodoScreen({Key? key, List? TodoModel, required int index}) : super(key: key);
//
//   @override
//   State<TodoScreen> createState() => _TodoScreenState();
// }
//
// class _TodoScreenState extends State<TodoScreen> {
//   DateTime selectedDate = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();
//
//   Future<void> selectData(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000, 1),
//       lastDate: DateTime(2050),
//     );
//
//     debugPrint("Picked ---> $selectedDate");
//     debugPrint("Picked ---> $picked");
//
//     if (picked != null && picked != selectedDate) {
//       selectedDate = picked;
//       setState(() {});
//     }
//   }
//
//   Future<void> selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );
//
//     debugPrint("Picked ---> $selectedTime");
//     debugPrint("Picked ---> $picked");
//
//     if (picked != null && picked != selectedTime) {
//       selectedTime = picked;
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF242424),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: const [
//                   CupertinoNavigationBarBackButton(
//                     color: Colors.white,
//                   ),
//                   SizedBox(
//                     width: 30,
//                   ),
//                   Text(
//                     'TODO Information',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 20,
//                       color: Colors.white54,
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               const TextField(
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontFamily: 'Abel',
//                 ),
//                 textInputAction: TextInputAction.go,
//                 keyboardType: TextInputType.name,
//                 textCapitalization: TextCapitalization.words,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(12),
//                     ),
//                     borderSide: BorderSide(
//                       color: Colors.white60,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(12),
//                     ),
//                     borderSide: BorderSide(
//                       color: Colors.white60,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(12),
//                     ),
//                     borderSide: BorderSide(
//                       color: Colors.white60,
//                     ),
//                   ),
//                   labelText: "User Name",
//                   labelStyle: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontFamily: 'Montserrat',
//                     fontWeight: FontWeight.w500,
//                   ),
//                   hintText: 'Enter Name.',
//                   hintStyle: TextStyle(
//                     color: Colors.white12,
//                   ),
//                   prefixIcon: Icon(
//                     Icons.account_circle_sharp,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     height: 50,
//                     width: 155,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.white60,
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         SizedBox(
//                           width: 80,
//                           child: Text(
//                             DateFormat('d/M/yy').format(selectedDate),
//                             style: const TextStyle(
//                               color: Colors.white60,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             selectData(context);
//                           },
//                           child: Container(
//                             height: 35,
//                             width: 35,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(
//                                 color: const Color(0xFF063970),
//                               ),
//                             ),
//                             child: const Icon(
//                               Icons.calendar_month_rounded,
//                               color: Colors.lightBlue,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 50,
//                     width: 155,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.white60,
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         SizedBox(
//                           width: 90,
//                           child: Text(
//                             '${selectedTime.format(context)}',
//                             style: const TextStyle(
//                               color: Colors.white60,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             selectTime(context);
//                           },
//                           child: Container(
//                             height: 35,
//                             width: 35,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(
//                                 color: const Color(0xFF063970),
//                               ),
//                             ),
//                             child: const Icon(
//                               Icons.access_time_rounded,
//                               color: Colors.lightBlue,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 style: const TextStyle(
//                   color: Colors.white,
//                 ),
//                 keyboardType: TextInputType.name,
//                 textInputAction: TextInputAction.done,
//                 minLines: 6,
//                 maxLines: 8,
//                 obscureText: false,
//                 decoration: InputDecoration(
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.white60, width: 1.2),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                       color: Colors.white60,
//                       width: 1.2,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   border: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                       color: Colors.white60,
//                       width: 1.2,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   hintText: 'Review ',
//                   hintStyle: const TextStyle(color: Colors.white),
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(bottom: 20),
//         child: GestureDetector(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 CupertinoPageRoute(
//                   builder: (context) => const HomeScreen(),
//                 ));
//           },
//           child: Container(
//             height: 50,
//             width: 250,
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xFFfffffa),
//                   Color(0xFF36454f),
//                 ],
//               ),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.white10,
//                   blurRadius: 10,
//                   spreadRadius: 1,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//               border: Border.all(
//                 color: Colors.grey.shade500,
//               ),
//               borderRadius: BorderRadius.circular(25),
//             ),
//             child: const Center(
//               child: Text(
//                 'Submit',
//                 style: TextStyle(
//                   color: Colors.black45,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }
