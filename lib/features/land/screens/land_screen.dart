import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../models/land_model.dart';

class LandScreen extends StatefulWidget {
  const LandScreen({super.key});

  @override
  State<LandScreen> createState() => _LandScreenState();
}

class _LandScreenState extends State<LandScreen> {
  final _khatianController = TextEditingController();
  final _dagController = TextEditingController();
  final _mouzaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ভূমি সেবা'),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'খতিয়ান/পর্চা'),
              Tab(text: 'নামজারি'),
              Tab(text: 'ভূমি কর'),
              Tab(text: 'ভূমি অফিস'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildKhatianSearch(),
            _buildNamjari(),
            _buildLandTax(),
            _buildLandOffices(),
          ],
        ),
      ),
    );
  }

  Widget _buildKhatianSearch() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ভূমি রেকর্ড অনুসন্ধান', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('আপনার খতিয়ান/পর্চা তথ্য যাচাই করুন', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 20),
          // Record Type
          Row(
            children: [
              _buildRecordTypeChip('RS খতিয়ান'),
              const SizedBox(width: 8),
              _buildRecordTypeChip('BS খতিয়ান'),
              const SizedBox(width: 8),
              _buildRecordTypeChip('SA খতিয়ান'),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _khatianController,
            decoration: const InputDecoration(labelText: 'খতিয়ান নম্বর', prefixIcon: Icon(Icons.numbers)),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _dagController,
            decoration: const InputDecoration(labelText: 'দাগ নম্বর', prefixIcon: Icon(Icons.numbers)),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _mouzaController,
            decoration: const InputDecoration(labelText: 'মৌজার নাম', prefixIcon: Icon(Icons.location_on)),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _searchRecord,
              icon: const Icon(Icons.search),
              label: const Text('অনুসন্ধান করুন'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: AppColors.info.withValues(alpha: 0.1),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [Icon(Icons.info, color: AppColors.info), SizedBox(width: 8), Text('অনলাইন সেবা', style: TextStyle(fontWeight: FontWeight.bold))]),
                  SizedBox(height: 8),
                  Text('ই-পর্চা ওয়েবসাইট থেকে সরাসরি ভূমি রেকর্ড দেখতে পারবেন।'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Helpers.openUrl('http://www.land.gov.bd'),
              icon: const Icon(Icons.open_in_new),
              label: const Text('ই-পর্চা ওয়েবসাইটে যান'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordTypeChip(String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
        child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.primary)),
      ),
    );
  }

  void _searchRecord() {
    if (_khatianController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('খতিয়ান নম্বর লিখুন'), backgroundColor: Colors.red));
      return;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ভূমি রেকর্ড'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRecordRow('খতিয়ান নম্বর', _khatianController.text),
            _buildRecordRow('দাগ নম্বর', _dagController.text.isEmpty ? 'N/A' : _dagController.text),
            _buildRecordRow('মৌজা', _mouzaController.text.isEmpty ? 'N/A' : _mouzaController.text),
            const Divider(),
            _buildRecordRow('মালিক', 'মোঃ আব্দুল করিম'),
            _buildRecordRow('জমির পরিমাণ', '১.৫ একর'),
            _buildRecordRow('শ্রেণি', 'কৃষি জমি'),
            const SizedBox(height: 8),
            const Text('* এটি ডেমো ডেটা', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontStyle: FontStyle.italic)),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('বন্ধ করুন'))],
      ),
    );
  }

  Widget _buildRecordRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildNamjari() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('নামজারি আবেদন', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('প্রয়োজনীয় কাগজপত্র:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  ...['দলিলের সত্যায়িত কপি', 'খারিজ নামজারি আবেদন ফরম', 'DCR (ভূমি উন্নয়ন কর রশিদ)', 'পূর্ববর্তী মালিকের NID', 'নতুন মালিকের NID', 'মিউটেশন ফি রশিদ'].map((doc) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(children: [const Icon(Icons.check_circle, size: 18, color: AppColors.success), const SizedBox(width: 8), Expanded(child: Text(doc))]),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ফি ও সময়সীমা:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  _buildRecordRow('আবেদন ফি', '৫০০ টাকা'),
                  _buildRecordRow('সময়সীমা', '৪৫ কার্যদিবস'),
                  _buildRecordRow('আবেদন স্থান', 'এসি ল্যান্ড অফিস'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Helpers.openUrl('http://www.land.gov.bd'),
              icon: const Icon(Icons.open_in_new),
              label: const Text('অনলাইনে আবেদন করুন'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLandTax() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ভূমি উন্নয়ন কর', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Card(
            color: AppColors.primary.withValues(alpha: 0.05),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('করের হার:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 8),
                  Text('• কৃষি জমি: ২ টাকা/শতক/বছর'),
                  Text('• অকৃষি জমি: ৫ টাকা/শতক/বছর'),
                  Text('• শহরাঞ্চল: ১০ টাকা/শতক/বছর'),
                  Text('• বাণিজ্যিক: ২০ টাকা/শতক/বছর'),
                  SizedBox(height: 8),
                  Text('* ২৫ বিঘা পর্যন্ত কৃষি জমি কর মুক্ত', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Helpers.openUrl('https://ldtax.gov.bd'),
              icon: const Icon(Icons.payment),
              label: const Text('অনলাইনে কর পরিশোধ করুন'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('পেমেন্ট পদ্ধতি:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('• বিকাশ / নগদ / রকেট'),
                  Text('• ব্যাংক ট্রান্সফার'),
                  Text('• তহসিল অফিসে সরাসরি'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLandOffices() {
    final offices = [
      LandOffice(name: 'এসি ল্যান্ড অফিস (সদর)', officerName: 'মোঃ শরিফুল ইসলাম', designation: 'সহকারী কমিশনার (ভূমি)', phone: '01711-110001', address: 'জেলা প্রশাসকের কার্যালয়, সদর', upazila: 'সদর'),
      LandOffice(name: 'এসি ল্যান্ড অফিস (উত্তর)', officerName: 'মোঃ কামরুজ্জামান', designation: 'সহকারী কমিশনার (ভূমি)', phone: '01711-110002', address: 'উপজেলা পরিষদ, উত্তর', upazila: 'উত্তর'),
      LandOffice(name: 'সেটেলমেন্ট অফিস', officerName: 'মোঃ ফয়সাল আহমেদ', designation: 'সেটেলমেন্ট অফিসার', phone: '01711-110003', address: 'সেটেলমেন্ট ভবন, সদর', upazila: 'সদর'),
      LandOffice(name: 'সাব-রেজিস্ট্রি অফিস', officerName: 'মোঃ তৌফিকুর রহমান', designation: 'সাব-রেজিস্ট্রার', phone: '01711-110004', address: 'রেজিস্ট্রি ভবন, সদর', upazila: 'সদর'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: offices.length,
      itemBuilder: (context, index) {
        final office = offices[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.brown.withValues(alpha: 0.1),
              child: const Icon(Icons.business, color: Colors.brown),
            ),
            title: Text(office.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${office.designation}: ${office.officerName}'),
                Text(office.address, style: const TextStyle(fontSize: 12)),
              ],
            ),
            trailing: IconButton(icon: const Icon(Icons.call, color: AppColors.success), onPressed: () => Helpers.makePhoneCall(office.phone)),
            isThreeLine: true,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _khatianController.dispose();
    _dagController.dispose();
    _mouzaController.dispose();
    super.dispose();
  }
}
