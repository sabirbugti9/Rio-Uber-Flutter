import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_scooter/core/utils/extensions.dart';
import 'package:share_scooter/feature/payment/view/bloc/account_bloc.dart';
import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../widgets/circle_elevated_button.dart';

class RechargeTheWalletPage extends StatefulWidget {
  const RechargeTheWalletPage({super.key});

  @override
  State<RechargeTheWalletPage> createState() => _RechargeTheWalletPageState();
}

class _RechargeTheWalletPageState extends State<RechargeTheWalletPage> {
  int? selected;

  Widget customRadioButton(int index, double numberPlus, double number) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return InkWell(
        onTap: () {
          setState(() {
            selected = index;
            selectedPrice = number;
          });
        },
        child: AspectRatio(
          aspectRatio: width > 450 ? 5 / 3 : 3 / 2,
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.surface,
              border: (selected == index)
                  ? Border.all(color: ColorManager.primary, width: 4)
                  : Border.all(color: ColorManager.border, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) => Padding(
                padding: EdgeInsets.only(
                  top: constraints.maxHeight * .25,
                  left: constraints.maxWidth * .1,
                  right: constraints.maxWidth * .05,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FittedBox(
                          child: Text(
                            "+ ${numberPlus.to3Dot()} T",
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: ColorManager.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        FittedBox(
                          child: Text(
                            "${number.to3Dot()} T",
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: ColorManager.highEmphasis,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  double? selectedPrice;

  double balance = 0.0;
  @override
  void initState() {
    // context.read<AccountBloc>().add(FetchAccountDetailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: ColorManager.appBg,
      appBar: const CustomAppBarWidget(title: "شارژ کیف پول"),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              AssetsImage.bgBody,
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            padding: EdgeInsets.only(
              left: width * 0.04,
              right: width * 0.04,
              top: height * 0.04,
              bottom: MediaQuery.of(context).viewInsets.bottom * .4,
            ),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "موجودی کیف پول",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: ColorManager.highEmphasis),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state) {
                      log(state.toString());
                      if (state is AccountComplete) {
                        balance = state.accountModel.credit;
                      }
                      return Text(
                        "${balance.to3Dot()} T",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w800,
                            color: ColorManager.highEmphasis),
                      );
                    },
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Text(
                    'اگر در هنگام سواری، موجودی کیف پول شما تمام شود؛ تا سواری بعدی باید اعتبار خود را شارژ نمائید.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.mediumEmphasis,
                      height: 1.8,
                    ),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  SizedBox(
                    height: width > 450 ? height * .25 : height * .15,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      itemCount: 4,
                      itemBuilder: (context, i) =>
                          customRadioButton(i, 5000.0, 10000.0),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  DesiredAmountCardWidget(width: width),
                  SizedBox(
                    height: height * .01,
                  ),
                  Text(
                    'به ازای مبالغ بالای 50.000 تومان، 10% جایزه به اعتبار شما افزوده می شود.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.mediumEmphasis,
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: height * .1,
              width: double.infinity,
              padding: EdgeInsets.zero,
              color: ColorManager.appBg,
              child: Padding(
                padding: EdgeInsets.only(
                  left: width * 0.04,
                  right: width * 0.04,
                  bottom: height * 0.015,
                  top: height * 0.015,
                ),
                child: CustomElevatedButton(
                  onTap: () {
                    context
                        .read<AccountBloc>()
                        .add(AddCreditEvent(selectedPrice ?? 0.0));
                  },
                  content: selectedPrice != null
                      ? "شارژ ${selectedPrice?.to3Dot()} تومان"
                      : "پرداخت اینترنتی",
                  fontSize: 16,
                  bgColor: ColorManager.primary,
                  frColor: Colors.white,
                  borderRadius: 12,
                  width: width,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DesiredAmountCardWidget extends StatelessWidget {
  const DesiredAmountCardWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * .18,
      width: width,
      decoration: BoxDecoration(
        color: ColorManager.surfacePrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorManager.border,
          width: 1,
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                CustomElevatedButton(
                  onTap: null,
                  content: "مبلغ دلخواه",
                  fontSize: 16,
                  bgColor: ColorManager.primaryExtraLight,
                  frColor: Colors.white,
                  borderRadius: 12,
                  width: width,
                ),
                const SizedBox(
                  height: 15,
                ),
                CircleElevatedButton(
                  onTap: () {},
                  icon: AssetsIcon.add,
                  bgColor: ColorManager.surface,
                  frColor: ColorManager.primaryDark,
                ),
                const SizedBox(
                  height: 17,
                ),
              ],
            )),
      ),
    );
  }
}
