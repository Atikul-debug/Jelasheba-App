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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('যোগাযোগ')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'নাম, পদবি বা অফিস অনুসন্ধান...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).cardTheme.color,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat, style: const TextStyle(fontSize: 12)),
                    selected: cat == _selectedCategory,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                    selectedColor: AppColors.primary.withValues(alpha: 0.2),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(child: Text('কোনো তথ্য পাওয়া যায়নি'))
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final contact = _filtered[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                            child: const Icon(Icons.business, color: AppColors.primary),
                          ),
                          title: Text(contact.nameBn, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(contact.designationBn, style: const TextStyle(color: AppColors.primary, fontSize: 13)),
                              Text(contact.officeBn, style: const TextStyle(fontSize: 12)),
                              Text(contact.address, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                            ],
                          ),
                          isThreeLine: true,
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.call, color: AppColors.success, size: 20),
                                onPressed: () => Helpers.makePhoneCall(contact.phone),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                              if (contact.email != null)
                                IconButton(
                                  icon: const Icon(Icons.email, color: AppColors.info, size: 20),
                                  onPressed: () => Helpers.sendEmail(contact.email!),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                            ],
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
}
