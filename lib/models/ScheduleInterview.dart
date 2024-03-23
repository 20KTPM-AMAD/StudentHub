class ScheduleInterview {
  String id;
  String title;
  DateTime startTime;
  DateTime endTime;
  bool isCanceled;
  List<String> participants;

  ScheduleInterview({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.isCanceled,
    required this.participants,
  });

  ScheduleInterview fromMap(Map<String, dynamic> map) {
    return ScheduleInterview(
      id: map['id'],
      title: map['title'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      isCanceled: map['isCanceled'],
      participants: map['participants'],
    );
  }

  Map toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['isCanceled'] = isCanceled;
    map['participants'] = participants;
    return map;
  }
}