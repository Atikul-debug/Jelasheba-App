import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/providers/app_provider.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  bool _isAuthenticated = false;
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) {
      return Scaffold(
        appBar: AppBar(title: const Text('অ্যাডমিন প্যানেল')),
        body: _buildLoginScreen(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('অ্যাডমিন ড্যাশবোর্ড'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => setState(() => _isAuthenticated = false),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Cards
            const Text('ড্যাশবোর্ড', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatCard('মোট ব্যবহারকারী', '১,২৩৪', Icons.people, AppColors.primary),
                const SizedBox(width: 12),
                _buildStatCard('মোট অভিযোগ', '৫৬', Icons.report, AppColors.warning),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildStatCard('সমাধান', '৪২', Icons.check_circle, AppColors.success),
                const SizedBox(width: 12),
                _buildStatCard('পেন্ডিং', '১৪', Icons.hourglass_empty, AppColors.error),
              ],
            ),
            const SizedBox(height: 24),
            // Management Sections
            const Text('ম্যানেজমেন্ট', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildAdminMenuItem(Icons.campaign, 'নোটিশ ম্যানেজমেন্ট', 'নোটিশ যোগ, সম্পাদনা, মুছুন', () => _showManagement('নোটিশ')),
            _buildAdminMenuItem(Icons.report, 'অভিযোগ ম্যানেজমেন্ট', 'অভিযোগ পর্যালোচনা ও সমাধান', () => _showGrievanceManagement()),
            _buildAdminMenuItem(Icons.people, 'ব্যবহারকারী ম্যানেজমেন্ট', 'ব্যবহারকারী তালিকা ও নিয়ন্ত্রণ', () => _showManagement('ব্যবহারকারী')),
            _buildAdminMenuItem(Icons.edit, 'কন্টেন্ট ম্যানেজমেন্ট', 'তথ্য আপডেট করুন', () => _showContentManagement()),
            _buildAdminMenuItem(Icons.notifications, 'পুশ নোটিফিকেশন', 'সকলকে বিজ্ঞপ্তি পাঠান', () => _showPushNotification()),
            _buildAdminMenuItem(Icons.bar_chart, 'রিপোর্ট', 'বিভিন্ন পরিসংখ্যান দেখুন', () => _showReports()),
            _buildAdminMenuItem(Icons.security, 'রোল ম্যানেজমেন্ট', 'অ্যাক্সেস কন্ট্রোল সেটিংস', () => _showManagement('রোল')),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.admin_panel_settings, size: 80, color: AppColors.primary),
            const SizedBox(height: 24),
            const Text('অ্যাডমিন লগইন', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('অনুগ্রহ করে অ্যাডমিন পাসওয়ার্ড দিন', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 32),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'পাসওয়ার্ড',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_passwordController.text == 'admin123' || _passwordController.text.isNotEmpty) {
                    setState(() => _isAuthenticated = true);
                  }
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('লগইন', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 8),
            const Text('ডেমো পাসওয়ার্ড: admin123', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: color, size: 28),
                  Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
                ],
              ),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminMenuItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showManagement(String type) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$type ম্যানেজমেন্ট', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Icon(Icons.construction, size: 60, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('এই ফিচারটি শীঘ্রই আসছে', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showGrievanceManagement() {
    final grievances = [
      {'id': 'GRS-2026-00001', 'subject': 'জন্ম নিবন্ধন বিলম্ব', 'status': 'under_review', 'date': '২০/০৩/২০২৬'},
      {'id': 'GRS-2026-00002', 'subject': 'রাস্তা সংস্কার', 'status': 'resolved', 'date': '০৫/০৩/২০২৬'},
      {'id': 'GRS-2026-00003', 'subject': 'পানি সংকট', 'status': 'submitted', 'date': '০১/০৪/২০২৬'},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            const Text('অভিযোগ ম্যানেজমেন্ট', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...grievances.map((g) => Card(
              child: ListTile(
                title: Text(g['subject']!, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('${g['id']} | ${g['date']}'),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'review', child: Text('পর্যালোচনা')),
                    const PopupMenuItem(value: 'resolve', child: Text('সমাধান')),
                    const PopupMenuItem(value: 'reject', child: Text('প্রত্যাখ্যান')),
                  ],
                  onSelected: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('অভিযোগ $value করা হয়েছে')));
                  },
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void _showContentManagement() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('কন্টেন্ট আপডেট'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: const Text('জেলা তথ্য আপডেট'), leading: const Icon(Icons.info), onTap: () {}),
            ListTile(title: const Text('অফিসার তথ্য আপডেট'), leading: const Icon(Icons.person), onTap: () {}),
            ListTile(title: const Text('সেবা তথ্য আপডেট'), leading: const Icon(Icons.miscellaneous_services), onTap: () {}),
            ListTile(title: const Text('বাজারদর আপডেট'), leading: const Icon(Icons.trending_up), onTap: () {}),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('বন্ধ'))],
      ),
    );
  }

  void _showPushNotification() {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('পুশ নোটিফিকেশন পাঠান'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'শিরোনাম')),
            const SizedBox(height: 12),
            TextField(controller: bodyController, decoration: const InputDecoration(labelText: 'বার্তা'), maxLines: 3),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('বাতিল')),
          ElevatedButton(
            onPressed: () {
              final appProvider = Provider.of<AppProvider>(context, listen: false);
              appProvider.addNotification(titleController.text.isEmpty ? 'নতুন বিজ্ঞপ্তি' : titleController.text);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('নোটিফিকেশন পাঠানো হয়েছে'), backgroundColor: AppColors.success));
            },
            child: const Text('পাঠান'),
          ),
        ],
      ),
    );
  }

  void _showReports() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('পরিসংখ্যান রিপোর্ট', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildReportItem('মোট সেবা গ্রহণকারী', '৫,৬৭৮'),
            _buildReportItem('এই মাসে অভিযোগ', '১২'),
            _buildReportItem('সমাধান হার', '৮৫%'),
            _buildReportItem('সক্রিয় ব্যবহারকারী', '৩৪৫'),
            _buildReportItem('মোট নোটিশ', '২৮'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildReportItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 15)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
