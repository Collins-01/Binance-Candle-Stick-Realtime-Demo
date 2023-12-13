import 'package:binance_demo/extensions/extensions.dart';
import 'package:binance_demo/presentation/views/viewmodels/home_viewmodel.dart';
import 'package:binance_demo/presentation/widgets/widgets.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CandleSticksSections extends ConsumerWidget {
  const CandleSticksSections({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewModelProvider);
    return Container(
      width: context.getDeviceWidth,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizingConfig.defaultPadding,
              vertical: 10,
            ),
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
                          vm.intervals.length,
                          (index) => GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: vm.selectedInterval == index
                                    ? const Color(0xffCFD3D8)
                                    : null,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: AppText.body1(
                                vm.intervals[index],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          StreamBuilder(
            stream: vm.channel == null ? null : vm.candleSticksStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return SizedBox(
                  height: 300,
                  width: context.getDeviceWidth,
                  child: Candlesticks(
                    candles: vm.candles,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
