import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../models/service_model.dart';

class CitizenServicesScreen extends StatefulWidget {
  const CitizenServicesScreen({super.key});

  @override
  State<CitizenServicesScreen> createState() => _CitizenServicesScreenState();
}

class _CitizenServicesScreenState extends State<CitizenServicesScreen> {
  String _selectedCategory = 'সব';
  String _searchQuery = '';

  final List<CitizenService> _services = [
    CitizenService(id: '1', name: 'Birth Registration', nameBn: 'জন্ম নিবন্ধন', description: 'জন্ম নিবন্ধন সনদ প্রাপ্তির জন্য আবেদন করুন। অনলাইনে আবেদন করা যায়।', category: 'নিবন্ধন', requiredDocuments: ['পিতা-মাতার NID', 'হাসপাতালের সনদ', 'ওয়ার্ড কাউন্সিলরের প্রত্যয়ন'], fee: '৫০ টাকা (নির্ধারিত সময়ে)', timeLimit: '৪৫ দিনের মধ্যে বিনামূল্যে', applicationUrl: 'https://bdris.gov.bd', office: 'ইউনিয়ন পরিষদ / পৌরসভা', iconName: 'child_care'),
    CitizenService(id: '2', name: 'Death Registration', nameBn: 'মৃত্যু নিবন্ধন', description: 'মৃত্যু নিবন্ধন সনদ প্রাপ্তির জন্য আবেদন।', category: 'নিবন্ধন', requiredDocuments: ['মৃতের NID', 'ডাক্তারের সনদ', 'ওয়ারিশ সনদ'], fee: '৫০ টাকা', timeLimit: '৪৫ দিনের মধ্যে বিনামূল্যে', applicationUrl: 'https://bdris.gov.bd', office: 'ইউনিয়ন পরিষদ / পৌরসভা', iconName: 'receipt_long'),
    CitizenService(id: '3', name: 'NID Correction', nameBn: 'জাতীয় পরিচয়পত্র সংশোধন', description: 'জাতীয় পরিচয়পত্রের তথ্য সংশোধনের জন্য আবেদন।', category: 'পরিচয়পত্র', requiredDocuments: ['বর্তমান NID', 'জন্ম নিবন্ধন', 'SSC সনদ', 'পাসপোর্ট (যদি থাকে)'], fee: '২৩০ টাকা', timeLimit: '১৫-৩০ কার্যদিবস', applicationUrl: 'https://services.nidw.gov.bd', office: 'জাতীয় পরিচয় নিবন্ধন অনুবিভাগ', iconName: 'badge'),
    CitizenService(id: '4', name: 'Passport', nameBn: 'পাসপোর্ট', description: 'নতুন পাসপোর্ট বা পাসপোর্ট নবায়নের জন্য আবেদন।', category: 'পরিচয়পত্র', requiredDocuments: ['NID', 'জন্ম নিবন্ধন', 'ছবি', 'আগের পাসপোর্ট (নবায়নের ক্ষেত্রে)'], fee: '৩,৪৫০ - ৬,৯০০ টাকা', timeLimit: '৭-২১ কার্যদিবস', applicationUrl: 'https://www.epassport.gov.bd', office: 'পাসপোর্ট অফিস', iconName: 'flight'),
    CitizenService(id: '5', name: 'Nationality Certificate', nameBn: 'নাগরিকত্ব সনদ', description: 'নাগরিকত্ব সনদ প্রাপ্তির জন্য আবেদন।', category: 'সনদপত্র', requiredDocuments: ['NID', 'চেয়ারম্যান/কাউন্সিলর প্রত্যয়ন', 'ছবি'], fee: 'বিনামূল্যে', timeLimit: '৭ কার্যদিবস', applicationUrl: '', office: 'ইউনিয়ন পরিষদ / পৌরসভা', iconName: 'flag'),
    CitizenService(id: '6', name: 'Character Certificate', nameBn: 'চারিত্রিক সনদ', description: 'চারিত্রিক সনদ প্রাপ্তির জন্য আবেদন।', category: 'সনদপত্র', requiredDocuments: ['NID', 'চেয়ারম্যান প্রত্যয়ন', 'ছবি'], fee: 'বিনামূল্যে', timeLimit: '৭ কার্যদিবস', applicationUrl: '', office: 'ইউনিয়ন পরিষদ / পৌরসভা', iconName: 'verified_user'),
    CitizenService(id: '7', name: 'Warish Certificate', nameBn: 'ওয়ারিশ সনদ', description: 'উত্তরাধিকার/ওয়ারিশ সনদ প্রাপ্তির জন্য আবেদন।', category: 'সনদপত্র', requiredDocuments: ['মৃত ব্যক্তির মৃত্যু সনদ', 'উত্তরাধিকারীদের NID', 'চেয়ারম্যান প্রত্যয়ন'], fee: 'বিনামূল্যে', timeLimit: '৭ কার্যদিবস', applicationUrl: '', office: 'ইউনিয়ন পরিষদ / পৌরসভা', iconName: 'family_restroom'),
    CitizenService(id: '8', name: 'Trade License', nameBn: 'ট্রেড লাইসেন্স', description: 'ব্যবসায়িক ট্রেড লাইসেন্সের জন্য আবেদন বা নবায়ন।', category: 'লাইসেন্স', requiredDocuments: ['NID', 'দোকান/ব্যবসা প্রতিষ্ঠানের ভাড়া চুক্তি', 'ছবি', 'টিন সনদ'], fee: '৫০০ - ৫,০০০ টাকা', timeLimit: '৭-১৫ কার্যদিবস', applicationUrl: '', office: 'পৌরসভা / সিটি কর্পোরেশন', iconName: 'store'),
  ];

