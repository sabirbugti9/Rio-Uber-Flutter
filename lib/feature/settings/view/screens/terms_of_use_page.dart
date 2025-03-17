import 'package:flutter/material.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.appBg,
      appBar: const CustomAppBarWidget(title: "Terms of Use"),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Lorem ipsum is a placeholder text used in the printing and typesetting industry. It has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries but also the leap into electronic typesetting, remaining essentially unchanged. It was popularized in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.highEmphasis),
            ),
          )
        ],
      ),
    );
  }
}
