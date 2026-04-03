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
      case 'store': return Icons.store;
      case 'home': return Icons.home;
      case 'water': return Icons.water_drop;
      case 'bolt': return Icons.bolt;
      case 'info': return Icons.info;
      case 'description': return Icons.description;
      case 'child_care': return Icons.child_care;
      case 'terrain': return Icons.terrain;
      default: return Icons.public;
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
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
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
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Payment Services
        const Text('অনলাইন পেমেন্ট সেবা', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ..._services.where((s) => s.isOnlinePayment).map((service) => _buildServiceCard(service)),
        const SizedBox(height: 16),
        const Text('আবেদন সেবা', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ..._services.where((s) => !s.isOnlinePayment).map((service) => _buildServiceCard(service)),
      ],
    );
  }

  Widget _buildServiceCard(EService service) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.info.withValues(alpha: 0.1),
          child: Icon(_getIcon(service.icon), color: AppColors.info),
        ),
        title: Text(service.nameBn, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(service.description, style: const TextStyle(fontSize: 12)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (service.isOnlinePayment)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: const Text('পেমেন্ট', style: TextStyle(fontSize: 10, color: AppColors.success)),
              ),
            const Icon(Icons.open_in_new, size: 18),
          ],
        ),
        onTap: service.url.isNotEmpty ? () => Helpers.openUrl(service.url) : null,
      ),
    );
  }

  Widget _buildTracking() {
    final demoSteps = [
      TrackingStep(title: 'Application Submitted', titleBn: 'আবেদন জমা হয়েছে', status: 'completed', date: DateTime.now().subtract(const Duration(days: 10))),
      TrackingStep(title: 'Document Verification', titleBn: 'কাগজপত্র যাচাই', status: 'completed', date: DateTime.now().subtract(const Duration(days: 7))),
      TrackingStep(title: 'Under Processing', titleBn: 'প্রক্রিয়াধীন', status: 'current', date: DateTime.now().subtract(const Duration(days: 3))),
      TrackingStep(title: 'Approval', titleBn: 'অনুমোদন', status: 'pending'),
      TrackingStep(title: 'Certificate Ready', titleBn: 'সনদ প্রস্তুত', status: 'pending'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('সেবা ট্র্যাক করুন', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: _trackingController,
            decoration: InputDecoration(
              labelText: 'ট্র্যাকিং নম্বর লিখুন',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () {
                if (_trackingController.text.isNotEmpty) {
                  setState(() {});
                }
              }),
            ),
          ),
          const SizedBox(height: 24),
          // Demo tracking timeline
          const Text('ডেমো ট্র্যাকিং:', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          ...demoSteps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isLast = index == demoSteps.length - 1;
            return _buildTimelineStep(step, isLast);
          }),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(TrackingStep step, bool isLast) {
    Color dotColor;
    IconData dotIcon;
    switch (step.status) {
      case 'completed':
        dotColor = AppColors.success;
        dotIcon = Icons.check_circle;
        break;
      case 'current':
        dotColor = AppColors.warning;
        dotIcon = Icons.hourglass_empty;
        break;
      default:
        dotColor = Colors.grey;
        dotIcon = Icons.circle_outlined;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(dotIcon, color: dotColor, size: 24),
            if (!isLast)
              Container(width: 2, height: 40, color: dotColor.withValues(alpha: 0.3)),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step.titleBn, style: TextStyle(fontWeight: FontWeight.bold, color: step.status == 'pending' ? Colors.grey : AppColors.textPrimary)),
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
