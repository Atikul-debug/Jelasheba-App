import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/providers/app_provider.dart';
import '../../../core/utils/helpers.dart';
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
  final PageController _bannerController = PageController();
  int _currentBanner = 0;
  String _searchQuery = '';
  final FocusNode _searchFocus = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _banners = [
    {'title': 'জেলাশেবায় স্বাগতম', 'subtitle': 'সকল সরকারি সেবা এখন আপনার হাতের মুঠোয়', 'icon': Icons.account_balance_rounded, 'gradient': const [Color(0xFF006A4E), Color(0xFF00897B)]},
    {'title': 'জরুরি প্রয়োজনে ৯৯৯', 'subtitle': 'পুলিশ, ফায়ার সার্ভিস ও অ্যাম্বুলেন্স একটি নম্বরে', 'icon': Icons.emergency_rounded, 'gradient': const [Color(0xFFDC2626), Color(0xFFEF4444)]},
    {'title': 'অভিযোগ জানান অনলাইনে', 'subtitle': 'জেলা প্রশাসকের কাছে সরাসরি অভিযোগ দাখিল করুন', 'icon': Icons.report_rounded, 'gradient': const [Color(0xFF7C3AED), Color(0xFF8B5CF6)]},
  ];

  @override
  void initState() {
    super.initState();
    _startBannerAutoScroll();
  }

  void _startBannerAutoScroll() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _bannerController.hasClients) {
        final next = (_currentBanner + 1) % _banners.length;
        _bannerController.animateToPage(next, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        _startBannerAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'সুপ্রভাত';
    if (hour < 17) return 'শুভ অপরাহ্ন';
    if (hour < 20) return 'শুভ সন্ধ্যা';
    return 'শুভ রাত্রি';
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
      case 0: return _buildHome();
      case 1: return const EmergencyScreen();
      case 2: return const NoticeboardScreen();
      case 3: return const UserPanelScreen();
      default: return _buildHome();
    }
  }

  Widget _buildBottomNav() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 24, offset: const Offset(0, -2)),
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
    final activeColor = isDark ? AppColors.primaryLight : AppColors.primary;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 18 : 14, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected ? LinearGradient(colors: [activeColor.withValues(alpha: 0.15), activeColor.withValues(alpha: 0.06)]) : null,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.15 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(isSelected ? activeIcon : inactiveIcon, color: isSelected ? activeColor : AppColors.textSecondary, size: 24),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(fontSize: isSelected ? 11 : 10, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, color: isSelected ? activeColor : AppColors.textSecondary),
              child: Text(label),
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
        // Premium Header
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.primary,
            ),
            child: SafeArea(
              bottom: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 8, 16, 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDark
                        ? [AppColors.darkSurface, AppColors.darkBackground]
                        : [const Color(0xFF006A4E), const Color(0xFF00795C)],
                  ),
                ),
                child: Column(
                  children: [
                    // Top row - actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // App name
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.grid_view_rounded, size: 18, color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('জেলাশেবা', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                                Text('সিরাজগঞ্জ', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 11, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        ),
                        // Actions
                        Row(
                          children: [
                            _buildAppBarAction(
                              icon: appProvider.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                              onTap: () => appProvider.toggleDarkMode(),
                            ),
                            const SizedBox(width: 6),
                            _buildAppBarAction(
                              icon: Icons.notifications_outlined,
                              onTap: () => _showNotifications(),
                              showBadge: appProvider.notifications.isNotEmpty,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Greeting card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                      ),
                      child: Row(
                        children: [
                          // Avatar
                          Container(
                            width: 50, height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.white.withValues(alpha: 0.2), Colors.white.withValues(alpha: 0.08)],
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: appProvider.isLoggedIn
                                  ? Text(appProvider.userName.isNotEmpty ? appProvider.userName[0].toUpperCase() : 'U', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800))
                                  : const Icon(Icons.person_rounded, color: Colors.white, size: 26),
                            ),
                          ),
                          const SizedBox(width: 14),
                          // Text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_getGreeting(), style: TextStyle(color: Colors.white.withValues(alpha: 0.65), fontSize: 12)),
                                const SizedBox(height: 3),
                                Text(
                                  appProvider.isLoggedIn ? appProvider.userName : 'সিরাজগঞ্জবাসী',
                                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          // Arrow
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.white60),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Sticky Search Bar - stays pinned on scroll, below status bar
        SliverPersistentHeader(
          pinned: true,
          delegate: _SearchBarDelegate(
            isDark: isDark,
            searchQuery: _searchQuery,
            searchController: _searchController,
            searchFocus: _searchFocus,
            statusBarHeight: MediaQuery.of(context).padding.top,
            onChanged: (value) => setState(() => _searchQuery = value),
            onClear: () { _searchController.clear(); setState(() => _searchQuery = ''); _searchFocus.unfocus(); },
          ),
        ),

        // Quick Actions - 4 icons row (hidden during search)
        if (_searchQuery.isEmpty)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))],
              ),
              child: Row(
                children: [
                  _buildQuickIcon(Icons.emergency_rounded, '৯৯৯', const Color(0xFFEF4444), () => Helpers.makePhoneCall('999')),
                  _buildQuickIcon(Icons.local_hospital_rounded, 'চিকিৎসা', const Color(0xFFE91E63), () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HealthScreen()))),
                  _buildQuickIcon(Icons.report_rounded, 'অভিযোগ', const Color(0xFFF59E0B), () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GrievanceScreen()))),
                  _buildQuickIcon(Icons.track_changes_rounded, 'ট্র্যাকিং', const Color(0xFF3B82F6), () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EServicesScreen()))),
                ],
              ),
            ),
          ),
        ),

        // Banner Slider (hidden during search)
        if (_searchQuery.isEmpty)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 6, 0, 4),
            child: Column(
              children: [
                SizedBox(
                  height: 145,
                  child: PageView.builder(
                    controller: _bannerController,
                    onPageChanged: (i) => setState(() => _currentBanner = i),
                    itemCount: _banners.length,
                    itemBuilder: (context, index) {
                      final banner = _banners[index];
                      final colors = banner['gradient'] as List<Color>;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [BoxShadow(color: colors[0].withValues(alpha: 0.25), blurRadius: 16, offset: const Offset(0, 6))],
                        ),
                        child: Stack(
                          children: [
                            // Background icon
                            Positioned(right: -10, bottom: -10, child: Icon(banner['icon'] as IconData, size: 110, color: Colors.white.withValues(alpha: 0.06))),
                            Positioned(top: -20, left: -20, child: Container(width: 70, height: 70, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.05)))),
                            // Content
                            Padding(
                              padding: const EdgeInsets.all(22),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
                                          child: Text('${index + 1}/${_banners.length}', style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 10, fontWeight: FontWeight.w600)),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(banner['title'] as String, style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800, height: 1.2)),
                                        const SizedBox(height: 6),
                                        Text(banner['subtitle'] as String, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12, height: 1.4), maxLines: 2, overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.12), shape: BoxShape.circle),
                                    child: Icon(banner['icon'] as IconData, size: 28, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                // Dot indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_banners.length, (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _currentBanner == i ? 22 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: _currentBanner == i ? AppColors.primary : (isDark ? Colors.white24 : Colors.grey[300]),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ),

        // Section Title - Services (search aware)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4, height: 22,
                      decoration: BoxDecoration(gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.primary, Color(0xFF26A69A)]), borderRadius: BorderRadius.circular(2)),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _searchQuery.isEmpty ? 'সকল সেবা' : '"$_searchQuery" এর ফলাফল',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.3),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: isDark ? 0.15 : 0.06),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('${_getFilteredServices().length} টি', style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),

        // Search results as list OR grid
        if (_searchQuery.isNotEmpty && _getFilteredServiceData().isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.06), shape: BoxShape.circle),
                    child: Icon(Icons.search_off_rounded, size: 48, color: Colors.grey[300]),
                  ),
                  const SizedBox(height: 16),
                  Text('"$_searchQuery" পাওয়া যায়নি', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  const Text('অন্য কিছু অনুসন্ধান করুন', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                ],
              ),
            ),
          )
        else if (_searchQuery.isNotEmpty)
          // Search results as LIST (better for search)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final services = _getFilteredServiceData();
                if (index >= services.length) return null;
                final service = services[index];
                final color = service['color'] as Color;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: isDark ? [] : AppColors.softShadow,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [color.withValues(alpha: 0.14), color.withValues(alpha: 0.05)]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(service['icon'] as IconData, color: color, size: 24),
                    ),
                    title: Text(service['title'] as String, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    subtitle: Text(
                      (_searchKeywords[service['title']] ?? []).take(4).join(', '),
                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.arrow_forward_rounded, color: color, size: 18),
                    ),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => service['screen'] as Widget)),
                  ),
                );
              },
              childCount: _getFilteredServiceData().length,
            ),
          )
        else
          // Normal grid view
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.78,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              delegate: SliverChildListDelegate(_buildServiceItems()),
            ),
          ),

        // DC Message + Emergency (hidden during search)
        if (_searchQuery.isEmpty)
        SliverToBoxAdapter(child: _buildDCMessage(isDark)),

        if (_searchQuery.isEmpty)
        // Emergency Helpline Strip
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFDC2626), Color(0xFFEF4444)]),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: AppColors.error.withValues(alpha: 0.25), blurRadius: 12, offset: const Offset(0, 4))],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.phone_in_talk_rounded, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('জরুরি হেল্পলাইন', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                        Text('যেকোনো জরুরি প্রয়োজনে কল করুন', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12)),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Helpers.makePhoneCall('999'),
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text('৯৯৯', style: TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.w900, fontSize: 18)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // App Footer
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : const Color(0xFFF0F9FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.05) : AppColors.info.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [AppColors.info.withValues(alpha: 0.15), AppColors.info.withValues(alpha: 0.05)]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.verified_rounded, color: AppColors.info, size: 22),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('জেলাশেবা v1.0.0', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        SizedBox(height: 2),
                        Text('গণপ্রজাতন্ত্রী বাংলাদেশ সরকার', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  Icon(Icons.shield_rounded, color: AppColors.success.withValues(alpha: 0.5), size: 28),
                ],
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 8)),
      ],
    );
  }


  Widget _buildAppBarAction({required IconData icon, required VoidCallback onTap, bool showBadge = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Stack(
        children: [
          IconButton(icon: Icon(icon, size: 21), onPressed: onTap, color: Colors.white),
          if (showBadge)
            Positioned(
              right: 9, top: 9,
              child: Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5))),
            ),
        ],
      ),
    );
  }


  // Search keywords mapping for each service
  static const Map<String, List<String>> _searchKeywords = {
    'জেলা তথ্য': ['জেলা', 'তথ্য', 'উপজেলা', 'ইউনিয়ন', 'ডিসি', 'district'],
    'নাগরিক সেবা': ['নাগরিক', 'সেবা', 'জন্ম', 'নিবন্ধন', 'পাসপোর্ট', 'NID', 'সনদ', 'লাইসেন্স', 'citizen'],
    'অভিযোগ': ['অভিযোগ', 'গ্রিভেন্স', 'complaint', 'সমস্যা', 'রিপোর্ট'],
    'জরুরি সেবা': ['জরুরি', '৯৯৯', '999', 'পুলিশ', 'থানা', 'ফায়ার', 'emergency'],
    'চিকিৎসা': ['চিকিৎসা', 'স্বাস্থ্য', 'হাসপাতাল', 'ডাক্তার', 'ফার্মেসি', 'অ্যাম্বুলেন্স', 'রক্ত', 'health', 'hospital', 'doctor'],
    'শিক্ষা': ['শিক্ষা', 'স্কুল', 'কলেজ', 'মাদ্রাসা', 'বৃত্তি', 'ফলাফল', 'education', 'school'],
    'কৃষি': ['কৃষি', 'ফসল', 'ধান', 'সার', 'বাজারদর', 'agriculture', 'crop', 'fertilizer'],
    'ভূমি সেবা': ['ভূমি', 'জমি', 'খতিয়ান', 'নামজারি', 'land', 'কর'],
    'নোটিশ': ['নোটিশ', 'বিজ্ঞপ্তি', 'notice', 'টেন্ডার', 'নিয়োগ'],
    'ই-সেবা': ['ই-সেবা', 'অনলাইন', 'ডিজিটাল', 'বিল', 'ট্র্যাকিং', 'e-service'],
    'পর্যটন': ['পর্যটন', 'ভ্রমণ', 'হোটেল', 'দর্শনীয়', 'tourism', 'travel'],
    'যোগাযোগ': ['যোগাযোগ', 'ফোন', 'নম্বর', 'অফিস', 'contact', 'phone'],
    'প্রোফাইল': ['প্রোফাইল', 'অ্যাকাউন্ট', 'লগইন', 'profile', 'login'],
    'অ্যাডমিন': ['অ্যাডমিন', 'admin', 'ড্যাশবোর্ড', 'ম্যানেজমেন্ট'],
  };

  List<Map<String, dynamic>> _getFilteredServiceData() {
    final allServices = _getAllServices();
    if (_searchQuery.isEmpty) return allServices;

    final query = _searchQuery.toLowerCase();
    return allServices.where((service) {
      final title = (service['title'] as String).toLowerCase();
      final keywords = _searchKeywords[service['title']] ?? [];
      return title.contains(query) || keywords.any((k) => k.toLowerCase().contains(query));
    }).toList();
  }

  List<Widget> _getFilteredServices() {
    final filtered = _getFilteredServiceData();
    return filtered.map((service) {
      return _buildServiceCard(
        service['title'] as String,
        service['icon'] as IconData,
        service['color'] as Color,
        () => Navigator.push(context, MaterialPageRoute(builder: (_) => service['screen'] as Widget)),
      );
    }).toList();
  }

  List<Map<String, dynamic>> _getAllServices() {
    return [
      {'title': 'জেলা তথ্য', 'icon': Icons.info_outline_rounded, 'color': AppColors.primary, 'screen': const DistrictInfoScreen()},
      {'title': 'নাগরিক সেবা', 'icon': Icons.people_rounded, 'color': AppColors.info, 'screen': const CitizenServicesScreen()},
      {'title': 'অভিযোগ', 'icon': Icons.report_problem_rounded, 'color': const Color(0xFFF59E0B), 'screen': const GrievanceScreen()},
      {'title': 'জরুরি সেবা', 'icon': Icons.emergency_rounded, 'color': AppColors.error, 'screen': const EmergencyScreen()},
      {'title': 'চিকিৎসা', 'icon': Icons.local_hospital_rounded, 'color': const Color(0xFFE91E63), 'screen': const HealthScreen()},
      {'title': 'শিক্ষা', 'icon': Icons.school_rounded, 'color': const Color(0xFF7C3AED), 'screen': const EducationScreen()},
      {'title': 'কৃষি', 'icon': Icons.agriculture_rounded, 'color': const Color(0xFF059669), 'screen': const AgricultureScreen()},
      {'title': 'ভূমি সেবা', 'icon': Icons.terrain_rounded, 'color': const Color(0xFF92400E), 'screen': const LandScreen()},
      {'title': 'নোটিশ', 'icon': Icons.campaign_rounded, 'color': const Color(0xFFEA580C), 'screen': const NoticeboardScreen()},
      {'title': 'ই-সেবা', 'icon': Icons.computer_rounded, 'color': const Color(0xFF0891B2), 'screen': const EServicesScreen()},
      {'title': 'পর্যটন', 'icon': Icons.tour_rounded, 'color': const Color(0xFFD97706), 'screen': const TourismScreen()},
      {'title': 'যোগাযোগ', 'icon': Icons.contacts_rounded, 'color': const Color(0xFF475569), 'screen': const ContactDirectoryScreen()},
      {'title': 'প্রোফাইল', 'icon': Icons.person_rounded, 'color': const Color(0xFF4F46E5), 'screen': const UserPanelScreen()},
      {'title': 'অ্যাডমিন', 'icon': Icons.admin_panel_settings_rounded, 'color': const Color(0xFF6B7280), 'screen': const AdminPanelScreen()},
    ];
  }

  List<Widget> _buildServiceItems() {
    final services = [
      {'title': 'জেলা তথ্য', 'icon': Icons.info_outline_rounded, 'color': AppColors.primary, 'screen': const DistrictInfoScreen()},
      {'title': 'নাগরিক সেবা', 'icon': Icons.people_rounded, 'color': AppColors.info, 'screen': const CitizenServicesScreen()},
      {'title': 'অভিযোগ', 'icon': Icons.report_problem_rounded, 'color': const Color(0xFFF59E0B), 'screen': const GrievanceScreen()},
      {'title': 'জরুরি সেবা', 'icon': Icons.emergency_rounded, 'color': AppColors.error, 'screen': const EmergencyScreen()},
      {'title': 'চিকিৎসা', 'icon': Icons.local_hospital_rounded, 'color': const Color(0xFFE91E63), 'screen': const HealthScreen()},
      {'title': 'শিক্ষা', 'icon': Icons.school_rounded, 'color': const Color(0xFF7C3AED), 'screen': const EducationScreen()},
      {'title': 'কৃষি', 'icon': Icons.agriculture_rounded, 'color': const Color(0xFF059669), 'screen': const AgricultureScreen()},
      {'title': 'ভূমি সেবা', 'icon': Icons.terrain_rounded, 'color': const Color(0xFF92400E), 'screen': const LandScreen()},
      {'title': 'নোটিশ', 'icon': Icons.campaign_rounded, 'color': const Color(0xFFEA580C), 'screen': const NoticeboardScreen()},
      {'title': 'ই-সেবা', 'icon': Icons.computer_rounded, 'color': const Color(0xFF0891B2), 'screen': const EServicesScreen()},
      {'title': 'পর্যটন', 'icon': Icons.tour_rounded, 'color': const Color(0xFFD97706), 'screen': const TourismScreen()},
      {'title': 'যোগাযোগ', 'icon': Icons.contacts_rounded, 'color': const Color(0xFF475569), 'screen': const ContactDirectoryScreen()},
      {'title': 'প্রোফাইল', 'icon': Icons.person_rounded, 'color': const Color(0xFF4F46E5), 'screen': const UserPanelScreen()},
      {'title': 'অ্যাডমিন', 'icon': Icons.admin_panel_settings_rounded, 'color': const Color(0xFF6B7280), 'screen': const AdminPanelScreen()},
    ];

    // Add empty placeholders if count not multiple of 4
    final remainder = services.length % 4;
    final paddedCount = remainder == 0 ? 0 : 4 - remainder;

    final items = services.map((service) {
      return _buildServiceCard(
        service['title'] as String,
        service['icon'] as IconData,
        service['color'] as Color,
        () => Navigator.push(context, MaterialPageRoute(builder: (_) => service['screen'] as Widget)),
      );
    }).toList();

    for (var i = 0; i < paddedCount; i++) {
      items.add(const SizedBox());
    }

    return items;
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
            boxShadow: isDark ? [] : [BoxShadow(color: color.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 3))],
            border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.04) : color.withValues(alpha: 0.08)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                    colors: [color.withValues(alpha: 0.14), color.withValues(alpha: 0.05)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isDark ? Colors.white : AppColors.textPrimary, height: 1.2),
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

  Widget _buildQuickIcon(IconData icon, String label, Color color, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: isDark ? 0.15 : 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isDark ? Colors.white : AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }

  Widget _buildDCMessage(bool isDark) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.25), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Stack(
        children: [
          Positioned(top: -25, right: -25, child: Container(width: 90, height: 90, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.05)))),
          Positioned(bottom: -15, left: -15, child: Container(width: 60, height: 60, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.04)))),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withValues(alpha: 0.35), width: 2)),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        child: const Icon(Icons.person_rounded, color: Colors.white, size: 24),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('জেলা প্রশাসকের বার্তা', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                          const SizedBox(height: 3),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
                            child: const Text('মোঃ আব্দুল্লাহ আল মামুন', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.format_quote_rounded, color: Colors.white60, size: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.07), borderRadius: BorderRadius.circular(14)),
                  child: const Text(
                    'প্রিয় জেলাবাসী, জেলাশেবা অ্যাপের মাধ্যমে আপনার প্রয়োজনীয় সকল সরকারি সেবা এখন আপনার হাতের মুঠোয়। আমরা আপনাদের সেবায় নিবেদিত।',
                    style: TextStyle(color: Colors.white, fontSize: 13, height: 1.6),
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
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.notifications_rounded, color: AppColors.primary, size: 20),
                      ),
                      const SizedBox(width: 10),
                      const Text('বিজ্ঞপ্তি', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  if (appProvider.notifications.isNotEmpty)
                    TextButton.icon(
                      onPressed: () { appProvider.clearNotifications(); Navigator.pop(context); },
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
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.06), shape: BoxShape.circle),
                      child: Icon(Icons.notifications_off_rounded, size: 48, color: Colors.grey[300]),
                    ),
                    const SizedBox(height: 16),
                    const Text('কোনো বিজ্ঞপ্তি নেই', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    const Text('নতুন বিজ্ঞপ্তি পেলে এখানে দেখা যাবে', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  ],
                ),
              )
            else
              ...appProvider.notifications.map((n) => ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.notifications_active_rounded, color: AppColors.primary, size: 20),
                ),
                title: Text(n, style: const TextStyle(fontSize: 14)),
              )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// Sticky search bar delegate
