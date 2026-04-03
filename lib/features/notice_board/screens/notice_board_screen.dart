import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/notice_model.dart';

class NoticeboardScreen extends StatefulWidget {
  const NoticeboardScreen({super.key});

  @override
  State<NoticeboardScreen> createState() => _NoticeboardScreenState();
}

class _NoticeboardScreenState extends State<NoticeboardScreen> {
  String _selectedCategory = 'সব';

  final List<Notice> _notices = [
    Notice(id: '1', title: 'Weekly Meeting', titleBn: 'সাপ্তাহিক সমন্বয় সভা', description: 'আগামী রবিবার সকাল ১০টায় জেলা প্রশাসকের কার্যালয়ে সাপ্তাহিক সমন্বয় সভা অনুষ্ঠিত হবে। সকল কর্মকর্তাদের উপস্থিত থাকার জন্য অনুরোধ করা হলো।', category: 'meeting', categoryBn: 'সভা', publishDate: DateTime.now().subtract(const Duration(days: 1)), publishedBy: 'জেলা প্রশাসক', isImportant: true),
    Notice(id: '2', title: 'Road Tender', titleBn: 'রাস্তা নির্মাণ টেন্ডার', description: 'সদর উপজেলার ৫ কি.মি. রাস্তা নির্মাণের জন্য টেন্ডার আহ্বান করা হচ্ছে। আগ্রহী ঠিকাদারদের ১৫ দিনের মধ্যে আবেদন করতে হবে।', category: 'tender', categoryBn: 'টেন্ডার', publishDate: DateTime.now().subtract(const Duration(days: 3)), expiryDate: DateTime.now().add(const Duration(days: 12)), publishedBy: 'নির্বাহী প্রকৌশলী', isImportant: false),
    Notice(id: '3', title: 'Teacher Recruitment', titleBn: 'শিক্ষক নিয়োগ বিজ্ঞপ্তি', description: '৫টি সরকারি প্রাথমিক বিদ্যালয়ে সহকারী শিক্ষক পদে নিয়োগ দেওয়া হবে। যোগ্যতা: স্নাতক ডিগ্রি। বেতন স্কেল: ১১,০০০-২৬,৫৯০ টাকা।', category: 'recruitment', categoryBn: 'নিয়োগ', publishDate: DateTime.now().subtract(const Duration(days: 5)), expiryDate: DateTime.now().add(const Duration(days: 25)), publishedBy: 'জেলা শিক্ষা অফিসার', isImportant: true),
    Notice(id: '4', title: 'Computer Training', titleBn: 'কম্পিউটার প্রশিক্ষণ', description: 'বেকার যুবকদের জন্য বিনামূল্যে কম্পিউটার প্রশিক্ষণ কর্মসূচি। সময়কাল: ৩ মাস। আসন সংখ্যা: ৫০।', category: 'training', categoryBn: 'প্রশিক্ষণ', publishDate: DateTime.now().subtract(const Duration(days: 7)), publishedBy: 'যুব উন্নয়ন অফিস', isImportant: false),
    Notice(id: '5', title: 'Dengue Awareness', titleBn: 'ডেঙ্গু সচেতনতা প্রচার', description: 'ডেঙ্গু প্রতিরোধে সচেতনতা বৃদ্ধির লক্ষ্যে আগামীকাল থেকে জেলা ব্যাপী পরিষ্কার-পরিচ্ছন্নতা অভিযান শুরু হচ্ছে। সকলের সহযোগিতা কামনা করা হচ্ছে।', category: 'general', categoryBn: 'সাধারণ', publishDate: DateTime.now().subtract(const Duration(days: 2)), publishedBy: 'সিভিল সার্জন', isImportant: true),
  ];

  final List<String> _categories = ['সব', 'সাধারণ', 'টেন্ডার', 'নিয়োগ', 'প্রশিক্ষণ', 'সভা'];

  List<Notice> get _filtered {
    return _notices.where((n) => _selectedCategory == 'সব' || n.categoryBn == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('নোটিশ বোর্ড')),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: cat == _selectedCategory,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                    selectedColor: AppColors.primary.withValues(alpha: 0.2),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final notice = _filtered[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: InkWell(
                    onTap: () => _showNoticeDetails(notice),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (notice.isImportant)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                                  child: const Text('জরুরি', style: TextStyle(color: AppColors.error, fontSize: 12, fontWeight: FontWeight.bold)),
                                ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                                child: Text(notice.categoryBn, style: const TextStyle(color: AppColors.primary, fontSize: 12)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(notice.titleBn, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(notice.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.textSecondary)),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${notice.publishDate.day}/${notice.publishDate.month}/${notice.publishDate.year}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                              Text(notice.publishedBy, style: const TextStyle(fontSize: 12, color: AppColors.primary)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showNoticeDetails(Notice notice) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),
              Row(
                children: [
                  if (notice.isImportant)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                      child: const Text('জরুরি', style: TextStyle(color: AppColors.error, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                    child: Text(notice.categoryBn, style: const TextStyle(color: AppColors.primary, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(notice.titleBn, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text('${notice.publishDate.day}/${notice.publishDate.month}/${notice.publishDate.year}', style: const TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(width: 16),
                  const Icon(Icons.person, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(notice.publishedBy, style: const TextStyle(color: AppColors.textSecondary)),
                ],
              ),
              if (notice.expiryDate != null) ...[
                const SizedBox(height: 4),
                Text('সময়সীমা: ${notice.expiryDate!.day}/${notice.expiryDate!.month}/${notice.expiryDate!.year}', style: const TextStyle(color: AppColors.error)),
              ],
              const Divider(height: 24),
              Text(notice.description, style: const TextStyle(fontSize: 16, height: 1.6)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share),
                      label: const Text('শেয়ার করুন'),
                    ),
                  ),
                  if (notice.attachmentUrl != null) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download),
                        label: const Text('ডাউনলোড'),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
