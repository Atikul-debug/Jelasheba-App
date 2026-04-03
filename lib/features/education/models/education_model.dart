class EducationInstitution {
  final String id;
  final String name;
  final String nameBn;
  final String type; // primary, secondary, college, madrasa, technical, university
  final String typeBn;
  final String address;
  final String phone;
  final String? email;
  final String principalName;
  final String? eiin;
  final String? mpoStatus;
  final int studentCount;
  final int teacherCount;
  final double? latitude;
  final double? longitude;

  EducationInstitution({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.type,
    required this.typeBn,
    required this.address,
    required this.phone,
    this.email,
    required this.principalName,
    this.eiin,
    this.mpoStatus,
    required this.studentCount,
    required this.teacherCount,
    this.latitude,
    this.longitude,
  });
}

class Scholarship {
  final String name;
  final String nameBn;
  final String description;
  final String eligibility;
  final String applicationUrl;
  final DateTime deadline;
  final String amount;

  Scholarship({
    required this.name,
    required this.nameBn,
    required this.description,
    required this.eligibility,
    required this.applicationUrl,
    required this.deadline,
    required this.amount,
  });
}
