class WaitlistEntry {
  final String? id;
  final String email;
  final String userType;
  final DateTime createdAt;
  final bool emailSent;
  final DateTime? emailSentAt;

  WaitlistEntry({
    this.id,
    required this.email,
    required this.userType,
    required this.createdAt,
    this.emailSent = false,
    this.emailSentAt,
  });

  factory WaitlistEntry.fromJson(Map<String, dynamic> json) {
    return WaitlistEntry(
      id: json['id'],
      email: json['email'],
      userType: json['user_type'],
      createdAt: DateTime.parse(json['created_at']),
      emailSent: json['email_sent'] ?? false,
      emailSentAt: json['email_sent_at'] != null
          ? DateTime.parse(json['email_sent_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'user_type': userType,
      'created_at': createdAt.toIso8601String(),
      'email_sent': emailSent,
      'email_sent_at': emailSentAt?.toIso8601String(),
    };
  }
}

enum UserType {
  student('طالب', 'student'),
  university('جامعة', 'university'),
  institute('معهد', 'institute'),
  trainingCenter('مركز تدريبي', 'training_center'),
  trainer('مدرب', 'trainer');

  final String arabicName;
  final String value;

  const UserType(this.arabicName, this.value);
}
