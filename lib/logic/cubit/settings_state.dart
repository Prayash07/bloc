part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool appNotifications;
  final bool emailNotification;

  SettingsState({
    required this.appNotifications,
    required this.emailNotification,
  });

  SettingsState.initialValue()
      : appNotifications = false,
        emailNotification = false;

  SettingsState copyWith({
    bool? appNotifications,
    bool? emailNotification,
  }) {
    return SettingsState(
      appNotifications: appNotifications ?? this.appNotifications,
      emailNotification: emailNotification ?? this.emailNotification,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        appNotifications,
        emailNotification,
      ];
}
