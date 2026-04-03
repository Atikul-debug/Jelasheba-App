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
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
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
            _buildGeneralInfo(),
            _buildUpazilaList(),
            _buildOfficerList(),
            _buildDCMessage(),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // District Map placeholder
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 60, color: AppColors.primary),
                SizedBox(height: 8),
                Text('জেলার ম্যাপ', style: TextStyle(color: AppColors.primary)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoTile('জেলার নাম', AppConstants.districtName),
          _buildInfoTile('আয়তন', '১,৪৬৩.৬০ বর্গ কি.মি.'),
          _buildInfoTile('জনসংখ্যা', '১,২৩,৪৫,৬৭৮'),
          _buildInfoTile('সাক্ষরতার হার', '৭৬.৫%'),
          _buildInfoTile('উপজেলার সংখ্যা', '৫'),
          _buildInfoTile('পৌরসভা', '৭'),
          _buildInfoTile('ইউনিয়ন পরিষদ', '৫৪'),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ইতিহাস', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Divider(),
                  const Text(
                    'জেলার ইতিহাস সুপ্রাচীনকাল থেকে সমৃদ্ধ। বিভিন্ন শাসনামলে এই অঞ্চল গুরুত্বপূর্ণ ভূমিকা পালন করেছে। ব্রিটিশ শাসনামলে জেলা হিসেবে প্রতিষ্ঠিত হয়ে পরবর্তীতে বাংলাদেশের একটি গুরুত্বপূর্ণ প্রশাসনিক একক হিসেবে আত্মপ্রকাশ করে।',
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(label, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
        trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ),
    );
  }

  Widget _buildUpazilaList() {
    final upazilas = [
      Upazila(name: 'Sadar', nameBn: 'সদর', unoName: 'মোঃ রফিকুল ইসলাম', phone: '01711-111111', unionCount: 12, population: 300000),
      Upazila(name: 'North', nameBn: 'উত্তর', unoName: 'মোঃ আলী হোসেন', phone: '01711-222222', unionCount: 10, population: 250000),
      Upazila(name: 'South', nameBn: 'দক্ষিণ', unoName: 'মোঃ কামাল উদ্দিন', phone: '01711-333333', unionCount: 11, population: 270000),
      Upazila(name: 'East', nameBn: 'পূর্ব', unoName: 'মোঃ জামাল উদ্দিন', phone: '01711-444444', unionCount: 9, population: 220000),
      Upazila(name: 'West', nameBn: 'পশ্চিম', unoName: 'মোঃ নাসির উদ্দিন', phone: '01711-555555', unionCount: 12, population: 280000),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: upazilas.length,
      itemBuilder: (context, index) {
        final upazila = upazilas[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: Text('${index + 1}', style: const TextStyle(color: AppColors.primary)),
            ),
            title: Text(upazila.nameBn, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('UNO: ${upazila.unoName}'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildDetailRow('ইউএনও', upazila.unoName),
                    _buildDetailRow('ফোন', upazila.phone),
                    _buildDetailRow('ইউনিয়ন সংখ্যা', '${upazila.unionCount}'),
                    _buildDetailRow('জনসংখ্যা', '${upazila.population}'),
                  ],
                ),
              ),
            ],
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
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildOfficerList() {
    final officers = [
      Officer(name: 'মোঃ আব্দুল্লাহ আল মামুন', designation: 'জেলা প্রশাসক', phone: '01711-000001', email: 'dc@district.gov.bd', office: 'জেলা প্রশাসকের কার্যালয়'),
      Officer(name: 'মোঃ ফজলুল হক', designation: 'অতিরিক্ত জেলা প্রশাসক (সার্বিক)', phone: '01711-000002', email: 'adc@district.gov.bd', office: 'জেলা প্রশাসকের কার্যালয়'),
      Officer(name: 'মোঃ শরিফুল ইসলাম', designation: 'অতিরিক্ত জেলা প্রশাসক (রাজস্ব)', phone: '01711-000003', email: 'adcrev@district.gov.bd', office: 'জেলা প্রশাসকের কার্যালয়'),
      Officer(name: 'মোঃ আনিসুর রহমান', designation: 'জেলা পুলিশ সুপার', phone: '01711-000004', email: 'sp@police.gov.bd', office: 'জেলা পুলিশ সুপারের কার্যালয়'),
      Officer(name: 'ডাঃ মোঃ হাসান আলী', designation: 'সিভিল সার্জন', phone: '01711-000005', email: 'cs@health.gov.bd', office: 'সিভিল সার্জন অফিস'),
      Officer(name: 'মোঃ কামরুজ্জামান', designation: 'জেলা শিক্ষা অফিসার', phone: '01711-000006', email: 'deo@education.gov.bd', office: 'জেলা শিক্ষা অফিস'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: officers.length,
      itemBuilder: (context, index) {
        final officer = officers[index];
        return InfoCard(
          title: officer.name,
          subtitle: '${officer.designation}\n${officer.office}',
          icon: Icons.person,
          iconColor: AppColors.primary,
          onTap: () => _showOfficerDetails(officer),
        );
      },
    );
  }

  void _showOfficerDetails(Officer officer) {
    // Details shown in card expansion
  }

  Widget _buildDCMessage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text(
            AppConstants.dcName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Text(
            AppConstants.dcDesignation,
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'জেলাবাসীর প্রতি বার্তা',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text(
                    'প্রিয় জেলাবাসী,\n\n'
                    'আসসালামু আলাইকুম। জেলাশেবা অ্যাপে আপনাকে স্বাগতম। এই অ্যাপের মাধ্যমে আপনি জেলা প্রশাসনের সকল সেবা সহজেই পেতে পারবেন।\n\n'
                    'আমাদের লক্ষ্য হচ্ছে জনগণের দোরগোড়ায় সেবা পৌঁছে দেওয়া। আপনাদের যেকোনো সমস্যা, অভিযোগ বা পরামর্শ এই অ্যাপের মাধ্যমে জানাতে পারবেন।\n\n'
                    'আসুন, আমরা সবাই মিলে একটি সুন্দর ও সমৃদ্ধ জেলা গড়ে তুলি।\n\n'
                    'ধন্যবাদান্তে,\n'
                    'মোঃ আব্দুল্লাহ আল মামুন\n'
                    'জেলা প্রশাসক',
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
