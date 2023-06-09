import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_sp_app/res/common/app_button.dart';
import 'package:todo_sp_app/res/constant/app_theam_color.dart';
import 'package:todo_sp_app/todo_screen.dart';

import 'model/app_todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = [
    'Edit',
    'delete',
  ];
  List<ToDoModel> toDoList = [];
  SharedPreferences? prefs;
  setInstant() async {
    prefs = await SharedPreferences.getInstance();
    getData();
  }

  setData() {
    List<String> data = [];

    for (int i = 0; i < toDoList.length; i++) {
      data.add(jsonEncode(toDoList[i].toJson()));
    }
    prefs!.setStringList('keys', data);
  }

  getData() {
    List<String> data = [];
    data = prefs!.getStringList('keys')!;

    for (int i = 0; i < data.length; i++) {
      toDoList.add(ToDoModel.fromJson(jsonDecode(data[i])));
    }
    debugPrint(toDoList.toString());
    setState(() {});
  }

  @override
  void initState() {
    setInstant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            "home screen",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: toDoList.isEmpty
          ? const Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  fontSize: 20,
                  color: AppThemeColor.textColor,
                ),
              ),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: toDoList.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title: ${toDoList[index].title}",
                            style: const TextStyle(color: AppThemeColor.Colortext, fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "date:${toDoList[index].date!}",
                            style: const TextStyle(color: AppThemeColor.Colortext, fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Time:${toDoList[index].time!}",
                            style: const TextStyle(color: AppThemeColor.Colortext, fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "description:${toDoList[index].des!}",
                            style: const TextStyle(color: AppThemeColor.Colortext, fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: items,
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Edit',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () async {
                                  dynamic data = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddToDoScreen(
                                        toDoList: toDoList,
                                        index: index,
                                      ),
                                    ),
                                  );
                                  if (data != null) {
                                    debugPrint("Data--->$data");
                                    toDoList = data;
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: items,
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Delete',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  toDoList.removeAt(index);
                                  setData();

                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      offset: const Offset(-30, 10),
                      color: Colors.grey,
                      elevation: 2,
                      onSelected: (value) {
                        debugPrint("value  --> $value");
                      },
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          dynamic data = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddToDoScreen(
                toDoList: toDoList,
              ),
            ),
          );

          if (data != null) {
            debugPrint("Data --> $data");
            toDoList = data;
            setState(() {});
          }
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 40),
          child: AppButton(
            title: "Add Todo",
            width: 250,
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:to_do_screens/to_do_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<String> items = [
//     'Edit',
//     'delete',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.asset("assets/images/splesh_screen_image.png"),
//           Center(
//             child: Image.asset(
//               "assets/images/home_screen.png",
//               height: 150,
//             ),
//           ),
//           Expanded(
//             child: ListView.separated(
//               separatorBuilder: (context, index) => const SizedBox(
//                 height: 20,
//               ),
//               physics: const BouncingScrollPhysics(),
//               itemCount: 3,
//               itemBuilder: (context, index) => Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey,
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     PopupMenuButton(
//                       padding: EdgeInsets.zero,
//                       itemBuilder: (context) => [
//                         PopupMenuItem(
//                           value: items,
//                           height: 30,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: const [
//                               Text(
//                                 'Edit',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               Icon(
//                                 Icons.edit,
//                                 color: Colors.black,
//                               ),
//                             ],
//                           ),
//                         ),
//                         PopupMenuItem(
//                           value: items,
//                           height: 30,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: const [
//                               Text(
//                                 'Delete',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               Icon(
//                                 Icons.delete_outline_rounded,
//                                 color: Colors.black,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                       offset: const Offset(-30, 10),
//                       color: const Color(0xFFFF97B1),
//                       elevation: 2,
//                       onSelected: (value) {
//                         debugPrint("value  --> $value");
//                       },
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 8),
//                       child: Container(
//                         height: 80,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.white10,
//                           ),
//                           borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(15),
//                             bottomRight: Radius.circular(15),
//                             topRight: Radius.circular(5),
//                             topLeft: Radius.circular(5),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     CupertinoPageRoute(
//                       builder: (context) => const ToDoScreen(),
//                     ));
//               },
//               child: Center(
//                 child: Container(
//                   height: 60,
//                   width: 200,
//                   decoration: BoxDecoration(
//                       color: const Color(0xFFFF97B1),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: const Center(
//                     child: Text(
//                       "add to do",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25,
//                         color: Color(0xFF030303),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//     );
//   }
// }
