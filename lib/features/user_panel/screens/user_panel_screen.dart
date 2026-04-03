import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/providers/app_provider.dart';

class UserPanelScreen extends StatefulWidget {
  const UserPanelScreen({super.key});

  @override
  State<UserPanelScreen> createState() => _UserPanelScreenState();
}

class _UserPanelScreenState extends State<UserPanelScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!appProvider.isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('লগইন / রেজিস্ট্রেশন')),
        body: _buildLoginForm(appProvider, isDark),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('আমার প্রোফাইল')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
              decoration: BoxDecoration(
                gradient: AppColors.headerGradient,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.white.withValues(alpha: 0.15),
                      child: const Icon(Icons.person_rounded, size: 48, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    appProvider.userName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.3),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(appProvider.userPhone, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  ),
                  if (appProvider.userEmail.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(appProvider.userEmail, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Menu Items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildMenuCard(isDark, [
                    _buildMenuItem(Icons.history_rounded, 'আবেদনের ইতিহাস', 'আপনার সকল আবেদন দেখুন', () => _showHistory(), isDark),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.report_rounded, 'অভিযোগের ইতিহাস', 'দাখিলকৃত অভিযোগ দেখুন', () => _showHistory(), isDark),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.bookmark_rounded, 'বুকমার্ক', 'পছন্দের সেবা দেখুন', () => _showBookmarks(appProvider), isDark),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.notifications_rounded, 'নোটিফিকেশন সেটিংস', 'বিজ্ঞপ্তি কাস্টমাইজ করুন', () => _showNotificationSettings(), isDark),
                  ]),
                  const SizedBox(height: 12),
                  _buildMenuCard(isDark, [
                    _buildMenuItem(
                      appProvider.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      appProvider.isDarkMode ? 'লাইট মোড' : 'ডার্ক মোড',
                      'থিম পরিবর্তন করুন',
                      () => appProvider.toggleDarkMode(),
                      isDark,
                    ),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.language_rounded, 'ভাষা', appProvider.language == 'bn' ? 'বাংলা' : 'English', () => _showLanguageDialog(appProvider), isDark),
                  ]),
                  const SizedBox(height: 12),
                  _buildMenuCard(isDark, [
                    _buildMenuItem(Icons.info_outline_rounded, 'অ্যাপ সম্পর্কে', 'সংস্করণ ১.০.০', () => _showAbout(), isDark),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.star_rounded, 'রেটিং দিন', 'অ্যাপটি রেট করুন', () {}, isDark),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.feedback_rounded, 'মতামত দিন', 'আপনার মতামত জানান', () => _showFeedback(), isDark),
                  ]),
                  const SizedBox(height: 12),
                  _buildMenuCard(isDark, [
                    _buildMenuItem(Icons.logout_rounded, 'লগ আউট', 'অ্যাকাউন্ট থেকে বের হন', () => _confirmLogout(appProvider), isDark, isDestructive: true),
                  ]),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(bool isDark, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark ? [] : AppColors.softShadow,
      ),
      child: Column(children: children),
    );
  }

  Widget _menuDivider(bool isDark) {
    return Divider(
      height: 1,
      indent: 56,
      color: isDark ? Colors.white.withValues(alpha: 0.06) : const Color(0xFFF3F4F6),
    );
  }

  Widget _buildLoginForm(AppProvider appProvider, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.1),
                  AppColors.primary.withValues(alpha: 0.05),
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
            ),
            child: const Icon(Icons.person_rounded, size: 56, color: AppColors.primary),
          ),
          const SizedBox(height: 28),
          const Text('জেলাশেবায় স্বাগতম', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: 0.3)),
          const SizedBox(height: 8),
          const Text('লগইন বা রেজিস্ট্রেশন করুন', style: TextStyle(color: AppColors.textSecondary, fontSize: 15)),
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
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'আপনার নাম', prefixIcon: Icon(Icons.person_outline_rounded)),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'মোবাইল নম্বর', prefixIcon: Icon(Icons.phone_rounded)),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'ইমেইল (ঐচ্ছিক)', prefixIcon: Icon(Icons.email_rounded)),
                  keyboardType: TextInputType.emailAddress,
                ),
                if (_otpSent) ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: _otpController,
                    decoration: const InputDecoration(labelText: 'OTP কোড', prefixIcon: Icon(Icons.lock_rounded)),
                    keyboardType: TextInputType.number,
                  ),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_otpSent) {
                        if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('নাম ও মোবাইল নম্বর দিন'), backgroundColor: AppColors.error));
                          return;
                        }
                        setState(() => _otpSent = true);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP পাঠানো হয়েছে (ডেমো: 1234)'), backgroundColor: AppColors.success));
                      } else {
                        if (_otpController.text == '1234' || _otpController.text.length == 4) {
                          appProvider.login(_nameController.text, _phoneController.text, email: _emailController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('সঠিক OTP দিন'), backgroundColor: AppColors.error));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: Text(_otpSent ? 'যাচাই করুন' : 'OTP পাঠান', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle, VoidCallback onTap, bool isDark, {bool isDestructive = false}) {
    final color = isDestructive ? AppColors.error : AppColors.primary;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: isDark ? 0.15 : 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: isDestructive ? AppColors.error : null),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: isDark ? Colors.white30 : Colors.grey[400]),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }

  void _showHistory() {
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
            const SizedBox(height: 24),
            Icon(Icons.history_rounded, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text('কোনো ইতিহাস নেই', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('আপনার আবেদন ও অভিযোগের ইতিহাস এখানে দেখা যাবে।', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showBookmarks(AppProvider appProvider) {
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
            if (appProvider.bookmarks.isEmpty) ...[
              Icon(Icons.bookmark_border_rounded, size: 64, color: Colors.grey[300]),
              const SizedBox(height: 16),
              const Text('কোনো বুকমার্ক নেই', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ] else
              ...appProvider.bookmarks.map((b) => ListTile(title: Text(b))),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showNotificationSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('নোটিফিকেশন সেটিংস'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(title: const Text('নোটিশ বিজ্ঞপ্তি'), value: true, onChanged: (_) {}, activeTrackColor: AppColors.primary.withValues(alpha: 0.5), thumbColor: WidgetStatePropertyAll(AppColors.primary)),
            SwitchListTile(title: const Text('অভিযোগ আপডেট'), value: true, onChanged: (_) {}, activeTrackColor: AppColors.primary.withValues(alpha: 0.5), thumbColor: WidgetStatePropertyAll(AppColors.primary)),
            SwitchListTile(title: const Text('জরুরি সতর্কতা'), value: true, onChanged: (_) {}, activeTrackColor: AppColors.primary.withValues(alpha: 0.5), thumbColor: WidgetStatePropertyAll(AppColors.primary)),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('বন্ধ'))],
      ),
    );
  }

  void _showLanguageDialog(AppProvider appProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ভাষা নির্বাচন'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('বাংলা', 'bn', appProvider),
            const SizedBox(height: 8),
            _buildLanguageOption('English', 'en', appProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String label, String code, AppProvider appProvider) {
    final isSelected = appProvider.language == code;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () { appProvider.setLanguage(code); Navigator.pop(context); },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withValues(alpha: 0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.withValues(alpha: 0.3),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                color: isSelected ? AppColors.primary : Colors.grey,
              ),
              const SizedBox(width: 12),
              Text(label, style: TextStyle(fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }

  void _showAbout() {
    showAboutDialog(
      context: context,
      applicationName: 'জেলাশেবা',
      applicationVersion: '1.0.0',
      applicationLegalese: '© ২০২৬ জেলা প্রশাসন',
      children: [const Text('\nজেলার সকল সরকারি সেবা এক জায়গায়।')],
    );
  }

  void _showFeedback() {
    final feedbackController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('মতামত দিন'),
        content: TextField(
          controller: feedbackController,
          maxLines: 4,
          decoration: const InputDecoration(hintText: 'আপনার মতামত লিখুন...', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('বাতিল')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('মতামত পাঠানো হয়েছে। ধন্যবাদ!'), backgroundColor: AppColors.success));
            },
            child: const Text('পাঠান'),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(AppProvider appProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.logout_rounded, color: AppColors.error, size: 20),
            ),
            const SizedBox(width: 12),
            const Text('লগ আউট'),
          ],
        ),
        content: const Text('আপনি কি লগ আউট করতে চান?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('না')),
          ElevatedButton(
            onPressed: () { appProvider.logout(); Navigator.pop(context); },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('হ্যাঁ, লগ আউট'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}
