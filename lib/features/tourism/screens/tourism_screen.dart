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
    TouristPlace(id: '1', name: 'Rabindra Kachari Bari', nameBn: 'রবীন্দ্র কাছারি বাড়ি', description: '🏛️ বিখ্যাত: রবীন্দ্রনাথ ঠাকুরের জমিদারি পরিচালনার কেন্দ্র। এখানে বসে তিনি "সোনার তরী", "চিত্রা", "চৈতালী" ও "পোস্টমাস্টার" সহ অসংখ্য কালজয়ী সাহিত্যকর্ম রচনা করেন। বর্তমানে জাদুঘর হিসেবে সংরক্ষিত — রবীন্দ্রনাথের ব্যবহৃত আসবাবপত্র, পালকি ও দুর্লভ আলোকচিত্র প্রদর্শিত।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1833, longitude: 89.5917, entryFee: '২০ টাকা', openingHours: 'সকাল ৯টা - বিকাল ৫টা', rating: 4.8),
    // ২. যমুনা সেতু
    TouristPlace(id: '2', name: 'Jamuna Bridge', nameBn: 'যমুনা সেতু (বঙ্গবন্ধু সেতু)', description: '🌉 বিখ্যাত: দক্ষিণ এশিয়ার দীর্ঘতম সেতুগুলোর একটি — ৪.৮ কিলোমিটার দীর্ঘ। ১৯৯৮ সালে উদ্বোধিত এই সেতু পূর্ব ও পশ্চিম বাংলাদেশকে সংযুক্ত করেছে। সড়ক, রেল, গ্যাস পাইপলাইন ও বিদ্যুৎ লাইন বহনকারী বহুমুখী সেতু। বিকেলে যমুনার উপর সূর্যাস্তের দৃশ্য অবিস্মরণীয়।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ-টাঙ্গাইল সংযোগ', latitude: 24.3833, longitude: 89.7833, entryFee: 'বিনামূল্যে', openingHours: 'সর্বদা খোলা', rating: 4.9),
    // ৩. বঙ্গবন্ধু যমুনা ইকোপার্ক
    TouristPlace(id: '3', name: 'Bangabandhu Jamuna Eco Park', nameBn: 'বঙ্গবন্ধু যমুনা ইকোপার্ক', description: '🌿 বিখ্যাত: যমুনা সেতুর পশ্চিম প্রান্তে ৮০ একর জমিতে নির্মিত বিশাল ইকোপার্ক। দেশি-বিদেশি শত শত প্রজাতির গাছ, কৃত্রিম লেক, পিকনিক স্পট, চিড়িয়াখানা ও শিশু পার্ক রয়েছে। পরিবার নিয়ে সারাদিন কাটানোর আদর্শ জায়গা।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'যমুনা সেতু পশ্চিম প্রান্ত, সিরাজগঞ্জ', latitude: 24.3900, longitude: 89.7750, entryFee: '৫০ টাকা', openingHours: 'সকাল ৮টা - বিকাল ৫টা', rating: 4.5),
    // ৪. চায়না বাঁধ
    TouristPlace(id: '4', name: 'China Bandh', nameBn: 'চায়না বাঁধ', description: '🏗️ বিখ্যাত: চীন সরকারের আর্থিক ও কারিগরি সহায়তায় নির্মিত বিশাল বন্যা নিয়ন্ত্রণ বাঁধ। যমুনার ভাঙন থেকে সিরাজগঞ্জ শহরকে রক্ষা করছে। বাঁধের উপরে পাকা রাস্তা — বিকেলে হাঁটা, সাইকেল চালানো ও নদীর দৃশ্য দেখার জন্য স্থানীয়দের প্রিয় জায়গা।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4480, longitude: 89.7080, openingHours: 'সর্বদা খোলা', rating: 4.2),
    // ৫. নবরত্ন মন্দির
    TouristPlace(id: '5', name: 'Nabaratna Temple', nameBn: 'নবরত্ন মন্দির', description: '🕌 বিখ্যাত: ৯টি চূড়া বিশিষ্ট প্রাচীন হিন্দু মন্দির — "নবরত্ন" নাম এখান থেকেই। পোড়ামাটির ফলক ও টেরাকোটা কারুকাজে সমৃদ্ধ। মুঘল ও সুলতানি স্থাপত্যরীতির মিশ্রণ দেখা যায়। প্রত্নতত্ত্ব ও স্থাপত্যপ্রেমীদের জন্য অবশ্যদর্শনীয়।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1850, longitude: 89.5930, openingHours: 'সকাল ৬টা - সন্ধ্যা ৭টা', rating: 4.3),
    // ৬. সেন ভাঙ্গাবাড়ী গ্রাম
    TouristPlace(id: '6', name: 'Sen Bhangabari', nameBn: 'সেন ভাঙ্গাবাড়ী গ্রাম (রজনীকান্ত ও সূচিত্রা সেনের জন্মস্থান)', description: '🎭 বিখ্যাত: বাংলা সাহিত্যের অমর গীতিকার রজনীকান্ত সেন ("তুমি নির্মল কর") ও মহানায়িকা সূচিত্রা সেনের পৈতৃক ভিটা। রজনীকান্তের "দেশ দেশ নন্দিত" গানটি বাংলা সংগীতের অমূল্য সম্পদ। সাহিত্য ও চলচ্চিত্র ইতিহাসপ্রেমীদের তীর্থস্থান।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'ভাঙ্গাবাড়ী, রায়গঞ্জ, সিরাজগঞ্জ', latitude: 24.3200, longitude: 89.5700, openingHours: 'সর্বদা খোলা', rating: 4.4),
    // ৭. জয়সাগর দিঘি
    TouristPlace(id: '7', name: 'Joysagar Dighi', nameBn: 'জয়সাগর দিঘি', description: '💧 বিখ্যাত: প্রাচীন আমলে খনন করা বিশাল জলাশয়। চারপাশে বড় বড় গাছে ঘেরা শান্ত পরিবেশ। স্থানীয়দের কাছে বিশ্রাম ও বিনোদনের জনপ্রিয় স্থান। দিঘির পারে বসে প্রকৃতি উপভোগ করা যায়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4550, longitude: 89.6950, openingHours: 'সর্বদা খোলা', rating: 4.1),
    // ৮. চলন বিল
    TouristPlace(id: '8', name: 'Chalan Beel', nameBn: 'চলন বিল', description: '🌊 বিখ্যাত: বাংলাদেশের সবচেয়ে বড় বিল — প্রায় ৩৬৮ বর্গকিলোমিটার আয়তন। বর্ষায় বিশাল জলরাশিতে ভরে ওঠে, দেখতে সাগরের মতো। শীতে অতিথি পাখির আগমনে মুখরিত হয়। দেশি মাছের অন্যতম উৎস — ইলিশ, বোয়াল, শোল, কই পাওয়া যায়। নৌকা ভ্রমণ অবিস্মরণীয়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'তাড়াশ, সিরাজগঞ্জ', latitude: 24.2800, longitude: 89.4500, openingHours: 'সর্বদা খোলা', rating: 4.6),
    // ৯. মিল্ক ভিটা
    TouristPlace(id: '9', name: 'Milk Vita', nameBn: 'মিল্ক ভিটা (বাংলাদেশ দুগ্ধ উৎপাদক সমবায়)', description: '🥛 বিখ্যাত: বাংলাদেশের প্রথম ও সবচেয়ে বড় সমবায় ভিত্তিক দুগ্ধ প্রক্রিয়াজাতকরণ কারখানা। ১৯৭৩ সালে প্রতিষ্ঠিত। বাঘাবাড়ীর হাজার হাজার কৃষক পরিবার এখানে দুধ সরবরাহ করে। মিল্ক ভিটা ব্র্যান্ডের দুধ, দই, ঘি সারাদেশে বিখ্যাত। কারখানা পরিদর্শন করা যায়।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'বাঘাবাড়ী, শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1750, longitude: 89.5980, openingHours: 'সকাল ৯টা - বিকাল ৫টা', rating: 4.0),
    // ১০. যাদব চক্রবর্তী নিবাস
    TouristPlace(id: '10', name: 'Jadob Chakroborti Nibas', nameBn: 'যাদব চক্রবর্তী নিবাস', description: '📚 বিখ্যাত: বিখ্যাত পণ্ডিত ও সমাজসেবক যাদব চক্রবর্তীর বাসভবন। ঔপনিবেশিক আমলের স্থাপত্যরীতিতে নির্মিত। প্রাচীন কাঠের কাজ, লোহার রেলিং ও পোড়ামাটির অলংকরণ সংরক্ষিত। সিরাজগঞ্জের সামাজিক ইতিহাসের সাক্ষী।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4525, longitude: 89.7015, openingHours: 'সর্বদা খোলা', rating: 4.0),
    // ১১. ইলিয়ট ব্রীজ
    TouristPlace(id: '11', name: 'Elliott Bridge', nameBn: 'ইলিয়ট ব্রিজ', description: '🌉 বিখ্যাত: ব্রিটিশ শাসনামলে তৎকালীন ডেপুটি কমিশনার ইলিয়টের নামে নির্মিত ঐতিহাসিক সেতু। লোহার কাঠামোতে তৈরি এই সেতু ঔপনিবেশিক প্রকৌশলবিদ্যার নিদর্শন। সিরাজগঞ্জের প্রাচীনতম স্থাপনাগুলোর একটি।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4520, longitude: 89.6980, openingHours: 'সর্বদা খোলা', rating: 4.1),
    // ১২. সার্কিট হাউজ
    TouristPlace(id: '12', name: 'Circuit House', nameBn: 'সার্কিট হাউজ', description: '🏛️ বিখ্যাত: ব্রিটিশ আমলে নির্মিত জেলা প্রশাসনের অতিথিশালা। সুন্দর বাগান ও যমুনার তীরে অবস্থিত। ঔপনিবেশিক স্থাপত্যরীতিতে তৈরি — উঁচু ছাদ, প্রশস্ত বারান্দা ও কাঠের কারুকাজ। বহু বিখ্যাত ব্যক্তি এখানে অবস্থান করেছেন।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4530, longitude: 89.7025, openingHours: 'সকাল ৯টা - বিকাল ৫টা', rating: 3.9),
    // ১৩. সিরাজগঞ্জ শহর রক্ষা বাঁধ
    TouristPlace(id: '13', name: 'Sirajganj Town Protection Embankment', nameBn: 'সিরাজগঞ্জ শহর রক্ষা বাঁধ', description: '🛡️ বিখ্যাত: যমুনার ভয়াবহ ভাঙন থেকে সিরাজগঞ্জ শহরকে রক্ষাকারী বিশাল বাঁধ। বাঁধের উপরে পাকা রাস্তা — বিকেলে জগিং, সাইকেল চালানো ও যমুনার বিস্তীর্ণ দৃশ্য দেখার জন্য শহরবাসীর প্রিয় স্থান। বর্ষায় নদীর উত্তাল রূপ দেখা যায়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4540, longitude: 89.7060, openingHours: 'সর্বদা খোলা', rating: 4.2),
    // ১৪. ধুবিল কাটার মহল জমিদার বাড়ী
    TouristPlace(id: '14', name: 'Dhubil Katar Mahal Zamindar Bari', nameBn: 'ধুবিল কাটার মহল জমিদার বাড়ী', description: '🏰 বিখ্যাত: উল্লাপাড়ার ঐতিহাসিক জমিদার বাড়ি। জমিদারি আমলের জৌলুশ ও আভিজাত্যের নিদর্শন। প্রাচীন দরজা-জানালা, কাঠের খোদাই ও পোড়ামাটির নকশা সংরক্ষিত। জমিদারি প্রথার ইতিহাস জানতে আগ্রহীদের জন্য দর্শনীয়।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'উল্লাপাড়া, সিরাজগঞ্জ', latitude: 24.3100, longitude: 89.5400, openingHours: 'সর্বদা খোলা', rating: 4.0),
    // ১৫. আটঘরিয়া জমিদার বাড়ী
    TouristPlace(id: '15', name: 'Atghoria Zamindar Bari', nameBn: 'আটঘরিয়া জমিদার বাড়ী', description: '🏰 বিখ্যাত: রায়গঞ্জ উপজেলার প্রাচীন জমিদার বাড়ি। নামটি এসেছে আটটি ঘর নিয়ে গড়ে ওঠা প্রাসাদ থেকে। ইন্দো-ইউরোপীয় স্থাপত্যরীতিতে নির্মিত। জমিদারি আমলের বিচারকক্ষ, দরবার হল ও পুকুরঘাট এখনো টিকে আছে।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'রায়গঞ্জ, সিরাজগঞ্জ', latitude: 24.2700, longitude: 89.5100, openingHours: 'সর্বদা খোলা', rating: 3.9),
    // ১৬. মাওলানা ভাসানীর বাড়ী
    TouristPlace(id: '16', name: 'Maulana Bhasani House', nameBn: 'মজলুম জননেতা মাওলানা আব্দুল হামিদ খান ভাসানীর বাড়ী', description: '🏠 বিখ্যাত: "মজলুম জননেতা" খ্যাত মাওলানা ভাসানীর ঐতিহাসিক বাসভবন। তিনি ছিলেন বাংলাদেশের স্বাধীনতা আন্দোলনের অন্যতম পুরোধা ব্যক্তিত্ব। তাঁর সহজ-সরল জীবনযাপনের নিদর্শন এই বাড়িতে সংরক্ষিত। রাজনৈতিক ইতিহাসের গবেষকদের জন্য গুরুত্বপূর্ণ।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ', latitude: 24.4490, longitude: 89.6960, openingHours: 'সর্বদা খোলা', rating: 4.5),
    // ১৭. সান্যাল জমিদার বাড়ীর শিব দুর্গা মন্দির
    TouristPlace(id: '17', name: 'Sanyal Zamindar Shib Durga Temple', nameBn: 'সান্যাল জমিদার বাড়ীর শিব দুর্গা মন্দির', description: '🕌 বিখ্যাত: সান্যাল জমিদার পরিবারের ব্যক্তিগত শিব ও দুর্গা মন্দির। পোড়ামাটির ফলকে রামায়ণ-মহাভারতের কাহিনী খোদিত। বাংলার ধ্রুপদী মন্দির স্থাপত্যের অনুপম নিদর্শন। দুর্গাপূজায় বিশেষ জাঁকজমক হয়।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1860, longitude: 89.5940, openingHours: 'সকাল ৬টা - সন্ধ্যা ৭টা', rating: 4.1),
    // ১৮. মকিমপুর জমিদার বাড়ীর মন্দির
    TouristPlace(id: '18', name: 'Mokimpur Zamindar Temple', nameBn: 'মকিমপুর জমিদার বাড়ীর মন্দির', description: '🛕 বিখ্যাত: মকিমপুর জমিদার পরিবারের প্রাচীন মন্দির। টেরাকোটা ও পোড়ামাটির অলংকরণে সজ্জিত। জমিদারি আমলে নির্মিত এই মন্দির হিন্দু ধর্মাবলম্বীদের পূজা-অর্চনার স্থান। স্থাপত্যশৈলী ও ধর্মীয় সম্প্রীতির প্রতীক।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'সিরাজগঞ্জ', latitude: 24.4200, longitude: 89.6800, openingHours: 'সর্বদা খোলা', rating: 4.0),
    // ১৯. তাড়াশ চলন বিল
    TouristPlace(id: '19', name: 'Tarash Chalan Beel', nameBn: 'তাড়াশ চলন বিল', description: '🐟 বিখ্যাত: তাড়াশ উপজেলায় চলন বিলের সবচেয়ে গভীর ও বিস্তৃত অংশ। মিঠাপানির মাছের অন্যতম উৎস — কৈ, মাগুর, শিং, পুঁটি প্রচুর পাওয়া যায়। বর্ষায় নৌকায় বিল পাড়ি দেওয়ার অভিজ্ঞতা রোমাঞ্চকর। শীতে পরিযায়ী পাখির মেলা বসে।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'তাড়াশ, সিরাজগঞ্জ', latitude: 24.2600, longitude: 89.4600, openingHours: 'সর্বদা খোলা', rating: 4.3),
    // ২০. মুক্তির সোপান
    TouristPlace(id: '20', name: 'Muktir Sopan', nameBn: 'মুক্তির সোপান', description: '🇧🇩 বিখ্যাত: ১৯৭১ সালের মুক্তিযুদ্ধে সিরাজগঞ্জের বীর শহীদদের স্মরণে নির্মিত স্মৃতিসৌধ। সিঁড়ি আকৃতির নকশা — মুক্তির ধাপে ধাপে এগিয়ে যাওয়ার প্রতীক। বিজয় দিবস ও স্বাধীনতা দিবসে বিশেষ অনুষ্ঠান হয়। দেশপ্রেমিকদের জন্য শ্রদ্ধা নিবেদনের স্থান।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4535, longitude: 89.7005, openingHours: 'সর্বদা খোলা', rating: 4.4),
    // ২১. বাঘাবাড়ি নদী বন্দর
    TouristPlace(id: '21', name: 'Baghbari River Port', nameBn: 'বাঘাবাড়ি নদী বন্দর', description: '⚓ বিখ্যাত: বাংলাদেশের অন্যতম গুরুত্বপূর্ণ অভ্যন্তরীণ নদী বন্দর। পেট্রোলিয়াম ডিপো ও জ্বালানি তেল সরবরাহের প্রধান কেন্দ্র। বিশাল বিশাল তেলবাহী জাহাজ ভেড়ে। যমুনা নদীর বিস্তীর্ণ দৃশ্য ও জাহাজ চলাচল দেখার জন্য দর্শনার্থীরা আসেন।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'বাঘাবাড়ী, শাহজাদপুর', latitude: 24.1700, longitude: 89.6000, openingHours: 'সর্বদা খোলা', rating: 4.3),
    // ২২. শাহজাদপুর মসজিদ
    TouristPlace(id: '22', name: 'Shahzadpur Mosque', nameBn: 'শাহজাদপুর মসজিদ', description: '🕌 বিখ্যাত: শাহজাদপুরের কেন্দ্রীয় জামে মসজিদ। মুঘল স্থাপত্যরীতিতে নির্মিত গম্বুজ ও মিনার। প্রাচীন ক্যালিগ্রাফি ও জ্যামিতিক নকশায় সজ্জিত। জুমার নামাজে শত শত মুসল্লি এখানে সমবেত হন। ধর্মীয় ও স্থাপত্য ঐতিহ্যের মিলনক্ষেত্র।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1840, longitude: 89.5920, openingHours: 'সর্বদা খোলা', rating: 4.2),
    // ২৩. শাহজাদপুর পোতাজিয়া বিল
    TouristPlace(id: '23', name: 'Shahzadpur Potajia Beel', nameBn: 'শাহজাদপুর পোতাজিয়া বিল', description: '🦆 বিখ্যাত: শাহজাদপুরের অন্যতম সুন্দর প্রাকৃতিক জলাভূমি। শীতকালে হাজার হাজার অতিথি পাখি আসে — বালিহাঁস, পানকৌড়ি, বক। মাছে ভরপুর এই বিলে স্থানীয় জেলেরা সারা বছর মাছ ধরে। নৌকায় বিল পরিভ্রমণ অসাধারণ অভিজ্ঞতা।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'শাহজাদপুর, সিরাজগঞ্জ', latitude: 24.1750, longitude: 89.5850, openingHours: 'সর্বদা খোলা', rating: 4.1),
    // ২৪. শাহ মখদুমের মাজার
    TouristPlace(id: '24', name: 'Shah Mokhdum Mazar', nameBn: 'শাহ মখদুমের মাজার', description: '🕋 বিখ্যাত: মধ্যযুগে ইসলাম প্রচারের জন্য আসা সুফি সাধক শাহ মখদুমের সমাধিস্থল। কয়েকশত বছরের পুরনো এই মাজার শরীফে প্রতিদিন ভক্তরা যিয়ারতে আসেন। বার্ষিক উরসে বিশাল সমাগম হয়। আধ্যাত্মিক শান্তির স্থান।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'সিরাজগঞ্জ', latitude: 24.4500, longitude: 89.6970, openingHours: 'সর্বদা খোলা', rating: 4.3),
    // ২৫. ছয়আনি পাড়া দুই গম্বুজ মসজিদ
    TouristPlace(id: '25', name: 'Chhoyani Para Mosque', nameBn: 'ছয়আনি পাড়া দুই গম্বুজ মসজিদ', description: '🕌 বিখ্যাত: সুলতানি বা মুঘল আমলে নির্মিত দুইটি গম্বুজ বিশিষ্ট প্রাচীন মসজিদ। ইটের তৈরি দেয়ালে পোড়ামাটির অলংকরণ। মসজিদের মেহরাব ও মিম্বরে সূক্ষ্ম কারুকাজ। বাংলার মধ্যযুগীয় মসজিদ স্থাপত্যের গুরুত্বপূর্ণ নমুনা।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'সিরাজগঞ্জ সদর', latitude: 24.4515, longitude: 89.7030, openingHours: 'সর্বদা খোলা', rating: 4.0),
    // ২৬. ভিক্টোরিয়া স্কুল
    TouristPlace(id: '26', name: 'Victoria School', nameBn: 'ভিক্টোরিয়া স্কুল', description: '🎓 বিখ্যাত: ব্রিটিশ রানী ভিক্টোরিয়ার নামে ১৮৮৭ সালে প্রতিষ্ঠিত সিরাজগঞ্জের প্রাচীনতম শিক্ষাপ্রতিষ্ঠান। ঔপনিবেশিক আমলের লাল ইটের ভবন, খিলান আকৃতির দরজা-জানালা এখনো সংরক্ষিত। অসংখ্য বিখ্যাত ব্যক্তি এখান থেকে শিক্ষালাভ করেছেন।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ সদর', latitude: 24.4528, longitude: 89.7008, openingHours: 'সকাল ৯টা - বিকাল ৪টা', rating: 4.0),
    // ২৭. হার্ড পয়েন্ট
    TouristPlace(id: '27', name: 'Hard Point', nameBn: 'হার্ড পয়েন্ট', description: '🌅 বিখ্যাত: সিরাজগঞ্জের সবচেয়ে জনপ্রিয় সূর্যাস্ত দেখার স্থান। যমুনা নদীর তীরে কংক্রিটের শক্ত বাঁধের উপর নির্মিত — তাই নাম "হার্ড পয়েন্ট"। বিকেলে তরুণ-তরুণী, পরিবার ও বন্ধুরা আড্ডা দিতে আসেন। নদীর উপর সূর্যাস্তের রঙের খেলা দেখার জন্য বিখ্যাত।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ সদর, যমুনা তীর', latitude: 24.4534, longitude: 89.7003, openingHours: 'সর্বদা খোলা', rating: 4.5),
    // ২৮. নওগাঁ শাহ শরীফ জিন্দানী মাজার
    TouristPlace(id: '28', name: 'Naogaon Shah Sharif Jindani Mazar', nameBn: 'নওগাঁ শাহ শরীফ জিন্দানী (রাঃ) মাজার', description: '🕋 বিখ্যাত: ত্রয়োদশ শতাব্দীতে ইসলাম প্রচারের জন্য আগত প্রখ্যাত সুফি সাধক শাহ শরীফ জিন্দানী (রাঃ)-এর মাজার। হাটিকুমরুল মসজিদের কাছে অবস্থিত। প্রতিদিন দূরদূরান্ত থেকে ভক্তরা যিয়ারতে আসেন। ওরস উপলক্ষে বিশাল সমাবেশ হয়।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'কামারখন্দ, সিরাজগঞ্জ', latitude: 24.3450, longitude: 89.5850, openingHours: 'সর্বদা খোলা', rating: 4.4),
    // ২৯. এনায়েত খাজা বেড়িবাঁধ
    TouristPlace(id: '29', name: 'Enayetpur Khaja Embankment', nameBn: 'এনায়েত খাজা বেড়িবাঁধ', description: '🚶 বিখ্যাত: এনায়েতপুর দরবার শরীফ এলাকার সুদৃশ্য বেড়িবাঁধ। বাঁধের উপর দিয়ে দীর্ঘ পথ হাঁটার সুযোগ — দুই পাশে সবুজ ফসলের মাঠ ও নদীর দৃশ্য। বিকেলে স্থানীয়দের হাঁটার ও বিশ্রামের জনপ্রিয় জায়গা।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'কামারখন্দ, সিরাজগঞ্জ', latitude: 24.3480, longitude: 89.6850, openingHours: 'সর্বদা খোলা', rating: 4.0),
    // ৩০. রাউতারা বাঁধ ও স্লুইচ গেট
    TouristPlace(id: '30', name: 'Rautara Dam & Sluice Gate', nameBn: 'রাউতারা বাঁধ ও স্লুইচ গেট', description: '⚙️ বিখ্যাত: বন্যা নিয়ন্ত্রণ ও সেচ ব্যবস্থাপনার জন্য নির্মিত স্লুইচ গেট। পানি প্রবাহ নিয়ন্ত্রণের আধুনিক প্রকৌশলবিদ্যার নমুনা। বর্ষায় গেট দিয়ে পানি ছাড়ার দৃশ্য দর্শনীয়। কৃষি সেচে গুরুত্বপূর্ণ ভূমিকা রাখে।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'সিরাজগঞ্জ', latitude: 24.4300, longitude: 89.6750, openingHours: 'সর্বদা খোলা', rating: 3.8),
    // ৩১. খাজা ইউনুছ আলী মেডিকেল কলেজ
    TouristPlace(id: '31', name: 'Khwaja Yunus Ali Medical College', nameBn: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', description: '🏥 বিখ্যাত: এনায়েতপুর দরবার শরীফের পীর সাহেবের উদ্যোগে প্রতিষ্ঠিত আন্তর্জাতিক মানের মেডিকেল কলেজ ও হাসপাতাল। ৭৫০ শয্যা বিশিষ্ট হাসপাতাল, নার্সিং কলেজ ও গবেষণা কেন্দ্র। সুন্দর সবুজ ক্যাম্পাস ও আধুনিক স্থাপত্য। সাশ্রয়ী মূল্যে উন্নত চিকিৎসার জন্য বিখ্যাত।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'এনায়েতপুর, কামারখন্দ, সিরাজগঞ্জ', latitude: 24.3520, longitude: 89.6840, openingHours: 'সর্বদা খোলা', rating: 4.5),
    // ৩২. দরবার শরীফ মাজার
    TouristPlace(id: '32', name: 'Darbar Sharif Mazar', nameBn: 'এনায়েতপুর দরবার শরীফ মাজার', description: '🕋 বিখ্যাত: বাংলাদেশের সবচেয়ে বড় ও প্রসিদ্ধ দরবার শরীফগুলোর একটি। হযরত শাহ সুফি এনায়েতপুরী (রাঃ)-এর মাজার। প্রতি বছর লক্ষ লক্ষ মুরিদ ও ভক্ত সারাদেশ থেকে আসেন। বার্ষিক মাহফিলে ১০-১৫ লক্ষ মানুষের সমাগম হয়। বিশাল মসজিদ, মাদ্রাসা ও এতিমখানা রয়েছে।', category: 'religious', categoryBn: 'ধর্মীয়', address: 'এনায়েতপুর, কামারখন্দ, সিরাজগঞ্জ', latitude: 24.3500, longitude: 89.6833, openingHours: 'সর্বদা খোলা', rating: 4.8),
    // ৩৩. বেহুলার কূপ
    TouristPlace(id: '33', name: 'Behular Kup', nameBn: 'বেহুলার কূপ', description: '⛲ বিখ্যাত: বাংলার লোককাহিনী "বেহুলা-লখিন্দর"-এর সাথে সম্পর্কিত প্রাচীন কূপ। লোকমুখে প্রচলিত যে, সতী বেহুলা এই কূপের পানি ব্যবহার করতেন। পুরাতাত্ত্বিক ও লোকসাহিত্য গবেষকদের কাছে গুরুত্বপূর্ণ। রহস্যময় ও আকর্ষণীয় স্থান।', category: 'historical', categoryBn: 'ঐতিহাসিক', address: 'সিরাজগঞ্জ', latitude: 24.4400, longitude: 89.6900, openingHours: 'সর্বদা খোলা', rating: 4.1),
    // ৩৪. জোতপাড়া যমুনা নদীর ঘাট
    TouristPlace(id: '34', name: 'Jotpara Jamuna Ghat', nameBn: 'জোতপাড়া যমুনা নদীর ঘাট', description: '🚣 বিখ্যাত: সিরাজগঞ্জের জনপ্রিয় নদীর ঘাট। স্থানীয় জেলেদের মাছ ধরা, নৌকা যাতায়াত ও নদীর জীবনযাত্রা দেখার জন্য বিখ্যাত। সূর্যাস্তের সময় যমুনার উপর আলোর প্রতিফলন দেখার জন্য ফটোগ্রাফারদের প্রিয় স্থান। বর্ষায় নদীর উত্তাল রূপ দেখা যায়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'জোতপাড়া, সিরাজগঞ্জ', latitude: 24.4580, longitude: 89.7080, openingHours: 'সর্বদা খোলা', rating: 4.2),
    // ৩৫. উধুনিয়া
    TouristPlace(id: '35', name: 'Udhuniya', nameBn: 'উধুনিয়া', description: '🌾 বিখ্যাত: উল্লাপাড়া উপজেলার গ্রামীণ প্রকৃতির অপরূপ নিদর্শন। সবুজ ধানক্ষেত, আঁকাবাঁকা মেঠো পথ ও খোলা আকাশের অসাধারণ দৃশ্য। বাংলাদেশের গ্রামীণ জীবনযাত্রা ও কৃষি সংস্কৃতি কাছ থেকে দেখার জন্য বিখ্যাত। ফটোগ্রাফারদের কাছে "হিডেন জেম" — শান্ত পরিবেশে প্রকৃতি ফটোগ্রাফির আদর্শ লোকেশন। বিশেষত শীত ও বর্ষায় প্রাকৃতিক সৌন্দর্য সবচেয়ে ভালো উপভোগ করা যায়।', category: 'scenic', categoryBn: 'প্রাকৃতিক', address: 'উল্লাপাড়া, সিরাজগঞ্জ', latitude: 24.2800, longitude: 89.6200, openingHours: 'সর্বদা খোলা', rating: 4.1),
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
