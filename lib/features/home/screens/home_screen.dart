import 'package:flutter/material.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? _buildHome()
          : _currentIndex == 1
              ? const EmergencyScreen()
              : _currentIndex == 2
                  ? const NoticeboardScreen()
                  : const UserPanelScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'হোম'),
          BottomNavigationBarItem(icon: Icon(Icons.emergency), label: 'জরুরি'),
          BottomNavigationBarItem(icon: Icon(Icons.campaign), label: 'নোটিশ'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'প্রোফাইল'),
        ],
      ),
    );
  }

  Widget _buildHome() {
    final appProvider = Provider.of<AppProvider>(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'জেলাশেবা',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Icon(Icons.account_balance, size: 50, color: Colors.white70),
                  const SizedBox(height: 8),
                  Text(
                    AppConstants.districtName,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'জেলা প্রশাসকের কার্যালয়',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(appProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => appProvider.toggleDarkMode(),
              color: Colors.white,
            ),
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () => _showNotifications(),
              color: Colors.white,
            ),
          ],
        ),
        // Search Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'সেবা অনুসন্ধান করুন...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).cardTheme.color,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                // Search functionality
              },
            ),
          ),
        ),
        // Quick Actions
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildQuickAction('৯৯৯', Icons.emergency, AppColors.error, () {
                  // Call 999
                }),
                const SizedBox(width: 8),
                _buildQuickAction('অভিযোগ', Icons.report, AppColors.warning, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const GrievanceScreen()));
                }),
                const SizedBox(width: 8),
                _buildQuickAction('ট্র্যাকিং', Icons.track_changes, AppColors.info, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const EServicesScreen()));
                }),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        // Service Grid
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'সকল সেবা',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildListDelegate(_buildServiceItems()),
          ),
        ),
        // DC Message
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'জেলা প্রশাসকের বার্তা',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'মোঃ আব্দুল্লাহ আল মামুন',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'প্রিয় জেলাবাসী, জেলাশেবা অ্যাপের মাধ্যমে আপনার প্রয়োজনীয় সকল সরকারি সেবা এখন আপনার হাতের মুঠোয়। আমরা আপনাদের সেবায় নিবেদিত।',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  List<Widget> _buildServiceItems() {
    final services = [
      {'title': 'জেলা তথ্য', 'icon': Icons.info_outline, 'color': AppColors.primary, 'screen': const DistrictInfoScreen()},
      {'title': 'নাগরিক সেবা', 'icon': Icons.people, 'color': AppColors.info, 'screen': const CitizenServicesScreen()},
      {'title': 'অভিযোগ', 'icon': Icons.report_problem, 'color': AppColors.warning, 'screen': const GrievanceScreen()},
      {'title': 'জরুরি সেবা', 'icon': Icons.emergency, 'color': AppColors.error, 'screen': const EmergencyScreen()},
      {'title': 'স্বাস্থ্য', 'icon': Icons.local_hospital, 'color': const Color(0xFFE91E63), 'screen': const HealthScreen()},
      {'title': 'শিক্ষা', 'icon': Icons.school, 'color': const Color(0xFF9C27B0), 'screen': const EducationScreen()},
      {'title': 'কৃষি', 'icon': Icons.agriculture, 'color': const Color(0xFF4CAF50), 'screen': const AgricultureScreen()},
      {'title': 'ভূমি সেবা', 'icon': Icons.terrain, 'color': const Color(0xFF795548), 'screen': const LandScreen()},
      {'title': 'নোটিশ বোর্ড', 'icon': Icons.campaign, 'color': const Color(0xFFFF5722), 'screen': const NoticeboardScreen()},
      {'title': 'ই-সেবা', 'icon': Icons.computer, 'color': const Color(0xFF00BCD4), 'screen': const EServicesScreen()},
      {'title': 'পর্যটন', 'icon': Icons.tour, 'color': const Color(0xFFFF9800), 'screen': const TourismScreen()},
      {'title': 'যোগাযোগ', 'icon': Icons.contacts, 'color': const Color(0xFF607D8B), 'screen': const ContactDirectoryScreen()},
      {'title': 'প্রোফাইল', 'icon': Icons.person, 'color': const Color(0xFF3F51B5), 'screen': const UserPanelScreen()},
      {'title': 'অ্যাডমিন', 'icon': Icons.admin_panel_settings, 'color': const Color(0xFF9E9E9E), 'screen': const AdminPanelScreen()},
    ];

    return services.map((service) {
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon, Color color, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  void _showNotifications() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('বিজ্ঞপ্তি', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    appProvider.clearNotifications();
                    Navigator.pop(context);
                  },
                  child: const Text('সব মুছুন'),
                ),
              ],
            ),
            const Divider(),
            if (appProvider.notifications.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: Text('কোনো বিজ্ঞপ্তি নেই')),
              )
            else
              ...appProvider.notifications.map((n) => ListTile(
                    leading: const Icon(Icons.notifications, color: AppColors.primary),
                    title: Text(n),
                  )),
          ],
        ),
      ),
    );
  }
}