  List<String> get _categories {
    final cats = _services.map((s) => s.category).toSet().toList();
    return ['সব', ...cats];
  }

  List<CitizenService> get _filteredServices {
    return _services.where((s) {
      final matchCategory = _selectedCategory == 'সব' || s.category == _selectedCategory;
      final matchSearch = _searchQuery.isEmpty || s.nameBn.contains(_searchQuery) || s.description.contains(_searchQuery);
      return matchCategory && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('নাগরিক সেবা')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: isDark ? [] : AppColors.softShadow,
              ),
              child: TextField(
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'সেবা অনুসন্ধান করুন...',
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: isDark ? AppColors.darkCard : Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = cat == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      cat,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: isSelected ? Colors.white : (isDark ? Colors.white : AppColors.textPrimary),
                      ),
                    ),
                    selected: isSelected,
                    showCheckmark: false,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                    selectedColor: AppColors.primary,
                    backgroundColor: isDark ? AppColors.darkCard : Colors.white,
                    side: BorderSide(color: isSelected ? AppColors.primary : AppColors.primary.withValues(alpha: 0.3)),
                    elevation: isSelected ? 3 : 0,
                    shadowColor: AppColors.primary.withValues(alpha: 0.4),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              physics: const BouncingScrollPhysics(),
              itemCount: _filteredServices.length,
              itemBuilder: (context, index) => _buildServiceCard(_filteredServices[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(CitizenService service) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: isDark ? 0.15 : 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.description_rounded, color: AppColors.info, size: 22),
          ),
          title: Text(service.nameBn, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          subtitle: Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(8)),
            child: Text(service.category, style: const TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w500)),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 4),
                  Text(service.description, style: const TextStyle(height: 1.5, fontSize: 13)),
                  const SizedBox(height: 14),
                  _buildDetailItem(Icons.folder_rounded, 'প্রয়োজনীয় কাগজপত্র:', service.requiredDocuments.map((d) => '• $d').join('\n')),
                  _buildDetailItem(Icons.payments_rounded, 'ফি:', service.fee),
                  _buildDetailItem(Icons.schedule_rounded, 'সময়সীমা:', service.timeLimit),
                  _buildDetailItem(Icons.business_rounded, 'অফিস:', service.office),
                  if (service.applicationUrl.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => Helpers.openUrl(service.applicationUrl),
                        icon: const Icon(Icons.open_in_new_rounded, size: 18),
                        label: const Text('অনলাইনে আবেদন করুন'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary, fontSize: 13)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(height: 1.4, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
