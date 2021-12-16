// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ru = {
  "main_screen": {
    "all_tasks_switch": "Все задачи",
    "uncompleted_tasks_switch": "Незавершённые задачи",
    "empty": "Пусто",
    "tasks_tab": "Задачи",
    "settings_tab": "Настройки",
    "deeplink_success": "Успешно запущено через {deeplink}"
  },
  "create_screen": {
    "app_bar": "Создание",
    "name_field": "Название",
    "empty_name_error": "Пожалуйста, введите название задачи",
    "add_reminder_button": "Добавить напоминание",
    "change_date_button": "Изменить время",
    "save_button": "Сохранить",
    "notification_cancelled": "Напоминание успешно отменено",
    "notification_cancelled_error": "Возникла ошибка во время отмены напоминания",
    "notification_created": "Напоминание успешно создано",
    "notification_created_error": "Возникла ошибка во время создания напоминания"
  },
  "update_screen": {
    "app_bar": "Обновить",
    "name_field": "@:create_screen.name_field",
    "empty_name_error": "@:create_screen.empty_name_error",
    "add_reminder_button": "@:create_screen.add_reminder_button",
    "change_date_button": "@:create_screen.change_date_button",
    "save_button": "@:create_screen.save_button",
    "notification_cancelled": "@:create_screen.notification_cancelled",
    "notification_cancelled_error": "@:create_screen.notification_cancelled_error",
    "notification_created": "@:create_screen.notification_created",
    "notification_created_error": "@:create_screen.notification_created_error"
  },
  "settings_screen": {
    "app_bar": "Настройки",
    "language_field": "Язык",
    "notifications_field": "Разрешить уведомления",
    "theme_field": "Включить тёмную тему",
    "locale_change_error": "Произошла ошибка при изменении языка",
    "notification_change_error": "Произошла ошибка при изменении разрешений на уведомления",
    "notification_permitted": "Уведомления разрешены",
    "notification_not_permitted": "Уведомления не разрешены"
  },
  "notifications": {
    "title": "Задача {taskId} скоро начнётся"
  },
  "details_screen": {
    "app_bar": "Детали"
  }
};
static const Map<String,dynamic> en = {
  "main_screen": {
    "all_tasks_switch": "All Tasks",
    "uncompleted_tasks_switch": "Uncompleted Tasks",
    "empty": "Empty",
    "tasks_tab": "Tasks",
    "settings_tab": "Settings",
    "deeplink_success": "Successfully got from {deeplink}"
  },
  "create_screen": {
    "app_bar": "Create",
    "name_field": "Name",
    "empty_name_error": "Please enter some text",
    "add_reminder_button": "Add reminder",
    "change_date_button": "Change Date",
    "save_button": "Save",
    "notification_cancelled": "Notification successfully canceled",
    "notification_cancelled_error": "An error occurred while cancelling notification",
    "notification_created": "Notification successfully created",
    "notification_created_error": "An error occurred while creating notification"
  },
  "update_screen": {
    "app_bar": "Update",
    "name_field": "@:create_screen.name_field",
    "empty_name_error": "@:create_screen.empty_name_error",
    "add_reminder_button": "@:create_screen.add_reminder_button",
    "change_date_button": "@:create_screen.change_date_button",
    "save_button": "Update",
    "notification_cancelled": "@:create_screen.notification_cancelled",
    "notification_cancelled_error": "@:create_screen.notification_cancelled_error",
    "notification_created": "@:create_screen.notification_created",
    "notification_created_error": "@:create_screen.notification_created_error"
  },
  "settings_screen": {
    "app_bar": "Settings",
    "language_field": "Language",
    "notifications_field": "Allow notifications",
    "theme_field": "Enable dark theme",
    "locale_change_error": "An error occurred while changing locale",
    "notification_change_error": "An error occurred while changing notification permissions",
    "notification_permitted": "Notifications are permitted",
    "notification_not_permitted": "Notifications are not permitted"
  },
  "notifications": {
    "title": "Task {taskId} is about to start"
  },
  "details_screen": {
    "app_bar": "Details"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": ru, "en": en};
}
