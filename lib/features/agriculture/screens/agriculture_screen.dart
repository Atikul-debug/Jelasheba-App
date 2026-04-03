import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../models/agriculture_model.dart';

class AgricultureScreen extends StatelessWidget {
  const AgricultureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('কৃষি সেবা'),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'ফসল পরামর্শ'),
              Tab(text: 'বাজারদর'),
              Tab(text: 'সার/বীজ'),
              Tab(text: 'কৃষি অফিস'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCropAdvice(),
            _buildMarketPrice(),
            _buildFertilizerDealers(),
            _buildAgriOffices(),
          ],
        ),
      ),
    );
  }

  Widget _buildCropAdvice() {
    final crops = [
      CropAdvice(name: 'Rice (Boro)', nameBn: 'ধান (বোরো)', season: 'Winter', seasonBn: 'শীতকাল (নভেম্বর-এপ্রিল)', method: 'বীজতলায় চারা তৈরি করে জমিতে রোপণ করতে হবে। সেচ নিশ্চিত করুন।', fertilizer: 'ইউরিয়া, TSP, MOP', pesticide: 'কার্বোফুরান, কার্টাপ'),
      CropAdvice(name: 'Rice (Aman)', nameBn: 'ধান (আমন)', season: 'Monsoon', seasonBn: 'বর্ষাকাল (জুন-নভেম্বর)', method: 'বর্ষার পানি ব্যবহার করে চাষ করা হয়। জমি ভালোভাবে চাষ দিন।', fertilizer: 'ইউরিয়া, TSP, MOP, জিপসাম', pesticide: 'কার্বেন্ডাজিম'),
      CropAdvice(name: 'Wheat', nameBn: 'গম', season: 'Winter', seasonBn: 'শীতকাল (নভেম্বর-মার্চ)', method: 'শুকনো মৌসুমে চাষ করা হয়। ২-৩ বার সেচ দিন।', fertilizer: 'ইউরিয়া, TSP, MOP', pesticide: 'প্রোপিকোনাজল'),
      CropAdvice(name: 'Jute', nameBn: 'পাট', season: 'Summer', seasonBn: 'গ্রীষ্মকাল (মার্চ-জুলাই)', method: 'উঁচু জমিতে বীজ ছিটিয়ে বপন করুন।', fertilizer: 'ইউরিয়া, TSP', pesticide: 'ম্যালাথিয়ন'),
      CropAdvice(name: 'Potato', nameBn: 'আলু', season: 'Winter', seasonBn: 'শীতকাল (অক্টোবর-ফেব্রুয়ারি)', method: 'বেড তৈরি করে আলুর কাটিং রোপণ করুন। নিয়মিত সেচ দিন।', fertilizer: 'ইউরিয়া, TSP, MOP, জিপসাম, জিংক', pesticide: 'ম্যানকোজেব'),
      CropAdvice(name: 'Vegetables', nameBn: 'শাকসবজি', season: 'All Year', seasonBn: 'সারা বছর', method: 'মৌসুম অনুযায়ী বিভিন্ন সবজি চাষ করা যায়।', fertilizer: 'জৈব সার, ইউরিয়া, TSP', pesticide: 'নিম তেল, জৈব কীটনাশক'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: crops.length,
      itemBuilder: (context, index) {
        final crop = crops[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green.withValues(alpha: 0.1),
              child: const Icon(Icons.grass, color: Colors.green),
            ),
            title: Text(crop.nameBn, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('মৌসুম: ${crop.seasonBn}'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCropDetail('চাষ পদ্ধতি', crop.method),
                    _buildCropDetail('সার', crop.fertilizer),
                    _buildCropDetail('কীটনাশক', crop.pesticide),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCropDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildMarketPrice() {
    final prices = [
      MarketPrice(cropName: 'Rice', cropNameBn: 'ধান (মোটা)', pricePerKg: 28, market: 'জেলা বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Rice Fine', cropNameBn: 'ধান (চিকন)', pricePerKg: 42, market: 'জেলা বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Wheat', cropNameBn: 'গম', pricePerKg: 35, market: 'জেলা বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Potato', cropNameBn: 'আলু', pricePerKg: 25, market: 'জেলা বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Onion', cropNameBn: 'পেঁয়াজ', pricePerKg: 60, market: 'জেলা বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Garlic', cropNameBn: 'রসুন', pricePerKg: 120, market: 'জেলা বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Tomato', cropNameBn: 'টমেটো', pricePerKg: 40, market: 'জেলা বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Lentil', cropNameBn: 'মসুর ডাল', pricePerKg: 110, market: 'জেলা বাজার', date: DateTime.now()),
    ];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: AppColors.primary.withValues(alpha: 0.1),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: AppColors.primary),
              const SizedBox(width: 8),
              Text('তারিখ: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              const Text('জেলা বাজার', style: TextStyle(color: AppColors.primary)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: prices.length,
            itemBuilder: (context, index) {
              final price = prices[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.withValues(alpha: 0.1),
                    child: const Icon(Icons.shopping_basket, color: Colors.orange),
                  ),
                  title: Text(price.cropNameBn, style: const TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Text('৳${price.pricePerKg.toInt()}/কেজি', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFertilizerDealers() {
    final dealers = [
      FertilizerDealer(name: 'আল-আমিন ফার্টিলাইজার', address: 'বাজার রোড, সদর', phone: '01711-800001', licenseNo: 'FD-001', availableFertilizers: ['ইউরিয়া', 'TSP', 'MOP', 'DAP']),
      FertilizerDealer(name: 'গ্রীন এগ্রো', address: 'স্টেশন রোড, সদর', phone: '01711-800002', licenseNo: 'FD-002', availableFertilizers: ['ইউরিয়া', 'TSP', 'জিপসাম', 'জিংক']),
      FertilizerDealer(name: 'কৃষক বন্ধু', address: 'উত্তর বাজার', phone: '01711-800003', licenseNo: 'FD-003', availableFertilizers: ['ইউরিয়া', 'MOP', 'বোরন', 'জৈব সার']),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: dealers.length,
      itemBuilder: (context, index) {
        final dealer = dealers[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: Colors.brown.withValues(alpha: 0.1),
              child: const Icon(Icons.store, color: Colors.brown),
            ),
            title: Text(dealer.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('লাইসেন্স: ${dealer.licenseNo}'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ঠিকানা: ${dealer.address}'),
                    Text('ফোন: ${dealer.phone}'),
                    const SizedBox(height: 8),
                    const Text('সচল সার:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Wrap(spacing: 8, children: dealer.availableFertilizers.map((f) => Chip(label: Text(f, style: const TextStyle(fontSize: 12)))).toList()),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(onPressed: () => Helpers.makePhoneCall(dealer.phone), icon: const Icon(Icons.call), label: const Text('কল করুন')),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAgriOffices() {
    final offices = [
      AgricultureOffice(name: 'জেলা কৃষি সম্প্রসারণ অধিদপ্তর', officerName: 'মোঃ আনোয়ার হোসেন', designation: 'উপ-পরিচালক', phone: '01711-900001', address: 'কৃষি ভবন, সদর', upazila: 'সদর'),
      AgricultureOffice(name: 'উপজেলা কৃষি অফিস (সদর)', officerName: 'মোঃ শামীম আহমেদ', designation: 'উপজেলা কৃষি অফিসার', phone: '01711-900002', address: 'উপজেলা পরিষদ, সদর', upazila: 'সদর'),
      AgricultureOffice(name: 'মৎস্য অফিস', officerName: 'মোঃ জহিরুল ইসলাম', designation: 'জেলা মৎস্য অফিসার', phone: '01711-900003', address: 'মৎস্য ভবন, সদর', upazila: 'সদর'),
      AgricultureOffice(name: 'প্রাণিসম্পদ অফিস', officerName: 'ডাঃ মোঃ রাশেদুল ইসলাম', designation: 'জেলা প্রাণিসম্পদ অফিসার', phone: '01711-900004', address: 'প্রাণিসম্পদ ভবন, সদর', upazila: 'সদর'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: offices.length,
      itemBuilder: (context, index) {
        final office = offices[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: const Icon(Icons.business, color: AppColors.primary),
            ),
            title: Text(office.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${office.designation}: ${office.officerName}'),
                Text(office.address, style: const TextStyle(fontSize: 12)),
              ],
            ),
            trailing: IconButton(icon: const Icon(Icons.call, color: AppColors.success), onPressed: () => Helpers.makePhoneCall(office.phone)),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
