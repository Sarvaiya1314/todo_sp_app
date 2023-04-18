import 'package:flutter/material.dart';

import '../constant/app_theam_color.dart';

class AppContainer extends StatelessWidget {
  final String? hintText;
  final bool? isData;
  final IconData? icon;
  const AppContainer({Key? key, this.hintText, this.isData, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 150,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppThemeColor.hintColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon!, color: Colors.grey),
          const SizedBox(
            width: 6,
          ),
          Text(
            hintText ?? "",
            style: TextStyle(
              color: isData! ? AppThemeColor.textColor : AppThemeColor.textHintColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
