class LandRecord {
  final String khatianNo;
  final String dagNo;
  final String mouza;
  final String upazila;
  final String ownerName;
  final double area;
  final String type; // RS, BS, SA

  LandRecord({
    required this.khatianNo,
    required this.dagNo,
    required this.mouza,
    required this.upazila,
    required this.ownerName,
    required this.area,
    required this.type,
  });
}

class NamjariApplication {
  final String id;
  final String applicantName;
  final String phone;
  final String khatianNo;
  final String dagNo;
  final String mouza;
  final String status;
  final DateTime appliedDate;
  final String trackingNumber;
  final List<String> documents;

  NamjariApplication({
    required this.id,
    required this.applicantName,
    required this.phone,
    required this.khatianNo,
    required this.dagNo,
    required this.mouza,
    required this.status,
    required this.appliedDate,
    required this.trackingNumber,
    required this.documents,
  });
}

class LandOffice {
  final String name;
  final String officerName;
  final String designation;
  final String phone;
  final String address;
  final String upazila;

  LandOffice({
    required this.name,
    required this.officerName,
    required this.designation,
    required this.phone,
    required this.address,
    required this.upazila,
  });
}
