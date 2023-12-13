import 'package:binance_demo/constants/constants.dart';
import 'package:binance_demo/extensions/context_extension.dart';
import 'package:binance_demo/presentation/views/components/components.dart';
import 'package:binance_demo/presentation/widgets/widgets.dart';

import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int selectedInterval = 0;
  final intervals = [
    '1m',
    '3m',
    '5m',
    '15m',
    '30m',
    '1h',
    '2h',
    '4h',
    '6h',
    '8h',
    '12h',
    '1d',
    '3d',
    '1w',
    '1M',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 15,
              ),
              margin:
                  EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
              width: context.getDeviceWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(AppAssets.company_logo),
                  Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.textColor,
                        ),
                      ),
                      Gap.w16,
                      const Icon(Icons.interests_rounded),
                      Gap.w16,
                      const Icon(Icons.menu)
                    ],
                  )
                ],
              ),
            ),
            //TODO: Add expanded to scroll
            Gap.h8,
            Container(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 15,
              ),
              margin:
                  EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
              width: context.getDeviceWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppText.heading5("BTC/USDT"),
                      Gap.w16,
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 14,
                      ),
                      Gap.w16,
                      AppText.heading5(
                        "\$20,634",
                        color: AppColors.green,
                      )
                    ],
                  ),
                  Gap.h14,
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        PriceChangeComponent(
                          icon: Icons.alarm_rounded,
                          title: "Change",
                          isIncrease: true,
                          priceChange: "520.80 +1.25%",
                        ),
                        PriceChangeComponent(
                          icon: Icons.arrow_downward,
                          title: "Change",
                          priceChange: "520.80 +1.25%",
                        ),
                        PriceChangeComponent(
                          icon: Icons.arrow_downward,
                          title: "Change",
                          priceChange: "520.80 +1.25%",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap.h8,
            //TODO: Finish Up
            Container(
              width: context.getDeviceWidth,
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              margin:
                  EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: AppText.body1("Charts"),
                  )
                ],
              ),
            ),
            //
            Gap.h8,
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
              child: Row(
                children: [
                  AppText.body1("Time"),
                  Gap.w4,
                  Expanded(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                          intervals.length,
                          (index) => GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: selectedInterval == index
                                    ? const Color(0xffCFD3D8)
                                    : null,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: AppText.body1(
                                intervals[index],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
