import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/core/utils/resources/functions.dart';
import 'package:share_scooter/feature/settings/view/cubit/account_cubit.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_form_field_widget.dart';
import 'package:flutter/services.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final persianRegExp = RegExp(r'^[\u0600-\u06FF\s]*$');
  final firstNameController = TextEditingController();
  final dateController = TextEditingController();
  final studentController = TextEditingController();
  final numberController = TextEditingController();
  final RegExp dateRegExp = RegExp(r'^\d{4}/\d{1,2}/\d{1,2}$');
  final RegExp studentRegExp = RegExp(r'^\d{8,10}$');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    numberController.text =
        context.read<AccountCubit>().state.account?.phone ?? "";
    firstNameController.text =
        context.read<AccountCubit>().state.account?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    log("build widget");
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
        backgroundColor: ColorManager.appBg,
        appBar: const CustomAppBarWidget(title: "حساب کاربری"),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
            right: 24,
            left: 24,
          ),
          child: Form(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight + height * .14,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                                color: ColorManager.border, width: 1.0),
                          ),
                          color: ColorManager.surface,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                CustomTextFormFieldWidget(
                                  inputFormatters: [
                                    PersianTextInputFormatter()
                                  ],
                                  valid: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'لطفا نام را وارد کنید';
                                    } else if (!persianRegExp.hasMatch(value)) {
                                      return 'فقط حروف فارسی مجاز است';
                                    }
                                    return null;
                                  },
                                  hintText: "نام و نام خانوادگی",
                                  controller: firstNameController,
                                ),
                                Divider(
                                  color: ColorManager.border,
                                  thickness: 1,
                                ),
                                CustomTextFormFieldWidget(
                                  hintText: "تاریخ تولد",
                                  controller: dateController,
                                  inputFormatters: [
                                    DateTextInputFormatter(),
                                  ],
                                  valid: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'لطفا تاریخ را وارد کنید';
                                    } else if (!dateRegExp.hasMatch(value)) {
                                      return 'فرمت تاریخ باید به صورت yyyy/MM/dd باشد';
                                    }
                                    return null;
                                  },
                                ),
                                Divider(
                                  color: ColorManager.border,
                                  thickness: 1,
                                ),
                                CustomTextFormFieldWidget(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  valid: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'لطفا کد ملی یا شماره دانشجویی را وارد کنید';
                                    } else if (!studentRegExp.hasMatch(value)) {
                                      return 'کد ملی یا شماره دانشجویی باید حداقل 8 و حداکثر شامل 10 عدد باشد';
                                    }
                                    return null;
                                  },
                                  hintText: "کدملی / شماره دانشجویی",
                                  controller: studentController,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'شماره دانشجویی و یا کد ملی معتبر وارد نمائید',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.mediumEmphasis,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                                color: ColorManager.border, width: 1.0),
                          ),
                          color: ColorManager.surface,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: CustomTextFormFieldWidget(
                              phoneNumberPrefix: true,
                              textAlign: TextAlign.start,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(13),
                              ],
                              onChanged: (value) {
                                numberController.text =
                                    formatNumber(value).trimRight();
                              },
                              valid: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'لطفا شماره تلفن خود را وارد کنید';
                                } else if (!phoneRegExp
                                    .hasMatch(value.replaceAll(' ', ''))) {
                                  return 'شماره تلفن معتبر نیست';
                                }
                                return null;
                              },
                              hintText: "شماره تماس",
                              controller: numberController,
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
        ),
        bottomSheet: SizedBox(
          width: width,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * .01, horizontal: width * .05),
            child: CustomElevatedButton(
              onTap: () {},
              content: "ذخیره",
              fontSize: 16,
              bgColor: ColorManager.primary,
              frColor: Colors.white,
              borderRadius: 12,
              width: width * .9,
            ),
          ),
        ));
  }
}

class PersianTextInputFormatter extends TextInputFormatter {
  final RegExp _persianRegExp = RegExp(r'^[\u0600-\u06FF\s]*$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (_persianRegExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

class DateTextInputFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'^\d{0,4}(/(\d{0,2}(/(\d{0,2})?)?)?)?$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_regExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
