import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../utils/resources/assets_manager.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const CustomAppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.surface,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 25,
        ),
      ),
      leading: IconButton(
        icon: SvgPicture.asset(
          color: ColorManager.primaryDark,
          AssetsIcon.back,
          matchTextDirection: true,
          fit: BoxFit.scaleDown,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
