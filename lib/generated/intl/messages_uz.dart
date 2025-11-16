// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uz locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'uz';

  static String m0(date) => "Yaratildi: ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addTask": MessageLookupByLibrary.simpleMessage("Vazifa qo\'shish"),
        "all": MessageLookupByLibrary.simpleMessage("Barchasi"),
        "allTasks": MessageLookupByLibrary.simpleMessage("Barcha vazifalar"),
        "almostDone": MessageLookupByLibrary.simpleMessage("deyarli tayyor!"),
        "appTitle":
            MessageLookupByLibrary.simpleMessage("Vazifa boshqaruvchisi"),
        "cancel": MessageLookupByLibrary.simpleMessage("Bekor qilish"),
        "clear": MessageLookupByLibrary.simpleMessage("Tozalash"),
        "clearDates":
            MessageLookupByLibrary.simpleMessage("Sanalarni tozalash"),
        "completed": MessageLookupByLibrary.simpleMessage("Bajarilgan"),
        "confirmDeleteTask": MessageLookupByLibrary.simpleMessage(
            "Ushbu vazifani o\'chirishni istaysizmi?"),
        "created": m0,
        "delete": MessageLookupByLibrary.simpleMessage("O\'chirish"),
        "deleteTask":
            MessageLookupByLibrary.simpleMessage("Vazifani o\'chirish"),
        "description": MessageLookupByLibrary.simpleMessage("Tavsif"),
        "descriptionHint": MessageLookupByLibrary.simpleMessage(
            "Tafsilotlar, havolalar yoki eslatmalar qo\'shing"),
        "descriptionOptional":
            MessageLookupByLibrary.simpleMessage("Tavsif (ixtiyoriy)"),
        "doneLabel": MessageLookupByLibrary.simpleMessage("Bajarildi"),
        "doneStatus": MessageLookupByLibrary.simpleMessage("Bajarildi"),
        "edit": MessageLookupByLibrary.simpleMessage("Tahrirlash"),
        "editTask": MessageLookupByLibrary.simpleMessage("Vazifani tahrirlash"),
        "end": MessageLookupByLibrary.simpleMessage("Tugash"),
        "endDate": MessageLookupByLibrary.simpleMessage("Tugash sanasi"),
        "endDateBeforeStartError": MessageLookupByLibrary.simpleMessage(
            "Tugash sanasi boshlanish sanasidan oldin bo\'lishi mumkin emas"),
        "endDateTime":
            MessageLookupByLibrary.simpleMessage("Tugash sanasi va vaqti"),
        "english": MessageLookupByLibrary.simpleMessage("Ingliz"),
        "group": MessageLookupByLibrary.simpleMessage("Guruh"),
        "gym": MessageLookupByLibrary.simpleMessage("Sport zali"),
        "high": MessageLookupByLibrary.simpleMessage("Yuqori"),
        "inProgress": MessageLookupByLibrary.simpleMessage("Jarayonda"),
        "language": MessageLookupByLibrary.simpleMessage("Til"),
        "low": MessageLookupByLibrary.simpleMessage("Past"),
        "markDone":
            MessageLookupByLibrary.simpleMessage("Bajarildi deb belgilash"),
        "markTodo": MessageLookupByLibrary.simpleMessage(
            "Bajarish kerak deb belgilash"),
        "medium": MessageLookupByLibrary.simpleMessage("O\'rta"),
        "noDescription": MessageLookupByLibrary.simpleMessage("Tavsif yo\'q"),
        "noTasksYet":
            MessageLookupByLibrary.simpleMessage("Hozircha vazifalar yo\'q"),
        "notSet": MessageLookupByLibrary.simpleMessage("Belgilanmagan"),
        "open": MessageLookupByLibrary.simpleMessage("Ochiq"),
        "other": MessageLookupByLibrary.simpleMessage("Boshqa"),
        "personal": MessageLookupByLibrary.simpleMessage("Shaxsiy"),
        "plus1hEnd": MessageLookupByLibrary.simpleMessage("+1 soat tugash"),
        "plus30mEnd": MessageLookupByLibrary.simpleMessage("+30 daq tugash"),
        "priority": MessageLookupByLibrary.simpleMessage("Ustuvorlik"),
        "russian": MessageLookupByLibrary.simpleMessage("Rus"),
        "save": MessageLookupByLibrary.simpleMessage("Saqlash"),
        "saveChanges":
            MessageLookupByLibrary.simpleMessage("O\'zgarishlarni saqlash"),
        "schedule": MessageLookupByLibrary.simpleMessage("Jadval"),
        "settings": MessageLookupByLibrary.simpleMessage("Sozlamalar"),
        "somethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Nimadir xato ketdi"),
        "start": MessageLookupByLibrary.simpleMessage("Boshlanish"),
        "startDate": MessageLookupByLibrary.simpleMessage("Boshlanish sanasi"),
        "startDateTime":
            MessageLookupByLibrary.simpleMessage("Boshlanish sanasi va vaqti"),
        "startNow": MessageLookupByLibrary.simpleMessage("Hozir boshlash"),
        "status": MessageLookupByLibrary.simpleMessage("Holat"),
        "study": MessageLookupByLibrary.simpleMessage("O\'qish"),
        "systemDefault":
            MessageLookupByLibrary.simpleMessage("Tizim bo\'yicha"),
        "tapToAddFirstTask": MessageLookupByLibrary.simpleMessage(
            "Birinchi vazifani qo\'shish uchun + tugmasini bosing"),
        "taskAdded": MessageLookupByLibrary.simpleMessage("Vazifa qo\'shildi"),
        "taskDeleted":
            MessageLookupByLibrary.simpleMessage("Vazifa o\'chirildi"),
        "taskDetails":
            MessageLookupByLibrary.simpleMessage("Vazifa tafsilotlari"),
        "tasks": MessageLookupByLibrary.simpleMessage("Vazifalar"),
        "tipDone": MessageLookupByLibrary.simpleMessage(
            "Bajarildi: Boshlanish/tugashni to\'ldirdik. Kerak bo\'lsa o\'zgartiring."),
        "tipInProgress": MessageLookupByLibrary.simpleMessage(
            "Taxminiy tugash vaqtini belgilashingiz mumkin."),
        "tipTodo": MessageLookupByLibrary.simpleMessage(
            "Maslahat: Rejalash uchun boshlanish vaqtini belgilang."),
        "title": MessageLookupByLibrary.simpleMessage("Sarlavha"),
        "titleHint":
            MessageLookupByLibrary.simpleMessage("Nima qilishingiz kerak?"),
        "titleRequired":
            MessageLookupByLibrary.simpleMessage("Sarlavha majburiy"),
        "toDo": MessageLookupByLibrary.simpleMessage("Bajarish kerak"),
        "toDoStatus": MessageLookupByLibrary.simpleMessage("Bajarish kerak"),
        "uzbek": MessageLookupByLibrary.simpleMessage("O\'zbek"),
        "viewTask":
            MessageLookupByLibrary.simpleMessage("Vazifalarni ko\'rish"),
        "work": MessageLookupByLibrary.simpleMessage("Ish"),
        "yourTodaysTask":
            MessageLookupByLibrary.simpleMessage("Bugungi vazifangiz")
      };
}
