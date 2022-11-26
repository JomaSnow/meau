import 'package:app/util/design.dart';
import 'package:app/widgets/drawer_dropdown_item.dart';
import 'package:app/widgets/drawer_item.dart';
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

  bool _userToggled = true;
  bool _shortcutsToggled = false;
  bool _infoToggled = false;
  bool _settingsToggled = false;

  void _toggleUserDropdown() {
    if (_userListHeight != null) {
      setState(() {
        _userListHeight = null;
      });
    } else {
      setState(() {
        _userListHeight = 0;
      });
    }
    setState(() {
      _userToggled = !_userToggled;
    });
  }

  void _toggleShortcutsDropdown() {
    if (_shortcutsListHeight != null) {
      setState(() {
        _shortcutsListHeight = null;
      });
    } else {
      setState(() {
        _shortcutsListHeight = 0;
      });
    }
    setState(() {
      _shortcutsToggled = !_shortcutsToggled;
    });
  }

  void _toggleInfoDropdown() {
    if (_infoListHeight != null) {
      setState(() {
        _infoListHeight = null;
      });
    } else {
      setState(() {
        _infoListHeight = 0;
      });
    }
    setState(() {
      _infoToggled = !_infoToggled;
    });
  }

  void _toggleSettingsDropdown() {
    if (_settingsListHeight != null) {
      setState(() {
        _settingsListHeight = null;
      });
    } else {
      setState(() {
        _settingsListHeight = 0;
      });
    }
    setState(() {
      _settingsToggled = !_settingsToggled;
    });
  }

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
          DrawerDropdownItem(
            onTap: _toggleUserDropdown,
            color: Design.lightBlue,
            title: "Prof Shahmat",
            dropdownToggled: _userToggled,
          ),
          Container(
            height: _userListHeight,
            color: Design.white2,
            child: Column(
              children: [
                DrawerItem(
                  title: "Meu perfil",
                  onTap: () {},
                ),
                DrawerItem(
                  title: "Meus pets",
                  onTap: () {},
                ),
                DrawerItem(
                  title: "Favoritos",
                  onTap: () {},
                ),
                DrawerItem(
                  title: "Chat",
                  onTap: () {},
                ),
              ],
            ),
          ),
          DrawerDropdownItem(
            onTap: _toggleShortcutsDropdown,
            color: Design.lightYellow,
            icon: Icons.pets,
            title: "Atalhos",
            dropdownToggled: _shortcutsToggled,
          ),
          Container(
            height: _shortcutsListHeight,
            color: Design.white2,
            child: Column(
              children: [
                DrawerItem(
                  title: "Cadastrar um pet",
                  onTap: () {},
                ),
                DrawerItem(
                  title: "Adotar um pet",
                  onTap: () {},
                ),
                DrawerItem(
                  title: "Ajudar um pet",
                  onTap: () {},
                ),
                DrawerItem(
                  title: "Apadrinhar um pet",
                  onTap: () {},
                ),
              ],
            ),
          ),
          DrawerDropdownItem(
            onTap: _toggleInfoDropdown,
            color: Design.accentBlue,
            icon: Icons.info,
            title: "Informações",
            dropdownToggled: _infoToggled,
          ),
          Container(
            height: _infoListHeight,
            color: Design.white2,
            child: Column(
              children: [
                DrawerItem(
                  title: "Dicas",
                  onTap: () {},
                ),
                DrawerItem(
                  title: "Eventos",
                  onTap: () {},
                ),
                DrawerItem(
                  title: "Legislação",
                  onTap: () {},
                ),
                DrawerItem(
                  title: "Termo de adoção",
                  onTap: () {},
                ),
                DrawerItem(
                  title: "Histórias de adoção",
                  onTap: () {},
                ),
              ],
            ),
          ),
          DrawerDropdownItem(
            onTap: _toggleSettingsDropdown,
            color: Design.lightestGray,
            icon: Icons.settings,
            title: "Configurações",
            dropdownToggled: _settingsToggled,
          ),
          Container(
            height: _settingsListHeight,
            color: Design.white2,
            child: Column(
              children: [
                DrawerItem(
                  title: "Privacidade",
                  onTap: () {},
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
