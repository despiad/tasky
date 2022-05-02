import 'package:tasky/localization/localization_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

String? validateTaskName(String? name) {
  if (name == null || name.isEmpty) {
    return LocaleKeys.create_screen_empty_name_error.tr();
  }
  return null;
}
