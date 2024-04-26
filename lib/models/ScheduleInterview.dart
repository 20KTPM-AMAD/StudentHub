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

  factory ScheduleInterview.fromMap(Map<String, dynamic> map) {
    return ScheduleInterview(
      id: map['id'],
      title: map['title'],
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      isCanceled: map['isCanceled'] == 'true', // Chuyển đổi từ chuỗi thành bool
      participants: List<String>.from(map['participants']), // Chuyển đổi từ danh sách chuỗi
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