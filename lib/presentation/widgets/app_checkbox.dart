import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  const AppCheckbox({
    required this.value,
    super.key,
    this.onSwitch,
    this.text,
  });
  final bool value;
  final Function(bool)? onSwitch;
  final Widget? text;

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  late bool isToggled;
  @override
  void initState() {
    isToggled = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isToggled = !isToggled;
        widget.onSwitch!(isToggled);
      },
      child: Row(
        children: [
          AnimatedContainer(
            height: 17,
            width: 17,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isToggled
                  ? Theme.of(context).cardColor
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.blackTint,
                width: 1.1,
              ),
            ),
            child: isToggled
                ? const Center(
                    child: Icon(
                      Icons.check_rounded,
                      size: 13,
                      color: AppColors.blackTint2,
                    ),
                  )
                : const SizedBox(),
          ),
          if (widget.text != null) ...[widget.text!]
        ],
      ),
    );
  }
}
