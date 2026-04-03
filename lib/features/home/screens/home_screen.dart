import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/providers/app_provider.dart';
import '../../district_info/screens/district_info_screen.dart';
import '../../citizen_services/screens/citizen_services_screen.dart';
import '../../grievance/screens/grievance_screen.dart';
import '../../emergency/screens/emergency_screen.dart';
import '../../health/screens/health_screen.dart';
import '../../education/screens/education_screen.dart';
import '../../agriculture/screens/agriculture_screen.dart';
import '../../land/screens/land_screen.dart';
import '../../notice_board/screens/notice_board_screen.dart';
import '../../e_services/screens/e_services_screen.dart';
import '../../tourism/screens/tourism_screen.dart';
import '../../contact_directory/screens/contact_directory_screen.dart';
import '../../user_panel/screens/user_panel_screen.dart';
import '../../admin_panel/screens/admin_panel_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late final AnimationController _fabAnimController;

  @override
  void initState() {
    super.initState();
    _fabAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _fabAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _currentIndex == 0
          ? SystemUiOverlayStyle.light
          : (Theme.of(context).brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark),
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _getScreen(_currentIndex),
        ),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return _buildHome();
      case 1:
        return const EmergencyScreen();
      case 2:
        return const NoticeboardScreen();
      case 3:
        return const UserPanelScreen();
      default:
        return _buildHome();
    }
  }

  Widget _buildBottomNav() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_rounded, Icons.home_outlined, 'হোম'),
              _buildNavItem(1, Icons.emergency_rounded, Icons.emergency_outlined, 'জরুরি'),
              _buildNavItem(2, Icons.campaign_rounded, Icons.campaign_outlined, 'নোটিশ'),
              _buildNavItem(3, Icons.person_rounded, Icons.person_outline_rounded, 'প্রোফাইল'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final isSelected = _currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20 : 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.primaryLight.withValues(alpha: 0.15) : AppColors.primary.withValues(alpha: 0.1))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              color: isSelected
                  ? (isDark ? AppColors.primaryLight : AppColors.primary)
                  : AppColors.textSecondary,
              size: isSelected ? 26 : 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: isSelected ? 11 : 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? (isDark ? AppColors.primaryLight : AppColors.primary)
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHome() {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Modern Gradient Header
        SliverAppBar(
          expandedHeight: 220,
          floating: false,
          pinned: true,
          stretch: true,
          backgroundColor: isDark ? AppColors.darkSurface : AppColors.primary,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.account_balance_rounded, size: 18, color: Colors.white),
                ),
                const SizedBox(width: 8),
                const Text(
                  'জেলাশেবা',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            background: Container(
              decoration: const BoxDecoration(gradient: AppColors.headerGradient),
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    top: -30,
                    right: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: -40,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.04),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.03),
                      ),
                    ),
                  ),
                  // Content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 2),
                          ),
                          child: const Icon(Icons.account_balance_rounded, size: 40, color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          AppConstants.districtName,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'জেলা প্রশাসকের কার্যালয়',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
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
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(appProvider.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded, size: 22),
                onPressed: () => appProvider.toggleDarkMode(),
                color: Colors.white,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, size: 22),
                    onPressed: () => _showNotifications(),
                    color: Colors.white,
                  ),
                  if (appProvider.notifications.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),

        // Search Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isDark ? [] : AppColors.softShadow,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'সেবা অনুসন্ধান করুন...',
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.tune_rounded, color: AppColors.primary, size: 20),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: isDark ? AppColors.darkCard : Colors.white,
                ),
                onChanged: (value) {},
              ),
            ),
          ),
        ),

        // Quick Actions
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildQuickAction('৯৯৯ কল', Icons.emergency_rounded, AppColors.error, () {}),
                const SizedBox(width: 10),
                _buildQuickAction('অভিযোগ', Icons.report_rounded, AppColors.warning, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const GrievanceScreen()));
                }),
                const SizedBox(width: 10),
                _buildQuickAction('ট্র্যাকিং', Icons.track_changes_rounded, AppColors.info, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const EServicesScreen()));
                }),
              ],
            ),
          ),
        ),

        // Section Title
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: Row(
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
                const Text(
                  'সকল সেবা',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 0.3),
                ),
              ],
            ),
          ),
        ),

        // Service Grid
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.85,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildListDelegate(_buildServiceItems()),
          ),
        ),

        // DC Message Card
        SliverToBoxAdapter(
          child: _buildDCMessage(isDark),
        ),

        // App Info Footer
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : const Color(0xFFF0F9FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.05) : AppColors.info.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.info_outline_rounded, color: AppColors.info, size: 22),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('জেলাশেবা v1.0.0', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        SizedBox(height: 2),
                        Text(
                          'জেলার সকল সরকারি সেবা এক অ্যাপে',
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 8)),
      ],
    );
  }

  List<Widget> _buildServiceItems() {
    final services = [
      {'title': 'জেলা তথ্য', 'icon': Icons.info_outline_rounded, 'color': AppColors.primary, 'screen': const DistrictInfoScreen()},
      {'title': 'নাগরিক সেবা', 'icon': Icons.people_rounded, 'color': AppColors.info, 'screen': const CitizenServicesScreen()},
      {'title': 'অভিযোগ', 'icon': Icons.report_problem_rounded, 'color': AppColors.warning, 'screen': const GrievanceScreen()},
      {'title': 'জরুরি সেবা', 'icon': Icons.emergency_rounded, 'color': AppColors.error, 'screen': const EmergencyScreen()},
      {'title': 'স্বাস্থ্য', 'icon': Icons.local_hospital_rounded, 'color': const Color(0xFFE91E63), 'screen': const HealthScreen()},
      {'title': 'শিক্ষা', 'icon': Icons.school_rounded, 'color': const Color(0xFF7C3AED), 'screen': const EducationScreen()},
      {'title': 'কৃষি', 'icon': Icons.agriculture_rounded, 'color': const Color(0xFF059669), 'screen': const AgricultureScreen()},
      {'title': 'ভূমি সেবা', 'icon': Icons.terrain_rounded, 'color': const Color(0xFF92400E), 'screen': const LandScreen()},
      {'title': 'নোটিশ বোর্ড', 'icon': Icons.campaign_rounded, 'color': const Color(0xFFEA580C), 'screen': const NoticeboardScreen()},
      {'title': 'ই-সেবা', 'icon': Icons.computer_rounded, 'color': const Color(0xFF0891B2), 'screen': const EServicesScreen()},
      {'title': 'পর্যটন', 'icon': Icons.tour_rounded, 'color': const Color(0xFFD97706), 'screen': const TourismScreen()},
      {'title': 'যোগাযোগ', 'icon': Icons.contacts_rounded, 'color': const Color(0xFF475569), 'screen': const ContactDirectoryScreen()},
      {'title': 'প্রোফাইল', 'icon': Icons.person_rounded, 'color': const Color(0xFF4F46E5), 'screen': const UserPanelScreen()},
      {'title': 'অ্যাডমিন', 'icon': Icons.admin_panel_settings_rounded, 'color': const Color(0xFF6B7280), 'screen': const AdminPanelScreen()},
    ];

    return services.asMap().entries.map((entry) {
      final service = entry.value;
      return _buildServiceCard(
        service['title'] as String,
        service['icon'] as IconData,
        service['color'] as Color,
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => service['screen'] as Widget),
        ),
      );
    }).toList();
  }

  Widget _buildServiceCard(String title, IconData icon, Color color, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDark ? [] : [
              BoxShadow(
                color: color.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: isDark ? Colors.white.withValues(alpha: 0.05) : color.withValues(alpha: 0.12),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withValues(alpha: 0.12),
                      color.withValues(alpha: 0.06),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon, Color color, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withValues(alpha: isDark ? 0.2 : 0.1),
                  color.withValues(alpha: isDark ? 0.1 : 0.04),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDCMessage(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative elements
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: -10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 2),
                      ),
                      child: const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white24,
                        child: Icon(Icons.person_rounded, color: Colors.white, size: 28),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'জেলা প্রশাসকের বার্তা',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'মোঃ আব্দুল্লাহ আল মামুন',
                              style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.format_quote_rounded, color: Colors.white70, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'প্রিয় জেলাবাসী, জেলাশেবা অ্যাপের মাধ্যমে আপনার প্রয়োজনীয় সকল সরকারি সেবা এখন আপনার হাতের মুঠোয়। আমরা আপনাদের সেবায় নিবেদিত।',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.6,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showNotifications() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('বিজ্ঞপ্তি', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  if (appProvider.notifications.isNotEmpty)
                    TextButton.icon(
                      onPressed: () {
                        appProvider.clearNotifications();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.clear_all_rounded, size: 18),
                      label: const Text('সব মুছুন'),
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            if (appProvider.notifications.isEmpty)
              Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    Icon(Icons.notifications_off_rounded, size: 64, color: Colors.grey[300]),
                    const SizedBox(height: 12),
                    const Text(
                      'কোনো বিজ্ঞপ্তি নেই',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              )
            else
              ...appProvider.notifications.map((n) => ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.notifications_rounded, color: AppColors.primary, size: 20),
                    ),
                    title: Text(n),
                  )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
