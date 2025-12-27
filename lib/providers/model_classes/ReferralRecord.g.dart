// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReferralRecord.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferralRecord _$ReferralRecordFromJson(Map<String, dynamic> json) =>
    ReferralRecord(
      patientName: json['patientName'] as String,
      patientPhone: json['patientPhone'] as String,
      patientEmail: json['patientEmail'] as String,
      referringDoctorName: json['referringDoctorName'] as String,
      referringDoctorPhone: json['referringDoctorPhone'] as String,
      referringDoctorEmail: json['referringDoctorEmail'] as String,
      consultType: json['consultType'] as String,
      comments: json['comments'] as String?,
    );

Map<String, dynamic> _$ReferralRecordToJson(ReferralRecord instance) =>
    <String, dynamic>{
      'patientName': instance.patientName,
      'patientPhone': instance.patientPhone,
      'patientEmail': instance.patientEmail,
      'referringDoctorName': instance.referringDoctorName,
      'referringDoctorPhone': instance.referringDoctorPhone,
      'referringDoctorEmail': instance.referringDoctorEmail,
      'consultType': instance.consultType,
      'comments': instance.comments,
    };
