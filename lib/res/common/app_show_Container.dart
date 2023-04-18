import 'package:flutter/material.dart';

class AppShowContainer extends StatelessWidget {
  const AppShowContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'Edit',
      'Delete',
    ];
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white10,
                    )),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white10,
                  ),
                ),
                child: PopupMenuButton(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: items,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Edit',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: items,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.blueAccent,
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
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white10,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
