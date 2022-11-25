import 'dart:developer';

import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.title = "",
      this.leadingAction = _defaultLeadingAction,
      this.leadingIcon,
      this.transparentBackground = false,
      this.backgroundColor = Design.accentBlue,
      this.iconsColor = Design.darkerGray});

  final String title;
  final Color backgroundColor;
  final Color iconsColor;
  final bool transparentBackground;
  final VoidCallback leadingAction;
  final LeadingIcon? leadingIcon;

  static _defaultLeadingAction() {
    log("Pressed leading icon. Remember to pass a function to leadingAction attribute.");
  }

  Widget _drawLeadingIcon(LeadingIcon? icon) {
    if (icon == LeadingIcon.search) {
      return IconButton(
        icon: const Icon(Icons.search),
        color: iconsColor,
        onPressed: leadingAction,
      );
    }

    if (icon == LeadingIcon.share) {
      return IconButton(
        icon: const Icon(Icons.share),
        color: iconsColor,
        onPressed: leadingAction,
      );
    }

    if (icon == LeadingIcon.options) {
      return IconButton(
        icon: const Icon(Icons.more_vert),
        color: iconsColor,
        onPressed: leadingAction,
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: iconsColor),
      shadowColor: transparentBackground ? Colors.transparent : null,
      backgroundColor:
          transparentBackground ? Colors.transparent : backgroundColor,
      actions: [
        _drawLeadingIcon(leadingIcon),
      ],
      actionsIconTheme: IconThemeData(color: iconsColor),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: "Roboto",
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Design.darkerGray,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

enum LeadingIcon {
  search,
  share,
  options,
}
