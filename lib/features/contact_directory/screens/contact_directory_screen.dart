import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../models/contact_model.dart';

class ContactDirectoryScreen extends StatefulWidget {
  const ContactDirectoryScreen({super.key});

  @override
  State<ContactDirectoryScreen> createState() => _ContactDirectoryScreenState();
}

class _ContactDirectoryScreenState extends State<ContactDirectoryScreen> {
  String _selectedCategory = 'সব';
  String _searchQuery = '';

  final List<ContactInfo> _contacts = [
    ContactInfo(id: '1', name: 'Md. Abdullah', nameBn: 'মোঃ আব্দুল্লাহ আল মামুন', designation: 'DC', designationBn: 'জেলা প্রশাসক', office: 'DC Office', officeBn: 'জেলা প্রশাসকের কার্যালয়', phone: '02-1234567', email: 'dc@district.gov.bd', address: 'জেলা প্রশাসকের কার্যালয়, সদর', category: 'administration', categoryBn: 'প্রশাসন'),
    ContactInfo(id: '2', name: 'Md. Anisur', nameBn: 'মোঃ আনিসুর রহমান', designation: 'SP', designationBn: 'পুলিশ সুপার', office: 'SP Office', officeBn: 'পুলিশ সুপারের কার্যালয়', phone: '02-2345678', email: 'sp@police.gov.bd', address: 'পুলিশ সুপারের কার্যালয়, সদর', category: 'police', categoryBn: 'পুলিশ'),
    ContactInfo(id: '3', name: 'Dr. Md. Hasan', nameBn: 'ডাঃ মোঃ হাসান আলী', designation: 'Civil Surgeon', designationBn: 'সিভিল সার্জন', office: 'Civil Surgeon Office', officeBn: 'সিভিল সার্জন অফিস', phone: '02-3456789', email: 'cs@health.gov.bd', address: 'সিভিল সার্জন অফিস, সদর', category: 'health', categoryBn: 'স্বাস্থ্য'),
    ContactInfo(id: '4', name: 'Md. Kamruzzaman', nameBn: 'মোঃ কামরুজ্জামান', designation: 'DEO', designationBn: 'জেলা শিক্ষা অফিসার', office: 'Education Office', officeBn: 'জেলা শিক্ষা অফিস', phone: '02-4567890', email: 'deo@education.gov.bd', address: 'জেলা শিক্ষা অফিস, সদর', category: 'education', categoryBn: 'শিক্ষা'),
    ContactInfo(id: '5', name: 'Md. Anowar', nameBn: 'মোঃ আনোয়ার হোসেন', designation: 'DD Agriculture', designationBn: 'উপ-পরিচালক (কৃষি)', office: 'DAE', officeBn: 'কৃষি সম্প্রসারণ অধিদপ্তর', phone: '02-5678901', email: 'dd@dae.gov.bd', address: 'কৃষি ভবন, সদর', category: 'agriculture', categoryBn: 'কৃষি'),
    ContactInfo(id: '6', name: 'Sonali Bank', nameBn: 'সোনালী ব্যাংক', designation: 'Branch', designationBn: 'সদর শাখা', office: 'Sonali Bank', officeBn: 'সোনালী ব্যাংক লি.', phone: '02-6789012', address: 'ব্যাংক রোড, সদর', category: 'bank', categoryBn: 'ব্যাংক'),
    ContactInfo(id: '7', name: 'Janata Bank', nameBn: 'জনতা ব্যাংক', designation: 'Branch', designationBn: 'সদর শাখা', office: 'Janata Bank', officeBn: 'জনতা ব্যাংক লি.', phone: '02-7890123', address: 'স্টেশন রোড, সদর', category: 'bank', categoryBn: 'ব্যাংক'),
    ContactInfo(id: '8', name: 'Head Post Office', nameBn: 'প্রধান ডাকঘর', designation: 'Post Master', designationBn: 'পোস্ট মাস্টার', office: 'Post Office', officeBn: 'প্রধান ডাকঘর', phone: '02-8901234', address: 'ডাকঘর রোড, সদর', category: 'post', categoryBn: 'ডাক'),
    ContactInfo(id: '9', name: 'BRAC', nameBn: 'ব্র্যাক', designation: 'Area Manager', designationBn: 'এরিয়া ম্যানেজার', office: 'BRAC', officeBn: 'ব্র্যাক আঞ্চলিক কার্যালয়', phone: '02-9012345', address: 'এনজিও ভবন, সদর', category: 'ngo', categoryBn: 'এনজিও'),
    ContactInfo(id: '10', name: 'Social Welfare', nameBn: 'সমাজসেবা অফিস', designation: 'DSS Officer', designationBn: 'জেলা সমাজসেবা অফিসার', office: 'DSS', officeBn: 'জেলা সমাজসেবা কার্যালয়', phone: '02-0123456', address: 'সমাজসেবা ভবন, সদর', category: 'administration', categoryBn: 'প্রশাসন'),
  ];

  final List<String> _categories = ['সব', 'প্রশাসন', 'পুলিশ', 'স্বাস্থ্য', 'শিক্ষা', 'কৃষি', 'ব্যাংক', 'ডাক', 'এনজিও'];

  List<ContactInfo> get _filtered {
    return _contacts.where((c) {
      final matchCat = _selectedCategory == 'সব' || c.categoryBn == _selectedCategory;
      final matchSearch = _searchQuery.isEmpty || c.nameBn.contains(_searchQuery) || c.officeBn.contains(_searchQuery) || c.designationBn.contains(_searchQuery);
      return matchCat && matchSearch;
    }).toList();
  }

  Color _getCatColor(String cat) {
    switch (cat) {
      case 'প্রশাসন': return AppColors.primary;
      case 'পুলিশ': return const Color(0xFF1A237E);
      case 'স্বাস্থ্য': return const Color(0xFFE91E63);
      case 'শিক্ষা': return const Color(0xFF7C3AED);
      case 'কৃষি': return const Color(0xFF059669);
      case 'ব্যাংক': return const Color(0xFFF59E0B);
      case 'ডাক': return const Color(0xFFEF4444);
      case 'এনজিও': return const Color(0xFF06B6D4);
      default: return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('যোগাযোগ')),
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
                  hintText: 'নাম, পদবি বা অফিস অনুসন্ধান...',
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = cat == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: FilterChip(
                    label: Text(cat, style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400)),
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
          const SizedBox(height: 4),
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off_rounded, size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 12),
                        const Text('কোনো তথ্য পাওয়া যায়নি', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final contact = _filtered[index];
                      return _buildContactCard(contact, isDark);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(ContactInfo contact, bool isDark) {
    final color = _getCatColor(contact.categoryBn);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: isDark ? [] : AppColors.softShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: isDark ? 0.15 : 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.business_rounded, color: color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.nameBn, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(contact.designationBn, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
                  Text(contact.officeBn, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, size: 12, color: Colors.grey[400]),
                      const SizedBox(width: 2),
                      Expanded(child: Text(contact.address, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary))),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () => Helpers.makePhoneCall(contact.phone),
                    child: const Icon(Icons.call_rounded, color: AppColors.success, size: 18),
                  ),
                ),
                if (contact.email != null) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.info.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () => Helpers.sendEmail(contact.email!),
                      child: const Icon(Icons.email_rounded, color: AppColors.info, size: 18),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
