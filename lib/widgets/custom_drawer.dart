import 'package:app/api/user_functions.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/adopt_form_screen.dart';
import 'package:app/screens/adopt_screen.dart';
import 'package:app/screens/adopt_stories_screen.dart';
import 'package:app/screens/chat_screen.dart';
import 'package:app/screens/events_screen.dart';
import 'package:app/screens/favourites_screen.dart';
import 'package:app/screens/foster_screen.dart';
import 'package:app/screens/help_screen.dart';
import 'package:app/screens/intro_screen.dart';
import 'package:app/screens/legislation_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/my_pets_screen.dart';
import 'package:app/screens/no_account_screen.dart';
import 'package:app/screens/pet_register_screen.dart';
import 'package:app/screens/privacy_screen.dart';
import 'package:app/screens/profile_screen.dart';
import 'package:app/screens/tips_screen.dart';
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

  UserModel? currentUser;

  @override
  void initState() {
    _setCurrentUser();
    super.initState();
  }

  void _setCurrentUser() async {
    UserModel? user = await getCurrentUser();
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

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
                  currentUser != null
                      ? Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.memory(
                              currentUser!.image!,
                              height: 70,
                              width: 70,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Image.asset(
                            "lib/assets/images/Meau_marca.png",
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                ],
              ),
            ),
          ),
          currentUser != null
              ? Column(
                  children: [
                    DrawerDropdownItem(
                      onTap: _toggleUserDropdown,
                      color: Design.lightBlue,
                      title: currentUser!.nome,
                      dropdownToggled: _userToggled,
                    ),
                    Container(
                      height: _userListHeight,
                      color: Design.white2,
                      child: Column(
                        children: [
                          DrawerItem(
                            title: "Meu perfil",
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileScreen()));
                            },
                          ),
                          DrawerItem(
                            title: "Meus pets",
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyPetsScreen()));
                            },
                          ),
                          DrawerItem(
                            title: "Favoritos",
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FavouritesScreen()));
                            },
                          ),
                          DrawerItem(
                            title: "Chat",
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChatScreen()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
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
                  onTap: () {
                    Navigator.pop(context);
                    currentUser != null
                        ? Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PetRegisterScreen()))
                        : Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NoAccountScreen()));
                  },
                ),
                DrawerItem(
                  title: "Adotar um pet",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const AdoptScreen()));
                  },
                ),
                DrawerItem(
                  title: "Ajudar um pet",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HelpScreen()));
                  },
                ),
                DrawerItem(
                  title: "Apadrinhar um pet",
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const FosterScreen()));
                  },
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
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const TipsScreen()));
                  },
                ),
                DrawerItem(
                  title: "Eventos",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const EventsScreen()));
                  },
                ),
                DrawerItem(
                  title: "Legislação",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LegislationScreen()));
                  },
                ),
                DrawerItem(
                  title: "Termo de adoção",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const AdoptFormScreen()));
                  },
                ),
                DrawerItem(
                  title: "Histórias de adoção",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const AdoptStoriesScreen()));
                  },
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
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const PrivacyScreen()));
                  },
                ),
              ],
            ),
          ),
          currentUser != null
              ? ListTile(
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
                  onTap: () async {
                    await signOff();
                    if (!mounted) return;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IntroScreen()));
                  },
                  tileColor: Design.lightBlue,
                )
              : ListTile(
                  title: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Design.darkerGray,
                          fontSize: 14,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  tileColor: Design.lightBlue,
                ),
        ],
      ),
    );
  }
}