class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final bool isDark;
  final String searchQuery;
  final TextEditingController searchController;
  final FocusNode searchFocus;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  _SearchBarDelegate({
    required this.isDark,
    required this.searchQuery,
    required this.searchController,
    required this.searchFocus,
    required this.onChanged,
    required this.onClear,
    required this.statusBarHeight,
  });

  final double statusBarHeight;

  @override
  double get maxExtent => 68 + statusBarHeight;

  @override
  double get minExtent => 68 + statusBarHeight;

  @override
  bool shouldRebuild(covariant _SearchBarDelegate oldDelegate) =>
      oldDelegate.searchQuery != searchQuery || oldDelegate.isDark != isDark;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      color: isDark ? AppColors.darkBackground : AppColors.background,
      padding: EdgeInsets.fromLTRB(16, statusBarHeight + 8, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (shrinkOffset > 0)
              BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4)),
            BoxShadow(color: AppColors.primary.withValues(alpha: isDark ? 0.08 : 0.06), blurRadius: 16, offset: const Offset(0, 4)),
          ],
          border: Border.all(
            color: searchQuery.isNotEmpty
                ? AppColors.primary.withValues(alpha: 0.3)
                : (isDark ? Colors.white.withValues(alpha: 0.06) : Colors.grey.withValues(alpha: 0.1)),
            width: searchQuery.isNotEmpty ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Search icon
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: searchQuery.isNotEmpty ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.search_rounded,
                  color: searchQuery.isNotEmpty ? AppColors.primary : (isDark ? Colors.white30 : Colors.grey[400]),
                  size: 20,
                ),
              ),
            ),
            // Text field
            Expanded(
              child: TextField(
                controller: searchController,
                focusNode: searchFocus,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'হাসপাতাল, ডাক্তার, কৃষি, ভূমি...',
                  hintStyle: TextStyle(color: isDark ? Colors.white24 : Colors.grey[400], fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                ),
                onChanged: onChanged,
              ),
            ),
            // Clear or mic
            if (searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: onClear,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.close_rounded, color: AppColors.error, size: 16),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: isDark ? 0.12 : 0.06),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.mic_rounded, color: AppColors.primary, size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
