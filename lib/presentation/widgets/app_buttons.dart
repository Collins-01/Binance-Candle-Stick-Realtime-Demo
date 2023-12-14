import 'package:binance_demo/presentation/widgets/widgets.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.title,
    required this.onPressed,
    required this.color,
    this.height,
    this.width,
    super.key,
  });

  final VoidCallback onPressed;
  final String title;
  final double? width;
  final double? height;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        color: color,
        elevation: 0,
        padding: const EdgeInsets.all(8),
        onPressed: onPressed,
        child: AppText.button(
          title,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class AppGradientButton extends StatelessWidget {
  const AppGradientButton({
    required this.onPressed,
    required this.title,
    this.height,
    this.width,
    super.key,
  });

  final double? width;
  final double? height;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        gradient: const LinearGradient(
          colors: [
            Color(0xff483BEB),
            Color(0xff7847E1),
            Color(0xffDD568D),
          ],
        ),
      ),
      child: MaterialButton(
        color: Colors.transparent,
        elevation: 0,
        padding: const EdgeInsets.all(8),
        onPressed: onPressed,
        child: AppText.body1(
          title,
          color: AppColors.white,
        ),
      ),
    );
  }
}
