import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../models/tourism_model.dart';

class TourismScreen extends StatefulWidget {
  const TourismScreen({super.key});

  @override
  State<TourismScreen> createState() => _TourismScreenState();
}

class _TourismScreenState extends State<TourismScreen> {
  String _selectedCategory = 'সব';

  final List<TouristPlace> _places = [
    TouristPlace(id: '1', name: 'Enayetpur Shrine', nameBn: 'এনায়েতপুর দরবার শরীফ', description: 'সিরাজগঞ্জের ঐতিহাসিক এনায়েতপুর দরবার শরীফ একটি বিখ্যাত ধর্মীয় স্থান। প্রতি বছর লক্ষ লক্ষ ভক্ত এখানে আসেন।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'কামারখন্দ, সিরাজগঞ্জ', latitude: 24.3500, longitude: 89.6833, openingHours: 'সর্বদা খোলা', rating: 4.8),
    TouristPlace(id: '2', name: 'Baghbari Ghat', nameBn: 'বাঘাবাড়ী ঘাট', description: 'যমুনা নদীর তীরে অবস্থিত বাঘাবাড়ী ঘাট সিরাজগঞ্জের অন্যতম দর্শনীয় স্থান। নদীর অপরূপ সৌন্দর্য উপভোগ করা যায়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1700, longitude: 89.6000, openingHours: 'সকাল ৬টা - সন্ধ্যা ৬টা', rating: 4.3),
    TouristPlace(id: '3', name: 'Harding Bridge', nameBn: 'হার্ডিঞ্জ ব্রিজ দর্শন', description: 'ঐতিহাসিক হার্ডিঞ্জ ব্রিজ বাংলাদেশের দীর্ঘতম রেলসেতুগুলির একটি। ব্রিটিশ আমলে নির্মিত এই সেতুটি ইতিহাসের সাক্ষী।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'পাকশী-সিরাজগঞ্জ সীমান্ত', latitude: 24.0700, longitude: 89.0200, entryFee: 'বিনামূল্যে', openingHours: 'সর্বদা খোলা', rating: 4.5),
    TouristPlace(id: '4', name: 'Shahzadpur Kuthibari', nameBn: 'শাহজাদপুর কুঠিবাড়ী', description: 'রবীন্দ্রনাথ ঠাকুরের স্মৃতিবিজড়িত শাহজাদপুর কুঠিবাড়ী। এখানে বসে তিনি অনেক বিখ্যাত রচনা লিখেছিলেন।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1833, longitude: 89.5917, entryFee: '২০ টাকা', openingHours: 'সকাল ৯টা - বিকাল ৫টা', rating: 4.7),
    TouristPlace(id: '5', name: 'Jamuna Eco Park', nameBn: 'যমুনা ইকো পার্ক', description: 'যমুনা নদীর চরে গড়ে ওঠা এই ইকো পার্কে বিভিন্ন প্রজাতির গাছ, পাখি ও প্রাকৃতিক সৌন্দর্য উপভোগ করা যায়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4600, longitude: 89.7100, entryFee: '১০ টাকা', openingHours: 'সকাল ৮টা - বিকাল ৫টা', rating: 4.0),
  ];

  final List<Hotel> _hotels = [
    Hotel(name: 'হোটেল সিরাজগঞ্জ গার্ডেন', address: 'স্টেশন রোড, সিরাজগঞ্জ সদর', phone: '01711-120001', priceRange: '১,২০০ - ৩,৫০০ টাকা', rating: 3.8, amenities: ['এসি', 'ওয়াইফাই', 'পার্কিং', 'রেস্টুরেন্ট']),
    Hotel(name: 'হোটেল যমুনা ভিউ', address: 'বড় বাজার, সিরাজগঞ্জ', phone: '01711-120002', priceRange: '৮০০ - ২,০০০ টাকা', rating: 3.5, amenities: ['এসি', 'ওয়াইফাই']),
    Hotel(name: 'হোটেল নিরাপদ', address: 'বাস স্ট্যান্ড, সিরাজগঞ্জ', phone: '01711-120003', priceRange: '৪০০ - ১,০০০ টাকা', rating: 3.0, amenities: ['ফ্যান', 'পার্কিং']),
  ];

  final List<Transport> _transports = [
    Transport(type: 'bus', typeBn: 'বাস', route: 'ঢাকা - সিরাজগঞ্জ', schedule: 'প্রতি ৩০ মিনিট পর পর', fare: '৪০০ - ৬০০ টাকা', operator: 'শ্যামলী পরিবহন / হানিফ', phone: '01711-130001'),
    Transport(type: 'bus', typeBn: 'বাস', route: 'সিরাজগঞ্জ - রাজশাহী', schedule: 'সকাল ৬টা, ৯টা, দুপুর ১২টা', fare: '২৫০ - ৪০০ টাকা', operator: 'আল-হামরা পরিবহন', phone: '01711-130002'),
    Transport(type: 'bus', typeBn: 'বাস', route: 'সিরাজগঞ্জ - বগুড়া', schedule: 'প্রতি ১ ঘন্টা পর পর', fare: '১৫০ - ২৫০ টাকা', operator: 'সিরাজগঞ্জ এক্সপ্রেস', phone: '01711-130003'),
  ];

  List<String> get _categories => ['সব', 'প্রাকৃতিক', 'ঐতিহাসিক', 'ধর্মীয়'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('পর্যটন'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'দর্শনীয় স্থান'),
              Tab(text: 'হোটেল'),
              Tab(text: 'যাতায়াত'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPlaces(),
            _buildHotels(),
            _buildTransport(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaces() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filtered = _selectedCategory == 'সব' ? _places : _places.where((p) => p.categoryBn == _selectedCategory).toList();
    return Column(
      children: [
        SizedBox(
          height: 52,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final isSelected = cat == _selectedCategory;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(cat, style: TextStyle(fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400)),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedCategory = cat),
                  selectedColor: AppColors.accent.withValues(alpha: 0.15),
                  checkmarkColor: AppColors.accent,
                  side: BorderSide(color: isSelected ? AppColors.accent.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.3)),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final place = filtered[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDark ? [] : AppColors.softShadow,
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.accent.withValues(alpha: 0.15), AppColors.accent.withValues(alpha: 0.05)],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(top: -15, right: -15, child: Container(width: 60, height: 60, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.accent.withValues(alpha: 0.08)))),
                          Center(child: Icon(Icons.photo_camera_rounded, size: 44, color: AppColors.accent.withValues(alpha: 0.5))),
                          Positioned(
                            top: 10, right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                                  const SizedBox(width: 2),
                                  Text('${place.rating}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(place.nameBn, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800))),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                                child: Text(place.categoryBn, style: const TextStyle(fontSize: 11, color: AppColors.accent, fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(place.description, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4)),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 16,
                            runSpacing: 6,
                            children: [
                              _buildPlaceInfo(Icons.location_on_rounded, place.address),
                              if (place.entryFee != null) _buildPlaceInfo(Icons.confirmation_number_rounded, 'প্রবেশ: ${place.entryFee}'),
                              if (place.openingHours != null) _buildPlaceInfo(Icons.access_time_rounded, place.openingHours!),
                            ],
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () => Helpers.openMap(place.latitude, place.longitude),
                              icon: const Icon(Icons.map_rounded, size: 18),
                              label: const Text('ম্যাপে দেখুন'),
                            ),
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
      ],
    );
  }

  Widget _buildPlaceInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildHotels() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      itemCount: _hotels.length,
      itemBuilder: (context, index) {
        final hotel = _hotels[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          padding: const EdgeInsets.all(16),
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
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: const Color(0xFF8B5CF6).withValues(alpha: isDark ? 0.15 : 0.08), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.hotel_rounded, color: Color(0xFF8B5CF6), size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(hotel.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: Colors.amber.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.star_rounded, color: Colors.amber, size: 14), Text(' ${hotel.rating}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))]),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(children: [const Icon(Icons.location_on_rounded, size: 14, color: AppColors.textSecondary), const SizedBox(width: 4), Text(hotel.address, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))]),
              const SizedBox(height: 4),
              Text('ভাড়া: ${hotel.priceRange}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Wrap(spacing: 6, runSpacing: 4, children: hotel.amenities.map((a) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: isDark ? AppColors.darkSurface : const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(8)),
                child: Text(a, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
              )).toList()),
              const SizedBox(height: 12),
              ElevatedButton.icon(onPressed: () => Helpers.makePhoneCall(hotel.phone), icon: const Icon(Icons.call_rounded, size: 18), label: const Text('বুকিং করুন')),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTransport() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      itemCount: _transports.length,
      itemBuilder: (context, index) {
        final t = _transports[index];
        final isTrail = t.type == 'train';
        final color = isTrail ? const Color(0xFFEF4444) : const Color(0xFF3B82F6);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: isDark ? [] : AppColors.softShadow,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withValues(alpha: isDark ? 0.15 : 0.08), borderRadius: BorderRadius.circular(12)),
              child: Icon(isTrail ? Icons.train_rounded : Icons.directions_bus_rounded, color: color, size: 22),
            ),
            title: Text(t.route, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                Text('${t.typeBn} | ${t.operator}', style: const TextStyle(fontSize: 12)),
                Text('সময়: ${t.schedule}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                Text('ভাড়া: ${t.fare}', style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
              ],
            ),
            isThreeLine: true,
            trailing: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.call_rounded, color: AppColors.success, size: 20),
            ),
            onTap: () => Helpers.makePhoneCall(t.phone),
          ),
        );
      },
    );
  }
}
