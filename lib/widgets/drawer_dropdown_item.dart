import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class DrawerDropdownItem extends StatelessWidget {
  const DrawerDropdownItem(
      {super.key,
      this.title = "",
      this.icon,
      this.dropdownToggled = false,
      required this.onTap,
      this.color = Design.lightBlue});

  final String title;
  final IconData? icon;
  final bool dropdownToggled;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon != null
                  ? Icon(
                      icon,
                      color: Design.lightGray,
                      size: 24,
                    )
                  : Container(),
              Container(
                margin: EdgeInsets.only(left: (icon != null ? 20 : 0)),
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Design.darkerGray,
                      fontSize: 14,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Icon(
            dropdownToggled
                ? Icons.expand_less_rounded
                : Icons.expand_more_rounded,
            color: Design.darkerGray,
          )
        ],
      ),
      tileColor: color,
      onTap: onTap,
    );
  }
}
