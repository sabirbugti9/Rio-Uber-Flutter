import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/extensions.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/utils/resources/routes_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';
import 'package:share_scooter/feature/payment/view/bloc/account_bloc.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Drawer(
      backgroundColor: ColorManager.surface,
      width: width * .8,
      child: Column(
        children: [
          _getDrawerHeader(height, width),
          _getDrawerBody(),
        ],
      ),
    );
  }

  Widget _getDrawerBody() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          MenuListTile(
            title: "Ride History",
            icon: AssetsIcon.history,
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Navigator.pushNamed(
                context,
                Routes.rideHistoryRoute,
              );
            },
          ),
          MenuListTile(
            title: "Credit Payment",
            icon: AssetsIcon.payment,
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Navigator.pushNamed(
                context,
                Routes.creditPaymentRoute,
              );
            },
          ),
          MenuListTile(
            title: "Referral Credit",
            icon: AssetsIcon.earn,
            onTap: () {},
          ),
          MenuListTile(
            title: "Gift Card",
            icon: AssetsIcon.gift,
            onTap: () {},
          ),
          MenuListTile(
            title: "Rio Guide",
            icon: AssetsIcon.help,
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: SvgPicture.asset(
              AssetsIcon.settings,
            ),
            title: const Text(
              "Settings",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Navigator.pushNamed(
                context,
                Routes.settingRoute,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _getDrawerHeader(double height, double width) {
    return SizedBox(
      height: height * .4,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AssetsImage.menuBg,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: width * .075,
            top: height * .13,
            height: height * .1,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state) {
                      String name = "";
                      if (state is AccountComplete) {
                        name = state.accountModel.name;
                      }
                      return const Text(
                        "Hello Sabir Bugti",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      );
                    },
                  ),
                  const Text(
                    "Ready to ride with Rio today?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: width * .075,
            top: height * .26,
            width: width > 500 ? width * .4 : width * .65,
            height: height * .1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.walletBg,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SvgPicture.asset(
                        AssetsImage.bg,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          ColorManager.primaryDark,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * .02, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const FittedBox(
                                      child: Text(
                                        "Your Wallet Balance",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            wordSpacing: 2,
                                            letterSpacing: 1),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    BlocBuilder<AccountBloc, AccountState>(
                                      builder: (context, state) {
                                        double balance = 0.0;
                                        if (state is AccountComplete) {
                                          balance = state.accountModel.credit;
                                        }
                                        return FittedBox(
                                          child: Text(
                                            "${balance.to3Dot()} Toman (T)",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            CustomElevatedButton(
                              onTap: () => Navigator.pushNamed(
                                context,
                                Routes.rechargeWalletRoute,
                              ),
                              content: "Recharge",
                              fontSize: 16,
                              bgColor: ColorManager.surfaceTertiary,
                              frColor: Colors.black,
                              borderRadius: 12,
                              width: width > 500 ? width * .1 : width * .2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuListTile extends StatelessWidget {
  const MenuListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
      ),
      onTap: onTap,
      title: Align(
        alignment: Alignment.centerLeft,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
