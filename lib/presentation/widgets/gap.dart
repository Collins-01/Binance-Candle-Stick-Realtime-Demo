import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  const Gap(int i, {super.key, this.height = 10, this.width = 10});

  ///assign [gap] to [height] and [width]
  const Gap.both(double gap, {super.key})
      : height = gap,
        width = gap;

  ///assign [gap] to [height]
  const Gap.h(double gap, {super.key})
      : height = gap,
        width = 0;

  ///assign [gap] to [width]
  const Gap.w(double gap, {super.key})
      : width = gap,
        height = 0;

  ///assign 0 (zero) to [height] and [width]
  const Gap.shrink({super.key})
      : height = 0,
        width = 0;

  final double height;
  final double width;

  static Gap get s4 => const Gap.both(4);
  static Gap get s6 => const Gap.both(6);
  static Gap get s8 => const Gap.both(8);
  static Gap get s10 => const Gap.both(10);
  static Gap get s12 => const Gap.both(12);
  static Gap get s14 => const Gap.both(14);
  static Gap get s16 => const Gap.both(16);
  static Gap get s18 => const Gap.both(18);
  static Gap get s20 => const Gap.both(20);
  static Gap get s22 => const Gap.both(22);
  static Gap get s24 => const Gap.both(24);
  static Gap get s26 => const Gap.both(26);
  static Gap get s28 => const Gap.both(28);
  static Gap get s30 => const Gap.both(30);
  static Gap get s32 => const Gap.both(32);

  // Width const
  static Gap get w4 => const Gap.w(4);
  static Gap get w6 => const Gap.w(6);
  static Gap get w8 => const Gap.w(8);
  static Gap get w10 => const Gap.w(10);
  static Gap get w12 => const Gap.w(12);
  static Gap get w14 => const Gap.w(14);
  static Gap get w16 => const Gap.w(16);
  static Gap get w18 => const Gap.w(18);
  static Gap get w20 => const Gap.w(20);
  static Gap get w22 => const Gap.w(22);
  static Gap get w24 => const Gap.w(24);
  static Gap get w26 => const Gap.w(26);
  static Gap get w28 => const Gap.w(28);
  static Gap get w30 => const Gap.w(30);
  static Gap get w32 => const Gap.w(32);

  // Height const
  static Gap get h4 => const Gap.h(4);
  static Gap get h6 => const Gap.h(6);
  static Gap get h8 => const Gap.h(8);
  static Gap get h10 => const Gap.h(10);
  static Gap get h12 => const Gap.h(12);
  static Gap get h14 => const Gap.h(14);
  static Gap get h16 => const Gap.h(16);
  static Gap get h18 => const Gap.h(18);
  static Gap get h20 => const Gap.h(20);
  static Gap get h22 => const Gap.h(22);
  static Gap get h24 => const Gap.h(24);
  static Gap get h26 => const Gap.h(26);
  static Gap get h28 => const Gap.h(28);
  static Gap get h30 => const Gap.h(30);
  static Gap get h32 => const Gap.h(32);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}
