class EService {
  final String id;
  final String name;
  final String nameBn;
  final String description;
  final String url;
  final String icon;
  final String category;
  final bool isOnlinePayment;

  EService({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.description,
    required this.url,
    required this.icon,
    required this.category,
    required this.isOnlinePayment,
  });
}

class ServiceTracking {
  final String trackingNumber;
  final String serviceName;
  final String status;
  final DateTime appliedDate;
  final List<TrackingStep> steps;

  ServiceTracking({
    required this.trackingNumber,
    required this.serviceName,
    required this.status,
    required this.appliedDate,
    required this.steps,
  });
}

class TrackingStep {
  final String title;
  final String titleBn;
  final String status; // completed, current, pending
  final DateTime? date;
  final String? note;

  TrackingStep({
    required this.title,
    required this.titleBn,
    required this.status,
    this.date,
    this.note,
  });
}
