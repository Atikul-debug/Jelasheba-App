class EmergencyService {
  final String name;
  final String nameBn;
  final String number;
  final String icon;
  final String category;
  final String? address;
  final double? latitude;
  final double? longitude;

  EmergencyService({
    required this.name,
    required this.nameBn,
    required this.number,
    required this.icon,
    required this.category,
    this.address,
    this.latitude,
    this.longitude,
  });
}

class PoliceStation {
  final String name;
  final String nameBn;
  final String ocName;
  final String phone;
  final String address;
  final double latitude;
  final double longitude;

  PoliceStation({
    required this.name,
    required this.nameBn,
    required this.ocName,
    required this.phone,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class BloodDonor {
  final String name;
  final String phone;
  final String bloodGroup;
  final String area;
  final DateTime lastDonation;
  final bool isAvailable;
  // New fields
  final int? age;
  final String? gender;
  final String? district;
  final String? upazila;
  final double? weight;
  final String? profession;

  BloodDonor({
    required this.name,
    required this.phone,
    required this.bloodGroup,
    required this.area,
    required this.lastDonation,
    required this.isAvailable,
    this.age,
    this.gender,
    this.district,
    this.upazila,
    this.weight,
    this.profession,
  });
}
