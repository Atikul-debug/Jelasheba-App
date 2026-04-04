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

  // Cycling gradients & icons for image placeholders
  static const List<List<Color>> _placeGradients = [
    [Color(0xFF6B21A8), Color(0xFF9333EA)],  // purple
    [Color(0xFF1E3A5F), Color(0xFF3B82F6)],  // blue
    [Color(0xFF166534), Color(0xFF22C55E)],  // green
    [Color(0xFFB45309), Color(0xFFF59E0B)],  // amber
    [Color(0xFF065F46), Color(0xFF059669)],  // teal
    [Color(0xFF7C2D12), Color(0xFFEA580C)],  // orange
    [Color(0xFF0E7490), Color(0xFF06B6D4)],  // cyan
    [Color(0xFF831843), Color(0xFFEC4899)],  // pink
    [Color(0xFF78350F), Color(0xFFD97706)],  // brown
    [Color(0xFF3730A3), Color(0xFF818CF8)],  // indigo
    [Color(0xFF1E40AF), Color(0xFF60A5FA)],  // light blue
    [Color(0xFF15803D), Color(0xFF4ADE80)],  // light green
    [Color(0xFF0F766E), Color(0xFF2DD4BF)],  // turquoise
    [Color(0xFFB91C1C), Color(0xFFF87171)],  // red
    [Color(0xFF4338CA), Color(0xFFA78BFA)],  // violet
    [Color(0xFF92400E), Color(0xFFFBBF24)],  // gold
    [Color(0xFF1D4ED8), Color(0xFF93C5FD)],  // sky
  ];

  static const List<IconData> _placeIcons = [
    Icons.museum_rounded,
    Icons.architecture_rounded,
    Icons.park_rounded,
    Icons.water_rounded,
    Icons.temple_hindu_rounded,
    Icons.home_rounded,
    Icons.water_rounded,
    Icons.water_rounded,
    Icons.factory_rounded,
    Icons.house_rounded,
    Icons.foundation_rounded,
    Icons.villa_rounded,
    Icons.security_rounded,
    Icons.house_rounded,
    Icons.house_rounded,
    Icons.house_rounded,
    Icons.auto_awesome_rounded,
  ];

  final List<TouristPlace> _places = [
    // ১. রবীন্দ্র কাছারি বাড়ি
    TouristPlace(id: '1', name: 'Rabindra Kachari Bari', nameBn: 'রবীন্দ্র কাছারি বাড়ি', description: 'কবি রবীন্দ্রনাথ ঠাকুরের স্মৃতিবিজড়িত কাছারি বাড়ি। এখানে বসে তিনি অনেক বিখ্যাত রচনা লিখেছিলেন। সাহিত্যপ্রেমীদের জন্য তীর্থস্থান।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1833, longitude: 89.5917, entryFee: '২০ টাকা', openingHours: 'সকাল ৯টা - বিকাল ৫টা', rating: 4.8),
    // ২. যমুনা সেতু
    TouristPlace(id: '2', name: 'Jamuna Bridge', nameBn: 'যমুনা সেতু (বঙ্গবন্ধু সেতু)', description: 'বাংলাদেশের অন্যতম বড় সেতু। যমুনা নদীর উপর তৈরি এই ৪.৮ কিমি দীর্ঘ সেতুটি প্রকৌশলের এক বিস্ময়। বিকেলের ভিউ অসাধারণ।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ-টাঙ্গাইল সংযোগ', latitude: 24.3833, longitude: 89.7833, entryFee: 'বিনামূল্যে', openingHours: 'সর্বদা খোলা', rating: 4.9),
    // ৩. বঙ্গবন্ধু যমুনা ইকোপার্ক
    TouristPlace(id: '3', name: 'Bangabandhu Jamuna Eco Park', nameBn: 'বঙ্গবন্ধু যমুনা ইকোপার্ক', description: 'যমুনা সেতুর কাছে অবস্থিত সুন্দর ইকোপার্ক। বিভিন্ন প্রজাতির গাছ, পাখি ও প্রাকৃতিক সৌন্দর্য। পরিবার নিয়ে ঘুরার আদর্শ স্থান।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'যমুনা সেতু এলাকা, সিরাজগঞ্জ', latitude: 24.3900, longitude: 89.7750, entryFee: '৫০ টাকা', openingHours: 'সকাল ৮টা - বিকাল ৫টা', rating: 4.5),
    // ৪. চায়না বাঁধ
    TouristPlace(id: '4', name: 'China Bandh', nameBn: 'চায়না বাঁধ', description: 'চীনা সহায়তায় নির্মিত বন্যা নিয়ন্ত্রণ বাঁধ। বাঁধের উপর দিয়ে হাঁটা ও নদীর দৃশ্য উপভোগের জন্য জনপ্রিয় স্থান।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4480, longitude: 89.7080, openingHours: 'সর্বদা খোলা', rating: 4.2),
    // ৫. নবরত্ন মন্দির
    TouristPlace(id: '5', name: 'Nabaratna Temple', nameBn: 'নবরত্ন মন্দির', description: 'প্রাচীন হিন্দু মন্দির। অসাধারণ স্থাপত্যশৈলীতে নির্মিত। ধর্মীয় ও ঐতিহাসিক গুরুত্বপূর্ণ স্থান।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1850, longitude: 89.5930, openingHours: 'সকাল ৬টা - সন্ধ্যা ৭টা', rating: 4.3),
    // ৬. সেন ভাঙ্গাবাড়ী গ্রাম
    TouristPlace(id: '6', name: 'Sen Bhangabari', nameBn: 'সেন ভাঙ্গাবাড়ী গ্রাম (রজনীকান্ত ও সূচিত্রা সেনের জন্মস্থান)', description: 'কবি রজনীকান্ত সেন ও কিংবদন্তি নায়িকা সূচিত্রা সেনের জন্মস্থান। বাংলা সংস্কৃতির ইতিহাসে গুরুত্বপূর্ণ স্থান।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'ভাঙ্গাবাড়ী, সিরাজগঞ্জ', latitude: 24.3200, longitude: 89.5700, openingHours: 'সর্বদা খোলা', rating: 4.4),
    // ৭. জয়সাগর দিঘি
    TouristPlace(id: '7', name: 'Joysagar Dighi', nameBn: 'জয়সাগর দিঘি', description: 'ঐতিহাসিক বিশাল দিঘি। পারিপার্শ্বিক প্রাকৃতিক সৌন্দর্য মনোমুগ্ধকর। বিশ্রাম ও পিকনিকের জন্য আদর্শ।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4550, longitude: 89.6950, openingHours: 'সর্বদা খোলা', rating: 4.1),
    // ৮. চলন বিল
    TouristPlace(id: '8', name: 'Chalan Beel', nameBn: 'চলন বিল', description: 'বাংলাদেশের সবচেয়ে বড় বিলগুলোর একটি। বর্ষাকালে অপরূপ রূপ ধারণ করে। পাখি দেখা, নৌকা ভ্রমণ ও মাছ ধরার জন্য বিখ্যাত।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'তাড়াশ, সিরাজগঞ্জ', latitude: 24.2800, longitude: 89.4500, openingHours: 'সর্বদা খোলা', rating: 4.6),
    // ৯. মিল্ক ভিটা
    TouristPlace(id: '9', name: 'Milk Vita', nameBn: 'মিল্ক ভিটা (বাংলাদেশ দুগ্ধ উৎপাদক সমবায়)', description: 'বাংলাদেশের বিখ্যাত মিল্ক ভিটার কারখানা। দুগ্ধ শিল্পের ইতিহাস জানতে ও শিল্প পরিদর্শনের জন্য আকর্ষণীয়।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'বাঘাবাড়ী, সিরাজগঞ্জ', latitude: 24.1750, longitude: 89.5980, openingHours: 'সকাল ৯টা - বিকাল ৫টা', rating: 4.0),
    // ১০. যাদব চক্রবর্তী নিবাস
    TouristPlace(id: '10', name: 'Jadob Chakroborti Nibas', nameBn: 'যাদব চক্রবর্তী নিবাস', description: 'ঐতিহাসিক ব্যক্তিত্ব যাদব চক্রবর্তীর নিবাস। প্রাচীন স্থাপত্য ও সাংস্কৃতিক ঐতিহ্য সংরক্ষিত।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4525, longitude: 89.7015, openingHours: 'সর্বদা খোলা', rating: 4.0),
    // ১১. ইলিয়ট ব্রীজ
    TouristPlace(id: '11', name: 'Elliott Bridge', nameBn: 'ইলিয়ট ব্রিজ', description: 'ব্রিটিশ আমলে নির্মিত ঐতিহাসিক সেতু। প্রাচীন স্থাপত্যশৈলী দেখার মতো। ইতিহাস অনুরাগীদের জন্য আকর্ষণীয়।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4520, longitude: 89.6980, openingHours: 'সর্বদা খোলা', rating: 4.1),
    // ১২. সার্কিট হাউজ
    TouristPlace(id: '12', name: 'Circuit House', nameBn: 'সার্কিট হাউজ', description: 'ব্রিটিশ আমলের ঐতিহাসিক সার্কিট হাউজ। সুন্দর স্থাপত্য ও পরিবেশ। সিরাজগঞ্জের ঐতিহ্যবাহী স্থাপনা।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4530, longitude: 89.7025, openingHours: 'সকাল ৯টা - বিকাল ৫টা', rating: 3.9),
    // ১৩. সিরাজগঞ্জ শহর রক্ষা বাঁধ
    TouristPlace(id: '13', name: 'Sirajganj Town Protection Embankment', nameBn: 'সিরাজগঞ্জ শহর রক্ষা বাঁধ', description: 'যমুনা নদীর ভাঙন থেকে শহর রক্ষার বাঁধ। বাঁধের উপর দিয়ে হাঁটার সুন্দর অভিজ্ঞতা। নদীর অসাধারণ দৃশ্য।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4540, longitude: 89.7060, openingHours: 'সর্বদা খোলা', rating: 4.2),
    // ১৪. ধুবিল কাটার মহল জমিদার বাড়ী
    TouristPlace(id: '14', name: 'Dhubil Katar Mahal Zamindar Bari', nameBn: 'ধুবিল কাটার মহল জমিদার বাড়ী', description: 'প্রাচীন জমিদার বাড়ি। ঐতিহাসিক স্থাপত্য ও কারুকাজ সংরক্ষিত। জমিদারি আমলের স্মৃতি বহন করে।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'উল্লাপাড়া, সিরাজগঞ্জ', latitude: 24.3100, longitude: 89.5400, openingHours: 'সর্বদা খোলা', rating: 4.0),
    // ১৫. আটঘরিয়া জমিদার বাড়ী
    TouristPlace(id: '15', name: 'Atghoria Zamindar Bari', nameBn: 'আটঘরিয়া জমিদার বাড়ী', description: 'ঐতিহাসিক জমিদার বাড়ি। পুরনো দিনের জমিদারি আমলের স্থাপত্যের নিদর্শন। ইতিহাসপ্রেমীদের জন্য দর্শনীয়।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'রায়গঞ্জ, সিরাজগঞ্জ', latitude: 24.2700, longitude: 89.5100, openingHours: 'সর্বদা খোলা', rating: 3.9),
    // ১৬. মাওলানা ভাসানীর বাড়ী
    TouristPlace(id: '16', name: 'Maulana Bhasani House', nameBn: 'মজলুম জননেতা মাওলানা আব্দুল হামিদ খান ভাসানীর বাড়ী', description: 'মজলুম জননেতা মাওলানা ভাসানীর ঐতিহাসিক বাসস্থান। বাংলাদেশের রাজনৈতিক ইতিহাসে গুরুত্বপূর্ণ স্থান।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ', latitude: 24.4490, longitude: 89.6960, openingHours: 'সর্বদা খোলা', rating: 4.5),
    // ১৭. সান্যাল জমিদার বাড়ীর শিব দুর্গা মন্দির
    TouristPlace(id: '17', name: 'Sanyal Zamindar Shib Durga Temple', nameBn: 'সান্যাল জমিদার বাড়ীর শিব দুর্গা মন্দির', description: 'জমিদার আমলের প্রাচীন শিব ও দুর্গা মন্দির। সুন্দর কারুকাজ ও ধর্মীয় স্থাপত্যের অনন্য নিদর্শন।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1860, longitude: 89.5940, openingHours: 'সকাল ৬টা - সন্ধ্যা ৭টা', rating: 4.1),
    // ১৮. মকিমপুর জমিদার বাড়ীর মন্দির
    TouristPlace(id: '18', name: 'Mokimpur Zamindar Temple', nameBn: 'মকিমপুর জমিদার বাড়ীর মন্দির', description: 'মকিমপুর জমিদার বাড়ির প্রাচীন মন্দির। ঐতিহাসিক স্থাপত্য ও ধর্মীয় গুরুত্ব রয়েছে।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'সিরাজগঞ্জ', latitude: 24.4200, longitude: 89.6800, openingHours: 'সর্বদা খোলা', rating: 4.0),
    // ১৯. তাড়াশ চলন বিল
    TouristPlace(id: '19', name: 'Tarash Chalan Beel', nameBn: 'তাড়াশ চলন বিল', description: 'তাড়াশ উপজেলায় চলন বিলের অংশ। বর্ষাকালে অপরূপ রূপ ধারণ করে। মাছ ধরা ও নৌকা ভ্রমণের জন্য জনপ্রিয়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'তাড়াশ, সিরাজগঞ্জ', latitude: 24.2600, longitude: 89.4600, openingHours: 'সর্বদা খোলা', rating: 4.3),
    // ২০. মুক্তির সোপান
    TouristPlace(id: '20', name: 'Muktir Sopan', nameBn: 'মুক্তির সোপান', description: 'মুক্তিযুদ্ধের স্মৃতিসৌধ। দেশের স্বাধীনতা সংগ্রামের স্মৃতি সংরক্ষিত। দেশপ্রেমিক নাগরিকদের জন্য অবশ্যই দর্শনীয়।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4535, longitude: 89.7005, openingHours: 'সর্বদা খোলা', rating: 4.4),
    // ২১. বাঘাবাড়ি নদী বন্দর
    TouristPlace(id: '21', name: 'Baghbari River Port', nameBn: 'বাঘাবাড়ি নদী বন্দর', description: 'গুরুত্বপূর্ণ নদী বন্দর। নদীপথের যোগাযোগের কেন্দ্রবিন্দু। নদীর সুন্দর দৃশ্য উপভোগ করা যায়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'বাঘাবাড়ী, শাহজাদপুর', latitude: 24.1700, longitude: 89.6000, openingHours: 'সর্বদা খোলা', rating: 4.3),
    // ২২. শাহজাদপুর মসজিদ
    TouristPlace(id: '22', name: 'Shahzadpur Mosque', nameBn: 'শাহজাদপুর মসজিদ', description: 'শাহজাদপুরের ঐতিহাসিক মসজিদ। প্রাচীন স্থাপত্যশৈলীতে নির্মিত। ধর্মীয় ও সাংস্কৃতিক গুরুত্ব রয়েছে।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1840, longitude: 89.5920, openingHours: 'সর্বদা খোলা', rating: 4.2),
    // ২৩. শাহজাদপুর পোতাজিয়া বিল
    TouristPlace(id: '23', name: 'Shahzadpur Potajia Beel', nameBn: 'শাহজাদপুর পোতাজিয়া বিল', description: 'শাহজাদপুরের সুন্দর প্রাকৃতিক বিল। পাখি দেখা, নৌকা ভ্রমণ ও মাছ ধরার জন্য জনপ্রিয়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1750, longitude: 89.5850, openingHours: 'সর্বদা খোলা', rating: 4.1),
    // ২৪. শাহ মখদুমের মাজার
    TouristPlace(id: '24', name: 'Shah Mokhdum Mazar', nameBn: 'শাহ মখদুমের মাজার', description: 'প্রাচীন সুফি সাধকের মাজার। ধর্মপ্রাণ মানুষের কাছে অত্যন্ত শ্রদ্ধার স্থান। পবিত্র ও শান্ত পরিবেশ।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'সিরাজগঞ্জ', latitude: 24.4500, longitude: 89.6970, openingHours: 'সর্বদা খোলা', rating: 4.3),
    // ২৫. ছয়আনি পাড়া দুই গম্বুজ মসজিদ
    TouristPlace(id: '25', name: 'Chhoyani Para Mosque', nameBn: 'ছয়আনি পাড়া দুই গম্বুজ মসজিদ', description: 'প্রাচীন দুই গম্বুজ বিশিষ্ট মসজিদ। সুন্দর কারুকাজ ও স্থাপত্যশৈলী। ঐতিহাসিক ধর্মীয় স্থাপনা।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'সিরাজগঞ্জ সদর', latitude: 24.4515, longitude: 89.7030, openingHours: 'সর্বদা খোলা', rating: 4.0),
    // ২৬. ভিক্টোরিয়া স্কুল
    TouristPlace(id: '26', name: 'Victoria School', nameBn: 'ভিক্টোরিয়া স্কুল', description: 'ব্রিটিশ আমলে প্রতিষ্ঠিত ঐতিহাসিক বিদ্যালয়। প্রাচীন ভবন ও স্থাপত্যশৈলী সংরক্ষিত। শিক্ষার ইতিহাসের সাক্ষী।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4528, longitude: 89.7008, openingHours: 'সকাল ৯টা - বিকাল ৪টা', rating: 4.0),
    // ২৭. হার্ড পয়েন্ট
    TouristPlace(id: '27', name: 'Hard Point', nameBn: 'হার্ড পয়েন্ট', description: 'যমুনা নদীর তীরে অবস্থিত জনপ্রিয় স্থান। সূর্যাস্ত দেখার জন্য অত্যন্ত জনপ্রিয়। বিকেলের আবহাওয়া মনোমুগ্ধকর।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ সদর, যমুনা তীর', latitude: 24.4534, longitude: 89.7003, openingHours: 'সর্বদা খোলা', rating: 4.5),
    // ২৮. নওগাঁ শাহ শরীফ জিন্দানী মাজার
    TouristPlace(id: '28', name: 'Naogaon Shah Sharif Jindani Mazar', nameBn: 'নওগাঁ শাহ শরীফ জিন্দানী (রাঃ) মাজার', description: 'প্রাচীন সুফি সাধকের মাজার শরীফ। ধর্মপ্রাণ মানুষের তীর্থস্থান। শান্ত ও পবিত্র পরিবেশ।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'কামারখন্দ, সিরাজগঞ্জ', latitude: 24.3450, longitude: 89.5850, openingHours: 'সর্বদা খোলা', rating: 4.4),
    // ২৯. এনায়েত খাজা বেড়িবাঁধ
    TouristPlace(id: '29', name: 'Enayetpur Khaja Embankment', nameBn: 'এনায়েত খাজা বেড়িবাঁধ', description: 'এনায়েতপুর এলাকার বেড়িবাঁধ। বাঁধের উপর দিয়ে হাঁটা ও প্রাকৃতিক দৃশ্য উপভোগের জন্য সুন্দর স্থান।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'কামারখন্দ, সিরাজগঞ্জ', latitude: 24.3480, longitude: 89.6850, openingHours: 'সর্বদা খোলা', rating: 4.0),
    // ৩০. রাউতারা বাঁধ ও স্লুইচ গেট
    TouristPlace(id: '30', name: 'Rautara Dam & Sluice Gate', nameBn: 'রাউতারা বাঁধ ও স্লুইচ গেট', description: 'পানি নিয়ন্ত্রণ বাঁধ ও স্লুইচ গেট। প্রকৌশলবিদ্যার নিদর্শন। পানির প্রবাহ দেখার জন্য আকর্ষণীয়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ', latitude: 24.4300, longitude: 89.6750, openingHours: 'সর্বদা খোলা', rating: 3.8),
    // ৩১. খাজা ইউনুছ আলী মেডিকেল কলেজ
    TouristPlace(id: '31', name: 'Khwaja Yunus Ali Medical College', nameBn: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', description: 'সিরাজগঞ্জের বিখ্যাত মেডিকেল কলেজ ও হাসপাতাল। আধুনিক স্থাপত্য ও সবুজ ক্যাম্পাস। দর্শনীয় স্থান।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'এনায়েতপুর, সিরাজগঞ্জ', latitude: 24.3520, longitude: 89.6840, openingHours: 'সর্বদা খোলা', rating: 4.5),
    // ৩২. দরবার শরীফ মাজার
    TouristPlace(id: '32', name: 'Darbar Sharif Mazar', nameBn: 'এনায়েতপুর দরবার শরীফ মাজার', description: 'বিখ্যাত ধর্মীয় স্থান। সারা দেশ থেকে লক্ষ লক্ষ মানুষ আসেন। বার্ষিক ওরস মাহফিল অনুষ্ঠিত হয়।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'এনায়েতপুর, কামারখন্দ', latitude: 24.3500, longitude: 89.6833, openingHours: 'সর্বদা খোলা', rating: 4.8),
    // ৩৩. বেহুলার কূপ
    TouristPlace(id: '33', name: 'Behular Kup', nameBn: 'বেহুলার কূপ', description: 'লোককথার বেহুলার সাথে সম্পর্কিত প্রাচীন কূপ। পৌরাণিক ও ঐতিহাসিক গুরুত্ব রয়েছে। দর্শনার্থীদের আকর্ষণ করে।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ', latitude: 24.4400, longitude: 89.6900, openingHours: 'সর্বদা খোলা', rating: 4.1),
    // ৩৪. জোতপাড়া যমুনা নদীর ঘাট
    TouristPlace(id: '34', name: 'Jotpara Jamuna Ghat', nameBn: 'জোতপাড়া যমুনা নদীর ঘাট', description: 'যমুনা নদীর সুন্দর ঘাট। নদীর দৃশ্য উপভোগ, নৌকা ভ্রমণ ও সূর্যাস্ত দেখার জন্য অত্যন্ত জনপ্রিয়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'জোতপাড়া, সিরাজগঞ্জ', latitude: 24.4580, longitude: 89.7080, openingHours: 'সর্বদা খোলা', rating: 4.2),
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

  List<String> get _categories => ['সব', 'ঐতিহাসিক', 'ধর্মীয়', 'প্রাকৃতিক'];

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
