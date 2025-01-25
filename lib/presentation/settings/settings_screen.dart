import 'dart:io';

import 'package:diresto/presentation/settings/cubit/settings_cubit.dart';
import 'package:diresto/presentation/widget/custom_dialog.dart';
import 'package:diresto/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyles.title,
        ),
      ),
      body: BlocBuilder<SettingsCubit, bool>(
        builder: (context, state) {
          return Column(
            children: [
              ListTile(
                title: Text(
                  'Reminder at 11 AM',
                  style: TextStyles.body,
                ),
                trailing: Switch.adaptive(
                  value: state,
                  onChanged: (value) {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      BlocProvider.of<SettingsCubit>(context)
                          .scheduledRestaurant(value);
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
