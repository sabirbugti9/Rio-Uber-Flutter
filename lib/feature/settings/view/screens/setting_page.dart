import 'package:flutter/material.dart';
import 'package:share_scooter/core/utils/resources/routes_manager.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.appBg,
        appBar: const CustomAppBarWidget(title: "Settings"),
        body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: [
                Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: ColorManager.border, width: 1.0),
                  ),
                  color: ColorManager.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTileSetting(
                          title: 'Account',
                          leading: Icons.account_circle,
                          onTap: () {
                            Navigator.pushNamed(context, Routes.accountRoute);
                          },
                        ),
                        Divider(
                          color: ColorManager.border,
                          thickness: 1,
                        ),
                        ListTileSetting(
                          title: 'Change Language',
                          leading: Icons.language,
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.changeLanguageRoute);
                          },
                        ),
                        ListTileSetting(
                          title: 'Terms of Use',
                          leading: Icons.text_snippet_rounded,
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.termsOfUsePeageRoute);
                          },
                        ),
                        ListTileSetting(
                          title: 'Privacy Policy',
                          leading: Icons.privacy_tip,
                          onTap: () {},
                        ),
                        Divider(
                          color: ColorManager.border,
                          thickness: 1,
                        ),
                        ListTileSetting(
                          title: 'Log Out',
                          leading: Icons.exit_to_app,
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}

class ListTileSetting extends StatelessWidget {
  const ListTileSetting(
      {super.key,
      required this.title,
      required this.leading,
      required this.onTap});

  final String title;
  final IconData leading;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: ColorManager.highEmphasis,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: Icon(
        leading,
        color: ColorManager.placeholder,
        size: 24,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: ColorManager.placeholder,
        size: 24,
      ),
      onTap: onTap,
    );
  }
}
