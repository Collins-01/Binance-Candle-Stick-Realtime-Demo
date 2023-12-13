import 'package:binance_demo/constants/constants.dart';
import 'package:binance_demo/extensions/context_extension.dart';
import 'package:binance_demo/presentation/views/components/components.dart';
import 'package:binance_demo/presentation/views/viewmodels/home_viewmodel.dart';
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeViewModelProvider).getSymbols();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(homeViewModelProvider);
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 15,
                bottom: 15,
                left: SizingConfig.defaultPadding,
                right: SizingConfig.defaultPadding,
              ),
              // margin:
              //     EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap.h8,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizingConfig.defaultPadding,
                        vertical: 15,
                      ),
                      width: context.getDeviceWidth,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              AppText.heading5(vm.currentSymbol?.symbol ?? ""),
                              Gap.w16,
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 14,
                              ),
                              Gap.w16,
                              AppText.heading5(
                                "\$${vm.currentSymbol?.price ?? ""}",
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

                    TabIndicator(
                      currentIndex: vm.currentTabIndex,
                      options: const ["Charts", "Orderbook", "Recent trades"],
                      onTap: (index) {
                        vm.setTabIndex(index);
                      },
                    ),
                    //
                    Gap.h8,
                    if (vm.currentTabIndex == 0) const CandleSticksSections(),
                    if (vm.currentTabIndex == 1) const OrderBookSection(),
                    if (vm.currentTabIndex == 2) const SizedBox.shrink(),

                    Gap.h30,
                    Container(
                      width: context.getDeviceWidth,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gap.h20,
                          TabIndicator(
                            currentIndex: vm.bottomTabIndex,
                            options: const [
                              "Open Orders",
                              "Positions",
                              "Order History"
                            ],
                            onTap: (index) {
                              vm.setBottomTabIndex(index);
                            },
                          ),
                          Gap.h30,
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText.heading5("No Open Orders"),
                                Gap.h10,
                                AppText.body2(
                                  "Lorem ipsum dolor sit amet, consectetur.",
                                ),
                                AppText.body2(
                                    "adipiscing elit. Id pulvinar nullam sit imperdiet"),
                                AppText.body2("pulvinar")
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Gap.h(62),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizingConfig.defaultPadding,
                        vertical: 10,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TradeButton(
                            type: TradeType.Buy,
                            onPressed: () {},
                          ),
                          TradeButton(
                            type: TradeType.Sell,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    const Gap.h(62),
                    //Bottom.
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
