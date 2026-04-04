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
    // সিরাজগঞ্জ জেলার সকল থানা (১৩টি)
    PoliceStation(name: 'Sirajganj Sadar', nameBn: 'সিরাজগঞ্জ সদর থানা', ocName: 'মোঃ মাহবুবুর রহমান', phone: '01713-373001', address: 'সদর, সিরাজগঞ্জ', latitude: 24.4534, longitude: 89.7003),
    PoliceStation(name: 'Kotwali Model', nameBn: 'কোতোয়ালী মডেল থানা', ocName: 'মোঃ জাহাঙ্গীর আলম', phone: '01713-373002', address: 'কোতোয়ালী, সিরাজগঞ্জ', latitude: 24.4520, longitude: 89.6990),
    PoliceStation(name: 'Shahjadpur', nameBn: 'শাহজাদপুর থানা', ocName: 'মোঃ সাইফুল ইসলাম', phone: '01713-373003', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1833, longitude: 89.5917),
    PoliceStation(name: 'Ullapara', nameBn: 'উল্লাপাড়া থানা', ocName: 'মোঃ নাজমুল হক', phone: '01713-373004', address: 'উল্লাপাড়া, সিরাজগঞ্জ', latitude: 24.3167, longitude: 89.5500),
    PoliceStation(name: 'Kazipur', nameBn: 'কাজীপুর থানা', ocName: 'মোঃ ফারুক হোসেন', phone: '01713-373005', address: 'কাজীপুর, সিরাজগঞ্জ', latitude: 24.6333, longitude: 89.6167),
    PoliceStation(name: 'Belkuchi', nameBn: 'বেলকুচি থানা', ocName: 'মোঃ আব্দুল কাদের', phone: '01713-373006', address: 'বেলকুচি, সিরাজগঞ্জ', latitude: 24.3700, longitude: 89.6800),
    PoliceStation(name: 'Chauhali', nameBn: 'চৌহালী থানা', ocName: 'মোঃ রশিদুল ইসলাম', phone: '01713-373007', address: 'চৌহালী, সিরাজগঞ্জ', latitude: 24.3833, longitude: 89.7500),
    PoliceStation(name: 'Kamarkhanda', nameBn: 'কামারখন্দ থানা', ocName: 'মোঃ শাহাদাত হোসেন', phone: '01713-373008', address: 'কামারখন্দ, সিরাজগঞ্জ', latitude: 24.3500, longitude: 89.5833),
    PoliceStation(name: 'Raiganj', nameBn: 'রায়গঞ্জ থানা', ocName: 'মোঃ তারিকুল ইসলাম', phone: '01713-373009', address: 'রায়গঞ্জ, সিরাজগঞ্জ', latitude: 24.2700, longitude: 89.5200),
    PoliceStation(name: 'Tarash', nameBn: 'তাড়াশ থানা', ocName: 'মোঃ মোস্তাফিজুর রহমান', phone: '01713-373010', address: 'তাড়াশ, সিরাজগঞ্জ', latitude: 24.2600, longitude: 89.4600),
    PoliceStation(name: 'Enayetpur', nameBn: 'এনায়েতপুর থানা', ocName: 'মোঃ আনোয়ার হোসেন', phone: '01713-373011', address: 'এনায়েতপুর, কামারখন্দ, সিরাজগঞ্জ', latitude: 24.3520, longitude: 89.6840),
    PoliceStation(name: 'Salanga', nameBn: 'সলঙ্গা থানা', ocName: 'মোঃ ইকবাল হোসেন', phone: '01713-373012', address: 'সলঙ্গা, শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.2000, longitude: 89.6000),
    PoliceStation(name: 'Chowhali Bazar', nameBn: 'চৌহালী বাজার থানা', ocName: 'মোঃ রফিকুল ইসলাম', phone: '01713-373013', address: 'চৌহালী বাজার, সিরাজগঞ্জ', latitude: 24.3900, longitude: 89.7600),
  ];

  final List<BloodDonor> _bloodDonors = [
    BloodDonor(name: 'মোঃ রাকিবুল হাসান', phone: '01711-200001', bloodGroup: 'A+', area: 'সদর', lastDonation: DateTime(2026, 1, 15), isAvailable: true),
    BloodDonor(name: 'মোঃ তানভীর আহমেদ', phone: '01711-200002', bloodGroup: 'B+', area: 'শাহজাদপুর', lastDonation: DateTime(2026, 2, 10), isAvailable: true),
    BloodDonor(name: 'মোঃ সোহেল রানা', phone: '01711-200003', bloodGroup: 'O+', area: 'উল্লাপাড়া', lastDonation: DateTime(2025, 12, 20), isAvailable: true),
    BloodDonor(name: 'মোঃ আরিফুল ইসলাম', phone: '01711-200004', bloodGroup: 'AB+', area: 'কাজীপুর', lastDonation: DateTime(2026, 3, 1), isAvailable: false),
    BloodDonor(name: 'মোঃ ইমরান হোসেন', phone: '01711-200005', bloodGroup: 'A-', area: 'বেলকুচি', lastDonation: DateTime(2026, 1, 5), isAvailable: true),
    BloodDonor(name: 'মোঃ শাকিল আহমেদ', phone: '01711-200006', bloodGroup: 'O-', area: 'তাড়াশ', lastDonation: DateTime(2025, 11, 25), isAvailable: true),
    BloodDonor(name: 'মোঃ নাঈম হোসেন', phone: '01711-200007', bloodGroup: 'B-', area: 'সদর', lastDonation: DateTime(2026, 2, 28), isAvailable: true),
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showDonorRegistrationForm(),
          backgroundColor: AppColors.error,
          icon: const Icon(Icons.volunteer_activism_rounded, color: Colors.white),
          label: const Text('রক্তদাতা যোগ দিন', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          elevation: 6,
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
              _buildDisasterInfo('আশ্রয়কেন্দ্র', '৩৫টি সরকারি আশ্রয়কেন্দ্র'),
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
            // Blood group filter
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
                      label: Text(
                        group,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : (isDark ? Colors.white : AppColors.textPrimary),
                        ),
                      ),
                      selected: isSelected,
                      showCheckmark: false,
                      onSelected: (_) => setState(() => _selectedBloodGroup = group),
                      selectedColor: AppColors.error,
                      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
                      side: BorderSide(color: isSelected ? AppColors.error : AppColors.error.withValues(alpha: 0.3)),
                      elevation: isSelected ? 3 : 0,
                      shadowColor: AppColors.error.withValues(alpha: 0.4),
                    ),
                  );
                },
              ),
            ),
            // Donor count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Row(
                children: [
                  Container(width: 4, height: 16, decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 8),
                  Text('মোট ${filtered.length} জন রক্তদাতা', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Donor list
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
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 70),
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
                                Icon(Icons.location_on_rounded, size: 12, color: Colors.grey[400]),
                                const SizedBox(width: 2),
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

  void _showDonorRegistrationForm() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final areaController = TextEditingController();
    String selectedGroup = 'A+';
    final allGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(height: 16),
                  // Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFFDC2626), Color(0xFFEF4444)]),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('রক্তদাতা রেজিস্ট্রেশন', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                          Text('আপনার তথ্য দিয়ে যোগ দিন', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // নাম
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'আপনার নাম *',
                      prefixIcon: Icon(Icons.person_rounded),
                      hintText: 'পূর্ণ নাম লিখুন',
                    ),
                  ),
                  const SizedBox(height: 14),

                  // ফোন নম্বর
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'মোবাইল নম্বর *',
                      prefixIcon: Icon(Icons.phone_rounded),
                      hintText: '01XXXXXXXXX',
                    ),
                  ),
                  const SizedBox(height: 14),

                  // এলাকা
                  TextField(
                    controller: areaController,
                    decoration: const InputDecoration(
                      labelText: 'এলাকা / ঠিকানা *',
                      prefixIcon: Icon(Icons.location_on_rounded),
                      hintText: 'যেমন: সদর, শাহজাদপুর',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // রক্তের গ্রুপ
                  const Text('রক্তের গ্রুপ নির্বাচন করুন *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: allGroups.map((group) {
                      final isSelected = group == selectedGroup;
                      return GestureDetector(
                        onTap: () => setModalState(() => selectedGroup = group),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 60,
                          height: 44,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.error : (isDark ? AppColors.darkCard : Colors.white),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? AppColors.error : AppColors.error.withValues(alpha: 0.3),
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: isSelected ? [BoxShadow(color: AppColors.error.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2))] : [],
                          ),
                          child: Center(
                            child: Text(
                              group,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: isSelected ? Colors.white : AppColors.error,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Validate
                        if (nameController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('আপনার নাম লিখুন'), backgroundColor: AppColors.error));
                          return;
                        }
                        if (phoneController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('মোবাইল নম্বর লিখুন'), backgroundColor: AppColors.error));
                          return;
                        }
                        if (areaController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('এলাকা / ঠিকানা লিখুন'), backgroundColor: AppColors.error));
                          return;
                        }

                        // Add donor
                        setState(() {
                          _bloodDonors.insert(0, BloodDonor(
                            name: nameController.text.trim(),
                            phone: phoneController.text.trim(),
                            bloodGroup: selectedGroup,
                            area: areaController.text.trim(),
                            lastDonation: DateTime.now(),
                            isAvailable: true,
                          ));
                        });

                        Navigator.pop(context);

                        // Success dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 52),
                                ),
                                const SizedBox(height: 16),
                                const Text('ধন্যবাদ! 🎉', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                                const SizedBox(height: 8),
                                Text(
                                  'আপনি সফলভাবে রক্তদাতা হিসেবে যোগ দিয়েছেন।\n\nনাম: ${nameController.text.trim()}\nরক্তের গ্রুপ: $selectedGroup\nএলাকা: ${areaController.text.trim()}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14, height: 1.5),
                                ),
                                const SizedBox(height: 8),
                                const Text('আপনার তথ্য তালিকায় যোগ হয়েছে।', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                              ],
                            ),
                            actions: [
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('ঠিক আছে'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.volunteer_activism_rounded),
                      label: const Text('রক্তদাতা হিসেবে যোগ দিন', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
