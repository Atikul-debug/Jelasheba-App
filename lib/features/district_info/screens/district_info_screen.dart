import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/info_card.dart';
import '../models/district_model.dart';

class DistrictInfoScreen extends StatelessWidget {
  const DistrictInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('জেলা তথ্য'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'সাধারণ তথ্য'),
              Tab(text: 'উপজেলা'),
              Tab(text: 'অফিসার'),
              Tab(text: 'ডিসি বার্তা'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGeneralInfo(context),
            _buildUpazilaList(context),
            _buildOfficerList(context),
            _buildDCMessage(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralInfo(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: AppColors.cardGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppColors.colorShadow(AppColors.primary),
            ),
            child: Stack(
              children: [
                Positioned(top: -20, right: -20, child: Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.06)))),
                Positioned(bottom: -10, left: -10, child: Container(width: 50, height: 50, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.04)))),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.12)),
                        child: const Icon(Icons.map_rounded, size: 40, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      const Text('জেলার ম্যাপ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                      Text(AppConstants.districtName, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(width: 4, height: 20, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text('পরিসংখ্যান', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard('আয়তন', '১,৪৬৩.৬০', 'বর্গ কি.মি.', Icons.straighten_rounded, const Color(0xFF3B82F6), isDark),
              const SizedBox(width: 10),
              _buildStatCard('জনসংখ্যা', '১২.৩৪', 'লক্ষ', Icons.people_rounded, const Color(0xFF8B5CF6), isDark),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildStatCard('সাক্ষরতা', '৭৬.৫', '%', Icons.school_rounded, const Color(0xFF10B981), isDark),
              const SizedBox(width: 10),
              _buildStatCard('উপজেলা', '৫', 'টি', Icons.location_city_rounded, const Color(0xFFF59E0B), isDark),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildStatCard('পৌরসভা', '৭', 'টি', Icons.apartment_rounded, const Color(0xFFEF4444), isDark),
              const SizedBox(width: 10),
              _buildStatCard('ইউনিয়ন', '৫৪', 'টি', Icons.villa_rounded, const Color(0xFF06B6D4), isDark),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isDark ? [] : AppColors.softShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.history_edu_rounded, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text('ইতিহাস', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'জেলার ইতিহাস সুপ্রাচীনকাল থেকে সমৃদ্ধ। বিভিন্ন শাসনামলে এই অঞ্চল গুরুত্বপূর্ণ ভূমিকা পালন করেছে। ব্রিটিশ শাসনামলে জেলা হিসেবে প্রতিষ্ঠিত হয়ে পরবর্তীতে বাংলাদেশের একটি গুরুত্বপূর্ণ প্রশাসনিক একক হিসেবে আত্মপ্রকাশ করে।',
                  style: TextStyle(fontSize: 14, height: 1.6, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String unit, IconData icon, Color color, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: isDark ? [] : [BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
          border: Border.all(color: color.withValues(alpha: 0.12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withValues(alpha: isDark ? 0.15 : 0.08), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: isDark ? Colors.white : AppColors.textPrimary)),
                  TextSpan(text: ' $unit', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildUpazilaList(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final upazilas = [
      Upazila(name: 'Sadar', nameBn: 'সদর', unoName: 'মোঃ রফিকুল ইসলাম', phone: '01711-111111', unionCount: 12, population: 300000),
      Upazila(name: 'North', nameBn: 'উত্তর', unoName: 'মোঃ আলী হোসেন', phone: '01711-222222', unionCount: 10, population: 250000),
      Upazila(name: 'South', nameBn: 'দক্ষিণ', unoName: 'মোঃ কামাল উদ্দিন', phone: '01711-333333', unionCount: 11, population: 270000),
      Upazila(name: 'East', nameBn: 'পূর্ব', unoName: 'মোঃ জামাল উদ্দিন', phone: '01711-444444', unionCount: 9, population: 220000),
      Upazila(name: 'West', nameBn: 'পশ্চিম', unoName: 'মোঃ নাসির উদ্দিন', phone: '01711-555555', unionCount: 12, population: 280000),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      itemCount: upazilas.length,
      itemBuilder: (context, index) {
        final upazila = upazilas[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDark ? [] : AppColors.softShadow,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: Container(
                width: 42, height: 42,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppColors.primary.withValues(alpha: 0.12), AppColors.primary.withValues(alpha: 0.06)]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text('${index + 1}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 16))),
              ),
              title: Text(upazila.nameBn, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('UNO: ${upazila.unoName}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    children: [
                      const Divider(),
                      const SizedBox(height: 4),
                      _buildDetailRow('ইউএনও', upazila.unoName),
                      _buildDetailRow('ফোন', upazila.phone),
                      _buildDetailRow('ইউনিয়ন সংখ্যা', '${upazila.unionCount}'),
                      _buildDetailRow('জনসংখ্যা', '${upazila.population}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildOfficerList(BuildContext context) {
    final officers = [
      Officer(name: 'মোঃ আব্দুল্লাহ আল মামুন', designation: 'জেলা প্রশাসক', phone: '01711-000001', email: 'dc@district.gov.bd', office: 'জেলা প্রশাসকের কার্যালয়'),
      Officer(name: 'মোঃ ফজলুল হক', designation: 'অতিরিক্ত জেলা প্রশাসক (সার্বিক)', phone: '01711-000002', email: 'adc@district.gov.bd', office: 'জেলা প্রশাসকের কার্যালয়'),
      Officer(name: 'মোঃ শরিফুল ইসলাম', designation: 'অতিরিক্ত জেলা প্রশাসক (রাজস্ব)', phone: '01711-000003', email: 'adcrev@district.gov.bd', office: 'জেলা প্রশাসকের কার্যালয়'),
      Officer(name: 'মোঃ আনিসুর রহমান', designation: 'জেলা পুলিশ সুপার', phone: '01711-000004', email: 'sp@police.gov.bd', office: 'জেলা পুলিশ সুপারের কার্যালয়'),
      Officer(name: 'ডাঃ মোঃ হাসান আলী', designation: 'সিভিল সার্জন', phone: '01711-000005', email: 'cs@health.gov.bd', office: 'সিভিল সার্জন অফিস'),
      Officer(name: 'মোঃ কামরুজ্জামান', designation: 'জেলা শিক্ষা অফিসার', phone: '01711-000006', email: 'deo@education.gov.bd', office: 'জেলা শিক্ষা অফিস'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      physics: const BouncingScrollPhysics(),
      itemCount: officers.length,
      itemBuilder: (context, index) {
        final officer = officers[index];
        return InfoCard(
          title: officer.name,
          subtitle: '${officer.designation}\n${officer.office}',
          icon: Icons.person_rounded,
          iconColor: AppColors.primary,
          onTap: () {},
        );
      },
    );
  }

  Widget _buildDCMessage(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              boxShadow: AppColors.colorShadow(AppColors.primary),
            ),
            child: const CircleAvatar(
              radius: 52,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person_rounded, size: 52, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          const Text(AppConstants.dcName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(AppConstants.dcDesignation, style: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: isDark ? [] : AppColors.softShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.format_quote_rounded, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text('জেলাবাসীর প্রতি বার্তা', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  ],
                ),
                const Divider(height: 28),
                const Text(
                  'প্রিয় জেলাবাসী,\n\n'
                  'আসসালামু আলাইকুম। জেলাশেবা অ্যাপে আপনাকে স্বাগতম। এই অ্যাপের মাধ্যমে আপনি জেলা প্রশাসনের সকল সেবা সহজেই পেতে পারবেন।\n\n'
                  'আমাদের লক্ষ্য হচ্ছে জনগণের দোরগোড়ায় সেবা পৌঁছে দেওয়া। আপনাদের যেকোনো সমস্যা, অভিযোগ বা পরামর্শ এই অ্যাপের মাধ্যমে জানাতে পারবেন।\n\n'
                  'আসুন, আমরা সবাই মিলে একটি সুন্দর ও সমৃদ্ধ জেলা গড়ে তুলি।\n\n'
                  'ধন্যবাদান্তে,\nমোঃ আব্দুল্লাহ আল মামুন\nজেলা প্রশাসক',
                  style: TextStyle(fontSize: 15, height: 1.7),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
