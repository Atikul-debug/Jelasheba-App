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
            _buildCropAdvice(context),
            _buildMarketPrice(context),
            _buildFertilizerDealers(context),
            _buildAgriOffices(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCropAdvice(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final crops = [
      CropAdvice(name: 'Rice (Boro)', nameBn: 'ধান (বোরো)', season: 'Winter', seasonBn: 'শীতকাল (নভেম্বর-এপ্রিল)', method: 'বীজতলায় চারা তৈরি করে জমিতে রোপণ করতে হবে। সেচ নিশ্চিত করুন।', fertilizer: 'ইউরিয়া, TSP, MOP', pesticide: 'কার্বোফুরান, কার্টাপ'),
      CropAdvice(name: 'Rice (Aman)', nameBn: 'ধান (আমন)', season: 'Monsoon', seasonBn: 'বর্ষাকাল (জুন-নভেম্বর)', method: 'বর্ষার পানি ব্যবহার করে চাষ করা হয়। জমি ভালোভাবে চাষ দিন।', fertilizer: 'ইউরিয়া, TSP, MOP, জিপসাম', pesticide: 'কার্বেন্ডাজিম'),
      CropAdvice(name: 'Wheat', nameBn: 'গম', season: 'Winter', seasonBn: 'শীতকাল (নভেম্বর-মার্চ)', method: 'শুকনো মৌসুমে চাষ করা হয়। ২-৩ বার সেচ দিন।', fertilizer: 'ইউরিয়া, TSP, MOP', pesticide: 'প্রোপিকোনাজল'),
      CropAdvice(name: 'Jute', nameBn: 'পাট', season: 'Summer', seasonBn: 'গ্রীষ্মকাল (মার্চ-জুলাই)', method: 'উঁচু জমিতে বীজ ছিটিয়ে বপন করুন।', fertilizer: 'ইউরিয়া, TSP', pesticide: 'ম্যালাথিয়ন'),
      CropAdvice(name: 'Potato', nameBn: 'আলু', season: 'Winter', seasonBn: 'শীতকাল (অক্টোবর-ফেব্রুয়ারি)', method: 'বেড তৈরি করে আলুর কাটিং রোপণ করুন। নিয়মিত সেচ দিন।', fertilizer: 'ইউরিয়া, TSP, MOP, জিপসাম, জিংক', pesticide: 'ম্যানকোজেব'),
      CropAdvice(name: 'Vegetables', nameBn: 'শাকসবজি', season: 'All Year', seasonBn: 'সারা বছর', method: 'মৌসুম অনুযায়ী বিভিন্ন সবজি চাষ করা যায়।', fertilizer: 'জৈব সার, ইউরিয়া, TSP', pesticide: 'নিম তেল, জৈব কীটনাশক'),
    ];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: crops.length,
      itemBuilder: (context, index) {
        final crop = crops[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDark ? [] : AppColors.softShadow,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.grass, color: Colors.green),
              ),
              title: Text(
                crop.nameBn,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              subtitle: Text(
                'মৌসুম: ${crop.seasonBn}',
                style: const TextStyle(fontSize: 13),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCropDetail(context, 'চাষ পদ্ধতি', crop.method),
                      _buildCropDetail(context, 'সার', crop.fertilizer),
                      _buildCropDetail(context, 'কীটনাশক', crop.pesticide),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCropDetail(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary, fontSize: 14),
          ),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(height: 1.4, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildMarketPrice(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final prices = [
      MarketPrice(cropName: 'Rice', cropNameBn: 'ধান (মোটা)', pricePerKg: 28, market: 'সিরাজগঞ্জ বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Rice Fine', cropNameBn: 'ধান (চিকন)', pricePerKg: 42, market: 'সিরাজগঞ্জ বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Wheat', cropNameBn: 'গম', pricePerKg: 35, market: 'সিরাজগঞ্জ বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Potato', cropNameBn: 'আলু', pricePerKg: 25, market: 'সিরাজগঞ্জ বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Onion', cropNameBn: 'পেঁয়াজ', pricePerKg: 60, market: 'সিরাজগঞ্জ বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Garlic', cropNameBn: 'রসুন', pricePerKg: 120, market: 'সিরাজগঞ্জ বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Tomato', cropNameBn: 'টমেটো', pricePerKg: 40, market: 'সিরাজগঞ্জ বাজার', date: DateTime.now()),
      MarketPrice(cropName: 'Lentil', cropNameBn: 'মসুর ডাল', pricePerKg: 110, market: 'সিরাজগঞ্জ বাজার', date: DateTime.now()),
    ];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDark ? [] : AppColors.softShadow,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.calendar_today, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'তারিখ: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              const Spacer(),
              const Text(
                'সিরাজগঞ্জ বাজার',
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: prices.length,
            itemBuilder: (context, index) {
              final price = prices[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isDark ? [] : AppColors.softShadow,
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.shopping_basket, color: Colors.orange),
                  ),
                  title: Text(
                    price.cropNameBn,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  trailing: Text(
                    '৳${price.pricePerKg.toInt()}/কেজি',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFertilizerDealers(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final dealers = [
      FertilizerDealer(name: 'আল-আমিন ফার্টিলাইজার', address: 'বড় বাজার, সিরাজগঞ্জ', phone: '01711-800001', licenseNo: 'FD-001', availableFertilizers: ['ইউরিয়া', 'TSP', 'MOP', 'DAP']),
      FertilizerDealer(name: 'যমুনা এগ্রো', address: 'স্টেশন রোড, সিরাজগঞ্জ', phone: '01711-800002', licenseNo: 'FD-002', availableFertilizers: ['ইউরিয়া', 'TSP', 'জিপসাম', 'জিংক']),
      FertilizerDealer(name: 'কৃষক বন্ধু সিরাজগঞ্জ', address: 'শাহজাদপুর রোড, সিরাজগঞ্জ', phone: '01711-800003', licenseNo: 'FD-003', availableFertilizers: ['ইউরিয়া', 'MOP', 'বোরন', 'জৈব সার']),
    ];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: dealers.length,
      itemBuilder: (context, index) {
        final dealer = dealers[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDark ? [] : AppColors.softShadow,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.brown.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.store, color: Colors.brown),
              ),
              title: Text(
                dealer.name,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              subtitle: Text(
                'লাইসেন্স: ${dealer.licenseNo}',
                style: const TextStyle(fontSize: 13),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ঠিকানা: ${dealer.address}', style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 4),
                      Text('ফোন: ${dealer.phone}', style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 10),
                      const Text(
                        'সচল সার:',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: dealer.availableFertilizers.map((f) => Chip(
                          label: Text(f, style: const TextStyle(fontSize: 12)),
                        )).toList(),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () => Helpers.makePhoneCall(dealer.phone),
                        icon: const Icon(Icons.call),
                        label: const Text('কল করুন'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAgriOffices(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final offices = [
      AgricultureOffice(name: 'সিরাজগঞ্জ জেলা কৃষি সম্প্রসারণ অধিদপ্তর', officerName: 'মোঃ জাহাঙ্গীর আলম', designation: 'উপ-পরিচালক', phone: '0751-62789', address: 'কৃষি ভবন, সিরাজগঞ্জ', upazila: 'সদর'),
      AgricultureOffice(name: 'উপজেলা কৃষি অফিস (সিরাজগঞ্জ সদর)', officerName: 'মোঃ শামীম আহমেদ', designation: 'উপজেলা কৃষি অফিসার', phone: '01711-900002', address: 'উপজেলা পরিষদ, সিরাজগঞ্জ সদর', upazila: 'সদর'),
      AgricultureOffice(name: 'সিরাজগঞ্জ জেলা মৎস্য অফিস', officerName: 'মোঃ জহিরুল ইসলাম', designation: 'জেলা মৎস্য অফিসার', phone: '01711-900003', address: 'মৎস্য ভবন, সিরাজগঞ্জ', upazila: 'সদর'),
      AgricultureOffice(name: 'সিরাজগঞ্জ প্রাণিসম্পদ অফিস', officerName: 'ডাঃ মোঃ রাশেদুল ইসলাম', designation: 'জেলা প্রাণিসম্পদ অফিসার', phone: '01711-900004', address: 'প্রাণিসম্পদ ভবন, সিরাজগঞ্জ', upazila: 'সদর'),
    ];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: offices.length,
      itemBuilder: (context, index) {
        final office = offices[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDark ? [] : AppColors.softShadow,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.business, color: AppColors.primary),
            ),
            title: Text(
              office.name,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  '${office.designation}: ${office.officerName}',
                  style: const TextStyle(fontSize: 13),
                ),
                Text(
                  office.address,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.call, color: AppColors.success),
                onPressed: () => Helpers.makePhoneCall(office.phone),
              ),
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
