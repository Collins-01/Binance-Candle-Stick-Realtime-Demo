import 'package:binance_demo/constants/constants.dart';
import 'package:binance_demo/extensions/extensions.dart';
import 'package:binance_demo/presentation/widgets/widgets.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarSection extends PreferredSize {
  const AppBarSection(
      {super.key, required super.preferredSize, required super.child});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(63),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).shadowColor,
              width: 1.5,
            ),
          ),
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: SvgPicture.asset(
            AppAssets.company_logo,
            colorFilter: ColorFilter.mode(
              context.isDarkMode ? AppColors.white : AppColors.black,
              BlendMode.colorBurn,
            ),
          ),
          actions: [
            Row(
              children: [
                SvgPicture.asset(AppAssets.avatar),
                Gap.w16,
                SvgPicture.asset(AppAssets.internet),
                Gap.w16,
                SvgPicture.asset(AppAssets.menu),
              ],
            ),
            Gap.w14,
          ],
        ),
      ),
    );
  }
}
