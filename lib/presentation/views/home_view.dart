import 'package:binance_demo/constants/constants.dart';
import 'package:binance_demo/extensions/context_extension.dart';
import 'package:binance_demo/presentation/views/components/components.dart';
import 'package:binance_demo/presentation/views/viewmodels/home_viewmodel.dart';
import 'package:binance_demo/presentation/widgets/widgets.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

final drawerItems = [
  'Exchange',
  'Wallets',
  'Roqqu Hub',
  'Log out',
];

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeViewModelProvider).getSymbols();
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(homeViewModelProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      endDrawer: Stack(
        children: [
          Positioned(
            top: 65,
            right: 10,
            child: Container(
              height: 208,
              width: 214,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).shadowColor,
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...drawerItems.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      child: AppText.body1(e),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      key: _scaffoldKey,
      appBar: PreferredSize(
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
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
                                icon: Icons.access_time_rounded,
                                title: "24h change",
                                isIncrease: true,
                                priceChange: "520.80 +1.25%",
                              ),
                              PriceChangeComponent(
                                icon: Icons.arrow_upward_rounded,
                                title: "24h high",
                                priceChange: "520.80 +1.25%",
                              ),
                              PriceChangeComponent(
                                icon: Icons.arrow_downward_rounded,
                                title: "24h low",
                                priceChange: "520.80 +1.25%",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap.h8,

                  // * Home Tab Section
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: Theme.of(context).shadowColor,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 42,
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Theme.of(context).shadowColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context).shadowColor,
                              width: 1.5,
                            ),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            padding: const EdgeInsets.all(2),
                            labelStyle: const TextStyle(
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            tabs: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: AppText.body1('Charts'),
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: AppText.body1('Orderbook'),
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: AppText.body1('Recent trades'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 550,
                          child: TabBarView(
                            controller: _tabController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              const CandleSticksSections(),
                              const OrderBookSection(),
                              Container(
                                height: 30,
                                padding: const EdgeInsets.all(20),
                                child: AppText.heading5(
                                  'Recent Trades',
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Gap.h30,
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: Theme.of(context).shadowColor,
                        width: 1.5,
                      ),
                    ),
                    child: const TradesSection(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: const BottomSheetSection(),
    );
  }
}
