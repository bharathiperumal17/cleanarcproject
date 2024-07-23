import 'package:cleanarcproject/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton(
      {super.key, required this.btnName, required this.onPressed});
  final String btnName;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          gradient: LinearGradient(colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
            // AppPallete.gradient3
          ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: AppPallete.transparentColor,
            fixedSize: const Size(355, 55),
            backgroundColor: AppPallete.transparentColor),
        onPressed: onPressed,
        child: Text(
          btnName,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
