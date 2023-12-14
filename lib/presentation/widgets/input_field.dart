import 'package:binance_demo/extensions/context_extension.dart';
import 'package:binance_demo/presentation/widgets/widgets.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.controller,
    super.key,
    this.onEditingComplete,
    this.isPassword = false,
    this.isDropDown = false,
    this.inputType,
    this.maxValue,
    this.maxLines = 1,
    this.isCard = false,
    this.autofocus = false,
    this.foreground = AppColors.blackTint2,
    this.validator,
    this.isReadOnly = false,
    this.icon,
    this.hintText,
    this.suffixText,
    this.textSize = 15,
    this.onSaved,
    this.onFieldSubmitted,
    this.radius = 8,
  });

  final VoidCallback? onSaved;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onFieldSubmitted;

  final String? suffixText;
  final double textSize;
  final bool isPassword;

  final bool isDropDown;
  final String? hintText;
  final TextInputType? inputType;
  final Color foreground;
  final int? maxValue;
  final int? maxLines;
  final bool isCard;
  final bool autofocus;
  final Widget? icon;
  final double radius;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).viewInsets.bottom,
      ),
      controller: controller,
      keyboardType: inputType,
      validator: validator,
      maxLength: maxValue,
      maxLines: maxLines,
      autofocus: autofocus,
      textCapitalization: TextCapitalization.sentences,
      onEditingComplete: onEditingComplete,
      readOnly: isReadOnly,
      style: TextStyle(
        color: foreground,
        fontSize: textSize,
        height: 1.6,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
      decoration: InputDecoration(
        counterText: '',
        filled: false,
        hintText: hintText,
        contentPadding:
            const EdgeInsets.only(top: 20, bottom: 12, left: 16, right: 5),
        hintStyle: TextStyle(
          fontSize: textSize,
          height: 1.7,
          color: foreground.withOpacity(0.8),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.isDarkMode
                ? AppColors.blackTint3
                : const Color(0xfff1f1f1),
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.isDarkMode
                ? AppColors.blackTint3
                : const Color(0xfff1f1f1),
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        suffixIconConstraints:
            const BoxConstraints(minHeight: 19, minWidth: 19),
        suffixIcon: suffixText != null
            ? Padding(
                padding: const EdgeInsets.only(right: 16),
                child: AppText.body1(
                  suffixText!,
                  fontSize: textSize,
                  color: foreground.withOpacity(0.8),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
