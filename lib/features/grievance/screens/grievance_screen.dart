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
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('অভিযোগ দাখিল করুন', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Category
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory.isEmpty ? null : _selectedCategory,
              decoration: const InputDecoration(labelText: 'অভিযোগের ধরন *', prefixIcon: Icon(Icons.category)),
              items: GrievanceCategory.categories.map((c) => DropdownMenuItem(value: c.nameBn, child: Text(c.nameBn))).toList(),
              onChanged: (v) => setState(() => _selectedCategory = v ?? ''),
              validator: (v) => v == null || v.isEmpty ? 'অভিযোগের ধরন নির্বাচন করুন' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'আপনার নাম *', prefixIcon: Icon(Icons.person)),
              validator: (v) => v == null || v.isEmpty ? 'নাম লিখুন' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'মোবাইল নম্বর *', prefixIcon: Icon(Icons.phone)),
              keyboardType: TextInputType.phone,
              validator: (v) => v == null || v.isEmpty ? 'মোবাইল নম্বর লিখুন' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'ইমেইল (ঐচ্ছিক)', prefixIcon: Icon(Icons.email)),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'বিষয় *', prefixIcon: Icon(Icons.subject)),
              validator: (v) => v == null || v.isEmpty ? 'বিষয় লিখুন' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'বিস্তারিত বর্ণনা *', alignLabelWithHint: true),
              maxLines: 5,
              validator: (v) => v == null || v.isEmpty ? 'বর্ণনা লিখুন' : null,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ফাইল আপলোড ফিচার শীঘ্রই আসছে')));
              },
              icon: const Icon(Icons.attach_file),
              label: const Text('ফাইল সংযুক্ত করুন'),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _submitGrievance,
                icon: const Icon(Icons.send),
                label: const Text('অভিযোগ জমা দিন', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              ),
            ),
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
              const Icon(Icons.check_circle, color: AppColors.success, size: 60),
              const SizedBox(height: 16),
              const Text('আপনার অভিযোগ সফলভাবে জমা হয়েছে।'),
              const SizedBox(height: 8),
              Text('ট্র্যাকিং নম্বর: $trackingNumber', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              const Text('এই নম্বরটি সংরক্ষণ করুন।', style: TextStyle(color: AppColors.textSecondary)),
            ],
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('ঠিক আছে'))],
        ),
      );
    }
  }

  Widget _buildMyGrievances() {
    if (_myGrievances.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('কোনো অভিযোগ নেই', style: TextStyle(fontSize: 18)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _myGrievances.length,
      itemBuilder: (context, index) {
        final g = _myGrievances[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(g.status).withValues(alpha: 0.1),
              child: Icon(_getStatusIcon(g.status), color: _getStatusColor(g.status)),
            ),
            title: Text(g.subject, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ট্র্যাকিং: ${g.trackingNumber}'),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor(g.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(_getStatusText(g.status), style: TextStyle(color: _getStatusColor(g.status), fontSize: 12)),
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
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),
              Text(g.subject, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: _getStatusColor(g.status).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                child: Text(_getStatusText(g.status), style: TextStyle(color: _getStatusColor(g.status), fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              _buildDetailRow('ট্র্যাকিং নম্বর', g.trackingNumber),
              _buildDetailRow('ক্যাটাগরি', g.category),
              _buildDetailRow('দাখিলের তারিখ', '${g.submittedDate.day}/${g.submittedDate.month}/${g.submittedDate.year}'),
              const Divider(),
              const Text('বিবরণ:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(g.description),
              if (g.resolution != null) ...[
                const Divider(),
                const Text('সমাধান:', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.success)),
                const SizedBox(height: 4),
                Text(g.resolution!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
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

  Widget _buildTracking() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('অভিযোগ ট্র্যাক করুন', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: _trackingController,
            decoration: InputDecoration(
              labelText: 'ট্র্যাকিং নম্বর লিখুন',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: _trackGrievance,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Icon(Icons.track_changes, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('আপনার ট্র্যাকিং নম্বর দিয়ে অভিযোগের বর্তমান অবস্থা জানুন', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary)),
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('অভিযোগ পাওয়া যায়নি'), backgroundColor: Colors.red));
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
      case 'submitted': return Icons.send;
      case 'under_review': return Icons.hourglass_empty;
      case 'resolved': return Icons.check_circle;
      case 'rejected': return Icons.cancel;
      default: return Icons.help;
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
