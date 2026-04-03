class Notice {
  final String id;
  final String title;
  final String titleBn;
  final String description;
  final String category; // general, tender, recruitment, training, meeting
  final String categoryBn;
  final DateTime publishDate;
  final DateTime? expiryDate;
  final String? attachmentUrl;
  final String publishedBy;
  final bool isImportant;

  Notice({
    required this.id,
    required this.title,
    required this.titleBn,
    required this.description,
    required this.category,
    required this.categoryBn,
    required this.publishDate,
    this.expiryDate,
    this.attachmentUrl,
    required this.publishedBy,
    required this.isImportant,
  });
}
