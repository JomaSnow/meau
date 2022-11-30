import 'dart:developer';

import 'package:app/widgets/custom_drawer.dart';
import 'package:app/widgets/scrollable_container.dart';
import 'package:flutter/material.dart';
import '../util/design.dart';
import 'custom_app_bar.dart';

class PageTemplate extends StatelessWidget {
  const PageTemplate({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.showDrawer = true,
    this.title = "",
    this.appBarBackgroundColor = Design.accentBlue,
    this.appBarIconsColor = Design.darkerGray,
    this.appBarLeadingAction = _defaultLeadingAction,
    this.appBarLeadingIcon,
    this.appBarTransparentBackground = false,
    this.horizontalPadding = 15,
  });

  final List<Widget> children;
  final String title;
  final Color appBarBackgroundColor;
  final Color appBarIconsColor;
  final VoidCallback appBarLeadingAction;
  final LeadingIcon? appBarLeadingIcon;
  final bool appBarTransparentBackground;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final bool showDrawer;
  final double horizontalPadding;

  static _defaultLeadingAction() {
    log("Pressed leading icon. Remember to pass a function to leadingAction attribute.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: title,
        backgroundColor: appBarBackgroundColor,
        iconsColor: appBarIconsColor,
        leadingAction: appBarLeadingAction,
        leadingIcon: appBarLeadingIcon,
        transparentBackground: appBarTransparentBackground,
      ),
      drawer: showDrawer ? const CustomDrawer() : null,
      body: ScrollableContainer(
        horizontalPadding: horizontalPadding,
        child: Column(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: crossAxisAlignment,
            children: children),
      ),
    );
  }
}
