import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../models/education_model.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  String _selectedType = 'সব';
  String _searchQuery = '';

  final List<EducationInstitution> _institutions = [
    EducationInstitution(id: '1', name: 'Govt. Primary School', nameBn: 'সরকারি প্রাথমিক বিদ্যালয়', type: 'primary', typeBn: 'প্রাথমিক', address: 'সদর, জেলা সদর', phone: '01711-700001', principalName: 'মোঃ আমিনুল ইসলাম', eiin: '100001', mpoStatus: 'সরকারি', studentCount: 450, teacherCount: 12),
    EducationInstitution(id: '2', name: 'Zilla School', nameBn: 'জেলা স্কুল', type: 'secondary', typeBn: 'মাধ্যমিক', address: 'স্কুল রোড, সদর', phone: '01711-700002', principalName: 'মোঃ ফজলুল হক', eiin: '100002', mpoStatus: 'সরকারি', studentCount: 1200, teacherCount: 45),
    EducationInstitution(id: '3', name: 'Girls High School', nameBn: 'বালিকা উচ্চ বিদ্যালয়', type: 'secondary', typeBn: 'মাধ্যমিক', address: 'কলেজ রোড, সদর', phone: '01711-700003', principalName: 'ফাতেমা বেগম', eiin: '100003', mpoStatus: 'MPO', studentCount: 800, teacherCount: 30),
    EducationInstitution(id: '4', name: 'Govt. College', nameBn: 'সরকারি কলেজ', type: 'college', typeBn: 'কলেজ', address: 'কলেজ রোড, সদর', phone: '01711-700004', principalName: 'প্রফেসর মোঃ আলী আকবর', eiin: '100004', mpoStatus: 'সরকারি', studentCount: 3000, teacherCount: 80),
    EducationInstitution(id: '5', name: 'Darul Ulum Madrasa', nameBn: 'দারুল উলুম মাদ্রাসা', type: 'madrasa', typeBn: 'মাদ্রাসা', address: 'মাদ্রাসা রোড, সদর', phone: '01711-700005', principalName: 'মাওলানা আব্দুল্লাহ', eiin: '100005', mpoStatus: 'MPO', studentCount: 600, teacherCount: 25),
    EducationInstitution(id: '6', name: 'Technical Institute', nameBn: 'কারিগরি শিক্ষা প্রতিষ্ঠান', type: 'technical', typeBn: 'কারিগরি', address: 'ইন্ডাস্ট্রিয়াল এরিয়া, সদর', phone: '01711-700006', principalName: 'মোঃ ইকবাল হোসেন', eiin: '100006', mpoStatus: 'সরকারি', studentCount: 500, teacherCount: 20),
  ];

  final List<Scholarship> _scholarships = [
    Scholarship(name: 'Primary Stipend', nameBn: 'প্রাথমিক শিক্ষা উপবৃত্তি', description: 'প্রাথমিক স্তরের শিক্ষার্থীদের জন্য সরকারি উপবৃত্তি', eligibility: 'প্রাথমিক বিদ্যালয়ের ৬০% এর উপরে ফলাফল', applicationUrl: '', deadline: DateTime(2026, 6, 30), amount: '৩০০ টাকা/মাস'),
    Scholarship(name: 'Secondary Stipend', nameBn: 'মাধ্যমিক শিক্ষা উপবৃত্তি', description: 'মাধ্যমিক স্তরের মেয়ে শিক্ষার্থীদের জন্য', eligibility: 'মাধ্যমিক স্তরের ছাত্রী, ৫০% এর উপরে', applicationUrl: '', deadline: DateTime(2026, 7, 31), amount: '৫০০ টাকা/মাস'),
    Scholarship(name: 'HSC Stipend', nameBn: 'উচ্চ মাধ্যমিক উপবৃত্তি', description: 'উচ্চ মাধ্যমিক স্তরের শিক্ষার্থীদের জন্য', eligibility: 'GPA 4.0 এর উপরে', applicationUrl: '', deadline: DateTime(2026, 8, 15), amount: '৮০০ টাকা/মাস'),
  ];

  List<String> get _types => ['সব', 'প্রাথমিক', 'মাধ্যমিক', 'কলেজ', 'মাদ্রাসা', 'কারিগরি'];

  List<EducationInstitution> get _filtered {
    return _institutions.where((i) {
      final matchType = _selectedType == 'সব' || i.typeBn == _selectedType;
      final matchSearch = _searchQuery.isEmpty || i.nameBn.contains(_searchQuery);
      return matchType && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('শিক্ষা সেবা'),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'প্রতিষ্ঠান'),
              Tab(text: 'বৃত্তি'),
              Tab(text: 'ফলাফল'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildInstitutions(),
            _buildScholarships(),
            _buildResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildInstitutions() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isDark ? [] : AppColors.softShadow,
            ),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'প্রতিষ্ঠান অনুসন্ধান...',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _types.length,
            itemBuilder: (context, index) {
              final type = _types[index];
              final isSelected = type == _selectedType;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedType = type),
                  selectedColor: AppColors.primary.withValues(alpha: 0.2),
                  checkmarkColor: AppColors.primary,
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : (isDark ? Colors.white24 : Colors.grey.shade300),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: _filtered.length,
            itemBuilder: (context, index) {
              final inst = _filtered[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isDark ? [] : AppColors.softShadow,
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9C27B0).withValues(alpha: isDark ? 0.15 : 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.school_rounded, color: Color(0xFF9C27B0)),
                    ),
                    title: Text(inst.nameBn, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    subtitle: Text('${inst.typeBn} | ${inst.mpoStatus}'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildDetail('ঠিকানা', inst.address),
                            _buildDetail('প্রধান', inst.principalName),
                            _buildDetail('EIIN', inst.eiin ?? 'N/A'),
                            _buildDetail('শিক্ষার্থী', '${inst.studentCount}'),
                            _buildDetail('শিক্ষক', '${inst.teacherCount}'),
                            _buildDetail('ফোন', inst.phone),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () => Helpers.makePhoneCall(inst.phone),
                                icon: const Icon(Icons.call_rounded),
                                label: const Text('যোগাযোগ করুন'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(color: AppColors.textSecondary))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildScholarships() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: _scholarships.length,
      itemBuilder: (context, index) {
        final s = _scholarships[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDark ? [] : AppColors.softShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: isDark ? 0.15 : 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.school_rounded, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(s.nameBn, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
                  ],
                ),
                const SizedBox(height: 12),
                Text(s.description),
                const SizedBox(height: 8),
                _buildDetail('যোগ্যতা', s.eligibility),
                _buildDetail('পরিমাণ', s.amount),
                _buildDetail('সময়সীমা', '${s.deadline.day}/${s.deadline.month}/${s.deadline.year}'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResults() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final results = [
      {'name': 'PSC ফলাফল', 'url': 'http://www.dpe.gov.bd', 'icon': Icons.grade_rounded},
      {'name': 'JSC ফলাফল', 'url': 'http://www.educationboardresults.gov.bd', 'icon': Icons.grade_rounded},
      {'name': 'SSC ফলাফল', 'url': 'http://www.educationboardresults.gov.bd', 'icon': Icons.grade_rounded},
      {'name': 'HSC ফলাফল', 'url': 'http://www.educationboardresults.gov.bd', 'icon': Icons.grade_rounded},
    ];

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            const Text('পরীক্ষার ফলাফল', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 8),
        const Text('নিচের লিংকে ক্লিক করে আপনার ফলাফল দেখুন', style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 16),
        ...results.map((r) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDark ? [] : AppColors.softShadow,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: isDark ? 0.15 : 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(r['icon'] as IconData, color: AppColors.primary),
            ),
            title: Text(r['name'] as String, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            subtitle: Text(r['url'] as String, style: const TextStyle(fontSize: 12)),
            trailing: const Icon(Icons.open_in_new_rounded, color: AppColors.primary),
            onTap: () => Helpers.openUrl(r['url'] as String),
          ),
        )),
      ],
    );
  }
}
