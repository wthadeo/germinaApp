class Hour{
  int hour;
  int minutes;

  Hour({required this.hour, required this.minutes});

  factory Hour.fromJson(dynamic json) {
    return Hour(
        hour: json['hour'] as int,
        minutes: json['minutes'] as int);
  }
}