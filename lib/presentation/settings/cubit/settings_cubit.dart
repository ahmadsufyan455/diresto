import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:diresto/utils/background_service.dart';
import 'package:diresto/utils/date_time_helper.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SettingsCubit extends HydratedCubit<Map<String, bool>> {
  SettingsCubit() : super({'isScheduled': false, 'isDarkMode': false});

  Future<bool> scheduledRestaurant(bool value) async {
    if (value) {
      emit({...state, 'isScheduled': true});
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      emit({...state, 'isScheduled': false});
      return await AndroidAlarmManager.cancel(1);
    }
  }

  void toggleTheme(bool value) {
    if (value) {
      emit({...state, 'isDarkMode': true});
    } else {
      emit({...state, 'isDarkMode': false});
    }
  }

  @override
  Map<String, bool>? fromJson(Map<String, dynamic> json) {
    return {
      'isScheduled': json['isScheduled'] ?? false,
      'isDarkMode': json['isDarkMode'] ?? false,
    };
  }

  @override
  Map<String, dynamic>? toJson(Map<String, bool> state) {
    return {
      'isScheduled': state['isScheduled'],
      'isDarkMode': state['isDarkMode'],
    };
  }
}
