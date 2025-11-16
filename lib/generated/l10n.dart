// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Task Manager`
  String get appTitle {
    return Intl.message(
      'Task Manager',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Delete Task`
  String get deleteTask {
    return Intl.message(
      'Delete Task',
      name: 'deleteTask',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this task?`
  String get confirmDeleteTask {
    return Intl.message(
      'Are you sure you want to delete this task?',
      name: 'confirmDeleteTask',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Task added`
  String get taskAdded {
    return Intl.message(
      'Task added',
      name: 'taskAdded',
      desc: '',
      args: [],
    );
  }

  /// `Task deleted`
  String get taskDeleted {
    return Intl.message(
      'Task deleted',
      name: 'taskDeleted',
      desc: '',
      args: [],
    );
  }

  /// `No tasks yet`
  String get noTasksYet {
    return Intl.message(
      'No tasks yet',
      name: 'noTasksYet',
      desc: '',
      args: [],
    );
  }

  /// `Tap + to add your first task`
  String get tapToAddFirstTask {
    return Intl.message(
      'Tap + to add your first task',
      name: 'tapToAddFirstTask',
      desc: '',
      args: [],
    );
  }

  /// `Edit Task`
  String get editTask {
    return Intl.message(
      'Edit Task',
      name: 'editTask',
      desc: '',
      args: [],
    );
  }

  /// `Add Task`
  String get addTask {
    return Intl.message(
      'Add Task',
      name: 'addTask',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Title is required`
  String get titleRequired {
    return Intl.message(
      'Title is required',
      name: 'titleRequired',
      desc: '',
      args: [],
    );
  }

  /// `Description (optional)`
  String get descriptionOptional {
    return Intl.message(
      'Description (optional)',
      name: 'descriptionOptional',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get medium {
    return Intl.message(
      'Medium',
      name: 'medium',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message(
      'High',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get group {
    return Intl.message(
      'Group',
      name: 'group',
      desc: '',
      args: [],
    );
  }

  /// `Work`
  String get work {
    return Intl.message(
      'Work',
      name: 'work',
      desc: '',
      args: [],
    );
  }

  /// `Study`
  String get study {
    return Intl.message(
      'Study',
      name: 'study',
      desc: '',
      args: [],
    );
  }

  /// `Gym`
  String get gym {
    return Intl.message(
      'Gym',
      name: 'gym',
      desc: '',
      args: [],
    );
  }

  /// `Personal`
  String get personal {
    return Intl.message(
      'Personal',
      name: 'personal',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Start date`
  String get startDate {
    return Intl.message(
      'Start date',
      name: 'startDate',
      desc: '',
      args: [],
    );
  }

  /// `End date`
  String get endDate {
    return Intl.message(
      'End date',
      name: 'endDate',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `End date cannot be before start date`
  String get endDateBeforeStartError {
    return Intl.message(
      'End date cannot be before start date',
      name: 'endDateBeforeStartError',
      desc: '',
      args: [],
    );
  }

  /// `Not set`
  String get notSet {
    return Intl.message(
      'Not set',
      name: 'notSet',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Task Details`
  String get taskDetails {
    return Intl.message(
      'Task Details',
      name: 'taskDetails',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Created: {date}`
  String created(String date) {
    return Intl.message(
      'Created: $date',
      name: 'created',
      desc: 'Created label with formatted date',
      args: [date],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `No description`
  String get noDescription {
    return Intl.message(
      'No description',
      name: 'noDescription',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `To do`
  String get toDo {
    return Intl.message(
      'To do',
      name: 'toDo',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get inProgress {
    return Intl.message(
      'In Progress',
      name: 'inProgress',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get doneStatus {
    return Intl.message(
      'Done',
      name: 'doneStatus',
      desc: '',
      args: [],
    );
  }

  /// `To-do`
  String get toDoStatus {
    return Intl.message(
      'To-do',
      name: 'toDoStatus',
      desc: '',
      args: [],
    );
  }

  /// `Your today's task`
  String get yourTodaysTask {
    return Intl.message(
      'Your today\'s task',
      name: 'yourTodaysTask',
      desc: '',
      args: [],
    );
  }

  /// `almost done!`
  String get almostDone {
    return Intl.message(
      'almost done!',
      name: 'almostDone',
      desc: '',
      args: [],
    );
  }

  /// `View Task`
  String get viewTask {
    return Intl.message(
      'View Task',
      name: 'viewTask',
      desc: '',
      args: [],
    );
  }

  /// `All Tasks`
  String get allTasks {
    return Intl.message(
      'All Tasks',
      name: 'allTasks',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get tasks {
    return Intl.message(
      'Tasks',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `System default`
  String get systemDefault {
    return Intl.message(
      'System default',
      name: 'systemDefault',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get russian {
    return Intl.message(
      'Russian',
      name: 'russian',
      desc: '',
      args: [],
    );
  }

  /// `Uzbek`
  String get uzbek {
    return Intl.message(
      'Uzbek',
      name: 'uzbek',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get schedule {
    return Intl.message(
      'Schedule',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `What do you need to do?`
  String get titleHint {
    return Intl.message(
      'What do you need to do?',
      name: 'titleHint',
      desc: '',
      args: [],
    );
  }

  /// `Add details, links, or notes`
  String get descriptionHint {
    return Intl.message(
      'Add details, links, or notes',
      name: 'descriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Tip: Set a start time to plan when to begin.`
  String get tipTodo {
    return Intl.message(
      'Tip: Set a start time to plan when to begin.',
      name: 'tipTodo',
      desc: '',
      args: [],
    );
  }

  /// `You can set an expected end time.`
  String get tipInProgress {
    return Intl.message(
      'You can set an expected end time.',
      name: 'tipInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Done: We filled start/end for you. Adjust if needed.`
  String get tipDone {
    return Intl.message(
      'Done: We filled start/end for you. Adjust if needed.',
      name: 'tipDone',
      desc: '',
      args: [],
    );
  }

  /// `Start now`
  String get startNow {
    return Intl.message(
      'Start now',
      name: 'startNow',
      desc: '',
      args: [],
    );
  }

  /// `+30m end`
  String get plus30mEnd {
    return Intl.message(
      '+30m end',
      name: 'plus30mEnd',
      desc: '',
      args: [],
    );
  }

  /// `+1h end`
  String get plus1hEnd {
    return Intl.message(
      '+1h end',
      name: 'plus1hEnd',
      desc: '',
      args: [],
    );
  }

  /// `Clear dates`
  String get clearDates {
    return Intl.message(
      'Clear dates',
      name: 'clearDates',
      desc: '',
      args: [],
    );
  }

  /// `Start date & time`
  String get startDateTime {
    return Intl.message(
      'Start date & time',
      name: 'startDateTime',
      desc: '',
      args: [],
    );
  }

  /// `End date & time`
  String get endDateTime {
    return Intl.message(
      'End date & time',
      name: 'endDateTime',
      desc: '',
      args: [],
    );
  }

  /// `Mark Done`
  String get markDone {
    return Intl.message(
      'Mark Done',
      name: 'markDone',
      desc: '',
      args: [],
    );
  }

  /// `Mark To do`
  String get markTodo {
    return Intl.message(
      'Mark To do',
      name: 'markTodo',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get doneLabel {
    return Intl.message(
      'Done',
      name: 'doneLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uz'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
