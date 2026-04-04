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
    TouristPlace(id: '1', name: 'Historical Fort', nameBn: 'ঐতিহাসিক দুর্গ', description: 'মোগল আমলে নির্মিত এই দুর্গটি জেলার অন্যতম প্রাচীন স্থাপনা। ইতিহাস ও স্থাপত্যের অনন্য নিদর্শন।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সদর উপজেলা', latitude: 23.8, longitude: 90.4, entryFee: '২০ টাকা', openingHours: 'সকাল ৯টা - বিকাল ৫টা', rating: 4.5),
    TouristPlace(id: '2', name: 'Lake Park', nameBn: 'লেক পার্ক', description: 'প্রাকৃতিক সৌন্দর্যে ভরপুর এই লেক পার্কটি পরিবার নিয়ে ঘুরে বেড়ানোর জন্য আদর্শ।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'উত্তর উপজেলা', latitude: 23.82, longitude: 90.42, entryFee: '১০ টাকা', openingHours: 'সকাল ৬টা - সন্ধ্যা ৬টা', rating: 4.2),
    TouristPlace(id: '3', name: 'Ancient Mosque', nameBn: 'প্রাচীন মসজিদ', description: 'সুলতানি আমলের এই মসজিদটি স্থাপত্য শিল্পের অনন্য নিদর্শন। প্রতিদিন শত শত দর্শনার্থী আসেন।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'দক্ষিণ উপজেলা', latitude: 23.78, longitude: 90.38, openingHours: 'সর্বদা খোলা', rating: 4.7),
    TouristPlace(id: '4', name: 'Eco Park', nameBn: 'ইকো পার্ক', description: 'জীববৈচিত্র্যে সমৃদ্ধ এই ইকো পার্কে বিভিন্ন প্রজাতির গাছ ও পাখি দেখা যায়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'পূর্ব উপজেলা', latitude: 23.81, longitude: 90.43, entryFee: '৩০ টাকা', openingHours: 'সকাল ৮টা - বিকাল ৫টা', rating: 4.0),
    TouristPlace(id: '5', name: 'Hindu Temple', nameBn: 'প্রাচীন মন্দির', description: 'শতবর্ষ প্রাচীন এই মন্দিরটি হিন্দু সম্প্রদায়ের একটি গুরুত্বপূর্ণ তীর্থস্থান।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'পশ্চিম উপজেলা', latitude: 23.79, longitude: 90.37, openingHours: 'সকাল ৬টা - সন্ধ্যা ৭টা', rating: 4.3),
  ];

  final List<Hotel> _hotels = [
    Hotel(name: 'হোটেল গ্র্যান্ড প্যালেস', address: 'স্টেশন রোড, সদর', phone: '01711-120001', priceRange: '১,৫০০ - ৫,০০০ টাকা', rating: 4.0, amenities: ['এসি', 'ওয়াইফাই', 'পার্কিং', 'রেস্টুরেন্ট']),
    Hotel(name: 'হোটেল রয়েল', address: 'কলেজ রোড, সদর', phone: '01711-120002', priceRange: '৮০০ - ২,৫০০ টাকা', rating: 3.5, amenities: ['এসি', 'ওয়াইফাই']),
    Hotel(name: 'হোটেল সিটি ইন', address: 'বাস স্ট্যান্ড, সদর', phone: '01711-120003', priceRange: '৫০০ - ১,৫০০ টাকা', rating: 3.0, amenities: ['ফ্যান', 'পার্কিং']),
  ];

  final List<Transport> _transports = [
    Transport(type: 'bus', typeBn: 'বাস', route: 'ঢাকা - জেলা সদর', schedule: 'প্রতি ৩০ মিনিট পর পর', fare: '৪০০ - ৬০০ টাকা', operator: 'গ্রীনলাইন পরিবহন', phone: '01711-130001'),
    Transport(type: 'bus', typeBn: 'বাস', route: 'জেলা সদর - চট্টগ্রাম', schedule: 'সকাল ৬টা, ৯টা, দুপুর ১২টা', fare: '৫০০ - ৮০০ টাকা', operator: 'শ্যামলী পরিবহন', phone: '01711-130002'),
    Transport(type: 'train', typeBn: 'ট্রেন', route: 'ঢাকা - জেলা সদর', schedule: 'সকাল ৭টা, বিকাল ৩টা', fare: '২০০ - ৫০০ টাকা', operator: 'বাংলাদেশ রেলওয়ে', phone: '131'),
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
