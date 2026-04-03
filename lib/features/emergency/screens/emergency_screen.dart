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
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
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
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        // SOS Button
        Container(
          margin: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () => Helpers.makePhoneCall('999'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Column(
              children: [
                Icon(Icons.emergency, size: 40, color: Colors.white),
                SizedBox(height: 8),
                Text('জরুরি কল করুন - ৯৯৯', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                Text('ট্যাপ করে এখনই কল করুন', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('সকল জরুরি নম্বর', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        ..._emergencyNumbers.map((e) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: (e['color'] as Color).withValues(alpha: 0.1),
              child: Icon(e['icon'] as IconData, color: e['color'] as Color),
            ),
            title: Text(e['name'] as String, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(e['number'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
            trailing: IconButton(
              icon: const Icon(Icons.call, color: AppColors.success),
              onPressed: () => Helpers.makePhoneCall(e['number'] as String),
            ),
          ),
        )),
        const SizedBox(height: 16),
        // Disaster Management
        Card(
          margin: const EdgeInsets.all(16),
          color: AppColors.warning.withValues(alpha: 0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.warning_amber, color: AppColors.warning),
                    SizedBox(width: 8),
                    Text('দুর্যোগ ব্যবস্থাপনা', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                _buildDisasterInfo('আশ্রয়কেন্দ্র', '২৫টি সরকারি আশ্রয়কেন্দ্র'),
                _buildDisasterInfo('হেল্পলাইন', '১০৯০'),
                _buildDisasterInfo('দুর্যোগ পূর্বাভাস', 'বাংলাদেশ আবহাওয়া অধিদপ্তর'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDisasterInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: AppColors.warning),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildPoliceStations() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _policeStations.length,
      itemBuilder: (context, index) {
        final station = _policeStations[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ExpansionTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFF1A237E),
              child: Icon(Icons.local_police, color: Colors.white),
            ),
            title: Text(station.nameBn, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('OC: ${station.ocName}'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildStationDetail('ওসি', station.ocName),
                    _buildStationDetail('ফোন', station.phone),
                    _buildStationDetail('ঠিকানা', station.address),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => Helpers.makePhoneCall(station.phone),
                            icon: const Icon(Icons.call),
                            label: const Text('কল করুন'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => Helpers.openMap(station.latitude, station.longitude),
                            icon: const Icon(Icons.map),
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
          SizedBox(width: 80, child: Text(label, style: const TextStyle(color: AppColors.textSecondary))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildBloodDonors() {
    final bloodGroups = ['সব', 'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
    final filtered = _selectedBloodGroup == 'সব'
        ? _bloodDonors
        : _bloodDonors.where((d) => d.bloodGroup == _selectedBloodGroup).toList();

    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: bloodGroups.length,
            itemBuilder: (context, index) {
              final group = bloodGroups[index];
              final isSelected = group == _selectedBloodGroup;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(group),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedBloodGroup = group),
                  selectedColor: AppColors.error.withValues(alpha: 0.2),
                  checkmarkColor: AppColors.error,
                ),
              );
            },
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? const Center(child: Text('এই গ্রুপের রক্তদাতা পাওয়া যায়নি'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final donor = filtered[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.error.withValues(alpha: 0.1),
                          child: Text(donor.bloodGroup, style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                        title: Text(donor.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text('${donor.area} | ${donor.isAvailable ? "সচল" : "অসচল"}'),
                        trailing: donor.isAvailable
                            ? IconButton(icon: const Icon(Icons.call, color: AppColors.success), onPressed: () => Helpers.makePhoneCall(donor.phone))
                            : const Icon(Icons.block, color: Colors.grey),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
