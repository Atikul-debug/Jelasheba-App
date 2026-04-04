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

  // Gradient + Icon for each place image placeholder
  static const List<List<Color>> _placeGradients = [
    [Color(0xFF1E3A5F), Color(0xFF3B82F6)],    // bridge blue
    [Color(0xFF6B21A8), Color(0xFF9333EA)],    // kuthibari purple
    [Color(0xFF065F46), Color(0xFF059669)],    // mosque green
    [Color(0xFFB45309), Color(0xFFF59E0B)],    // river sunset amber
    [Color(0xFF166534), Color(0xFF22C55E)],    // park green
    [Color(0xFF7C2D12), Color(0xFFEA580C)],    // shrine orange
    [Color(0xFF0E7490), Color(0xFF06B6D4)],    // river cyan
    [Color(0xFF1E40AF), Color(0xFF60A5FA)],    // beel blue
    [Color(0xFF15803D), Color(0xFF4ADE80)],    // village green
    [Color(0xFF78350F), Color(0xFFD97706)],    // bridge brown
    [Color(0xFF831843), Color(0xFFEC4899)],    // mazar pink
    [Color(0xFF3730A3), Color(0xFF818CF8)],    // campus indigo
    [Color(0xFF0F766E), Color(0xFF2DD4BF)],    // char teal
    [Color(0xFF1D4ED8), Color(0xFF93C5FD)],    // ghat blue
    [Color(0xFFB91C1C), Color(0xFFF87171)],    // belkuchi red
    [Color(0xFF4338CA), Color(0xFFA78BFA)],    // shahzadpur violet
  ];

  static const List<IconData> _placeIcons = [
    Icons.architecture_rounded,       // bridge
    Icons.museum_rounded,             // kuthibari
    Icons.mosque_rounded,             // mosque
    Icons.water_rounded,              // river sunset
    Icons.park_rounded,               // park
    Icons.auto_awesome_rounded,       // shrine
    Icons.sailing_rounded,            // river
    Icons.water_rounded,              // beel
    Icons.grass_rounded,              // village
    Icons.foundation_rounded,         // elliott bridge
    Icons.auto_awesome_rounded,       // mazar
    Icons.school_rounded,             // campus
    Icons.terrain_rounded,            // char
    Icons.directions_boat_rounded,    // ghat
    Icons.wb_twilight_rounded,        // belkuchi sunset
    Icons.nature_people_rounded,      // shahzadpur char
  ];

  final List<TouristPlace> _places = [
    TouristPlace(id: '1', name: 'Bangabandhu Bridge', nameBn: 'বঙ্গবন্ধু সেতু (যমুনা সেতু)', description: 'বাংলাদেশের অন্যতম বড় সেতু। যমুনা নদীর উপর তৈরি এই সেতুটি ৪.৮ কিলোমিটার দীর্ঘ। বিকেলের সময় ভিউ অসাধারণ সুন্দর।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ-টাঙ্গাইল সংযোগ', latitude: 24.3833, longitude: 89.7833, entryFee: 'বিনামূল্যে', openingHours: 'সর্বদা খোলা', rating: 4.8),
    TouristPlace(id: '2', name: 'Shahzadpur Rabindra Kuthibari', nameBn: 'শাহজাদপুর রবীন্দ্র কুঠিবাড়ী', description: 'কবি রবীন্দ্রনাথ ঠাকুর এখানে থাকতেন এবং অনেক বিখ্যাত রচনা লিখেছিলেন। ঐতিহাসিক ও সাহিত্যপ্রেমীদের জন্য অত্যন্ত গুরুত্বপূর্ণ স্থান।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1833, longitude: 89.5917, entryFee: '২০ টাকা', openingHours: 'সকাল ৯টা - বিকাল ৫টা', rating: 4.7),
    TouristPlace(id: '3', name: 'Hatikumrul Mosque', nameBn: 'হাটিকুমরুল নয়গম্বুজ মসজিদ', description: 'প্রাচীন মুঘল আমলের স্থাপত্য। অত্যন্ত সুন্দর কারুকাজ করা এই মসজিদটি স্থাপত্যশিল্পের এক অনন্য নিদর্শন।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'কামারখন্দ, সিরাজগঞ্জ', latitude: 24.3500, longitude: 89.5833, openingHours: 'সর্বদা খোলা', rating: 4.6),
    TouristPlace(id: '4', name: 'Hard Point Jamuna', nameBn: 'হার্ড পয়েন্ট যমুনা নদী', description: 'নদীর পাড়ে বসে সময় কাটানোর অসাধারণ জায়গা। সূর্যাস্ত দেখার জন্য অত্যন্ত জনপ্রিয়। বিকেলের আবহাওয়া মনোমুগ্ধকর।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ সদর, যমুনা তীর', latitude: 24.4534, longitude: 89.7003, openingHours: 'সর্বদা খোলা', rating: 4.5),
    TouristPlace(id: '5', name: 'Maulana Bhasani Park', nameBn: 'মাওলানা ভাসানী পার্ক', description: 'পরিবার নিয়ে ঘুরার জন্য চমৎকার জায়গা। শহরের ভিতরে অবস্থিত এই সুন্দর পার্কটি সিরাজগঞ্জবাসীর বিনোদনের অন্যতম কেন্দ্র।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ শহর', latitude: 24.4500, longitude: 89.7000, entryFee: '১০ টাকা', openingHours: 'সকাল ৬টা - রাত ৯টা', rating: 4.2),
    TouristPlace(id: '6', name: 'Enayetpur Darbar Sharif', nameBn: 'এনায়েতপুর দরবার শরীফ', description: 'ধর্মীয় গুরুত্বপূর্ণ স্থান। সারা দেশ থেকে লক্ষ লক্ষ মানুষ এখানে আসেন। বার্ষিক ওরস অনুষ্ঠিত হয়।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'কামারখন্দ, সিরাজগঞ্জ', latitude: 24.3500, longitude: 89.6833, openingHours: 'সর্বদা খোলা', rating: 4.8),
    TouristPlace(id: '7', name: 'Jamuna River Bank', nameBn: 'যমুনা নদী তীর এলাকা', description: 'প্রাকৃতিক সৌন্দর্যে ভরপুর যমুনা নদীর তীর। পিকনিক বা ঘুরে বেড়ানোর জন্য আদর্শ স্থান। নদীর বিস্তীর্ণ দৃশ্য মনোমুগ্ধকর।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4550, longitude: 89.7050, openingHours: 'সর্বদা খোলা', rating: 4.3),
    TouristPlace(id: '8', name: 'Kashem Beel', nameBn: 'কাসেম বিল', description: 'সিরাজগঞ্জের সবচেয়ে সুন্দর প্রাকৃতিক বিলগুলোর একটি। বর্ষাকালে পানিতে ভরে যায় — অসাধারণ দৃশ্য। পাখি দেখা ও নৌকা ভ্রমণের জন্য চমৎকার।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'তাড়াশ, সিরাজগঞ্জ', latitude: 24.3000, longitude: 89.6500, openingHours: 'সর্বদা খোলা', rating: 4.4),
    TouristPlace(id: '9', name: 'Udhuniya', nameBn: 'উধুনিয়া', description: 'গ্রামীণ পরিবেশ, সবুজ প্রকৃতি। শান্ত পরিবেশে ঘুরে বেড়ানোর জন্য অসাধারণ। ফটোগ্রাফির জন্য চমৎকার লোকেশন।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'উল্লাপাড়া, সিরাজগঞ্জ', latitude: 24.2800, longitude: 89.6200, openingHours: 'সর্বদা খোলা', rating: 4.1),
    TouristPlace(id: '10', name: 'Elliott Bridge', nameBn: 'এলিয়ট ব্রিজ', description: 'ব্রিটিশ আমলের পুরনো সেতু। ঐতিহাসিক গুরুত্ব রয়েছে। স্থাপত্যশৈলী দেখার মতো।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4520, longitude: 89.6980, openingHours: 'সর্বদা খোলা', rating: 4.0),
    TouristPlace(id: '11', name: 'Chala Shah Mazar', nameBn: 'চালা শাহ মাজার', description: 'প্রাচীন ধর্মীয় স্থান। অনেক দর্শনার্থী ও ভক্ত এখানে আসেন। শান্ত ও পবিত্র পরিবেশ।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'সিরাজগঞ্জ সদর', latitude: 24.4510, longitude: 89.7010, openingHours: 'সর্বদা খোলা', rating: 4.2),
    TouristPlace(id: '12', name: 'Sirajganj Govt College Campus', nameBn: 'সিরাজগঞ্জ সরকারি কলেজ ক্যাম্পাস', description: 'বড় সবুজ ক্যাম্পাস। বিকেলে ঘুরে বেড়ানোর জন্য চমৎকার। গাছপালায় ঘেরা শান্ত পরিবেশ।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'কলেজ রোড, সিরাজগঞ্জ', latitude: 24.4540, longitude: 89.7020, openingHours: 'সকাল ৬টা - সন্ধ্যা ৬টা', rating: 4.0),
    TouristPlace(id: '13', name: 'Jamuna Char Area', nameBn: 'যমুনা নদীর চর এলাকা', description: 'নদীর চর — অ্যাডভেঞ্চার টাইপ ভ্রমণ। পিকনিকের জন্য অত্যন্ত জনপ্রিয়। বিস্তীর্ণ বালুচরের সৌন্দর্য অতুলনীয়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ সদর, যমুনা চর', latitude: 24.4600, longitude: 89.7100, openingHours: 'সর্বদা খোলা', rating: 4.1),
    TouristPlace(id: '14', name: 'Baghbari Ghat', nameBn: 'বাঘাবাড়ী ঘাট', description: 'নদীপথের গুরুত্বপূর্ণ স্থান। সুন্দর নদীর দৃশ্য উপভোগ করা যায়। নৌকা ভ্রমণের জন্য আদর্শ।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1700, longitude: 89.6000, openingHours: 'সর্বদা খোলা', rating: 4.3),
    TouristPlace(id: '15', name: 'Belkuchi Jamuna Par', nameBn: 'বেলকুচি যমুনা পাড়', description: 'নদীর পাড়ে সময় কাটানোর জন্য চমৎকার। সূর্যাস্তের দৃশ্য অসাধারণ সুন্দর। প্রকৃতিপ্রেমীদের জন্য আদর্শ।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'বেলকুচি, সিরাজগঞ্জ', latitude: 24.3700, longitude: 89.6700, openingHours: 'সর্বদা খোলা', rating: 4.2),
    TouristPlace(id: '16', name: 'Shahzadpur Char', nameBn: 'শাহজাদপুর চর এলাকা', description: 'গ্রামীণ প্রকৃতি ও শান্ত পরিবেশ। নদীর চরের সৌন্দর্য উপভোগ করতে পারবেন। ফটোগ্রাফির জন্য অসাধারণ।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1900, longitude: 89.5950, openingHours: 'সর্বদা খোলা', rating: 4.0),
  ];

  final List<Hotel> _hotels = [
    Hotel(name: 'হোটেল সিরাজগঞ্জ গার্ডেন', address: 'স্টেশন রোড, সিরাজগঞ্জ সদর', phone: '01711-120001', priceRange: '১,২০০ - ৩,৫০০ টাকা', rating: 3.8, amenities: ['এসি', 'ওয়াইফাই', 'পার্কিং', 'রেস্টুরেন্ট']),
    Hotel(name: 'হো���েল যমুনা ভিউ', address: 'বড় বাজার, সিরাজগঞ্জ', phone: '01711-120002', priceRange: '৮০০ - ২,০০০ টাকা', rating: 3.5, amenities: ['এসি', 'ওয়াইফাই']),
    Hotel(name: 'হোটেল ���িরাপদ', address: 'বাস স্ট্যান��ড, সিরাজগঞ্জ', phone: '01711-120003', priceRange: '৪০০ - ১,০০০ টাকা', rating: 3.0, amenities: ['ফ্যান', 'পার্কিং']),
  ];

  final List<Transport> _transports = [
    Transport(type: 'bus', typeBn: 'বাস', route: 'ঢাকা - সিরাজগঞ্জ', schedule: 'প্রতি ৩০ মিনিট পর পর', fare: '৪০০ - ৬০০ টাকা', operator: 'শ্যামলী পরিবহন / হানিফ', phone: '01711-130001'),
    Transport(type: 'bus', typeBn: 'বাস', route: 'সিরাজগঞ্জ - রাজশাহী', schedule: 'সকাল ৬টা, ৯টা, দুপুর ১২টা', fare: '২৫০ - ৪০০ টাকা', operator: 'আল-হামরা পরিবহন', phone: '01711-130002'),
    Transport(type: 'bus', typeBn: 'বাস', route: 'সিরাজগঞ্জ - বগুড়া', schedule: 'প্রতি ১ ঘন্টা পর পর', fare: '১৫০ - ২৫০ টাকা', operator: 'সিরাজগঞ্জ এক্সপ্রেস', phone: '01711-130003'),
  ];

  List<String> get _categories => ['সব', 'প্রাকৃতিক', 'ঐতিহাসিক', 'ধর���মীয়'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('পর্যটন - সিরাজগঞ্জ'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.place_rounded, size: 18), text: 'দর্শনীয় স্থান'),
              Tab(icon: Icon(Icons.hotel_rounded, size: 18), text: 'হোটেল'),
              Tab(icon: Icon(Icons.directions_bus_rounded, size: 18), text: 'যাতায়াত'),
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
        // Category filter + count
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          child: Row(
            children: [
              Text('${filtered.length}টি স্থান', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
              const Spacer(),
            ],
          ),
        ),
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
              final placeIndex = _places.indexOf(place);
              return _buildPlaceCard(place, placeIndex, isDark);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceCard(TouristPlace place, int placeIndex, bool isDark) {
    final gradient = _placeGradients[placeIndex % _placeGradients.length];
    final icon = _placeIcons[placeIndex % _placeIcons.length];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: isDark ? [] : [
          BoxShadow(color: gradient[0].withValues(alpha: 0.12), blurRadius: 16, offset: const Offset(0, 6)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder with gradient + icon
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [gradient[0], gradient[1]],
              ),
            ),
            child: Stack(
              children: [
                // Decorative circles
                Positioned(top: -25, right: -25, child: Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.08)))),
                Positioned(bottom: -15, left: -15, child: Container(width: 60, height: 60, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.06)))),
                Positioned(top: 20, left: 20, child: Container(width: 30, height: 30, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.05)))),
                // Center icon
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 2),
                        ),
                        child: Icon(icon, size: 32, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                        child: Text(place.categoryBn, style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                // Rating badge
                Positioned(
                  top: 12, right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                        const SizedBox(width: 3),
                        Text('${place.rating}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                // Location pin
                Positioned(
                  bottom: 12, left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on_rounded, color: Colors.white70, size: 12),
                        const SizedBox(width: 3),
                        Text(place.address, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 10, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.nameBn, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, height: 1.2)),
                const SizedBox(height: 8),
                Text(place.description, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5)),
                const SizedBox(height: 12),
                // Info chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (place.entryFee != null)
                      _buildInfoChip(Icons.confirmation_number_rounded, place.entryFee!, const Color(0xFF10B981)),
                    if (place.openingHours != null)
                      _buildInfoChip(Icons.access_time_rounded, place.openingHours!, const Color(0xFF3B82F6)),
                    _buildInfoChip(Icons.my_location_rounded, '${place.latitude.toStringAsFixed(4)}°N, ${place.longitude.toStringAsFixed(4)}°E', const Color(0xFF8B5CF6)),
                  ],
                ),
                const SizedBox(height: 14),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => Helpers.openMap(place.latitude, place.longitude),
                        icon: const Icon(Icons.map_rounded, size: 18),
                        label: const Text('ম্যাপে দেখুন'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: gradient[0],
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : gradient[0].withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.share_rounded, color: gradient[0], size: 20),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : AppColors.error.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border_rounded, color: AppColors.error, size: 20),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.12 : 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
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
        final color = const Color(0xFF3B82F6);
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
              child: Icon(Icons.directions_bus_rounded, color: color, size: 22),
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
