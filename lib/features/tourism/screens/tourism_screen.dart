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
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
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
    final filtered = _selectedCategory == 'সব' ? _places : _places.where((p) => p.categoryBn == _selectedCategory).toList();
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final cat = _categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(cat),
                  selected: cat == _selectedCategory,
                  onSelected: (_) => setState(() => _selectedCategory = cat),
                  selectedColor: AppColors.accent.withValues(alpha: 0.2),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final place = filtered[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      color: AppColors.accent.withValues(alpha: 0.1),
                      child: const Center(child: Icon(Icons.photo_camera, size: 50, color: AppColors.accent)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(place.nameBn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                              Row(children: [const Icon(Icons.star, color: Colors.amber, size: 18), Text(' ${place.rating}', style: const TextStyle(fontWeight: FontWeight.bold))]),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                            child: Text(place.categoryBn, style: const TextStyle(fontSize: 12, color: AppColors.accent)),
                          ),
                          const SizedBox(height: 8),
                          Text(place.description, style: const TextStyle(color: AppColors.textSecondary)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 14, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(place.address, style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          if (place.entryFee != null)
                            Row(children: [const Icon(Icons.confirmation_number, size: 14, color: AppColors.textSecondary), const SizedBox(width: 4), Text('প্রবেশ মূল্য: ${place.entryFee}', style: const TextStyle(fontSize: 12))]),
                          if (place.openingHours != null)
                            Row(children: [const Icon(Icons.access_time, size: 14, color: AppColors.textSecondary), const SizedBox(width: 4), Text('সময়: ${place.openingHours}', style: const TextStyle(fontSize: 12))]),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () => Helpers.openMap(place.latitude, place.longitude),
                              icon: const Icon(Icons.map),
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

  Widget _buildHotels() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _hotels.length,
      itemBuilder: (context, index) {
        final hotel = _hotels[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(hotel.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                    Row(children: [const Icon(Icons.star, color: Colors.amber, size: 16), Text(' ${hotel.rating}')]),
                  ],
                ),
                const SizedBox(height: 4),
                Row(children: [const Icon(Icons.location_on, size: 14, color: AppColors.textSecondary), const SizedBox(width: 4), Text(hotel.address, style: const TextStyle(fontSize: 13))]),
                const SizedBox(height: 4),
                Text('ভাড়া: ${hotel.priceRange}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(spacing: 8, children: hotel.amenities.map((a) => Chip(label: Text(a, style: const TextStyle(fontSize: 11)), padding: EdgeInsets.zero, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)).toList()),
                const SizedBox(height: 8),
                ElevatedButton.icon(onPressed: () => Helpers.makePhoneCall(hotel.phone), icon: const Icon(Icons.call), label: const Text('বুকিং করুন')),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransport() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _transports.length,
      itemBuilder: (context, index) {
        final t = _transports[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.info.withValues(alpha: 0.1),
              child: Icon(t.type == 'bus' ? Icons.directions_bus : t.type == 'train' ? Icons.train : Icons.directions_boat, color: AppColors.info),
            ),
            title: Text(t.route, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${t.typeBn} | ${t.operator}'),
                Text('সময়: ${t.schedule}', style: const TextStyle(fontSize: 12)),
                Text('ভাড়া: ${t.fare}', style: const TextStyle(fontSize: 12, color: AppColors.primary)),
              ],
            ),
            isThreeLine: true,
            trailing: IconButton(icon: const Icon(Icons.call, color: AppColors.success), onPressed: () => Helpers.makePhoneCall(t.phone)),
          ),
        );
      },
    );
  }
}
