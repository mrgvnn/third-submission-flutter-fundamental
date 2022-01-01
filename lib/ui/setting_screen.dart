import 'dart:io';

import 'package:firstffasubmission/provider/preferences_provider.dart';
import 'package:firstffasubmission/provider/scheduling_provider.dart';
import 'package:firstffasubmission/utility/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({key}) : super(key: key);
  static const routeName = '/setting_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings Page'),
        ),
        body: _buildList(context));
  }

  _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Scheduling Restaurant'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyRestoActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledRestaurant(value);
                          provider.enableDailyResto(value);
                        }
                      },
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
