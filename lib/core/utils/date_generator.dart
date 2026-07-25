enum DayPeriod { morning, afternoon, evening, night }

String getFormattedDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  const weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String weekday = weekdays[date.weekday - 1];
  String month = months[date.month - 1];

  return '$weekday, ${date.day} $month ${date.year}';
}

DayPeriod getDayPeriod(DateTime time) {
  final hour = time.hour;
  if (hour >= 4 && hour < 12) {
    return DayPeriod.morning;
  } else if (hour >= 12 && hour < 17) {
    return DayPeriod.afternoon;
  } else if (hour >= 17 && hour < 21) {
    return DayPeriod.evening;
  } else {
    return DayPeriod.night;
  }
}

String getGreeting(DateTime time) {
  switch (getDayPeriod(time)) {
    case DayPeriod.morning:
      return 'Good Morning';
    case DayPeriod.afternoon:
      return 'Good Afternoon';
    case DayPeriod.evening:
      return 'Good Evening';
    case DayPeriod.night:
      return 'Good Night';
  }
}

DateTime getStartOfWeek(DateTime date) {
  final weekday = date.weekday;
  final daysToSubtract = weekday - DateTime.monday;
  return date.subtract(Duration(days: daysToSubtract));
}

String getTime(DateTime postDate) {
  final now = DateTime.now();
  final difference = now.difference(postDate);

  final diffInSeconds = difference.inSeconds;
  final diffInMinutes = difference.inMinutes;
  final diffInHours = difference.inHours;
  final diffInDays = difference.inDays;

  if (diffInSeconds < 60) {
    return '${diffInSeconds}s';
  } else if (diffInMinutes < 60) {
    return '${diffInMinutes}m';
  } else if (diffInHours < 24) {
    return '${diffInHours}h';
  } else {
    return '${diffInDays}d';
  }
}
