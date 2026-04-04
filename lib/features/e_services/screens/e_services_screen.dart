import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../models/e_service_model.dart';

class EServicesScreen extends StatefulWidget {
  const EServicesScreen({super.key});

  @override
  State<EServicesScreen> createState() => _EServicesScreenState();
}

class _EServicesScreenState extends State<EServicesScreen> {
  final _trackingController = TextEditingController();

  final List<EService> _services = [
    EService(id: '1', name: 'Trade License', nameBn: 'ট্রেড লাইসেন্স', description: 'অনলাইনে ট্রেড লাইসেন্সের জন্য আবেদন করুন', url: 'https://etrade.gov.bd', icon: 'store', category: 'লাইসেন্স', isOnlinePayment: true),
    EService(id: '2', name: 'Holding Tax', nameBn: 'হোল্ডিং ট্যাক্স', description: 'হোল্ডিং ট্যাক্স অনলাইনে পরিশোধ করুন', url: 'https://tax.gov.bd', icon: 'home', category: 'কর', isOnlinePayment: true),
    EService(id: '3', name: 'Water Bill', nameBn: 'পানির বিল', description: 'WASA পানির বিল পরিশোধ', url: 'https://wasa.gov.bd', icon: 'water', category: 'বিল', isOnlinePayment: true),
    EService(id: '4', name: 'Electric Bill', nameBn: 'বিদ্যুৎ বিল', description: 'বিদ্যুৎ বিল অনলাইনে পরিশোধ', url: 'https://pdb.gov.bd', icon: 'bolt', category: 'বিল', isOnlinePayment: true),
    EService(id: '5', name: 'RTI Application', nameBn: 'তথ্য অধিকার আবেদন', description: 'তথ্য অধিকার আইনে আবেদন করুন', url: 'https://rti.gov.bd', icon: 'info', category: 'আবেদন', isOnlinePayment: false),
    EService(id: '6', name: 'Online Petition', nameBn: 'অনলাইন পিটিশন', description: 'জেলা প্রশাসকের কাছে অনলাইন পিটিশন দাখিল', url: '', icon: 'description', category: 'আবেদন', isOnlinePayment: false),
    EService(id: '7', name: 'Birth Certificate', nameBn: 'জন্ম নিবন্ধন', description: 'অনলাইনে জন্ম নিবন্ধনের আবেদন', url: 'https://bdris.gov.bd', icon: 'child_care', category: 'নিবন্ধন', isOnlinePayment: true),
    EService(id: '8', name: 'Land Tax', nameBn: 'ভূমি উন্নয়ন কর', description: 'ভূমি উন্নয়ন কর অনলাইনে পরিশোধ', url: 'https://ldtax.gov.bd', icon: 'terrain', category: 'কর', isOnlinePayment: true),
  ];

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'store': return Icons.store_rounded;
      case 'home': return Icons.home_rounded;
      case 'water': return Icons.water_drop_rounded;
      case 'bolt': return Icons.bolt_rounded;
      case 'info': return Icons.info_rounded;
      case 'description': return Icons.description_rounded;
      case 'child_care': return Icons.child_care_rounded;
      case 'terrain': return Icons.terrain_rounded;
      default: return Icons.public_rounded;
    }
  }

  Color _getServiceColor(String icon) {
    switch (icon) {
      case 'store': return const Color(0xFF8B5CF6);
      case 'home': return const Color(0xFFEF4444);
      case 'water': return const Color(0xFF06B6D4);
      case 'bolt': return const Color(0xFFF59E0B);
      case 'info': return const Color(0xFF3B82F6);
      case 'description': return const Color(0xFF6B7280);
      case 'child_care': return const Color(0xFF10B981);
      case 'terrain': return const Color(0xFF92400E);
      default: return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ই-সেবা'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'সেবা তালিকা'),
              Tab(text: 'ট্র্যাকিং'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildServiceList(),
            _buildTracking(),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceList() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      children: [
        Row(
          children: [
            Container(width: 4, height: 20, decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 8),
            const Text('অনলাইন পেমেন্ট সেবা', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 12),
        ..._services.where((s) => s.isOnlinePayment).map((s) => _buildServiceCard(s, isDark)),
        const SizedBox(height: 20),
        Row(
          children: [
            Container(width: 4, height: 20, decoration: BoxDecoration(color: AppColors.info, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 8),
            const Text('আবেদন সেবা', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 12),
        ..._services.where((s) => !s.isOnlinePayment).map((s) => _buildServiceCard(s, isDark)),
      ],
    );
  }

  Widget _buildServiceCard(EService service, bool isDark) {
    final color = _getServiceColor(service.icon);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: isDark ? [] : AppColors.softShadow,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: isDark ? 0.15 : 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(_getIcon(service.icon), color: color, size: 22),
        ),
        title: Text(service.nameBn, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
        subtitle: Text(service.description, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (service.isOnlinePayment)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: const Text('পেমেন্ট', style: TextStyle(fontSize: 10, color: AppColors.success, fontWeight: FontWeight.w600)),
              ),
            Icon(Icons.open_in_new_rounded, size: 16, color: Colors.grey[400]),
          ],
        ),
        onTap: service.url.isNotEmpty ? () => Helpers.openUrl(service.url) : null,
      ),
    );
  }

  Widget _buildTracking() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final demoSteps = [
      TrackingStep(title: 'Application Submitted', titleBn: 'আবেদন জমা হয়েছে', status: 'completed', date: DateTime.now().subtract(const Duration(days: 10))),
      TrackingStep(title: 'Document Verification', titleBn: 'কাগজপত্র যাচাই', status: 'completed', date: DateTime.now().subtract(const Duration(days: 7))),
      TrackingStep(title: 'Under Processing', titleBn: 'প্রক্রিয়াধীন', status: 'current', date: DateTime.now().subtract(const Duration(days: 3))),
      TrackingStep(title: 'Approval', titleBn: 'অনুমোদন', status: 'pending'),
      TrackingStep(title: 'Certificate Ready', titleBn: 'সনদ প্রস্তুত', status: 'pending'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 4, height: 20, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text('সেবা ট্র্যাক করুন', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 16),
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
                  decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_rounded, color: AppColors.primary),
                    onPressed: () { if (_trackingController.text.isNotEmpty) setState(() {}); },
                  ),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isDark ? [] : AppColors.softShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppColors.info.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.timeline_rounded, color: AppColors.info, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text('ডেমো ট্র্যাকিং', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  ],
                ),
                const SizedBox(height: 20),
                ...demoSteps.asMap().entries.map((entry) {
                  final index = entry.key;
                  final step = entry.value;
                  final isLast = index == demoSteps.length - 1;
                  return _buildTimelineStep(step, isLast, isDark);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(TrackingStep step, bool isLast, bool isDark) {
    Color dotColor;
    IconData dotIcon;
    switch (step.status) {
      case 'completed':
        dotColor = AppColors.success;
        dotIcon = Icons.check_circle_rounded;
        break;
      case 'current':
        dotColor = AppColors.warning;
        dotIcon = Icons.hourglass_empty_rounded;
        break;
      default:
        dotColor = Colors.grey[400]!;
        dotIcon = Icons.circle_outlined;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotColor.withValues(alpha: 0.1),
              ),
              child: Icon(dotIcon, color: dotColor, size: 22),
            ),
            if (!isLast)
              Container(width: 2, height: 36, color: dotColor.withValues(alpha: 0.2)),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.titleBn,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: step.status == 'pending' ? Colors.grey : (isDark ? Colors.white : AppColors.textPrimary),
                  ),
                ),
                if (step.date != null)
                  Text('${step.date!.day}/${step.date!.month}/${step.date!.year}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _trackingController.dispose();
    super.dispose();
  }
}
