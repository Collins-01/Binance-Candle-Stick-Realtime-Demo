import 'package:binance_demo/constants/constants.dart';
import 'package:binance_demo/extensions/extensions.dart';
import 'package:binance_demo/presentation/views/viewmodels/home_viewmodel.dart';
import 'package:binance_demo/presentation/widgets/widgets.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class OrderBookSection extends ConsumerWidget {
  const OrderBookSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewModelProvider);
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
        if (vm.orderBooks != null) ...[
          Column(
            children: List.generate(
              vm.orderBooks!.asks!.length > 5 ? 5 : vm.orderBooks!.asks!.length,
              (index) => Stack(
                children: [
                  Gap.h10,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      color: const Color(0xffFF6838).withOpacity(.15),
                      height: 28,
                      width:
                          (double.tryParse(vm.orderBooks!.asks![index]![0])! *
                                  double.tryParse(
                                      vm.orderBooks!.asks![index]![1])!) /
                              100,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.body1(
                          '${double.tryParse(vm.orderBooks!.asks![index]![0]!.toString())}',
                          color: const Color(0xffFF6838),
                        ),
                        AppText.body1(
                          double.tryParse(
                            vm.orderBooks!.asks![index]![1]!.toString(),
                          )!
                              .toStringAsFixed(3),
                        ),
                        AppText.body1(
                          (double.tryParse(vm.orderBooks!.asks![index]![0])! +
                                  double.tryParse(
                                      vm.orderBooks!.asks![index]![1])!)
                              .formatValue2(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(19),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     if (vm.orderBooks!.asks!.length >= 2 &&
          //         vm.orderBooks!.asks![0]!.isNotEmpty) ...[
          //       AppText.body1(
          //         '${double.tryParse(vm.orderBooks!.asks![1]![0]!.toString())}',
          //         color: const Color(0xff25C26E),
          //         fontSize: 16,
          //       ),
          //       const Gap(13),
          //       Icon(
          //         Icons.arrow_upward_rounded,
          //         size: 18,
          //         color: context.isDarkMode
          //             ? AppColors.blackTint
          //             : const Color(0xff25C26E),
          //       ),
          //       const Gap(13),
          //       AppText.body1(
          //         '${double.tryParse(vm.orderBooks!.bids![1]![0]!.toString())}',
          //         fontSize: 16,
          //         color: context.isDarkMode
          //             ? AppColors.white
          //             : AppColors.primaryBlack,
          //       ),
          //     ]
          //   ],
          // ),
          const Gap(19),
          Column(
            children: List.generate(
              vm.orderBooks!.bids!.length > 5 ? 5 : vm.orderBooks!.bids!.length,
              (index) => Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      color: const Color(0xff25C26E).withOpacity(.15),
                      height: 30,
                      width:
                          (double.tryParse(vm.orderBooks!.bids![index]![0])! *
                                  double.tryParse(
                                      vm.orderBooks!.bids![index]![1])!) /
                              100,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.body1(
                          '${double.tryParse(vm.orderBooks!.bids![index]![0]!.toString())}',
                          color: const Color(0xffFF6838),
                        ),
                        AppText.body1(
                          double.tryParse(
                            vm.orderBooks!.bids![index]![1]!.toString(),
                          )!
                              .toStringAsFixed(3),
                        ),
                        AppText.body1(
                          (double.tryParse(vm.orderBooks!.bids![index]![0])! +
                                  double.tryParse(
                                      vm.orderBooks!.bids![index]![1])!)
                              .formatValue2(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        const Gap(19),
      ],
    );
  }
}
