import 'app_usage_model.dart';

class FocusDummyData {
  FocusDummyData._();

  static const List<double> weeklyHours = [2, 3, 5, 3, 4, 4.5, 2];
  static const List<String> weeklyLabels = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];
  static const List<String> weeklyDisplayLabels = [
    '2h:30m',
    '3h:30m',
    '5h',
    '3h',
    '4h',
    '4h:30m',
    '2h',
  ];

  static const List<AppUsageModel> apps = [
    AppUsageModel(
      name: 'Instagram',
      iconPath: 'assets/images/instagram.png',
      usageText: 'You spent 4h on Instagram today',
    ),
    AppUsageModel(
      name: 'Twitter',
      iconPath: 'assets/images/twitter.png',
      usageText: 'You spent 3h on Twitter today',
    ),
    AppUsageModel(
      name: 'Facebook',
      iconPath: 'assets/images/facebook.png',
      usageText: 'You spent 1h on Facebook today',
    ),
    AppUsageModel(
      name: 'Telegram',
      iconPath: 'assets/images/telegram.png',
      usageText: 'You spent 30m on Telegram today',
    ),
    AppUsageModel(
      name: 'Gmail',
      iconPath: 'assets/images/gmail.png',
      usageText: 'You spent 45m on Gmail today',
    ),
  ];
}
