import 'package:binance_demo/extensions/context_extension.dart';
import 'package:binance_demo/presentation/widgets/widgets.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class TradesSection extends StatefulWidget {
  const TradesSection({super.key});

  @override
  State<TradesSection> createState() => _TradesSectionState();
}

class _TradesSectionState extends State<TradesSection> {
  ValueNotifier<int> selectedValue = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              SizedBox(
                child: CupertinoSlidingSegmentedControl<int>(
                  backgroundColor: context.isDarkMode
                      ? AppColors.black.withOpacity(.16)
                      : const Color(0xffF1F1F1),
                  thumbColor: context.isDarkMode
                      ? const Color(0xff21262C)
                      : AppColors.white,
                  padding: const EdgeInsets.all(3),
                  groupValue: selectedValue.value,
                  children: {
                    0: Container(
                      width: 150,
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: AppText.body1(
                          'Open Orders',
                        ),
                      ),
                    ),
                    1: Container(
                      width: 150,
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: AppText.body1(
                          'Positions',
                        ),
                      ),
                    ),
                    2: Container(
                      width: 150,
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: AppText.body1(
                          'Order History',
                        ),
                      ),
                    ),
                    3: Container(
                      width: 150,
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: AppText.body1(
                          'Trade History',
                        ),
                      ),
                    ),
                  },
                  onValueChanged: (value) {
                    selectedValue.value = value!;
                  },
                ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: selectedValue,
          builder: (context, value, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(30),
                  AppText.heading5(
                    'No Open Orders',
                  ),
                  const Gap(5),
                  SizedBox(
                    width: 280,
                    child: AppText.body1(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
                      textAlign: TextAlign.center,
                      color: context.isDarkMode
                          ? AppColors.blackTint
                          : AppColors.blackTint2,
                      height: 2,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
