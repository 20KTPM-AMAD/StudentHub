class MeetingRoom {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String meetingRoomCode;
  final String meetingRoomId;
  final DateTime? expiredAt;

  MeetingRoom({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.meetingRoomCode,
    required this.meetingRoomId,
    this.expiredAt,
  });

  factory MeetingRoom.fromJson(Map<String, dynamic> json) {
    return MeetingRoom(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      meetingRoomCode: json['meeting_room_code'],
      meetingRoomId: json['meeting_room_id'],
      expiredAt: json['expired_at'] != null ? DateTime.parse(json['expired_at']) : null,
    );
  }
}
