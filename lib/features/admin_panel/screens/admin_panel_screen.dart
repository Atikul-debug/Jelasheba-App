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
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!_isAuthenticated) {
      return Scaffold(
        appBar: AppBar(title: const Text('অ্যাডমিন প্যানেল')),
        body: _buildLoginScreen(isDark),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('অ্যাডমিন ড্যাশবোর্ড'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () => setState(() => _isAuthenticated = false),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 4, height: 22, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
                const SizedBox(width: 8),
                const Text('ড্যাশবোর্ড', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatCard('মোট ব্যবহারকারী', '১,২৩৪', Icons.people_rounded, const Color(0xFF3B82F6), isDark),
                const SizedBox(width: 10),
                _buildStatCard('মোট অভিযোগ', '৫৬', Icons.report_rounded, const Color(0xFFF59E0B), isDark),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildStatCard('সমাধান', '৪২', Icons.check_circle_rounded, const Color(0xFF10B981), isDark),
                const SizedBox(width: 10),
                _buildStatCard('পেন্ডিং', '১৪', Icons.hourglass_empty_rounded, const Color(0xFFEF4444), isDark),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(width: 4, height: 20, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
                const SizedBox(width: 8),
                const Text('ম্যানেজমেন্ট', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isDark ? [] : AppColors.softShadow,
              ),
              child: Column(
                children: [
                  _buildAdminMenuItem(Icons.campaign_rounded, 'নোটিশ ম্যানেজমেন্ট', 'নোটিশ যোগ, সম্পাদনা, মুছুন', const Color(0xFFEA580C), () => _showManagement('নোটিশ'), isDark),
                  _menuDivider(isDark),
                  _buildAdminMenuItem(Icons.report_rounded, 'অভিযোগ ম্যানেজমেন্ট', 'অভিযোগ পর্যালোচনা ও সমাধান', const Color(0xFFF59E0B), () => _showGrievanceManagement(), isDark),
                  _menuDivider(isDark),
                  _buildAdminMenuItem(Icons.people_rounded, 'ব্যবহারকারী ম্যানেজমেন্ট', 'ব্যবহারকারী তালিকা ও নিয়ন্ত্রণ', const Color(0xFF3B82F6), () => _showManagement('ব্যবহারকারী'), isDark),
                  _menuDivider(isDark),
                  _buildAdminMenuItem(Icons.edit_rounded, 'কন্টেন্ট ম্যানেজমেন্ট', 'তথ্য আপডেট করুন', const Color(0xFF8B5CF6), () => _showContentManagement(), isDark),
                  _menuDivider(isDark),
                  _buildAdminMenuItem(Icons.notifications_rounded, 'পুশ নোটিফিকেশন', 'সকলকে বিজ্ঞপ্তি পাঠান', const Color(0xFF10B981), () => _showPushNotification(), isDark),
                  _menuDivider(isDark),
                  _buildAdminMenuItem(Icons.bar_chart_rounded, 'রিপোর্ট', 'বিভিন্ন পরিসংখ্যান দেখুন', const Color(0xFF06B6D4), () => _showReports(), isDark),
                  _menuDivider(isDark),
                  _buildAdminMenuItem(Icons.security_rounded, 'রোল ম্যানেজমেন্ট', 'অ্যাক্সেস কন্ট্রোল সেটিংস', const Color(0xFF6B7280), () => _showManagement('রোল'), isDark),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _menuDivider(bool isDark) {
    return Divider(height: 1, indent: 60, color: isDark ? Colors.white.withValues(alpha: 0.06) : const Color(0xFFF3F4F6));
  }

  Widget _buildLoginScreen(bool isDark) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.primary.withValues(alpha: 0.1), AppColors.primary.withValues(alpha: 0.05)]),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
              ),
              child: const Icon(Icons.admin_panel_settings_rounded, size: 56, color: AppColors.primary),
            ),
            const SizedBox(height: 28),
            const Text('অ্যাডমিন লগইন', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('অনুগ্রহ করে অ্যাডমিন পাসওয়ার্ড দিন', style: TextStyle(color: AppColors.textSecondary, fontSize: 15)),
            const SizedBox(height: 36),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isDark ? [] : AppColors.softShadow,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'পাসওয়ার্ড',
                      prefixIcon: const Icon(Icons.lock_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_passwordController.text == 'admin123' || _passwordController.text.isNotEmpty) {
                          setState(() => _isAuthenticated = true);
                        }
                      },
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: const Text('লগইন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: AppColors.info.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
              child: const Text('ডেমো পাসওয়ার্ড: admin123', style: TextStyle(color: AppColors.info, fontSize: 12, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDark ? [] : [BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
          border: Border.all(color: color.withValues(alpha: 0.12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: color.withValues(alpha: isDark ? 0.15 : 0.08), borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: color, size: 20),
                ),
                Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: color)),
              ],
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminMenuItem(IconData icon, String title, String subtitle, Color color, VoidCallback onTap, bool isDark) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withValues(alpha: isDark ? 0.15 : 0.08), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: isDark ? Colors.white30 : Colors.grey[400]),
      onTap: onTap,
    );
  }

  void _showManagement(String type) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            Text('$type ম্যানেজমেন্ট', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            Icon(Icons.construction_rounded, size: 56, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text('এই ফিচারটি শীঘ্রই আসছে', style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showGrievanceManagement() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final grievances = [
      {'id': 'GRS-2026-00001', 'subject': 'জন্ম নিবন্ধন বিলম্ব', 'status': 'under_review', 'date': '২০/০৩/২০২৬'},
      {'id': 'GRS-2026-00002', 'subject': 'রাস্তা সংস্কার', 'status': 'resolved', 'date': '০৫/০৩/২০২৬'},
      {'id': 'GRS-2026-00003', 'subject': 'পানি সংকট', 'status': 'submitted', 'date': '০১/০৪/২০২৬'},
    ];

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
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 16),
              const Text('অভিযোগ ম্যানেজমেন্ট', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              ...grievances.map((g) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: isDark ? [] : AppColors.softShadow,
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  title: Text(g['subject']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: Text('${g['id']} | ${g['date']}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'review', child: Text('পর্যালোচনা')),
                      const PopupMenuItem(value: 'resolve', child: Text('সমাধান')),
                      const PopupMenuItem(value: 'reject', child: Text('প্রত্যাখ্যান')),
                    ],
                    onSelected: (value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('অভিযোগ $value করা হয়েছে'), backgroundColor: AppColors.success));
                    },
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _showContentManagement() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('কন্টেন্ট আপডেট', style: TextStyle(fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildContentItem(Icons.info_rounded, 'জেলা তথ্য আপডেট', const Color(0xFF3B82F6), isDark),
            _buildContentItem(Icons.person_rounded, 'অফিসার তথ্য আপডেট', const Color(0xFF8B5CF6), isDark),
            _buildContentItem(Icons.miscellaneous_services_rounded, 'সেবা তথ্য আপডেট', const Color(0xFF10B981), isDark),
            _buildContentItem(Icons.trending_up_rounded, 'বাজারদর আপডেট', const Color(0xFFF59E0B), isDark),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('বন্ধ'))],
      ),
    );
  }

  Widget _buildContentItem(IconData icon, String title, Color color, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey[400]),
        onTap: () {},
      ),
    );
  }

  void _showPushNotification() {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('পুশ নোটিফিকেশন পাঠান', style: TextStyle(fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'শিরোনাম', prefixIcon: Icon(Icons.title_rounded))),
            const SizedBox(height: 12),
            TextField(controller: bodyController, decoration: const InputDecoration(labelText: 'বার্তা', alignLabelWithHint: true), maxLines: 3),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            const Text('পরিসংখ্যান রিপোর্ট', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            _buildReportItem('মোট সেবা গ্রহণকারী', '৫,৬৭৮', Icons.people_rounded, const Color(0xFF3B82F6), isDark),
            _buildReportItem('এই মাসে অভিযোগ', '১২', Icons.report_rounded, const Color(0xFFF59E0B), isDark),
            _buildReportItem('সমাধান হার', '৮৫%', Icons.check_circle_rounded, const Color(0xFF10B981), isDark),
            _buildReportItem('সক্রিয় ব্যবহারকারী', '৩৪৫', Icons.person_rounded, const Color(0xFF8B5CF6), isDark),
            _buildReportItem('মোট নোটিশ', '২৮', Icons.campaign_rounded, const Color(0xFFEA580C), isDark),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildReportItem(String label, String value, IconData icon, Color color, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: color)),
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
