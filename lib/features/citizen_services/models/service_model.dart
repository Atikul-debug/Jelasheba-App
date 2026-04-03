class CitizenService {
  final String id;
  final String name;
  final String nameBn;
  final String description;
  final String category;
  final List<String> requiredDocuments;
  final String fee;
  final String timeLimit;
  final String applicationUrl;
  final String office;
  final String iconName;

  CitizenService({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.description,
    required this.category,
    required this.requiredDocuments,
    required this.fee,
    required this.timeLimit,
    required this.applicationUrl,
    required this.office,
    required this.iconName,
  });
}

class ServiceApplication {
  final String id;
  final String serviceName;
  final String applicantName;
  final String phone;
  final String status; // pending, processing, completed, rejected
  final DateTime appliedDate;
  final DateTime? completedDate;
  final String trackingNumber;

  ServiceApplication({
    required this.id,
    required this.serviceName,
    required this.applicantName,
    required this.phone,
    required this.status,
    required this.appliedDate,
    this.completedDate,
    required this.trackingNumber,
  });
}
