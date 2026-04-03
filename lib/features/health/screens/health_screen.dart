import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../models/health_model.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  String _searchQuery = '';

  final List<Hospital> _hospitals = [
    Hospital(id: '1', name: 'District Sadar Hospital', nameBn: 'জেলা সদর হাসপাতাল', type: 'government', address: 'হাসপাতাল রোড, সদর', phone: '01711-300001', bedCount: 250, hasEmergency: true, departments: ['মেডিসিন', 'সার্জারি', 'গাইনি', 'শিশু', 'অর্থোপেডিক', 'চক্ষু', 'ENT'], latitude: 23.8, longitude: 90.4),
    Hospital(id: '2', name: 'Upazila Health Complex', nameBn: 'উপজেলা স্বাস্থ্য কমপ্লেক্স', type: 'government', address: 'উত্তর উপজেলা', phone: '01711-300002', bedCount: 50, hasEmergency: true, departments: ['মেডিসিন', 'সার্জারি', 'গাইনি'], latitude: 23.82, longitude: 90.42),
    Hospital(id: '3', name: 'Modern Hospital', nameBn: 'মডার্ন হাসপাতাল', type: 'private', address: 'স্টেশন রোড, সদর', phone: '01711-300003', bedCount: 100, hasEmergency: true, departments: ['মেডিসিন', 'সার্জারি', 'কার্ডিওলজি', 'নিউরোলজি'], latitude: 23.81, longitude: 90.41),
    Hospital(id: '4', name: 'City Clinic', nameBn: 'সিটি ক্লিনিক', type: 'private', address: 'কলেজ রোড, সদর', phone: '01711-300004', bedCount: 50, hasEmergency: false, departments: ['মেডিসিন', 'গাইনি', 'শিশু'], latitude: 23.79, longitude: 90.39),
  ];

  final List<Doctor> _doctors = [
    Doctor(id: '1', name: 'Dr. Md. Abdul Karim', nameBn: 'ডাঃ মোঃ আব্দুল করিম', specialty: 'Medicine', specialtyBn: 'মেডিসিন', qualification: 'MBBS, FCPS (Medicine)', hospital: 'জেলা সদর হাসপাতাল', chamber: 'হাসপাতাল রোড, সদর', phone: '01711-400001', visitingHours: 'সকাল ৯টা - দুপুর ২টা', fee: 500),
    Doctor(id: '2', name: 'Dr. Fatema Khatun', nameBn: 'ডাঃ ফাতেমা খাতুন', specialty: 'Gynecology', specialtyBn: 'গাইনি ও প্রসূতি', qualification: 'MBBS, MS (Gynae)', hospital: 'জেলা সদর হাসপাতাল', chamber: 'মডার্ন হাসপাতাল', phone: '01711-400002', visitingHours: 'বিকাল ৪টা - রাত ৮টা', fee: 700),
    Doctor(id: '3', name: 'Dr. Md. Hasan Ali', nameBn: 'ডাঃ মোঃ হাসান আলী', specialty: 'Surgery', specialtyBn: 'সার্জারি', qualification: 'MBBS, FCPS (Surgery)', hospital: 'মডার্ন হাসপাতাল', chamber: 'স্টেশন রোড', phone: '01711-400003', visitingHours: 'সকাল ১০টা - দুপুর ১টা', fee: 800),
    Doctor(id: '4', name: 'Dr. Md. Rahim Uddin', nameBn: 'ডাঃ মোঃ রহিম উদ্দিন', specialty: 'Pediatrics', specialtyBn: 'শিশু রোগ', qualification: 'MBBS, DCH', hospital: 'সিটি ক্লিনিক', chamber: 'কলেজ রোড', phone: '01711-400004', visitingHours: 'বিকাল ৫টা - রাত ৯টা', fee: 600),
    Doctor(id: '5', name: 'Dr. Md. Kamal', nameBn: 'ডাঃ মোঃ কামাল', specialty: 'Cardiology', specialtyBn: 'হৃদরোগ', qualification: 'MBBS, MD (Cardio)', hospital: 'মডার্ন হাসপাতাল', chamber: 'মডার্ন হাসপাতাল', phone: '01711-400005', visitingHours: 'সকাল ৮টা - দুপুর ১২টা', fee: 1000),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('স্বাস্থ্য সেবা'),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'হাসপাতাল'),
              Tab(text: 'ডাক্তার'),
              Tab(text: 'ফার্মেসি'),
              Tab(text: 'ডায়াগনস্টিক'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildHospitalList(),
            _buildDoctorList(),
            _buildPharmacyList(),
            _buildDiagnosticList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _hospitals.length,
      itemBuilder: (context, index) {
        final hospital = _hospitals[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: hospital.type == 'government' ? AppColors.primary.withValues(alpha: 0.1) : AppColors.secondary.withValues(alpha: 0.1),
              child: Icon(Icons.local_hospital, color: hospital.type == 'government' ? AppColors.primary : AppColors.secondary),
            ),
            title: Text(hospital.nameBn, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: hospital.type == 'government' ? AppColors.primary.withValues(alpha: 0.1) : AppColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(hospital.type == 'government' ? 'সরকারি' : 'বেসরকারি', style: TextStyle(fontSize: 10, color: hospital.type == 'government' ? AppColors.primary : AppColors.secondary)),
                ),
                const SizedBox(width: 8),
                if (hospital.hasEmergency)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                    child: const Text('জরুরি বিভাগ', style: TextStyle(fontSize: 10, color: AppColors.error)),
                  ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHospitalDetail('ঠিকানা', hospital.address),
                    _buildHospitalDetail('ফোন', hospital.phone),
                    _buildHospitalDetail('বেড সংখ্যা', '${hospital.bedCount}'),
                    const SizedBox(height: 8),
                    const Text('বিভাগসমূহ:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      children: hospital.departments.map((d) => Chip(label: Text(d, style: const TextStyle(fontSize: 12)), padding: EdgeInsets.zero)).toList(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: ElevatedButton.icon(onPressed: () => Helpers.makePhoneCall(hospital.phone), icon: const Icon(Icons.call), label: const Text('কল'))),
                        const SizedBox(width: 8),
                        Expanded(child: OutlinedButton.icon(onPressed: () => Helpers.openMap(hospital.latitude, hospital.longitude), icon: const Icon(Icons.map), label: const Text('ম্যাপ'))),
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

  Widget _buildHospitalDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(color: AppColors.textSecondary))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildDoctorList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: (v) => setState(() => _searchQuery = v),
            decoration: InputDecoration(
              hintText: 'ডাক্তার অনুসন্ধান...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Theme.of(context).cardTheme.color,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _doctors.where((d) => _searchQuery.isEmpty || d.nameBn.contains(_searchQuery) || d.specialtyBn.contains(_searchQuery)).length,
            itemBuilder: (context, index) {
              final doctor = _doctors.where((d) => _searchQuery.isEmpty || d.nameBn.contains(_searchQuery) || d.specialtyBn.contains(_searchQuery)).toList()[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE8F5E9),
                    child: Icon(Icons.medical_services, color: AppColors.primary),
                  ),
                  title: Text(doctor.nameBn, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctor.specialtyBn, style: const TextStyle(color: AppColors.primary)),
                      Text(doctor.qualification, style: const TextStyle(fontSize: 12)),
                      Text('${doctor.hospital} | ফি: ৳${doctor.fee.toInt()}', style: const TextStyle(fontSize: 12)),
                      Text('সময়: ${doctor.visitingHours}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.call, color: AppColors.success),
                    onPressed: () => Helpers.makePhoneCall(doctor.phone),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPharmacyList() {
    final pharmacies = [
      Pharmacy(name: 'লাজ ফার্মেসি', address: 'হাসপাতাল রোড, সদর', phone: '01711-500001', openingHours: 'সকাল ৮টা - রাত ১০টা', isOpen24Hours: false),
      Pharmacy(name: 'পপুলার ফার্মেসি', address: 'স্টেশন রোড, সদর', phone: '01711-500002', openingHours: '২৪ ঘন্টা', isOpen24Hours: true),
      Pharmacy(name: 'মডেল ফার্মেসি', address: 'কলেজ রোড, সদর', phone: '01711-500003', openingHours: 'সকাল ৭টা - রাত ১১টা', isOpen24Hours: false),
      Pharmacy(name: 'সিটি ফার্মেসি', address: 'বাজার রোড, সদর', phone: '01711-500004', openingHours: '২৪ ঘন্টা', isOpen24Hours: true),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: pharmacies.length,
      itemBuilder: (context, index) {
        final pharmacy = pharmacies[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green.withValues(alpha: 0.1),
              child: const Icon(Icons.local_pharmacy, color: Colors.green),
            ),
            title: Text(pharmacy.name, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pharmacy.address),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14, color: pharmacy.isOpen24Hours ? AppColors.success : AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(pharmacy.openingHours, style: TextStyle(fontSize: 12, color: pharmacy.isOpen24Hours ? AppColors.success : AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
            trailing: IconButton(icon: const Icon(Icons.call, color: AppColors.success), onPressed: () => Helpers.makePhoneCall(pharmacy.phone)),
          ),
        );
      },
    );
  }

  Widget _buildDiagnosticList() {
    final diagnostics = [
      DiagnosticCenter(name: 'জেলা ডায়াগনস্টিক সেন্টার', address: 'হাসপাতাল রোড, সদর', phone: '01711-600001', services: ['এক্স-রে', 'আল্ট্রাসনোগ্রাফি', 'ব্লাড টেস্ট', 'ইসিজি']),
      DiagnosticCenter(name: 'মডার্ন ডায়াগনস্টিক', address: 'স্টেশন রোড, সদর', phone: '01711-600002', services: ['সিটি স্ক্যান', 'এমআরআই', 'এক্স-রে', 'ব্লাড টেস্ট', 'ইসিজি', 'ইকো']),
      DiagnosticCenter(name: 'পপুলার ল্যাব', address: 'কলেজ রোড, সদর', phone: '01711-600003', services: ['ব্লাড টেস্ট', 'ইউরিন টেস্ট', 'বায়োকেমিস্ট্রি']),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: diagnostics.length,
      itemBuilder: (context, index) {
        final d = diagnostics[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.withValues(alpha: 0.1),
              child: const Icon(Icons.biotech, color: Colors.blue),
            ),
            title: Text(d.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(d.address),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('সেবাসমূহ:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Wrap(spacing: 8, runSpacing: 4, children: d.services.map((s) => Chip(label: Text(s, style: const TextStyle(fontSize: 12)), padding: EdgeInsets.zero)).toList()),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(onPressed: () => Helpers.makePhoneCall(d.phone), icon: const Icon(Icons.call), label: Text('কল: ${d.phone}')),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
