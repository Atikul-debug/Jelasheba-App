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
      // ১. বোরো ধান - সিরাজগঞ্জের প্রধান ফসল
      CropAdvice(name: 'Rice (Boro)', nameBn: 'বোরো ধান', season: 'Winter', seasonBn: 'রবি মৌসুম (নভেম্বর - মে)',
        method: '📅 বীজতলা: কার্তিক-অগ্রহায়ণ (নভেম্বর-ডিসেম্বর)\n📅 রোপণ: পৌষ-মাঘ (জানুয়ারি-ফেব্রুয়ারি)\n📅 কর্তন: বৈশাখ-জ্যৈষ্ঠ (এপ্রিল-মে)\n\nসিরাজগঞ্জে যমুনার পলিমাটিতে বোরো ধানের ফলন ভালো হয়। হাইব্রিড জাত (ব্রি ধান-২৮, ২৯, ৫০, ৮৯) ব্যবহার করুন। ৩০ দিনের চারা ১৫x২০ সেমি দূরত্বে রোপণ করুন।',
        fertilizer: '🟢 জমি তৈরিতে: TSP ১০০ কেজি/হেক্টর + MOP ৭০ কেজি/হেক্টর + জিপসাম ৬০ কেজি/হেক্টর + জিংক সালফেট ১০ কেজি/হেক্টর (শেষ চাষে)\n🟡 ১ম কিস্তি ইউরিয়া: রোপণের ১৫ দিন পর - ৮০ কেজি/হেক্টর\n🟡 ২য় কিস্তি ইউরিয়া: কুশি স্তরে (৩০-৩৫ দিন) - ৮০ কেজি/হেক্টর\n🟡 ৩য় কিস্তি ইউরিয়া: থোড় আসার ৫-৭ দিন আগে - ৭০ কেজি/হেক্টর',
        pesticide: '🐛 মাজরা পোকা: কার্টাপ (সানটাপ) ৫০ SP - ২ গ্রাম/লিটার\n🐛 পাতা পোড়া: ট্রাইসাইক্লাজল - ০.৭৫ গ্রাম/লিটার\n🐛 ব্লাস্ট রোগ: ট্রাইসাইক্লাজল বা কার্বেন্ডাজিম\n🐛 বাদামী গাছ ফড়িং: ইমিডাক্লোপ্রিড'),

      // ২. আমন ধান
      CropAdvice(name: 'Rice (Aman)', nameBn: 'আমন ধান (রোপা)', season: 'Monsoon', seasonBn: 'খরিফ-২ মৌসুম (জুলাই - ডিসেম্বর)',
        method: '📅 বীজতলা: আষাঢ় (জুন-জুলাই)\n📅 রোপণ: শ্রাবণ-ভাদ্র (জুলাই-আগস্ট)\n📅 কর্তন: অগ্রহায়ণ-পৌষ (নভেম্বর-ডিসেম্বর)\n\nসিরাজগঞ্জের নিচু জমি ও চরাঞ্চলে আমন ধান ভালো হয়। জাত: ব্রি ধান-৪৯, ৫২, ৭১, ৭৫। বন্যায় তলিয়ে গেলে পানি নেমে যাওয়ার পর নাবী আমন রোপণ করুন।',
        fertilizer: '🟢 জমি তৈরিতে: TSP ৬০ কেজি + MOP ৪০ কেজি + জিপসাম ৪৫ কেজি/হেক্টর\n🟡 ১ম কিস্তি ইউরিয়া: রোপণের ১৫ দিন পর - ৫০ কেজি/হেক্টর\n🟡 ২য় কিস্তি ইউরিয়া: কুশি স্তরে - ৫০ কেজি/হেক্টর\n🟡 ৩য় কিস্তি ইউরিয়া: থোড় আসার আগে - ৫০ কেজি/হেক্টর',
        pesticide: '🐛 মাজরা পোকা: ভার্চুয়াল ৪০ EC - ১ মিলি/লিটার\n🐛 পাতামোড়া পোকা: কার্টাপ ৫০ SP\n🐛 গলা পচা: কার্বেন্ডাজিম - ১ গ্রাম/লিটার\n🐛 টুংরো ভাইরাস: আক্রান্ত গাছ তুলে ফেলুন'),

      // ৩. গম
      CropAdvice(name: 'Wheat', nameBn: 'গম', season: 'Winter', seasonBn: 'রবি মৌসুম (নভেম্বর - মার্চ)',
        method: '📅 বপন: কার্তিক-অগ্রহায়ণ (নভেম্বর ১৫ - ডিসেম্বর ১)\n📅 কর্তন: চৈত্র (মার্চ-এপ্রিল)\n\nসিরাজগঞ্জের দোআঁশ মাটিতে গম ভালো ফলে। জাত: বারি গম-২৬, ২৮, ৩০, ৩৩। বীজ হার: ১২০ কেজি/হেক্টর। সেচ ৩ বার: চারা গজানোর ১৭-২১ দিন পর (মুকুট মূল), ৫০-৫৫ দিনে (শীষ বের হওয়ার সময়), ৭৫-৮০ দিনে (দানা পুষ্ট হওয়ার সময়)।',
        fertilizer: '🟢 শেষ চাষে: TSP ১৮০ কেজি + MOP ৫০ কেজি + জিপসাম ১২০ কেজি + বোরন ৭ কেজি/হেক্টর\n🟡 ইউরিয়া ১ম কিস্তি: বপনের ১৭-২১ দিনে (১ম সেচের পর) - ১০০ কেজি/হেক্টর\n🟡 ইউরিয়া ২য় কিস্তি: বপনের ৫০-৫৫ দিনে (২য় সেচের পর) - ১০০ কেজি/হেক্টর',
        pesticide: '🐛 পাতার দাগ রোগ: প্রোপিকোনাজল (টিল্ট ২৫০ EC) - ০.৫ মিলি/লিটার\n🐛 মরিচা রোগ: প্রোপিকোনাজল\n🐛 জাবপোকা: ইমিডাক্লোপ্রিড - ০.৫ মিলি/লিটার'),

      // ৪. পাট - সিরাজগঞ্জের ঐতিহ্যবাহী ফসল
      CropAdvice(name: 'Jute', nameBn: 'পাট (তোষা ও দেশি)', season: 'Summer', seasonBn: 'খরিফ-১ মৌসুম (মার্চ - আগস্ট)',
        method: '📅 বপন: ফাল্গুন-চৈত্র (মার্চ-এপ্রিল)\n📅 কর্তন: শ্রাবণ-ভাদ্র (জুলাই-আগস্ট)\n\nসিরাজগঞ্জ বাংলাদেশের অন্যতম পাট উৎপাদনকারী জেলা। যমুনার পলিমাটি পাটের জন্য আদর্শ। তোষা পাটে ফলন বেশি। বীজ হার: ৭-৮ কেজি/হেক্টর। সারিতে বপন করলে ফলন ও মান ভালো হয়। জাগ দিয়ে পচানোর জন্য পরিষ্কার পানি ব্যবহার করুন।',
        fertilizer: '🟢 শেষ চাষে: TSP ৫০ কেজি + MOP ৩০ কেজি/হেক্টর\n🟡 ইউরিয়া ১ম কিস্তি: বপনের ১৫-২০ দিনে (১ম নিড়ানির পর) - ৫০ কেজি/হেক্টর\n🟡 ইউরিয়া ২য় কিস্তি: বপনের ৪০-৪৫ দিনে - ৫০ কেজি/হেক্টর',
        pesticide: '🐛 ঘোড়া পোকা: সাইপারমেথ্রিন - ১ মিলি/লিটার\n🐛 বিছা পোকা: ক্লোরপাইরিফস ২০ EC\n🐛 কাণ্ড পচা: কার্বেন্ডাজিম স্প্রে'),

      // ৫. সরিষা
      CropAdvice(name: 'Mustard', nameBn: 'সরিষা', season: 'Winter', seasonBn: 'রবি মৌসুম (অক্টোবর - ফেব্রুয়ারি)',
        method: '📅 বপন: আশ্বিন-কার্তিক (অক্টোবর-নভেম্বর)\n📅 কর্তন: মাঘ-ফাল্গুন (ফেব্রুয়ারি)\n\nসিরাজগঞ্জের তাড়াশ, রায়গঞ্জ ও উল্লাপাড়ায় সরিষা বেশি চাষ হয়। জাত: বারি সরিষা-১৪, ১৫, ১৭। বীজ হার: ৮-১০ কেজি/হেক্টর। ছিটিয়ে বা সারিতে বপন করা যায়। ১ বার সেচ দিলে ফলন অনেক বাড়ে।',
        fertilizer: '🟢 শেষ চাষে: TSP ১৭০ কেজি + MOP ৫০ কেজি + জিপসাম ১৫০ কেজি + বোরন ৭ কেজি + জিংক ৫ কেজি/হেক্টর\n🟡 ইউরিয়া: বপনের ২৫-৩০ দিনে (ফুল আসার আগে) - ১৫০ কেজি/হেক্টর (একবারে)',
        pesticide: '🐛 জাবপোকা: ইমিডাক্লোপ্রিড বা ম্যালাথিয়ন ৫৭ EC - ২ মিলি/লিটার\n🐛 অলটারনারিয়া ব্লাইট: রোভরাল ৫০ WP - ২ গ্রাম/লিটার\n🐛 সাদা মরিচা: মেটালক্সিল + ম্যানকোজেব'),

      // ৬. আলু
      CropAdvice(name: 'Potato', nameBn: 'আলু', season: 'Winter', seasonBn: 'রবি মৌসুম (নভেম্বর - মার্চ)',
        method: '📅 রোপণ: কার্তিক-অগ্রহায়ণ (নভেম্বর)\n📅 তোলা: মাঘ-ফাল্গুন (ফেব্রুয়ারি-মার্চ)\n\nসিরাজগঞ্জের বেলে-দোআঁশ মাটিতে আলু ভালো হয়। জাত: ডায়মন্ড, কার্ডিনাল, এস্টারিক্স। বীজ আলু ২০-৩০ গ্রাম ওজনের কাটিং। সারি-সারি ৬০ সেমি ও বীজ থেকে বীজ ২৫ সেমি দূরত্বে রোপণ। মাটি উঠানো (earthing up) গুরুত্বপূর্ণ।',
        fertilizer: '🟢 জমি তৈরিতে: গোবর সার ১০ টন + TSP ১৫০ কেজি + MOP ১৫০ কেজি + জিপসাম ১০০ কেজি + জিংক ১০ কেজি + বোরন ৭ কেজি/হেক্টর\n🟡 ইউরিয়া: ১৫০ কেজি/হেক্টর - ২ ভাগে ভাগ করুন\n🟡 ১ম কিস্তি: রোপণের ৩০ দিন পর (মাটি উঠানোর সময়) - ৭৫ কেজি\n🟡 ২য় কিস্তি: রোপণের ৫০ দিন পর - ৭৫ কেজি',
        pesticide: '🐛 মড়ক রোগ (Late Blight): ম্যানকোজেব ৮০ WP - ২.৫ গ্রাম/লিটার (প্রতি ৭ দিন পর)\n🐛 আগাম মড়ক: ক্লোরোথ্যালোনিল\n🐛 কাটুই পোকা: ক্লোরপাইরিফস মাটিতে প্রয়োগ'),

      // ৭. ভুট্টা
      CropAdvice(name: 'Maize', nameBn: 'ভুট্টা', season: 'Winter', seasonBn: 'রবি মৌসুম (অক্টোবর - এপ্রিল)',
        method: '📅 বপন: কার্তিক (অক্টোবর-নভেম্বর)\n📅 কর্তন: ফাল্গুন-চৈত্র (মার্চ-এপ্রিল)\n\nসিরাজগঞ্জের কাজীপুর ও চৌহালীতে ভুট্টা চাষ বাড়ছে। হাইব্রিড জাত: এনকে-৪০, প্যাসিফিক-৯৮৪, কহিনুর। সারিতে ৭৫x২৫ সেমি দূরত্বে বীজ বপন। ৩-৪ বার সেচ দরকার।',
        fertilizer: '🟢 শেষ চাষে: TSP ২২০ কেজি + MOP ১২০ কেজি + জিপসাম ২০০ কেজি + জিংক ১০ কেজি + বোরন ৭ কেজি/হেক্টর\n🟡 ইউরিয়া ১ম কিস্তি: বপনের ২০-২৫ দিনে (হাঁটু উচ্চতায়) - ১৭০ কেজি\n🟡 ইউরিয়া ২য় কিস্তি: বপনের ৪০-৫০ দিনে (ফুল আসার আগে) - ১৭০ কেজি',
        pesticide: '🐛 মাজরা পোকা: কার্বোফুরান দানা গোড়ায় প্রয়োগ\n🐛 পাতা ব্লাইট: ম্যানকোজেব স্প্রে\n🐛 ফল আর্মিওয়ার্ম: এমামেক্টিন বেনজোয়েট'),

      // ৮. পেঁয়াজ
      CropAdvice(name: 'Onion', nameBn: 'পেঁয়াজ', season: 'Winter', seasonBn: 'রবি মৌসুম (নভেম্বর - মার্চ)',
        method: '📅 চারা তৈরি: কার্তিক (অক্টোবর-নভেম্বর)\n📅 রোপণ: অগ্রহায়ণ-পৌষ (ডিসেম্বর)\n📅 তোলা: ফাল্গুন-চৈত্র (মার্চ)\n\nসিরাজগঞ্জের শাহজাদপুর ও বেলকুচিতে পেঁয়াজ চাষ জনপ্রিয়। জাত: তাহেরপুরী, বারি পেঁয়াজ-১, ৪। চারা ৪০-৪৫ দিন বয়সে রোপণ। ১৫x১০ সেমি দূরত্বে। নিয়মিত সেচ ও আগাছা দমন করুন।',
        fertilizer: '🟢 জমি তৈরিতে: গোবর ৫ টন + TSP ১৮০ কেজি + MOP ১৫০ কেজি + জিপসাম ১১০ কেজি + জিংক ৫ কেজি/হেক্টর\n🟡 ইউরিয়া ১ম কিস্তি: রোপণের ২৫ দিন পর - ৯০ কেজি/হেক্টর\n🟡 ইউরিয়া ২য় কিস্তি: রোপণের ৫০ দিন পর - ৯০ কেজি/হেক্টর',
        pesticide: '🐛 পার্পল ব্লচ: রোভরাল ৫০ WP - ২ গ্রাম/লিটার\n🐛 থ্রিপস: ইমিডাক্লোপ্রিড - ০.৫ মিলি/লিটার\n🐛 গোড়া পচা: কার্বেন্ডাজিম - ১.৫ গ্রাম/লিটার'),

      // ৯. রসুন
      CropAdvice(name: 'Garlic', nameBn: 'রসুন', season: 'Winter', seasonBn: 'রবি মৌসুম (অক্টোবর - মার্চ)',
        method: '📅 রোপণ: কার্তিক-অগ্রহায়ণ (অক্টোবর-নভেম্বর)\n📅 তোলা: ফাল্গুন-চৈত্র (মার্চ)\n\nসিরাজগঞ্জে রসুন চাষ লাভজনক। জাত: বারি রসুন-১, ২। কোয়া আলাদা করে ১৫x১০ সেমি দূরত্বে রোপণ। ৫-৭ দিন পর পর সেচ। পাতা হলুদ হলে তোলার সময়।',
        fertilizer: '🟢 শেষ চাষে: গোবর ৫ টন + TSP ১৩০ কেজি + MOP ১০০ কেজি + জিপসাম ১০০ কেজি + জিংক ৫ কেজি + বোরন ৫ কেজি/হেক্টর\n🟡 ইউরিয়া ১ম কিস্তি: রোপণের ২৫ দিন পর - ৭৫ কেজি\n🟡 ইউরিয়া ২য় কিস্তি: রোপণের ৫০ দিন পর - ৭৫ কেজি',
        pesticide: '🐛 পার্পল ব্লচ: রোভরাল ৫০ WP\n🐛 থ্রিপস: সাকসেস ২.৫ SC\n🐛 সাদা পচা: কার্বেন্ডাজিম মাটিতে প্রয়োগ'),

      // ১০. মরিচ
      CropAdvice(name: 'Chili', nameBn: 'মরিচ', season: 'Winter', seasonBn: 'রবি মৌসুম (সেপ্টেম্বর - মার্চ)',
        method: '📅 চারা তৈরি: ভাদ্র-আশ্বিন (সেপ্টেম্বর)\n📅 রোপণ: আশ্বিন-কার্তিক (অক্টোবর-নভেম্বর)\n📅 তোলা: মাঘ-চৈত্র (ফেব্রুয়ারি-মার্চ, একাধিকবার)\n\nসিরাজগঞ্জে কাঁচা ও শুকনো উভয় মরিচ চাষ হয়। জাত: বারি মরিচ-১, ২, বিজলী। ৬০x৪০ সেমি দূরত্বে রোপণ।',
        fertilizer: '🟢 জমি তৈরিতে: গোবর ৫ টন + TSP ২৫০ কেজি + MOP ১৫০ কেজি + জিপসাম ১১০ কেজি + জিংক ৫ কেজি + বোরন ৫ কেজি/হেক্টর\n🟡 ইউরিয়া: ৩ কিস্তিতে - রোপণের ১৫, ৩৫ ও ৫৫ দিন পর - প্রতিবার ৭৫ কেজি',
        pesticide: '🐛 থ্রিপস/জাবপোকা: ইমিডাক্লোপ্রিড - ০.৫ মিলি/লিটার\n🐛 অ্যানথ্রাকনোজ: ম্যানকোজেব + কার্বেন্ডাজিম\n🐛 ফল পচা: কপার অক্সিক্লোরাইড'),

      // ১১. মসুর ডাল
      CropAdvice(name: 'Lentil', nameBn: 'মসুর ডাল', season: 'Winter', seasonBn: 'রবি মৌসুম (অক্টোবর - মার্চ)',
        method: '📅 বপন: কার্তিক (অক্টোবর শেষ - নভেম্বর মাঝামাঝি)\n📅 কর্তন: ফাল্গুন-চৈত্র (মার্চ)\n\nসিরাজগঞ্জের তাড়াশ ও রায়গঞ্জে মসুর চাষ বেশি। জাত: বারি মসুর-৬, ৭, ৮। বীজ হার: ৩০-৩৫ কেজি/হেক্টর। সেচ ছাড়াই চাষ সম্ভব তবে ১ বার সেচ দিলে ফলন ২০% বাড়ে।',
        fertilizer: '🟢 শেষ চাষে: TSP ৮০ কেজি + MOP ৩০ কেজি + বোরন ৫ কেজি/হেক্টর (ইউরিয়া লাগে না, ডাল জাতীয় ফসল নিজে নাইট্রোজেন তৈরি করে)\n⚠️ ইউরিয়া: দরকার নেই (রাইজোবিয়াম ব্যাকটেরিয়া নাইট্রোজেন সংবন্ধন করে)',
        pesticide: '🐛 মরিচা রোগ: ম্যানকোজেব - ২.৫ গ্রাম/লিটার\n🐛 জাবপোকা: ইমিডাক্লোপ্রিড\n🐛 উইল্ট: কার্বেন্ডাজিম দিয়ে বীজ শোধন'),

      // ১২. শাকসবজি (শীতকালীন)
      CropAdvice(name: 'Winter Vegetables', nameBn: 'শীতকালীন সবজি (ফুলকপি, বাঁধাকপি, টমেটো, বেগুন, লাউ, শিম)', season: 'Winter', seasonBn: 'রবি মৌসুম (অক্টোবর - মার্চ)',
        method: '📅 চারা তৈরি: আশ্বিন-কার্তিক\n📅 রোপণ: কার্তিক-অগ্রহায়ণ\n\nসিরাজগঞ্জের চরাঞ্চলে (কাজীপুর, চৌহালী) শীতকালীন সবজি প্রচুর হয়। ফুলকপি/বাঁধাকপি: ৬০x৪৫ সেমি, টমেটো: ৬০x৪০ সেমি। জৈব সার বেশি ব্যবহার করলে মান ভালো হয়।',
        fertilizer: '🟢 জমি তৈরিতে: গোবর ১০ টন + TSP ১৫০-২৫০ কেজি + MOP ১০০-১৫০ কেজি + জিপসাম ১০০ কেজি + বোরন ৫-৭ কেজি/হেক্টর\n🟡 ইউরিয়া: ১৫০-২৫০ কেজি/হেক্টর - ৩ কিস্তিতে (রোপণের ১৫, ৩০ ও ৫০ দিন পর)',
        pesticide: '🐛 জাবপোকা/সাদা মাছি: ইমিডাক্লোপ্রিড\n🐛 ফল ছিদ্রকারী পোকা: এমামেক্টিন বেনজোয়েট\n🐛 ব্লাইট: ম্যানকোজেব\n✅ নিরাপদ সবজি: নিম তেল ও ফেরোমন ট্র্যাপ ব্যবহার করুন'),

      // ১৩. গ্রীষ্মকালীন সবজি
      CropAdvice(name: 'Summer Vegetables', nameBn: 'গ্রীষ্মকালীন সবজি (করলা, পটল, ঝিঙ্গা, চিচিঙ্গা, ধুন্দুল)', season: 'Summer', seasonBn: 'খরিফ-১ মৌসুম (মার্চ - জুন)',
        method: '📅 বপন/রোপণ: ফাল্গুন-চৈত্র (ফেব্রুয়ারি-মার্চ)\n📅 তোলা: বৈশাখ-আষাঢ় (এপ্রিল-জুন)\n\nসিরাজগঞ্জে গ্রীষ্মে লতানো সবজি ভালো হয়। মাচা তৈরি করে চাষ করুন। নিয়মিত সেচ দিন।',
        fertilizer: '🟢 মাদায়: গোবর ৫ কেজি + TSP ১০০ গ্রাম + MOP ৮০ গ্রাম/মাদা\n🟡 ইউরিয়া: প্রতি ১৫ দিন পর পর মাদায় ৫০ গ্রাম করে',
        pesticide: '🐛 ফল মাছি: ফেরোমন ট্র্যাপ ব্যবহার করুন\n🐛 পাউডারি মিলডিউ: থিওভিট ৮০ WG\n🐛 এফিড: সাবান পানি বা নিম তেল স্প্রে'),

      // ১৪. আখ
      CropAdvice(name: 'Sugarcane', nameBn: 'আখ', season: 'Year Round', seasonBn: 'সারা বছর (রোপণ: অক্টোবর-মার্চ)',
        method: '📅 রোপণ: কার্তিক-ফাল্গুন (অক্টোবর-মার্চ)\n📅 কর্তন: ১০-১২ মাস পর\n\nসিরাজগঞ্জে আখ গুড় তৈরিতে ব্যবহার হয়। জাত: ঈশ্বরদী-৩৯, ৪০। টুকরা ২-৩ চোখ বিশিষ্ট। নালা পদ্ধতিতে রোপণ। মাটি বারবার উঠিয়ে দিন।',
        fertilizer: '🟢 নালায়: গোবর ১০ টন + TSP ১৫০ কেজি + MOP ১২০ কেজি + জিপসাম ১০০ কেজি/হেক্টর\n🟡 ইউরিয়া: ৩০০ কেজি/হেক্টর - ৩ কিস্তিতে (রোপণের ৩০, ৯০ ও ১৫০ দিন পর ১০০ কেজি করে)',
        pesticide: '🐛 মাজরা পোকা: কার্বোফুরান দানা গোড়ায়\n🐛 রেড রট: আক্রান্ত গাছ তুলে পুড়িয়ে ফেলুন\n🐛 সাদা মাছি: ইমিডাক্লোপ্রিড'),
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
