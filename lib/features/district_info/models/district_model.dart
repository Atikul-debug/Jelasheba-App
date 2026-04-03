class DistrictInfo {
  final String name;
  final String nameBn;
  final String history;
  final double area;
  final int population;
  final double literacyRate;
  final int upazilaCount;
  final int municipalityCount;
  final int unionCount;
  final String dcName;
  final String dcImage;
  final String dcMessage;
  final List<Upazila> upazilas;

  DistrictInfo({
    required this.name,
    required this.nameBn,
    required this.history,
    required this.area,
    required this.population,
    required this.literacyRate,
    required this.upazilaCount,
    required this.municipalityCount,
    required this.unionCount,
    required this.dcName,
    required this.dcImage,
    required this.dcMessage,
    required this.upazilas,
  });
}

class Upazila {
  final String name;
  final String nameBn;
  final String unoName;
  final String phone;
  final int unionCount;
  final int population;

  Upazila({
    required this.name,
    required this.nameBn,
    required this.unoName,
    required this.phone,
    required this.unionCount,
    required this.population,
  });
}

class Officer {
  final String name;
  final String designation;
  final String phone;
  final String email;
  final String office;
  final String? imageUrl;

  Officer({
    required this.name,
    required this.designation,
    required this.phone,
    required this.email,
    required this.office,
    this.imageUrl,
  });
}
