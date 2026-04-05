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
      return Scaffold(body: _buildLoginForm(appProvider, isDark));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Premium Profile Header
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: isDark ? AppColors.darkSurface : AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.headerGradient),
                child: Stack(
                  children: [
                    Positioned(top: -30, right: -30, child: Container(width: 130, height: 130, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.04)))),
                    Positioned(bottom: 20, left: -40, child: Container(width: 90, height: 90, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.03)))),
                    SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          // Avatar
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 3),
                              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 12, offset: const Offset(0, 4))],
                            ),
                            child: CircleAvatar(
                              radius: 44,
                              backgroundColor: Colors.white.withValues(alpha: 0.15),
                              child: Text(
                                appProvider.userName.isNotEmpty ? appProvider.userName[0].toUpperCase() : 'U',
                                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Name
                          Text(appProvider.userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.3)),
                          const SizedBox(height: 6),
                          // Phone + Email
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.phone_rounded, size: 14, color: Colors.white70),
                                    const SizedBox(width: 4),
                                    Text(appProvider.userPhone, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                  ],
                                ),
                              ),
                              if (appProvider.userEmail.isNotEmpty) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.email_rounded, size: 14, color: Colors.white70),
                                      const SizedBox(width: 4),
                                      Text(appProvider.userEmail, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Member badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Colors.white.withValues(alpha: 0.2), Colors.white.withValues(alpha: 0.08)]),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.verified_rounded, size: 14, color: Colors.amber),
                                SizedBox(width: 4),
                                Text('সক্রিয় নাগরিক', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                child: IconButton(
                  icon: const Icon(Icons.edit_rounded, size: 20),
                  onPressed: () => _showEditProfile(appProvider),
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // Quick Stats
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: isDark ? [] : AppColors.softShadow,
                ),
                child: Row(
                  children: [
                    _buildStatItem('০', 'আবেদন', const Color(0xFF3B82F6), isDark),
                    _buildStatDivider(isDark),
                    _buildStatItem('০', 'অভিযোগ', const Color(0xFFF59E0B), isDark),
                    _buildStatDivider(isDark),
                    _buildStatItem('${appProvider.bookmarks.length}', 'বুকমার্ক', const Color(0xFF8B5CF6), isDark),
                    _buildStatDivider(isDark),
                    _buildStatItem('${appProvider.notifications.length}', 'বিজ্ঞপ্তি', const Color(0xFFEF4444), isDark),
                  ],
                ),
              ),
            ),
          ),

          // Menu Sections
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  // Activity Section
                  _buildSectionHeader('কার্যক্রম', Icons.history_rounded),
                  const SizedBox(height: 8),
                  _buildMenuCard(isDark, [
                    _buildMenuItem(Icons.description_rounded, 'আবেদনের ইতিহাস', 'আপনার সকল আবেদন দেখুন', () => _showHistory(), isDark, color: const Color(0xFF3B82F6)),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.report_rounded, 'অভিযোগের ইতিহাস', 'দাখিলকৃত অভিযোগ দেখুন', () => _showHistory(), isDark, color: const Color(0xFFF59E0B)),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.bookmark_rounded, 'বুকমার্ক', '${appProvider.bookmarks.length}টি সেবা সংরক্ষিত', () => _showBookmarks(appProvider), isDark, color: const Color(0xFF8B5CF6)),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.notifications_rounded, 'বিজ্ঞপ্তি', '${appProvider.notifications.length}টি বিজ্ঞপ্তি', () => _showNotificationSettings(), isDark, color: const Color(0xFFEF4444)),
                  ]),

                  const SizedBox(height: 16),
                  _buildSectionHeader('সেটিংস', Icons.settings_rounded),
                  const SizedBox(height: 8),
                  _buildMenuCard(isDark, [
                    _buildMenuItem(
                      appProvider.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      appProvider.isDarkMode ? 'লাইট মোড' : 'ডার্ক মোড',
                      'থিম পরিবর্তন করুন',
                      () => appProvider.toggleDarkMode(), isDark,
                      color: const Color(0xFF06B6D4),
                    ),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.language_rounded, 'ভাষা', appProvider.language == 'bn' ? 'বাংলা' : 'English', () => _showLanguageDialog(appProvider), isDark, color: const Color(0xFF059669)),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.lock_rounded, 'গোপনীয়তা', 'আপনার তথ্য সুরক্ষিত', () {}, isDark, color: const Color(0xFF7C3AED)),
                  ]),

                  const SizedBox(height: 16),
                  _buildSectionHeader('সাহায্য', Icons.help_rounded),
                  const SizedBox(height: 8),
                  _buildMenuCard(isDark, [
                    _buildMenuItem(Icons.info_outline_rounded, 'অ্যাপ সম্পর্কে', 'জেলাশেবা v1.0.0', () => _showAbout(), isDark, color: const Color(0xFF0891B2)),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.star_rounded, 'রেটিং দিন', 'অ্যাপটি রেট করুন', () {}, isDark, color: const Color(0xFFD97706)),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.feedback_rounded, 'মতামত দিন', 'আপনার মতামত জানান', () => _showFeedback(), isDark, color: const Color(0xFF10B981)),
                    _menuDivider(isDark),
                    _buildMenuItem(Icons.support_agent_rounded, 'সাপোর্ট', 'সমস্যায় যোগাযোগ করুন', () {}, isDark, color: const Color(0xFF6366F1)),
                  ]),

                  const SizedBox(height: 16),
                  // Logout
                  _buildMenuCard(isDark, [
                    _buildMenuItem(Icons.logout_rounded, 'লগ আউট', 'অ্যাকাউন্ট থেকে বের হন', () => _confirmLogout(appProvider), isDark, isDestructive: true),
                  ]),

                  // Footer
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Text('জেলাশেবা v1.0.0', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                        const SizedBox(height: 2),
                        Text('সিরাজগঞ্জ জেলা প্রশাসন', style: TextStyle(color: Colors.grey[400], fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Container(width: 4, height: 18, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 8),
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color, bool isDark) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: color)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildStatDivider(bool isDark) {
    return Container(width: 1, height: 30, color: isDark ? Colors.white.withValues(alpha: 0.06) : const Color(0xFFE5E7EB));
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
    return Divider(height: 1, indent: 56, color: isDark ? Colors.white.withValues(alpha: 0.06) : const Color(0xFFF3F4F6));
  }

  Widget _buildLoginForm(AppProvider appProvider, bool isDark) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: isDark ? AppColors.darkSurface : AppColors.primary,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(gradient: AppColors.headerGradient),
              child: Stack(
                children: [
                  Positioned(top: -20, right: -20, child: Container(width: 100, height: 100, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.04)))),
                  SafeArea(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 2),
                            ),
                            child: const Icon(Icons.person_add_rounded, size: 40, color: Colors.white),
                          ),
                          const SizedBox(height: 12),
                          const Text('জেলাশেবায় স্বাগতম', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                          const SizedBox(height: 4),
                          Text('লগইন বা রেজিস্ট্রেশন করুন', style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isDark ? [] : AppColors.softShadow,
              ),
              child: Column(
                children: [
                  TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'আপনার নাম *', prefixIcon: Icon(Icons.person_outline_rounded))),
                  const SizedBox(height: 14),
                  TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'মোবাইল নম্বর *', prefixIcon: Icon(Icons.phone_rounded), hintText: '01XXXXXXXXX'), keyboardType: TextInputType.phone),
                  const SizedBox(height: 14),
                  TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'ইমেইল (ঐচ্ছিক)', prefixIcon: Icon(Icons.email_rounded)), keyboardType: TextInputType.emailAddress),
                  if (_otpSent) ...[
                    const SizedBox(height: 14),
                    TextField(controller: _otpController, decoration: const InputDecoration(labelText: 'OTP কোড *', prefixIcon: Icon(Icons.lock_rounded), hintText: '৪ সংখ্যার কোড'), keyboardType: TextInputType.number, maxLength: 4),
                  ],
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
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
                      icon: Icon(_otpSent ? Icons.verified_rounded : Icons.send_rounded, size: 20),
                      label: Text(_otpSent ? 'যাচাই করুন' : 'OTP পাঠান', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    ),
                  ),
                  if (!_otpSent) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : AppColors.info.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.info.withValues(alpha: 0.15)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline_rounded, size: 16, color: AppColors.info),
                          SizedBox(width: 8),
                          Expanded(child: Text('Firebase সংযুক্ত হলে রিয়েল OTP পাবেন। ডেমোতে যেকোনো ৪ সংখ্যা দিন।', style: TextStyle(fontSize: 11, color: AppColors.textSecondary))),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle, VoidCallback onTap, bool isDark, {bool isDestructive = false, Color? color}) {
    final iconColor = isDestructive ? AppColors.error : (color ?? AppColors.primary);
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: iconColor.withValues(alpha: isDark ? 0.15 : 0.08), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: isDestructive ? AppColors.error : null)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: isDark ? Colors.white30 : Colors.grey[400]),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }

  void _showEditProfile(AppProvider appProvider) {
    final nameCtrl = TextEditingController(text: appProvider.userName);
    final emailCtrl = TextEditingController(text: appProvider.userEmail);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.edit_rounded, color: AppColors.primary, size: 22)),
                  const SizedBox(width: 12),
                  const Text('প্রোফাইল সম্পাদনা', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                ],
              ),
              const SizedBox(height: 20),
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'নাম', prefixIcon: Icon(Icons.person_rounded))),
              const SizedBox(height: 12),
              TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'ইমেইল', prefixIcon: Icon(Icons.email_rounded)), keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 12),
              TextField(enabled: false, decoration: InputDecoration(labelText: 'মোবাইল', prefixIcon: const Icon(Icons.phone_rounded), hintText: appProvider.userPhone)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    appProvider.login(nameCtrl.text, appProvider.userPhone, email: emailCtrl.text);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('প্রোফাইল আপডেট হয়েছে'), backgroundColor: AppColors.success));
                  },
                  icon: const Icon(Icons.save_rounded, size: 20),
                  label: const Text('সংরক্ষণ করুন', style: TextStyle(fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _showHistory() {
    showModalBottomSheet(
      context: context, backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.06), shape: BoxShape.circle), child: Icon(Icons.history_rounded, size: 48, color: Colors.grey[300])),
          const SizedBox(height: 16),
          const Text('কোনো ইতিহাস নেই', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          const Text('Firebase সংযুক্ত হলে আপনার আবেদন ও অভিযোগের ইতিহাস এখানে দেখা যাবে।', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }

  void _showBookmarks(AppProvider appProvider) {
    showModalBottomSheet(
      context: context, backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 20),
          if (appProvider.bookmarks.isEmpty) ...[
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.06), shape: BoxShape.circle), child: Icon(Icons.bookmark_border_rounded, size: 48, color: Colors.grey[300])),
            const SizedBox(height: 16),
            const Text('কোনো বুকমার্ক নেই', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ] else
            ...appProvider.bookmarks.map((b) => ListTile(title: Text(b))),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  void _showNotificationSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('নোটিফিকেশন সেটিংস', style: TextStyle(fontWeight: FontWeight.w700)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          SwitchListTile(title: const Text('নোটিশ বিজ্ঞপ্তি'), value: true, onChanged: (_) {}, activeTrackColor: AppColors.primary.withValues(alpha: 0.5), thumbColor: WidgetStatePropertyAll(AppColors.primary)),
          SwitchListTile(title: const Text('অভিযোগ আপডেট'), value: true, onChanged: (_) {}, activeTrackColor: AppColors.primary.withValues(alpha: 0.5), thumbColor: WidgetStatePropertyAll(AppColors.primary)),
          SwitchListTile(title: const Text('জরুরি সতর্কতা'), value: true, onChanged: (_) {}, activeTrackColor: AppColors.primary.withValues(alpha: 0.5), thumbColor: WidgetStatePropertyAll(AppColors.primary)),
        ]),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('বন্ধ'))],
      ),
    );
  }

  void _showLanguageDialog(AppProvider appProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ভাষা নির্বাচন', style: TextStyle(fontWeight: FontWeight.w700)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          _buildLanguageOption('বাংলা', 'bn', appProvider),
          const SizedBox(height: 8),
          _buildLanguageOption('English', 'en', appProvider),
        ]),
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
            border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.withValues(alpha: 0.3), width: isSelected ? 2 : 1),
          ),
          child: Row(children: [
            Icon(isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded, color: isSelected ? AppColors.primary : Colors.grey),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400, fontSize: 15)),
          ]),
        ),
      ),
    );
  }

  void _showAbout() {
    showAboutDialog(context: context, applicationName: 'জেলাশেবা', applicationVersion: '1.0.0', applicationLegalese: '© ২০২৬ সিরাজগঞ্জ জেলা প্রশাসন', children: [const Text('\nসিরাজগঞ্জ জেলার সকল সরকারি সেবা এক জায়গায়।\n\nFirebase সংযুক্ত হলে রিয়েল-টাইম ডেটা সিঙ্ক হবে।')]);
  }

  void _showFeedback() {
    final feedbackController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('মতামত দিন', style: TextStyle(fontWeight: FontWeight.w700)),
        content: TextField(controller: feedbackController, maxLines: 4, decoration: const InputDecoration(hintText: 'আপনার মতামত লিখুন...', border: OutlineInputBorder())),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('বাতিল')),
          ElevatedButton(
            onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('মতামত পাঠানো হয়েছে। ধন্যবাদ!'), backgroundColor: AppColors.success)); },
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
        title: Row(children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.logout_rounded, color: AppColors.error, size: 20)),
          const SizedBox(width: 12),
          const Text('লগ আউট'),
        ]),
        content: const Text('আপনি কি লগ আউট করতে চান?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('না')),
          ElevatedButton(onPressed: () { appProvider.logout(); Navigator.pop(context); }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.error), child: const Text('হ্যাঁ, লগ আউট')),
        ],
      ),
    );
  }

  @override
  void dispose() { _nameController.dispose(); _phoneController.dispose(); _emailController.dispose(); _otpController.dispose(); super.dispose(); }
}
