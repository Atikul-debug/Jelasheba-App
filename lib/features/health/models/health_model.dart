class Hospital {
  final String id;
  final String name;
  final String nameBn;
  final String type; // government, private
  final String address;
  final String phone;
  final int bedCount;
  final bool hasEmergency;
  final List<String> departments;
  final double latitude;
  final double longitude;
  final int doctorCount;

  Hospital({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.type,
    required this.address,
    required this.phone,
    required this.bedCount,
    required this.hasEmergency,
    required this.departments,
    required this.latitude,
    required this.longitude,
    this.doctorCount = 0,
  });
}

class Doctor {
  final String id;
  final String name;
  final String nameBn;
  final String specialty;
  final String specialtyBn;
  final String qualification;
  final String hospital;
  final String chamber;
  final String phone;
  final String visitingHours;
  final double fee;
  final String? imageUrl;

  Doctor({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.specialty,
    required this.specialtyBn,
    required this.qualification,
    required this.hospital,
    required this.chamber,
    required this.phone,
    required this.visitingHours,
    required this.fee,
    this.imageUrl,
  });
}

class Pharmacy {
  final String name;
  final String address;
  final String phone;
  final String openingHours;
  final bool isOpen24Hours;

  Pharmacy({
    required this.name,
    required this.address,
    required this.phone,
    required this.openingHours,
    required this.isOpen24Hours,
  });
}

class DiagnosticCenter {
  final String name;
  final String address;
  final String phone;
  final List<String> services;

  DiagnosticCenter({
    required this.name,
    required this.address,
    required this.phone,
    required this.services,
  });
}
