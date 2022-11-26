import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  double? _userListHeight;
  double? _shortcutsListHeight = 0;
  double? _infoListHeight = 0;
  double? _settingsListHeight = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: Design.lightBlue,
            height: 124,
            child: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "lib/assets/images/user_avatar_placeholder.jpg",
                        height: 70,
                        width: 70,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Prof. Shahmat",
                  style: TextStyle(
                      color: Design.darkerGray,
                      fontSize: 14,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.expand_more_rounded,
                  color: Design.darkerGray,
                )
              ],
            ),
            onTap: () {
              if (_userListHeight != null) {
                setState(() {
                  _userListHeight = null;
                });
              } else {
                setState(() {
                  _userListHeight = 0;
                });
              }
            },
            tileColor: Design.lightBlue,
          ),
          Container(
            height: _userListHeight,
            color: Design.white2,
            child: Column(
              children: const [
                ListTile(
                  title: Text("Item"),
                ),
                ListTile(
                  title: Text("Item"),
                ),
                ListTile(
                  title: Text("Item"),
                ),
                ListTile(
                  title: Text("Item"),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.pets,
                      color: Design.lightGray,
                      size: 24,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text(
                        "Atalhos",
                        style: TextStyle(
                            color: Design.darkerGray,
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.expand_more_rounded,
                  color: Design.darkerGray,
                )
              ],
            ),
            tileColor: Design.lightYellow,
            onTap: () {
              if (_shortcutsListHeight != null) {
                setState(() {
                  _shortcutsListHeight = null;
                });
              } else {
                setState(() {
                  _shortcutsListHeight = 0;
                });
              }
            },
          ),
          Container(
            height: _shortcutsListHeight,
            color: Design.white2,
            child: Column(
              children: const [
                ListTile(
                  title: Text("Item"),
                ),
                ListTile(
                  title: Text("Item"),
                ),
                ListTile(
                  title: Text("Item"),
                ),
                ListTile(
                  title: Text("Item"),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.info,
                      color: Design.lightGray,
                      size: 24,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text(
                        "Informações",
                        style: TextStyle(
                            color: Design.darkerGray,
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.expand_more_rounded,
                  color: Design.darkerGray,
                )
              ],
            ),
            tileColor: Design.accentBlue,
            onTap: () {
              if (_infoListHeight != null) {
                setState(() {
                  _infoListHeight = null;
                });
              } else {
                setState(() {
                  _infoListHeight = 0;
                });
              }
            },
          ),
          Container(
            height: _infoListHeight,
            color: Design.white2,
            child: Column(
              children: const [
                ListTile(
                  title: Text("Item"),
                ),
                ListTile(
                  title: Text("Item"),
                ),
                ListTile(
                  title: Text("Item"),
                ),
                ListTile(
                  title: Text("Item"),
                ),
                ListTile(
                  title: Text("Item"),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.settings,
                      color: Design.lightGray,
                      size: 24,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text(
                        "Configurações",
                        style: TextStyle(
                            color: Design.darkerGray,
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.expand_more_rounded,
                  color: Design.darkerGray,
                )
              ],
            ),
            tileColor: Design.lightestGray,
            onTap: () {
              if (_settingsListHeight != null) {
                setState(() {
                  _settingsListHeight = null;
                });
              } else {
                setState(() {
                  _settingsListHeight = 0;
                });
              }
            },
          ),
          Container(
            height: _settingsListHeight,
            color: Design.white2,
            child: Column(
              children: const [
                ListTile(
                  title: Text("Item"),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Center(
              child: Text(
                "Sair",
                style: TextStyle(
                    color: Design.darkerGray,
                    fontSize: 14,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500),
              ),
            ),
            onTap: () {},
            tileColor: Design.lightBlue,
          ),
        ],
      ),
    );
  }
}
