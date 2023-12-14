import 'package:binance_demo/constants/app_assets.dart';
import 'package:binance_demo/extensions/extensions.dart';
import 'package:binance_demo/presentation/views/home/viewmodels/home_viewmodel.dart';
import 'package:binance_demo/presentation/widgets/widgets.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class PriceChangeSection extends ConsumerWidget {
  const PriceChangeSection({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final vm = ref.watch(homeViewModelProvider);
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).shadowColor,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          const Gap(20),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizingConfig.defaultPadding - 2,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppAssets.btc_usd,
                  width: 44,
                  height: 24,
                ),
                const Gap(8),
                if (vm.currentSymbol != null) ...[
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        AppText.heading5(
                          vm.currentSymbol?.symbol ?? "",
                        ),
                        const Gap(10),
                        const Padding(
                          padding: EdgeInsets.all(2),
                          child: Icon(Icons.keyboard_arrow_down_rounded),
                        ),
                      ],
                    ),
                  ),
                  const Gap(27),
                  AppText.heading5(
                    vm.currentSymbol == null
                        ? ""
                        : '\$${double.tryParse(vm.currentSymbol!.price).formatValue()}',
                    color: AppColors.green,
                  ),
                ] else ...[
                  AppText.heading5(
                    '--',
                  ),
                  const Gap(10),
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(2),
                      child: Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                  ),
                  const Gap(27),
                  AppText.heading5(
                    r'$0.0',
                    color: AppColors.green,
                  ),
                ]
              ],
            ),
          ),
          const Gap(18),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 102,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 18,
                              color: AppColors.blackTint,
                            ),
                            const Gap(5),
                            AppText.body2(
                              '24h change',
                              color: AppColors.blackTint,
                            )
                          ],
                        ),
                        const Gap(5),
                        if (vm.candleTicker != null)
                          AppText.body1(
                            '${vm.candleTicker?.candle.volume.formatValue2()} +1%',
                            color: AppColors.green,
                          )
                        else
                          AppText.body1(
                            '0.00 +0.00%',
                            color: AppColors.green,
                          )
                      ],
                    ),
                  ),
                  const Gap(17),
                  Container(
                    width: 1,
                    height: 48,
                    color: AppColors.divider.withOpacity(.08),
                  ),
                  const Gap(17),
                  SizedBox(
                    width: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.arrow_upward_rounded,
                              size: 18,
                              color: AppColors.blackTint,
                            ),
                            const Gap(5),
                            AppText.body2(
                              '24h high',
                              color: AppColors.blackTint,
                            )
                          ],
                        ),
                        const Gap(5),
                        if (vm.candleTicker != null)
                          AppText.body1(
                            '${vm.candleTicker?.candle.high.formatValue()} +1%',
                          )
                        else
                          AppText.body1(
                            '0.00 +0.00%',
                          )
                      ],
                    ),
                  ),
                  const Gap(17),
                  Container(
                    width: 1,
                    height: 48,
                    color: AppColors.divider.withOpacity(.08),
                  ),
                  const Gap(17),
                  SizedBox(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.arrow_downward_rounded,
                              size: 18,
                              color: AppColors.blackTint,
                            ),
                            const Gap(5),
                            AppText.body2(
                              '24h low',
                              color: AppColors.blackTint,
                            )
                          ],
                        ),
                        const Gap(5),
                        if (vm.candleTicker != null)
                          AppText.body1(
                            '${vm.candleTicker?.candle.low.formatValue()} -1%',
                          )
                        else
                          AppText.body1(
                            '0.00 -0.00%',
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
