import 'package:firstffasubmission/ui/favorite_screen.dart';
import 'package:firstffasubmission/ui/setting_screen.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100,
            child: const DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              child: Text(
                'Menu',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ),
          ListTile(
            title: const Text('Favoritmu'),
            leading: const Icon(Icons.favorite),
            onTap: () => Navigator.pushNamed(context, FavoriteScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Setting'),
            onTap: () => Navigator.pushNamed(context, SettingScreen.routeName),
          )
        ],
      ),
    );
  }
}
