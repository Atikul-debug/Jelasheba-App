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

    if (!appProvider.isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('লগইন / রেজিস্ট্রেশন')),
        body: _buildLoginForm(appProvider),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('আমার প্রোফাইল')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(appProvider.userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(appProvider.userPhone, style: const TextStyle(color: Colors.white70)),
                  if (appProvider.userEmail.isNotEmpty)
                    Text(appProvider.userEmail, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Menu Items
            _buildMenuItem(Icons.history, 'আবেদনের ইতিহাস', 'আপনার সকল আবেদন দেখুন', () => _showHistory()),
            _buildMenuItem(Icons.report, 'অভিযোগের ইতিহাস', 'দাখিলকৃত অভিযোগ দেখুন', () => _showHistory()),
            _buildMenuItem(Icons.bookmark, 'বুকমার্ক', 'পছন্দের সেবা দেখুন', () => _showBookmarks(appProvider)),
            _buildMenuItem(Icons.notifications, 'নোটিফিকেশন সেটিংস', 'বিজ্ঞপ্তি কাস্টমাইজ করুন', () => _showNotificationSettings()),
            const Divider(),
            _buildMenuItem(Icons.dark_mode, appProvider.isDarkMode ? 'লাইট মোড' : 'ডার্ক মোড', 'থিম পরিবর্তন করুন', () => appProvider.toggleDarkMode()),
            _buildMenuItem(Icons.language, 'ভাষা', appProvider.language == 'bn' ? 'বাংলা' : 'English', () => _showLanguageDialog(appProvider)),
            _buildMenuItem(Icons.info, 'অ্যাপ সম্পর্কে', 'সংস্করণ ১.০.০', () => _showAbout()),
            _buildMenuItem(Icons.star, 'রেটিং দিন', 'অ্যাপটি রেট করুন', () {}),
            _buildMenuItem(Icons.feedback, 'মতামত দিন', 'আপনার মতামত জানান', () => _showFeedback()),
            const Divider(),
            _buildMenuItem(Icons.logout, 'লগ আউট', 'অ্যাকাউন্ট থেকে বের হন', () => _confirmLogout(appProvider), isDestructive: true),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(AppProvider appProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, size: 60, color: AppColors.primary),
          ),
          const SizedBox(height: 24),
          const Text('জেলাশেবায় স্বাগতম', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('লগইন বা রেজিস্ট্রেশন করুন', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 32),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'আপনার নাম', prefixIcon: Icon(Icons.person)),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: 'মোবাইল নম্বর', prefixIcon: Icon(Icons.phone)),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'ইমেইল (ঐচ্ছিক)', prefixIcon: Icon(Icons.email)),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          if (_otpSent) ...[
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(labelText: 'OTP কোড', prefixIcon: Icon(Icons.lock)),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
          ],
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (!_otpSent) {
                  if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('নাম ও মোবাইল নম্বর দিন'), backgroundColor: Colors.red));
                    return;
                  }
                  setState(() => _otpSent = true);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP পাঠানো হয়েছে (ডেমো: 1234)'), backgroundColor: AppColors.success));
                } else {
                  if (_otpController.text == '1234' || _otpController.text.length == 4) {
                    appProvider.login(_nameController.text, _phoneController.text, email: _emailController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('সঠিক OTP দিন'), backgroundColor: Colors.red));
                  }
                }
              },
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              child: Text(_otpSent ? 'যাচাই করুন' : 'OTP পাঠান', style: const TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? AppColors.error : AppColors.primary),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: isDestructive ? AppColors.error : null)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showHistory() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text('কোনো ইতিহাস নেই', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('আপনার আবেদন ও অভিযোগের ইতিহাস এখানে দেখা যাবে।', textAlign: TextAlign.center),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showBookmarks(AppProvider appProvider) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (appProvider.bookmarks.isEmpty) ...[
              const Icon(Icons.bookmark_border, size: 60, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('কোনো বুকমার্ক নেই', style: TextStyle(fontSize: 18)),
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
            SwitchListTile(title: const Text('নোটিশ বিজ্ঞপ্তি'), value: true, onChanged: (_) {}),
            SwitchListTile(title: const Text('অভিযোগ আপডেট'), value: true, onChanged: (_) {}),
            SwitchListTile(title: const Text('জরুরি সতর্কতা'), value: true, onChanged: (_) {}),
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
            ListTile(
              title: const Text('বাংলা'),
              leading: Icon(Icons.radio_button_checked, color: appProvider.language == 'bn' ? AppColors.primary : Colors.grey),
              onTap: () { appProvider.setLanguage('bn'); Navigator.pop(context); },
            ),
            ListTile(
              title: const Text('English'),
              leading: Icon(Icons.radio_button_checked, color: appProvider.language == 'en' ? AppColors.primary : Colors.grey),
              onTap: () { appProvider.setLanguage('en'); Navigator.pop(context); },
            ),
          ],
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
        title: const Text('লগ আউট'),
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
