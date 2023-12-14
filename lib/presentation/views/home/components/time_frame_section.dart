import 'package:binance_demo/constants/app_assets.dart';
import 'package:binance_demo/extensions/context_extension.dart';
import 'package:binance_demo/presentation/views/home/viewmodels/home_viewmodel.dart';
import 'package:binance_demo/presentation/widgets/widgets.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimeFrameSection extends ConsumerWidget {
  TimeFrameSection({
    required this.onSelected,
    super.key,
  });

  final Function(String) onSelected;

  final List<String> timeframes = [
    '1H',
    '2H',
    '4H',
    '1D',
    '1W',
    '1M',
  ];

  @override
  Widget build(BuildContext context, ref) {
    final vm = ref.watch(homeViewModelProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            AppText.body1(
              'Time',
              color:
                  context.isDarkMode ? AppColors.white : AppColors.blackTint2,
            ),
            Gap.w4,
            ...timeframes.map(
              (e) => InkWell(
                onTap: () {
                  onSelected.call(e);
                  vm.setInterval(e);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 40,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: vm.currentInterval == e
                        ? context.isDarkMode
                            ? const Color(0xff555C63)
                            : const Color(0xffCFD3D8)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: AppText.body1(
                      e,
                      color: context.isDarkMode
                          ? AppColors.white
                          : AppColors.blackTint2,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 25,
                    color: AppColors.divider.withOpacity(.08),
                  ),
                  const Gap(5),
                  SvgPicture.asset(
                    AppAssets.charts,
                    // colorFilter: ColorFilter.mode(
                    //   context.isDarkMode
                    //       ? AppColors.white
                    //       : AppColors.blackTint2,
                    //   BlendMode.colorBurn,
                    // ),
                  )
                ],
              ),
            ),
            Gap.w6,
            Container(
              width: 1,
              height: 25,
              color: AppColors.divider.withOpacity(.08),
            ),
            Gap.w6,
            AppText.body1(
              'Fx Indicators',
              color: context.isDarkMode
                  ? AppColors.blackTint
                  : AppColors.blackTint2,
            ),
            Gap.w6,
          ],
        ),
      ),
    );
  }
}
