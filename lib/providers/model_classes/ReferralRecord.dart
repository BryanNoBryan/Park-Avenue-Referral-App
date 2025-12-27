import 'package:json_annotation/json_annotation.dart';

part 'ReferralRecord.g.dart';

@JsonSerializable()
class ReferralRecord {
  final String patientName,
      patientPhone,
      patientEmail,
      referringDoctorName,
      referringDoctorPhone,
      referringDoctorEmail,
      consultType;

  final String? comments;
  static const consultTypes = [
    'Wisdom Teeth',
    'Surgical Extraction',
    'Jaw Surgery',
    'TMJ Disorder',
    'Facial Cosmetics',
    'Other',
  ];
  static const String BACKEND_URL =
      "https://www.parkavenueoralsurgery.com/_functions/submitReferralForm";

  ReferralRecord({
    required this.patientName,
    required this.patientPhone,
    required this.patientEmail,
    required this.referringDoctorName,
    required this.referringDoctorPhone,
    required this.referringDoctorEmail,
    required this.consultType,
    this.comments,
  });

  bool validateConsultType(String type) {
    return consultTypes.contains(type);
  }

  /// Connect the generated [_$ReferralRecordFromJson] function to the `fromJson`
  /// factory.
  factory ReferralRecord.fromJson(Map<String, dynamic> json) =>
      _$ReferralRecordFromJson(json);

  /// Connect the generated [_$ReferralRecordToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReferralRecordToJson(this);
}
