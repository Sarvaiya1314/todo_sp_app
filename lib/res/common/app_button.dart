import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final double? width;
  const AppButton({Key? key, this.title, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width ?? 250,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFfffffa),
            Color(0xFF36454f),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.white10,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade500,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          title ?? '',
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
