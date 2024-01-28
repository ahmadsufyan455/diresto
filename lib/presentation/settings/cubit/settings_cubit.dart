import 'package:diresto/utils/background_service.dart';
import 'package:diresto/utils/constants.dart';
import 'package:diresto/utils/date_time_helper.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SettingsCubit extends HydratedCubit<bool> {
  SettingsCubit() : super(false);

  Future<bool> scheduledRestaurant(bool value) async {
    if (value) {
      emit(true);
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      emit(false);
      return await AndroidAlarmManager.cancel(1);
    }
  }

  @override
  bool? fromJson(Map<String, dynamic> json) => json[isScheduled];

  @override
  Map<String, dynamic>? toJson(bool state) => {isScheduled: state};
}
