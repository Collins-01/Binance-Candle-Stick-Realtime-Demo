import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ///The parts of the display that
  ///are partially obscured by system UI, typically by
  ///the hardware display "notches" or the system status bar.
  ///If you consumed this padding
  /// (e.g. by building a widget that envelops or accounts for this padding in
  /// its layout in such a way that children are no
  /// longer exposed to this padding),
  ///  you should remove this padding for
  /// subsequent descendants in the widget tree
  EdgeInsets get padding => MediaQuery.of(this).padding;

  /// width of device
  double get getDeviceWidth => MediaQuery.of(this).size.width;

  Size get size => MediaQuery.of(this).size;

  /// height of device
  double get getDeviceHeight => MediaQuery.of(this).size.height;

  /// width of device
  bool isDeviceWidthGreaterThan(double size) =>
      MediaQuery.of(this).size.width > size;

  /// height of device
  bool isDeviceHeightGreaterThan(double size) =>
      MediaQuery.of(this).size.height > size;

  /// width of device - without the values of the parts of the device
  /// that is obstructed by system UI
  double get getDeviceWidthNoPadding =>
      MediaQuery.of(this).size.width - padding.horizontal;

  /// height of device - without the values of the parts of the device
  /// that is obstructed by system UI
  double get getDeviceHeightNoPadding =>
      MediaQuery.of(this).size.height - padding.vertical;

  /// this is an extention to help get device width
  /// passing the argument [subtract] reduce the width
  /// by that value.
  double deviceWidth({double? subtract}) {
    double width = MediaQuery.of(this).size.width;
    // reduce the width by the value user passed
    if (subtract != null) {
      width -= subtract;
    }
    return width;
  }

  /// this is an extention to help get device height
  /// passing the argument ``subtract`` reduce the width
  /// by that value.
  double deviceHeight({double? subtract}) {
    double height = MediaQuery.of(this).size.height;
    // reduce the width by the value user passed
    if (subtract != null) {
      height -= subtract;
    }
    return height;
  }

  /// this is an extention to help get device height
  /// in percentage
  double deviceHeightPercentage({required double percentage}) {
    double height = MediaQuery.of(this).size.height;

    // calculate the height percentage
    return height * (percentage / 100);
  }

  /// this is an extention to help get device width
  /// in percentage
  double deviceWidthPercentage({required double percentage}) {
    double width = MediaQuery.of(this).size.width;

    // calculate the width percentage
    return width * (percentage / 100);
  }

  bool get isDarkMode {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark;
  }
}
