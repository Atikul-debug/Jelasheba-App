import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/grievance_model.dart';

class GrievanceScreen extends StatefulWidget {
  const GrievanceScreen({super.key});

  @override
  State<GrievanceScreen> createState() => _GrievanceScreenState();
}

class _GrievanceScreenState extends State<GrievanceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedCategory = '';
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _trackingController = TextEditingController();

  final List<Grievance> _myGrievances = [
    Grievance(
      id: '1', category: 'সেবা বিলম্ব', subject: 'জন্ম নিবন্ধন বিলম্ব',
      description: 'জন্ম নিবন্ধনের আবেদন করেছি ২ মাস হয়ে গেছে কিন্তু এখনও সনদ পাইনি।',
      applicantName: 'মোঃ আলী হোসেন', phone: '01711-111111', status: 'under_review',
      submittedDate: DateTime.now().subtract(const Duration(days: 15)),
      trackingNumber: 'GRS-2026-00001', attachments: [],
    ),
    Grievance(
      id: '2', category: 'অবকাঠামো', subject: 'রাস্তা সংস্কার',
      description: 'আমাদের এলাকার রাস্তা অনেক খারাপ অবস্থায় আছে।',
      applicantName: 'মোঃ আলী হোসেন', phone: '01711-111111', status: 'resolved',
      submittedDate: DateTime.now().subtract(const Duration(days: 30)),
      resolvedDate: DateTime.now().subtract(const Duration(days: 10)),
      trackingNumber: 'GRS-2026-00002', attachments: [], resolution: 'রাস্তা সংস্কারের কাজ শুরু হয়েছে।',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('অভিযোগ ব্যবস্থাপনা'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'নতুন অভিযোগ'),
              Tab(text: 'আমার অভিযোগ'),
              Tab(text: 'ট্র্যাকিং'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildNewGrievance(),
            _buildMyGrievances(),
            _buildTracking(),
          ],
        ),
      ),
    );
  }

  Widget _buildNewGrievance() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 4, height: 20, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
                const SizedBox(width: 8),
                const Text('অভিযোগ দাখিল করুন', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isDark ? [] : AppColors.softShadow,
              ),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _selectedCategory.isEmpty ? null : _selectedCategory,
                    decoration: const InputDecoration(labelText: 'অভিযোগের ধরন *', prefixIcon: Icon(Icons.category_rounded)),
                    items: GrievanceCategory.categories.map((c) => DropdownMenuItem(value: c.nameBn, child: Text(c.nameBn))).toList(),
                    onChanged: (v) => setState(() => _selectedCategory = v ?? ''),
                    validator: (v) => v == null || v.isEmpty ? 'অভিযোগের ধরন নির্বাচন করুন' : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'আপনার নাম *', prefixIcon: Icon(Icons.person_outline_rounded)),
                    validator: (v) => v == null || v.isEmpty ? 'নাম লিখুন' : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'মোবাইল নম্বর *', prefixIcon: Icon(Icons.phone_rounded)),
                    keyboardType: TextInputType.phone,
                    validator: (v) => v == null || v.isEmpty ? 'মোবাইল নম্বর লিখুন' : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'ইমেইল (ঐচ্ছিক)', prefixIcon: Icon(Icons.email_rounded)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(labelText: 'বিষয় *', prefixIcon: Icon(Icons.subject_rounded)),
                    validator: (v) => v == null || v.isEmpty ? 'বিষয় লিখুন' : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'বিস্তারিত বর্ণনা *', alignLabelWithHint: true),
                    maxLines: 5,
                    validator: (v) => v == null || v.isEmpty ? 'বর্ণনা লিখুন' : null,
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ফাইল আপলোড ফিচার শীঘ্রই আসছে')));
                      },
                      icon: const Icon(Icons.attach_file_rounded),
                      label: const Text('ফাইল সংযুক্ত করুন'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _submitGrievance,
                icon: const Icon(Icons.send_rounded),
                label: const Text('অভিযোগ জমা দিন', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _submitGrievance() {
    if (_formKey.currentState!.validate()) {
      final trackingNumber = 'GRS-2026-${(_myGrievances.length + 1).toString().padLeft(5, '0')}';
      setState(() {
        _myGrievances.insert(0, Grievance(
          id: '${_myGrievances.length + 1}',
          category: _selectedCategory,
          subject: _subjectController.text,
          description: _descriptionController.text,
          applicantName: _nameController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          status: 'submitted',
          submittedDate: DateTime.now(),
          trackingNumber: trackingNumber,
          attachments: [],
        ));
      });
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _subjectController.clear();
      _descriptionController.clear();
      _selectedCategory = '';
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('অভিযোগ জমা হয়েছে'),
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
              const Text('আপনার অভিযোগ সফলভাবে জমা হয়েছে।', textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'ট্র্যাকিং: $trackingNumber',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 8),
              const Text('এই নম্বরটি সংরক্ষণ করুন।', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            ],
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('ঠিক আছে'))],
        ),
      );
    }
  }

  Widget _buildMyGrievances() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (_myGrievances.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_rounded, size: 72, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text('কোনো অভিযোগ নেই', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            const Text('আপনার দাখিলকৃত অভিযোগ এখানে দেখা যাবে', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      itemCount: _myGrievances.length,
      itemBuilder: (context, index) {
        final g = _myGrievances[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDark ? [] : AppColors.softShadow,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _getStatusColor(g.status).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_getStatusIcon(g.status), color: _getStatusColor(g.status), size: 22),
            ),
            title: Text(g.subject, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('ট্র্যাকিং: ${g.trackingNumber}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: _getStatusColor(g.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _getStatusText(g.status),
                    style: TextStyle(color: _getStatusColor(g.status), fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            isThreeLine: true,
            onTap: () => _showGrievanceDetails(g),
          ),
        );
      },
    );
  }

  void _showGrievanceDetails(Grievance g) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
                const SizedBox(height: 20),
                Text(g.subject, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getStatusColor(g.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusText(g.status),
                    style: TextStyle(color: _getStatusColor(g.status), fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 20),
                _buildDetailRow('ট্র্যাকিং নম্বর', g.trackingNumber),
                _buildDetailRow('ক্যাটাগরি', g.category),
                _buildDetailRow('দাখিলের তারিখ', '${g.submittedDate.day}/${g.submittedDate.month}/${g.submittedDate.year}'),
                const Divider(height: 28),
                const Text('বিবরণ:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(height: 6),
                Text(g.description, style: const TextStyle(height: 1.5)),
                if (g.resolution != null) ...[
                  const Divider(height: 28),
                  Row(
                    children: [
                      const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 18),
                      const SizedBox(width: 6),
                      const Text('সমাধান:', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.success)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(g.resolution!, style: const TextStyle(height: 1.5)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildTracking() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Container(width: 4, height: 20, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text('অভিযোগ ট্র্যাক করুন', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isDark ? [] : AppColors.softShadow,
            ),
            padding: const EdgeInsets.all(4),
            child: TextField(
              controller: _trackingController,
              decoration: InputDecoration(
                labelText: 'ট্র্যাকিং নম্বর লিখুন',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_rounded, color: AppColors.primary),
                    onPressed: _trackGrievance,
                  ),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Icon(Icons.track_changes_rounded, size: 72, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            'আপনার ট্র্যাকিং নম্বর দিয়ে\nঅভিযোগের বর্তমান অবস্থা জানুন',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  void _trackGrievance() {
    final tracking = _trackingController.text.trim();
    if (tracking.isEmpty) return;
    final found = _myGrievances.where((g) => g.trackingNumber == tracking).toList();
    if (found.isNotEmpty) {
      _showGrievanceDetails(found.first);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('অভিযোগ পাওয়া যায়নি'), backgroundColor: AppColors.error));
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'submitted': return AppColors.info;
      case 'under_review': return AppColors.warning;
      case 'resolved': return AppColors.success;
      case 'rejected': return AppColors.error;
      default: return AppColors.textSecondary;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'submitted': return Icons.send_rounded;
      case 'under_review': return Icons.hourglass_empty_rounded;
      case 'resolved': return Icons.check_circle_rounded;
      case 'rejected': return Icons.cancel_rounded;
      default: return Icons.help_rounded;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'submitted': return 'জমা হয়েছে';
      case 'under_review': return 'পর্যালোচনাধীন';
      case 'resolved': return 'সমাধান হয়েছে';
      case 'rejected': return 'প্রত্যাখ্যাত';
      default: return 'অজানা';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    _trackingController.dispose();
    super.dispose();
  }
}
