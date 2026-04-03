class ContactInfo {
  final String id;
  final String name;
  final String nameBn;
  final String designation;
  final String designationBn;
  final String office;
  final String officeBn;
  final String phone;
  final String? email;
  final String? fax;
  final String address;
  final String category; // administration, police, health, education, agriculture, bank, post, ngo
  final String categoryBn;

  ContactInfo({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.designation,
    required this.designationBn,
    required this.office,
    required this.officeBn,
    required this.phone,
    this.email,
    this.fax,
    required this.address,
    required this.category,
    required this.categoryBn,
  });
}
