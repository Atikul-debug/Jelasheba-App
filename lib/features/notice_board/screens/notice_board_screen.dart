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
    Notice(id: '2', title: 'Road Tender', titleBn: 'রাস্তা নির্মাণ টেন্ডার', description: 'সিরাজগঞ্জ সদর উপজেলার ৫ কি.মি. রাস্তা নির্মাণের জন্য টেন্ডার আহ্বান করা হচ্ছে। আগ্রহী ঠিকাদারদের ১৫ দিনের মধ্যে আবেদন করতে হবে।', category: 'tender', categoryBn: 'টেন্ডার', publishDate: DateTime.now().subtract(const Duration(days: 3)), expiryDate: DateTime.now().add(const Duration(days: 12)), publishedBy: 'নির্বাহী প্রকৌশলী', isImportant: false),
    Notice(id: '3', title: 'Teacher Recruitment', titleBn: 'শিক্ষক নিয়োগ বিজ্ঞপ্তি', description: '৫টি সরকারি প্রাথমিক বিদ্যালয়ে সহকারী শিক্ষক পদে নিয়োগ দেওয়া হবে। যোগ্যতা: স্নাতক ডিগ্রি। বেতন স্কেল: ১১,০০০-২৬,৫৯০ টাকা।', category: 'recruitment', categoryBn: 'নিয়োগ', publishDate: DateTime.now().subtract(const Duration(days: 5)), expiryDate: DateTime.now().add(const Duration(days: 25)), publishedBy: 'জেলা শিক্ষা অফিসার', isImportant: true),
    Notice(id: '4', title: 'Computer Training', titleBn: 'কম্পিউটার প্রশিক্ষণ', description: 'বেকার যুবকদের জন্য বিনামূল্যে কম্পিউটার প্রশিক্ষণ কর্মসূচি। সময়কাল: ৩ মাস। আসন সংখ্যা: ৫০।', category: 'training', categoryBn: 'প্রশিক্ষণ', publishDate: DateTime.now().subtract(const Duration(days: 7)), publishedBy: 'যুব উন্নয়ন অফিস', isImportant: false),
    Notice(id: '5', title: 'Dengue Awareness', titleBn: 'ডেঙ্গু সচেতনতা প্রচার', description: 'ডেঙ্গু প্রতিরোধে সচেতনতা বৃদ্ধির লক্ষ্যে আগামীকাল থেকে জেলা ব্যাপী পরিষ্কার-পরিচ্ছন্নতা অভিযান শুরু হচ্ছে। সকলের সহযোগিতা কামনা করা হচ্ছে।', category: 'general', categoryBn: 'সাধারণ', publishDate: DateTime.now().subtract(const Duration(days: 2)), publishedBy: 'সিভিল সার্জন', isImportant: true),
  ];

  final List<String> _categories = ['সব', 'সাধারণ', 'টেন্ডার', 'নিয়োগ', 'প্রশিক্ষণ', 'সভা'];

  List<Notice> get _filtered {
    return _notices.where((n) => _selectedCategory == 'সব' || n.categoryBn == _selectedCategory).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'সভা': return const Color(0xFF7C3AED);
      case 'টেন্ডার': return const Color(0xFFF59E0B);
      case 'নিয়োগ': return const Color(0xFF3B82F6);
      case 'প্রশিক্ষণ': return const Color(0xFF10B981);
      case 'সাধারণ': return const Color(0xFF6B7280);
      default: return AppColors.primary;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'সভা': return Icons.groups_rounded;
      case 'টেন্ডার': return Icons.gavel_rounded;
      case 'নিয়োগ': return Icons.work_rounded;
      case 'প্রশিক্ষণ': return Icons.school_rounded;
      case 'সাধারণ': return Icons.campaign_rounded;
      default: return Icons.article_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('নোটিশ বোর্ড')),
      body: Column(
        children: [
          SizedBox(
            height: 52,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = cat == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat, style: TextStyle(fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400, fontSize: 13)),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                    selectedColor: AppColors.primary.withValues(alpha: 0.15),
                    checkmarkColor: AppColors.primary,
                    side: BorderSide(color: isSelected ? AppColors.primary.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.3)),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              physics: const BouncingScrollPhysics(),
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final notice = _filtered[index];
                return _buildNoticeCard(notice);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeCard(Notice notice) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final catColor = _getCategoryColor(notice.categoryBn);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark ? [] : AppColors.softShadow,
        border: notice.isImportant
            ? Border.all(color: AppColors.error.withValues(alpha: 0.2), width: 1.5)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showNoticeDetails(notice),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: catColor.withValues(alpha: isDark ? 0.15 : 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(_getCategoryIcon(notice.categoryBn), color: catColor, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (notice.isImportant)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  margin: const EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                                  child: const Text('জরুরি', style: TextStyle(color: AppColors.error, fontSize: 10, fontWeight: FontWeight.w700)),
                                ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: catColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                                child: Text(notice.categoryBn, style: TextStyle(color: catColor, fontSize: 10, fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(notice.titleBn, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(notice.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded, size: 13, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text('${notice.publishDate.day}/${notice.publishDate.month}/${notice.publishDate.year}', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                    const Spacer(),
                    Icon(Icons.person_rounded, size: 13, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(notice.publishedBy, style: TextStyle(fontSize: 12, color: AppColors.primary.withValues(alpha: 0.8), fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showNoticeDetails(Notice notice) {
    final catColor = _getCategoryColor(notice.categoryBn);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
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
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                        child: const Text('জরুরি', style: TextStyle(color: AppColors.error, fontSize: 12, fontWeight: FontWeight.w700)),
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(color: catColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                      child: Text(notice.categoryBn, style: TextStyle(color: catColor, fontSize: 12, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(notice.titleBn, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text('${notice.publishDate.day}/${notice.publishDate.month}/${notice.publishDate.year}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    const SizedBox(width: 16),
                    const Icon(Icons.person_rounded, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(notice.publishedBy, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  ],
                ),
                if (notice.expiryDate != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.timer_rounded, size: 14, color: AppColors.error),
                      const SizedBox(width: 4),
                      Text('সময়সীমা: ${notice.expiryDate!.day}/${notice.expiryDate!.month}/${notice.expiryDate!.year}', style: const TextStyle(color: AppColors.error, fontSize: 13, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
                const Divider(height: 28),
                Text(notice.description, style: const TextStyle(fontSize: 15, height: 1.7)),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share_rounded, size: 18),
                        label: const Text('শেয়ার করুন'),
                      ),
                    ),
                    if (notice.attachmentUrl != null) ...[
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download_rounded, size: 18),
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
      ),
    );
  }
}
