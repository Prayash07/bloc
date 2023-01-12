import 'package:bloc_test/logic/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: Text('Settings'),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          final notificationSnackBar = SnackBar(
            duration: Duration(milliseconds: 700),
            content: Text(
              'App ' +
                  state.appNotifications.toString().toUpperCase() +
                  ', Email ' +
                  state.emailNotification.toString().toUpperCase(),
            ),
          );
          // Scaffold.of(context).showSnackBar(notificationSnackBar);
          ScaffoldMessenger.of(context).showSnackBar(notificationSnackBar);
        },
        builder: (context, state) {
          return Container(
            child: Column(
              children: [
                SwitchListTile(
                  value: state.appNotifications,
                  onChanged: (newValue) {
                    BlocProvider.of<SettingsCubit>(context)
                        .toggleAppNotifications(newValue);
                  },
                  title: Text('App Notifications'),
                ),
                SwitchListTile(
                  value: state.emailNotification,
                  onChanged: (newValue) {
                    context
                        .read<SettingsCubit>()
                        .toggleEmailNotification(newValue);
                  },
                  title: Text('Email Notifications'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
