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

  String _selectedRecordType = 'RS খতিয়ান';

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

  Widget _buildSectionHeader(String title, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Container(
          width: 4,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildStyledContainer({required Widget child}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark ? [] : AppColors.softShadow,
      ),
      child: child,
    );
  }

  Widget _buildKhatianSearch() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('ভূমি রেকর্ড অনুসন্ধান', Icons.search),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              'আপনার খতিয়ান/পর্চা তথ্য যাচাই করুন',
              style: TextStyle(
                color: isDark ? Colors.white70 : AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Record Type Chips
          Row(
            children: [
              _buildRecordTypeChip('RS খতিয়ান'),
              const SizedBox(width: 8),
              _buildRecordTypeChip('BS খতিয়ান'),
              const SizedBox(width: 8),
              _buildRecordTypeChip('SA খতিয়ান'),
            ],
          ),
          const SizedBox(height: 20),
          // Form container
          _buildStyledContainer(
            child: Column(
              children: [
                TextField(
                  controller: _khatianController,
                  decoration: const InputDecoration(
                    labelText: 'খতিয়ান নম্বর',
                    prefixIcon: Icon(Icons.numbers),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _dagController,
                  decoration: const InputDecoration(
                    labelText: 'দাগ নম্বর',
                    prefixIcon: Icon(Icons.numbers),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _mouzaController,
                  decoration: const InputDecoration(
                    labelText: 'মৌজার নাম',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _searchRecord,
                    icon: const Icon(Icons.search),
                    label: const Text('অনুসন্ধান করুন'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Info box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.info.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.info.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.info_outline, color: AppColors.info, size: 20),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'অনলাইন সেবা',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.info,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'ই-পর্চা ওয়েবসাইট থেকে সরাসরি ভূমি রেকর্ড দেখতে পারবেন।',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Helpers.openUrl('http://www.land.gov.bd'),
              icon: const Icon(Icons.open_in_new),
              label: const Text('ই-পর্চা ওয়েবসাইটে যান'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordTypeChip(String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _selectedRecordType == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedRecordType = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : (isDark
                    ? AppColors.darkCard
                    : AppColors.primary.withValues(alpha: 0.06)),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.3),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? AppColors.colorShadow(AppColors.primary)
                : [],
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
          ),
        ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildNamjari() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('নামজারি আবেদন', Icons.assignment),
          const SizedBox(height: 20),
          // Required documents container
          _buildStyledContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.folder_open, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'প্রয়োজনীয় কাগজপত্র:',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...['দলিলের সত্যায়িত কপি', 'খারিজ নামজারি আবেদন ফরম', 'DCR (ভূমি উন্নয়ন কর রশিদ)', 'পূর্ববর্তী মালিকের NID', 'নতুন মালিকের NID', 'মিউটেশন ফি রশিদ'].map((doc) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.check_circle, size: 16, color: AppColors.success),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(doc)),
                    ],
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Fees & timeline container
          _buildStyledContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.receipt_long, color: AppColors.accent, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'ফি ও সময়সীমা:',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildRecordRow('আবেদন ফি', '৫০০ টাকা'),
                _buildRecordRow('সময়সীমা', '৪৫ কার্যদিবস'),
                _buildRecordRow('আবেদন স্থান', 'এসি ল্যান্ড অফিস'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Helpers.openUrl('http://www.land.gov.bd'),
              icon: const Icon(Icons.open_in_new),
              label: const Text('অনলাইনে আবেদন করুন'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLandTax() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('ভূমি উন্নয়ন কর', Icons.account_balance),
          const SizedBox(height: 20),
          // Tax rates info box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkCard
                  : AppColors.primary.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.15),
              ),
              boxShadow: isDark ? [] : AppColors.softShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.calculate, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'করের হার:',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildTaxRateRow('কৃষি জমি', '২ টাকা/শতক/বছর', Icons.grass),
                _buildTaxRateRow('অকৃষি জমি', '৫ টাকা/শতক/বছর', Icons.landscape),
                _buildTaxRateRow('শহরাঞ্চল', '১০ টাকা/শতক/বছর', Icons.location_city),
                _buildTaxRateRow('বাণিজ্যিক', '২০ টাকা/শতক/বছর', Icons.business),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.success.withValues(alpha: 0.2),
                    ),
                  ),
                  child: const Text(
                    '* ২৫ বিঘা পর্যন্ত কৃষি জমি কর মুক্ত',
                    style: TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Helpers.openUrl('https://ldtax.gov.bd'),
              icon: const Icon(Icons.payment),
              label: const Text('অনলাইনে কর পরিশোধ করুন'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Payment methods container
          _buildStyledContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.info.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.payment, color: AppColors.info, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'পেমেন্ট পদ্ধতি:',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildPaymentMethodRow('বিকাশ / নগদ / রকেট', Icons.phone_android),
                _buildPaymentMethodRow('ব্যাংক ট্রান্সফার', Icons.account_balance),
                _buildPaymentMethodRow('তহসিল অফিসে সরাসরি', Icons.storefront),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxRateRow(String label, String rate, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: isDark ? Colors.white54 : AppColors.textSecondary),
          const SizedBox(width: 10),
          Expanded(child: Text(label)),
          Text(
            rate,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodRow(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: AppColors.primary),
          ),
          const SizedBox(width: 10),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildLandOffices() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final offices = [
      LandOffice(name: 'এসি ল্যান্ড অফিস (সদর)', officerName: 'মোঃ শরিফুল ইসলাম', designation: 'সহকারী কমিশনার (ভূমি)', phone: '01711-110001', address: 'জেলা প্রশাসকের কার্যালয়, সদর', upazila: 'সদর'),
      LandOffice(name: 'এসি ল্যান্ড অফিস (উত্তর)', officerName: 'মোঃ কামরুজ্জামান', designation: 'সহকারী কমিশনার (ভূমি)', phone: '01711-110002', address: 'উপজেলা পরিষদ, উত্তর', upazila: 'উত্তর'),
      LandOffice(name: 'সেটেলমেন্ট অফিস', officerName: 'মোঃ ফয়সাল আহমেদ', designation: 'সেটেলমেন্ট অফিসার', phone: '01711-110003', address: 'সেটেলমেন্ট ভবন, সদর', upazila: 'সদর'),
      LandOffice(name: 'সাব-রেজিস্ট্রি অফিস', officerName: 'মোঃ তৌফিকুর রহমান', designation: 'সাব-রেজিস্ট্রার', phone: '01711-110004', address: 'রেজিস্ট্রি ভবন, সদর', upazila: 'সদর'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: offices.length,
      itemBuilder: (context, index) {
        final office = offices[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDark ? [] : AppColors.softShadow,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.brown.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.business, color: Colors.brown, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      office.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${office.designation}: ${office.officerName}',
                      style: TextStyle(
                        color: isDark ? Colors.white70 : AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 13,
                          color: isDark ? Colors.white38 : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            office.address,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white54 : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () => Helpers.makePhoneCall(office.phone),
                  child: const Icon(Icons.call, color: AppColors.success, size: 20),
                ),
              ),
            ],
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
