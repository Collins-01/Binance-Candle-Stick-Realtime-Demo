import 'package:binance_demo/constants/app_assets.dart';
import 'package:binance_demo/core/models/models.dart';
import 'package:binance_demo/extensions/extensions.dart';
import 'package:binance_demo/presentation/views/components/time_frame_section.dart';
import 'package:binance_demo/presentation/views/viewmodels/home_viewmodel.dart';
import 'package:binance_demo/presentation/widgets/widgets.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CandleSticksSection extends ConsumerStatefulWidget {
  const CandleSticksSection({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CandleSticksSectionState();
}

class _CandleSticksSectionState extends ConsumerState<CandleSticksSection> {
  bool _isTradingView = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _onModelReady();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(homeViewModelProvider);

    return Column(
      children: [
        const Gap(7),
        TimeFrameSection(
          onSelected: (value) {
            vm.setInterval(value);
          },
        ),
        const Gap(15),
        Divider(
          color: AppColors.blackTint.withOpacity(.1),
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 9,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  if (!_isTradingView) {
                    setState(() {
                      _isTradingView = true;
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 13,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: _isTradingView
                        ? context.isDarkMode
                            ? const Color(0xff555C63)
                            : const Color(0xffCFD3D8)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: AppText.body1(
                      'Trading view',
                      color: context.isDarkMode
                          ? AppColors.white
                          : AppColors.blackTint2,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (_isTradingView) {
                    setState(() {
                      _isTradingView = false;
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 13,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: !_isTradingView
                        ? context.isDarkMode
                            ? const Color(0xff555C63)
                            : const Color(0xffCFD3D8)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: AppText.body1(
                      'Depth',
                      color: context.isDarkMode
                          ? AppColors.white
                          : AppColors.blackTint2,
                    ),
                  ),
                ),
              ),
              const Gap(5),
              SvgPicture.asset(
                AppAssets.expand,
              )
            ],
          ),
        ),
        Divider(
          color: AppColors.blackTint.withOpacity(.1),
          thickness: 1,
        ),
        if (vm.candles.isNotEmpty)
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Candlesticks(
              key: Key(vm.currentSymbol!.symbol + vm.currentInterval),
              candles: vm.candles,
              onLoadMoreCandles: () {
                return vm.loadMoreCandles(
                  StreamValueDTO(
                    symbol: vm.currentSymbol!,
                    interval: vm.currentInterval.toLowerCase(),
                  ),
                );
              },
              // displayZoomActions: false,
              actions: [
                ToolBarAction(
                  width: 45,
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SvgPicture.asset(
                      AppAssets.arrow_down,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
                ToolBarAction(
                  width: 60,
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: AppText.body2(
                      vm.currentSymbol!.symbol,
                      fontSize: 11,
                      color: AppColors.blackTint2,
                    ),
                  ),
                ),
                if (vm.candleStick != null)
                  ToolBarAction(
                    width: 55,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          AppText.body2(
                            'O ',
                            fontSize: 11,
                            color: AppColors.blackTint2,
                          ),
                          AppText.body2(
                            vm.candleStick?.candle.open.formatValue() ?? "-",
                            fontSize: 11,
                            color: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (vm.candleStick != null)
                  ToolBarAction(
                    width: 55,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          AppText.body2(
                            'H ',
                            fontSize: 11,
                            color: AppColors.blackTint2,
                          ),
                          AppText.body2(
                            vm.candleStick?.candle.high.formatValue() ?? "-",
                            fontSize: 11,
                            color: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (vm.candleStick != null)
                  ToolBarAction(
                    width: 55,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          AppText.body2(
                            'L ',
                            fontSize: 11,
                            color: AppColors.blackTint2,
                          ),
                          AppText.body2(
                            vm.candleStick?.candle.low.formatValue() ?? "-",
                            fontSize: 11,
                            color: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (vm.candleStick != null)
                  ToolBarAction(
                    width: 55,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          AppText.body2(
                            'C ',
                            fontSize: 11,
                            color: AppColors.blackTint2,
                          ),
                          AppText.body2(
                            vm.candleStick?.candle.close.formatValue() ?? "-",
                            fontSize: 11,
                            color: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
