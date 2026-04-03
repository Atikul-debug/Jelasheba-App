import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../models/emergency_model.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  String _selectedBloodGroup = 'সব';

  final List<Map<String, dynamic>> _emergencyNumbers = [
    {'name': 'জাতীয় জরুরি সেবা', 'number': '999', 'icon': Icons.emergency, 'color': AppColors.error},
    {'name': 'ফায়ার সার্ভিস', 'number': '16163', 'icon': Icons.local_fire_department, 'color': Colors.orange},
    {'name': 'অ্যাম্বুলেন্স', 'number': '199', 'icon': Icons.local_hospital, 'color': AppColors.info},
    {'name': 'নারী ও শিশু হেল্পলাইন', 'number': '109', 'icon': Icons.woman, 'color': Colors.pink},
    {'name': 'শিশু হেল্পলাইন', 'number': '1098', 'icon': Icons.child_care, 'color': Colors.purple},
    {'name': 'জাতীয় তথ্য সেবা', 'number': '333', 'icon': Icons.info, 'color': AppColors.primary},
    {'name': 'দুর্নীতি দমন কমিশন', 'number': '106', 'icon': Icons.gavel, 'color': Colors.brown},
    {'name': 'সরকারি আইনি সেবা', 'number': '16430', 'icon': Icons.balance, 'color': Colors.teal},
  ];

  final List<PoliceStation> _policeStations = [
    PoliceStation(name: 'Sadar', nameBn: 'সদর থানা', ocName: 'মোঃ শফিকুল ইসলাম', phone: '01711-100001', address: 'সদর, জেলা সদর', latitude: 23.8, longitude: 90.4),
    PoliceStation(name: 'Kotwali', nameBn: 'কোতোয়ালী থানা', ocName: 'মোঃ নজরুল ইসলাম', phone: '01711-100002', address: 'কোতোয়ালী, জেলা সদর', latitude: 23.81, longitude: 90.41),
    PoliceStation(name: 'Model', nameBn: 'মডেল থানা', ocName: 'মোঃ হাবিবুর রহমান', phone: '01711-100003', address: 'মডেল টাউন, জেলা সদর', latitude: 23.79, longitude: 90.39),
  ];

  final List<BloodDonor> _bloodDonors = [
    BloodDonor(name: 'মোঃ রহিম উদ্দিন', phone: '01711-200001', bloodGroup: 'A+', area: 'সদর', lastDonation: DateTime(2026, 1, 15), isAvailable: true),
    BloodDonor(name: 'মোঃ করিম হোসেন', phone: '01711-200002', bloodGroup: 'B+', area: 'উত্তর', lastDonation: DateTime(2026, 2, 10), isAvailable: true),
    BloodDonor(name: 'মোঃ জাহিদ হাসান', phone: '01711-200003', bloodGroup: 'O+', area: 'দক্ষিণ', lastDonation: DateTime(2025, 12, 20), isAvailable: true),
    BloodDonor(name: 'মোঃ সাইফুল ইসলাম', phone: '01711-200004', bloodGroup: 'AB+', area: 'সদর', lastDonation: DateTime(2026, 3, 1), isAvailable: false),
    BloodDonor(name: 'মোঃ তানভীর আহমেদ', phone: '01711-200005', bloodGroup: 'A-', area: 'পূর্ব', lastDonation: DateTime(2026, 1, 5), isAvailable: true),
    BloodDonor(name: 'মোঃ ফারুক হোসেন', phone: '01711-200006', bloodGroup: 'O-', area: 'পশ্চিম', lastDonation: DateTime(2025, 11, 25), isAvailable: true),
    BloodDonor(name: 'মোঃ শাকিল আহমেদ', phone: '01711-200007', bloodGroup: 'B-', area: 'সদর', lastDonation: DateTime(2026, 2, 28), isAvailable: true),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('জরুরি সেবা'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'হেল্পলাইন'),
              Tab(text: 'থানা'),
              Tab(text: 'রক্তদাতা'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildHelplines(),
            _buildPoliceStations(),
            _buildBloodDonors(),
          ],
        ),
      ),
    );
  }

  Widget _buildHelplines() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      children: [
        // SOS Button
        Container(
          margin: const EdgeInsets.fromLTRB(4, 8, 4, 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.error.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Helpers.makePhoneCall('999'),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.emergency_rounded, size: 36, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    const Text('জরুরি কল করুন - ৯৯৯', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    const Text('ট্যাপ করে এখনই কল করুন', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
          child: Row(
            children: [
              Container(width: 4, height: 18, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text('সকল জরুরি নম্বর', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        ..._emergencyNumbers.map((e) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: isDark ? [] : AppColors.softShadow,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (e['color'] as Color).withValues(alpha: isDark ? 0.15 : 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(e['icon'] as IconData, color: e['color'] as Color, size: 22),
            ),
            title: Text(e['name'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            subtitle: Text(e['number'] as String, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: isDark ? AppColors.primaryLight : AppColors.primary)),
            trailing: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.call_rounded, color: AppColors.success, size: 20),
            ),
            onTap: () => Helpers.makePhoneCall(e['number'] as String),
          ),
        )),
        const SizedBox(height: 12),
        // Disaster Management
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 20),
                  ),
                  const SizedBox(width: 10),
                  const Text('দুর্যোগ ব্যবস্থাপনা', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 14),
              _buildDisasterInfo('আশ্রয়কেন্দ্র', '২৫টি সরকারি আশ্রয়কেন্দ্র'),
              _buildDisasterInfo('হেল্পলাইন', '১০৯০'),
              _buildDisasterInfo('দুর্যোগ পূর্বাভাস', 'বাংলাদেশ আবহাওয়া অধিদপ্তর'),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDisasterInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: AppColors.warning),
          const SizedBox(width: 10),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildPoliceStations() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      itemCount: _policeStations.length,
      itemBuilder: (context, index) {
        final station = _policeStations[index];
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
                  color: const Color(0xFF1A237E).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.local_police_rounded, color: Color(0xFF1A237E), size: 22),
              ),
              title: Text(station.nameBn, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              subtitle: Text('OC: ${station.ocName}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    children: [
                      const Divider(),
                      const SizedBox(height: 4),
                      _buildStationDetail('ওসি', station.ocName),
                      _buildStationDetail('ফোন', station.phone),
                      _buildStationDetail('ঠিকানা', station.address),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => Helpers.makePhoneCall(station.phone),
                              icon: const Icon(Icons.call_rounded, size: 18),
                              label: const Text('কল করুন'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Helpers.openMap(station.latitude, station.longitude),
                              icon: const Icon(Icons.map_rounded, size: 18),
                              label: const Text('ম্যাপে দেখুন'),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildStationDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 80, child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildBloodDonors() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bloodGroups = ['সব', 'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
    final filtered = _selectedBloodGroup == 'সব'
        ? _bloodDonors
        : _bloodDonors.where((d) => d.bloodGroup == _selectedBloodGroup).toList();

    return Column(
      children: [
        SizedBox(
          height: 56,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            itemCount: bloodGroups.length,
            itemBuilder: (context, index) {
              final group = bloodGroups[index];
              final isSelected = group == _selectedBloodGroup;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(group, style: TextStyle(fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400)),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedBloodGroup = group),
                  selectedColor: AppColors.error.withValues(alpha: 0.15),
                  checkmarkColor: AppColors.error,
                  side: BorderSide(color: isSelected ? AppColors.error.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.3)),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bloodtype_rounded, size: 64, color: Colors.grey[300]),
                      const SizedBox(height: 12),
                      const Text('এই গ্রুপের রক্তদাতা পাওয়া যায়নি', style: TextStyle(color: AppColors.textSecondary)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final donor = filtered[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: isDark ? [] : AppColors.softShadow,
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        leading: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              donor.bloodGroup,
                              style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.w800, fontSize: 13),
                            ),
                          ),
                        ),
                        title: Text(donor.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        subtitle: Row(
                          children: [
                            Text('${donor.area} ', style: const TextStyle(fontSize: 12)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                              decoration: BoxDecoration(
                                color: donor.isAvailable
                                    ? AppColors.success.withValues(alpha: 0.1)
                                    : Colors.grey.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                donor.isAvailable ? 'সচল' : 'অসচল',
                                style: TextStyle(
                                  color: donor.isAvailable ? AppColors.success : Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: donor.isAvailable
                            ? Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.success.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.call_rounded, color: AppColors.success, size: 20),
                              )
                            : Icon(Icons.block_rounded, color: Colors.grey[400], size: 20),
                        onTap: donor.isAvailable ? () => Helpers.makePhoneCall(donor.phone) : null,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
