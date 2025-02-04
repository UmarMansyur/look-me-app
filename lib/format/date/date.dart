class DateFormat {
  static List<String> monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  static String format(DateTime date) {
    return '${date.day} ${date.month} ${date.year}';
  }

  static String formatIndonesian(DateTime date) {
    return '${date.day} ${_getIndonesianMonth(date.month)} ${date.year}';
  }

  static String _getIndonesianMonth(int month) {
    return monthNames[month - 1];
  }

  static String formatIndonesianShort(DateTime date) {
    return '${date.day} ${_getIndonesianMonthShort(date.month)} ${date.year}';
  }

  static String _getIndonesianMonthShort(int month) {
    return monthNames[month - 1].substring(0, 3);
  }
}
