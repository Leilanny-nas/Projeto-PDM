class LocalDate {
  static final date = DateTime.now().toLocal();
  const LocalDate();

  static final List<String> _months = [
    "Jan",
    "Fev",
    "Mar",
    "Abr",
    "Mai",
    "Jun",
    "Jul",
    "Ago",
    "Set",
    "Out",
    "Nov",
    "Dez"
  ];

  static String fullDate({String? sep = "/"}) {
    final fullDate = "${date.day}$sep${date.month}$sep${date.year}";
    return fullDate;
  }

  static String get day {
    return date.day.toString();
  }

  static String get month {
    return date.month.toString();
  }

  static String get year {
    return date.year.toString();
  }

  static String strMonth({int? month}) {
    if (month != null) {
      return _months[month - 1];
    }

    return _months[date.month - 1];
  }
}
