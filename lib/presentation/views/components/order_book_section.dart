import 'package:binance_demo/constants/constants.dart';
import 'package:binance_demo/extensions/extensions.dart';
import 'package:binance_demo/presentation/widgets/widgets.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class OrderBookSection extends ConsumerWidget {
  const OrderBookSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        //* SELECT SECTION
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: context.isDarkMode
                          ? const Color(0xff353945)
                          : const Color(0xffCFD3D8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: SvgPicture.asset(
                      AppAssets.select_1,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        // color: Color(0xffCFD3D8),
                        ),
                    child: SvgPicture.asset(
                      AppAssets.select_2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: const BoxDecoration(
                        // color: Color(0xffCFD3D8),
                        ),
                    child: SvgPicture.asset(
                      AppAssets.select_3,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? const Color(0xff353945)
                      : const Color(0xffCFD3D8),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    AppText.caption(
                      '10',
                    ),
                    const Gap(5),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ],
          ),
        ),
        // * ORDER BOOK TITLES
        const Gap(12),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.body2(
                    'Price',
                    color: context.isDarkMode
                        ? AppColors.blackTint
                        : AppColors.blackTint2,
                  ),
                  const Gap(5),
                  AppText.small(
                    'USDT',
                    color: context.isDarkMode
                        ? AppColors.blackTint
                        : AppColors.blackTint2,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.body2(
                    'Amounts',
                    color: context.isDarkMode
                        ? AppColors.blackTint
                        : AppColors.blackTint2,
                  ),
                  const Gap(5),
                  AppText.small(
                    'BTC',
                    color: context.isDarkMode
                        ? AppColors.blackTint
                        : AppColors.blackTint2,
                  )
                ],
              ),
              AppText.body2(
                'Total',
                color: context.isDarkMode
                    ? AppColors.blackTint
                    : AppColors.blackTint2,
              ),
            ],
          ),
        ),
        const Gap(15),
        // * ORDER BOOK UI DISPLAY
      ],
    );
  }
}
