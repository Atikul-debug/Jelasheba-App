class Grievance {
  final String id;
  final String category;
  final String subject;
  final String description;
  final String applicantName;
  final String phone;
  final String? email;
  final String status; // submitted, under_review, resolved, rejected
  final DateTime submittedDate;
  final DateTime? resolvedDate;
  final String trackingNumber;
  final List<String> attachments;
  final String? resolution;

  Grievance({
    required this.id,
    required this.category,
    required this.subject,
    required this.description,
    required this.applicantName,
    required this.phone,
    this.email,
    required this.status,
    required this.submittedDate,
    this.resolvedDate,
    required this.trackingNumber,
    required this.attachments,
    this.resolution,
  });
}

class GrievanceCategory {
  final String id;
  final String name;
  final String nameBn;
  final String icon;

  GrievanceCategory({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.icon,
  });

  static List<GrievanceCategory> categories = [
    GrievanceCategory(id: '1', name: 'Corruption', nameBn: 'দুর্নীতি', icon: 'warning'),
    GrievanceCategory(id: '2', name: 'Service Delay', nameBn: 'সেবা বিলম্ব', icon: 'timer'),
    GrievanceCategory(id: '3', name: 'Harassment', nameBn: 'হয়রানি', icon: 'report'),
    GrievanceCategory(id: '4', name: 'Infrastructure', nameBn: 'অবকাঠামো', icon: 'construction'),
    GrievanceCategory(id: '5', name: 'Education', nameBn: 'শিক্ষা', icon: 'school'),
    GrievanceCategory(id: '6', name: 'Health', nameBn: 'স্বাস্থ্য', icon: 'health'),
    GrievanceCategory(id: '7', name: 'Land', nameBn: 'ভূমি', icon: 'terrain'),
    GrievanceCategory(id: '8', name: 'Others', nameBn: 'অন্যান্য', icon: 'more'),
  ];
}
