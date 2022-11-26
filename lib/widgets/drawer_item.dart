import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    this.title = "",
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 26),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Design.lightestGray, style: BorderStyle.solid, width: 1),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontSize: 14,
            color: Design.darkerGray,
          ),
        ),
      ),
    );
  }
}
