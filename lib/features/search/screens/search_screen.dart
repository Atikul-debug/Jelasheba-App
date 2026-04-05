import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../district_info/screens/district_info_screen.dart';
import '../../citizen_services/screens/citizen_services_screen.dart';
import '../../grievance/screens/grievance_screen.dart';
import '../../emergency/screens/emergency_screen.dart';
import '../../health/screens/health_screen.dart';
import '../../education/screens/education_screen.dart';
import '../../agriculture/screens/agriculture_screen.dart';
import '../../land/screens/land_screen.dart';
import '../../notice_board/screens/notice_board_screen.dart';
import '../../e_services/screens/e_services_screen.dart';
import '../../tourism/screens/tourism_screen.dart';
import '../../contact_directory/screens/contact_directory_screen.dart';
import '../../user_panel/screens/user_panel_screen.dart';
import '../../admin_panel/screens/admin_panel_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String _query = '';

  static const List<Map<String, dynamic>> _allServices = [
    {'title': 'জেলা তথ্য', 'subtitle': 'উপজেলা, ইউনিয়ন, ডিসি বার্তা', 'icon': Icons.info_outline_rounded, 'color': Color(0xFF006A4E), 'keywords': ['জেলা', 'তথ্য', 'উপজেলা', 'ইউনিয়ন', 'ডিসি', 'district', 'অফিসার']},
    {'title': 'নাগরিক সেবা', 'subtitle': 'জন্ম নিবন্ধন, পাসপোর্ট, NID, সনদ', 'icon': Icons.people_rounded, 'color': Color(0xFF3B82F6), 'keywords': ['নাগরিক', 'সেবা', 'জন্ম', 'নিবন্ধন', 'পাসপোর্ট', 'NID', 'সনদ', 'লাইসেন্স', 'citizen']},
    {'title': 'অভিযোগ', 'subtitle': 'অভিযোগ দাখিল, ট্র্যাকিং', 'icon': Icons.report_problem_rounded, 'color': Color(0xFFF59E0B), 'keywords': ['অভিযোগ', 'গ্রিভেন্স', 'complaint', 'সমস্যা', 'রিপোর্ট']},
    {'title': 'জরুরি সেবা', 'subtitle': '৯৯৯, পুলিশ, থানা, ফায়ার সার্ভিস', 'icon': Icons.emergency_rounded, 'color': Color(0xFFEF4444), 'keywords': ['জরুরি', '৯৯৯', '999', 'পুলিশ', 'থানা', 'ফায়ার', 'emergency', 'হেল্পলাইন']},
    {'title': 'চিকিৎসা', 'subtitle': 'হাসপাতাল, ডাক্তার, ফার্মেসি, অ্যাম্বুলেন্স, রক্তদাতা', 'icon': Icons.local_hospital_rounded, 'color': Color(0xFFE91E63), 'keywords': ['চিকিৎসা', 'স্বাস্থ্য', 'হাসপাতাল', 'ডাক্তার', 'ফার্মেসি', 'অ্যাম্বুলেন্স', 'রক্ত', 'health', 'hospital', 'doctor']},
    {'title': 'শিক্ষা', 'subtitle': 'স্কুল, কলেজ, মাদ্রাসা, বৃত্তি, ফলাফল', 'icon': Icons.school_rounded, 'color': Color(0xFF7C3AED), 'keywords': ['শিক্ষা', 'স্কুল', 'কলেজ', 'মাদ্রাসা', 'বৃত্তি', 'ফলাফল', 'education', 'school']},
    {'title': 'কৃষি', 'subtitle': 'ফসল, সার, বাজারদর, কৃষি অফিস', 'icon': Icons.agriculture_rounded, 'color': Color(0xFF059669), 'keywords': ['কৃষি', 'ফসল', 'ধান', 'সার', 'বাজারদর', 'agriculture', 'crop', 'fertilizer']},
    {'title': 'ভূমি সেবা', 'subtitle': 'খতিয়ান, নামজারি, ভূমি কর, ই-পর্চা', 'icon': Icons.terrain_rounded, 'color': Color(0xFF92400E), 'keywords': ['ভূমি', 'জমি', 'খতিয়ান', 'নামজারি', 'land', 'কর', 'পর্চা']},
    {'title': 'নোটিশ', 'subtitle': 'সরকারি নোটিশ, টেন্ডার, নিয়োগ', 'icon': Icons.campaign_rounded, 'color': Color(0xFFEA580C), 'keywords': ['নোটিশ', 'বিজ্ঞপ্তি', 'notice', 'টেন্ডার', 'নিয়োগ']},
    {'title': 'ই-সেবা', 'subtitle': 'অনলাইন পেমেন্ট, বিল, ট্র্যাকিং', 'icon': Icons.computer_rounded, 'color': Color(0xFF0891B2), 'keywords': ['ই-সেবা', 'অনলাইন', 'ডিজিটাল', 'বিল', 'ট্র্যাকিং', 'e-service']},
    {'title': 'পর্যটন', 'subtitle': 'দর্শনীয় স্থান, হোটেল, যাতায়াত', 'icon': Icons.tour_rounded, 'color': Color(0xFFD97706), 'keywords': ['পর্যটন', 'ভ্রমণ', 'হোটেল', 'দর্শনীয়', 'tourism', 'travel']},
    {'title': 'যোগাযোগ', 'subtitle': 'সরকার�� অফিস, ফোন নম্বর', 'icon': Icons.contacts_rounded, 'color': Color(0xFF475569), 'keywords': ['যোগাযোগ', 'ফোন', 'নম্বর', 'অফিস', 'contact', 'phone']},
    {'title': 'প্রোফাইল', 'subtitle': 'অ্যাকাউন্ট, সেটিংস, বুকমার্ক', 'icon': Icons.person_rounded, 'color': Color(0xFF4F46E5), 'keywords': ['প্রোফাইল', 'অ্যাকাউন্ট', 'লগইন', 'profile', 'login']},
    {'title': 'অ্যাডমিন', 'subtitle': 'ড্যাশবোর্ড, ম্যানেজমেন্ট', 'icon': Icons.admin_panel_settings_rounded, 'color': Color(0xFF6B7280), 'keywords': ['অ্যাডমিন', 'admin', 'ড্যাশবোর্ড', 'ম্যানেজমেন্ট']},
  ];

  Widget _getScreen(String title) {
    switch (title) {
      case 'জেলা তথ্য': return const DistrictInfoScreen();
      case 'নাগরিক সেবা': return const CitizenServicesScreen();
      case 'অভিযোগ': return const GrievanceScreen();
      case 'জরুরি সেবা': return const EmergencyScreen();
      case 'চিকিৎসা': return const HealthScreen();
      case 'শিক্ষা': return const EducationScreen();
      case 'কৃষি': return const AgricultureScreen();
      case 'ভূমি সেবা': return const LandScreen();
      case 'নোটিশ': return const NoticeboardScreen();
      case 'ই-সেবা': return const EServicesScreen();
      case 'পর্যটন': return const TourismScreen();
      case 'যোগাযোগ': return const ContactDirectoryScreen();
      case 'প্রোফাইল': return const UserPanelScreen();
      case 'অ্যাডমিন': return const AdminPanelScreen();
      default: return const DistrictInfoScreen();
    }
  }

  List<Map<String, dynamic>> get _filtered {
    if (_query.isEmpty) return _allServices;
    final q = _query.toLowerCase();
    return _allServices.where((s) {
      final title = (s['title'] as String).toLowerCase();
      final subtitle = (s['subtitle'] as String).toLowerCase();
      final keywords = s['keywords'] as List<String>;
      return title.contains(q) || subtitle.contains(q) || keywords.any((k) => k.toLowerCase().contains(q));
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () { if (mounted) _focusNode.requestFocus(); });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Search header
            Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.white,
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Row(
                children: [
                  // Back button
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                  // Search field
                  Expanded(
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(23),
                      ),
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText: 'সেবা, হাসপাতাল, ডাক্তার, কৃষি...',
                          hintStyle: TextStyle(color: isDark ? Colors.white30 : Colors.grey[400], fontSize: 14),
                          prefixIcon: Icon(Icons.search_rounded, color: _query.isNotEmpty ? AppColors.primary : Colors.grey[400], size: 20),
                          suffixIcon: _query.isNotEmpty
                              ? IconButton(icon: const Icon(Icons.close_rounded, size: 18), onPressed: () { _controller.clear(); setState(() => _query = ''); })
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        onChanged: (v) => setState(() => _query = v),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Results
            Expanded(
              child: _query.isEmpty
                  ? _buildSuggestions(isDark)
                  : _filtered.isEmpty
                      ? _buildNoResults()
                      : _buildResults(isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      children: [
        // Popular searches
        Row(
          children: [
            Container(width: 4, height: 18, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 8),
            const Text('জনপ্রিয় সেবা', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['চিকিৎসা', 'ডাক্তার', '৯৯৯', 'পর্যটন', 'কৃষি', 'ভূমি', 'নোটিশ', 'অভিযোগ'].map((tag) {
            return GestureDetector(
              onTap: () { _controller.text = tag; setState(() => _query = tag); },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFE0E0E0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up_rounded, size: 14, color: AppColors.primary.withValues(alpha: 0.6)),
                    const SizedBox(width: 6),
                    Text(tag, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        // All services
        Row(
          children: [
            Container(width: 4, height: 18, decoration: BoxDecoration(color: const Color(0xFF8B5CF6), borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 8),
            const Text('সকল সেবা', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 12),
        ..._allServices.map((s) => _buildServiceTile(s, isDark)),
      ],
    );
  }

  Widget _buildResults(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      children: [
        Text('${_filtered.length}টি ফলাফল পাওয়া গেছে', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const SizedBox(height: 12),
        ..._filtered.map((s) => _buildServiceTile(s, isDark)),
      ],
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.06), shape: BoxShape.circle),
            child: Icon(Icons.search_off_rounded, size: 48, color: Colors.grey[300]),
          ),
          const SizedBox(height: 16),
          Text('"$_query" পাওয়া যায়নি', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          const Text('অন্য কিছু দিয়ে খুঁজুন', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildServiceTile(Map<String, dynamic> service, bool isDark) {
    final color = service['color'] as Color;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: isDark ? 0.15 : 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(service['icon'] as IconData, color: color, size: 22),
        ),
        title: Text(service['title'] as String, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        subtitle: Text(service['subtitle'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey[400]),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _getScreen(service['title'] as String))),
      ),
    );
  }

  @override
  void dispose() { _controller.dispose(); _focusNode.dispose(); super.dispose(); }
}
