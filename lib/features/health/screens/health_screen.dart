import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../models/health_model.dart';
import '../../../features/emergency/models/emergency_model.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  String _searchQuery = '';
  String _selectedBloodGroup = 'সব';
  String _hospitalFilter = 'সব';

  final List<Hospital> _hospitals = [
    // ===== সরকারি হাসপাতাল =====
    Hospital(id: '1', name: 'Sheikh Fazilatunnessa Mujib General Hospital', nameBn: 'বঙ্গমাতা শেখ ফজিলাতুন্নেছা মুজিব ২৫০ শয্যা জেনারেল হাসপাতাল', type: 'government', address: 'সদর হাসপাতাল রোড, সিরাজগঞ্জ সদর, সিরাজগঞ্জ-৬৭০০', phone: '01711-480448', bedCount: 250, hasEmergency: true, departments: ['মেডিসিন', 'সার্জারি', 'গাইনি ও প্রসূতি', 'শিশু', 'অর্থোপেডিক', 'চক্ষু', 'নাক-কান-গলা', 'চর্ম ও যৌন', 'মানসিক', 'দন্ত', 'ফিজিওথেরাপি', 'প্যাথলজি', 'রেডিওলজি', 'এনেসথেসিওলজি'], latitude: 24.4534, longitude: 89.7003, doctorCount: 70),
    Hospital(id: '2', name: 'Shahzadpur UHC', nameBn: 'শাহজাদপুর উপজেলা স্বাস্থ্য কমপ্লেক্স', type: 'government', address: 'শাহজাদপুর, সিরাজগঞ্জ', phone: '07524-56231', bedCount: 50, hasEmergency: true, departments: ['মেডিসিন', 'সার্জারি', 'গাইনি ও প্রসূতি', 'শিশু', 'দন্ত'], latitude: 24.1833, doctorCount: 12, longitude: 89.5917),
    Hospital(id: '3', name: 'Ullapara UHC', nameBn: 'উল্লাপাড়া উপজেলা স্বাস্থ্য কমপ্লেক্স', type: 'government', address: 'উল্লাপাড়া, সিরাজগঞ্জ', phone: '07525-56124', bedCount: 50, hasEmergency: true, departments: ['মেডিসিন', 'সার্জারি', 'গাইনি ও প্রসূতি', 'শিশু'], latitude: 24.3167, longitude: 89.5500, doctorCount: 12),
    Hospital(id: '4', name: 'Kazipur UHC', nameBn: 'কাজীপুর উপজেলা স্বাস্থ্য কমপ্লেক্স', type: 'government', address: 'কাজীপুর, সিরাজগঞ্জ', phone: '07527-56012', bedCount: 31, hasEmergency: true, departments: ['মেডিসিন', 'গাইনি ও প্রসূতি', 'শিশু'], latitude: 24.6333, longitude: 89.6167, doctorCount: 8),
    Hospital(id: '5', name: 'Belkuchi UHC', nameBn: 'বেলকুচি উপজেলা স্বাস্থ্য কমপ্লেক্স', type: 'government', address: 'বেলকুচি, সিরাজগঞ্জ', phone: '07526-56087', bedCount: 31, hasEmergency: true, departments: ['মেডিসিন', 'গাইনি ও প্রসূতি'], latitude: 24.3700, longitude: 89.6800, doctorCount: 8),
    Hospital(id: '6', name: 'Tarash UHC', nameBn: 'তাড়াশ উপজেলা স্বাস্থ্য কমপ্লেক্স', type: 'government', address: 'তাড়াশ, সিরাজগঞ্জ', phone: '07528-56034', bedCount: 31, hasEmergency: true, departments: ['মেডিসিন', 'গাইনি ও প্রসূতি'], latitude: 24.2600, longitude: 89.4600, doctorCount: 8),
    Hospital(id: '7', name: 'Kamarkhanda UHC', nameBn: 'কামারখন্দ উপজেলা স্বাস্থ্য কমপ্লেক্স', type: 'government', address: 'কামারখন্দ, সিরাজগঞ্জ', phone: '07529-56045', bedCount: 31, hasEmergency: true, departments: ['মেডিসিন', 'গাইনি ও প্রসূতি'], latitude: 24.3500, longitude: 89.5833, doctorCount: 8),
    Hospital(id: '8', name: 'Raiganj UHC', nameBn: 'রায়গঞ্জ উপজেলা স্বাস্থ্য কমপ্লেক্স', type: 'government', address: 'রায়গঞ্জ, সিরাজগঞ্জ', phone: '07523-56078', bedCount: 31, hasEmergency: true, departments: ['মেডিসিন', 'গাইনি ও প্রসূতি'], latitude: 24.2700, longitude: 89.5200, doctorCount: 8),
    Hospital(id: '9', name: 'Chauhali UHC', nameBn: 'চৌহালী উপজেলা স্বাস্থ্য কমপ্লেক্স', type: 'government', address: 'চৌহালী, সিরাজগঞ্জ', phone: '07522-56056', bedCount: 20, hasEmergency: true, departments: ['মেডিসিন', 'গাইনি ও প্রসূতি'], latitude: 24.3833, longitude: 89.7500, doctorCount: 6),
    Hospital(id: '10', name: 'MCWC Sirajganj', nameBn: 'মা ও শিশু কল্যাণ কেন্দ্র, সিরাজগঞ্জ', type: 'government', address: 'সিরাজগঞ্জ সদর', phone: '0751-62456', bedCount: 20, hasEmergency: false, departments: ['গাইনি ও প্রসূতি', 'শিশু', 'পরিবার পরিকল্পনা'], latitude: 24.4530, longitude: 89.7010, doctorCount: 5),
    Hospital(id: '11', name: 'Sirajganj Eye Hospital', nameBn: 'সিরাজগঞ্জ চক্ষু হাসপাতাল', type: 'government', address: 'হায়দার কমপ্লেক্স, রেলগেট, সিরাজগঞ্জ সদর', phone: '01711-181858', bedCount: 20, hasEmergency: false, departments: ['চক্ষু চিকিৎসা', 'চক্ষু সার্জারি'], latitude: 24.4538, longitude: 89.6998, doctorCount: 4),
    // ===== বেসরকারি হাসপাতাল =====
    Hospital(id: '12', name: 'Khwaja Yunus Ali Medical College Hospital', nameBn: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', type: 'private', address: 'এনায়েতপুর, সিরাজগঞ্জ-৬৭৫১', phone: '01716-291681', bedCount: 586, hasEmergency: true, departments: ['মেডিসিন', 'সার্জারি', 'গাইনি ও প্রসূতি', 'শিশু', 'অর্থোপেডিক', 'কার্ডিওলজি', 'নিউরোলজি', 'নিউরোসার্জারি', 'ইউরোলজি', 'নেফ্রোলজি', 'চক্ষু', 'নাক-কান-গলা', 'ডেন্টাল', 'চর্ম', 'ক্যান্সার চিকিৎসা', 'ICU', 'CCU', 'NICU', 'ডায়ালাইসিস', 'ফিজিওথেরাপি', 'রেডিওলজি', 'প্যাথলজি'], latitude: 24.3520, longitude: 89.6840, doctorCount: 120),
    Hospital(id: '13', name: 'Shaheed M. Monsur Ali Medical College Hospital', nameBn: 'শহীদ এম মনসুর আলী মেডিকেল কলেজ হাসপাতাল', type: 'private', address: 'সিরাজগঞ্জ সদর, সিরাজগঞ্জ', phone: '01556-776540', bedCount: 250, hasEmergency: true, departments: ['মেডিসিন', 'সার্জারি', 'গাইনি ও প্রসূতি', 'শিশু', 'অর্থোপেডিক', 'কার্ডিওলজি', 'নিউরোলজি', 'চক্ষু', 'নাক-কান-গলা', 'ICU'], latitude: 24.4545, longitude: 89.7010, doctorCount: 69),
    Hospital(id: '14', name: 'North Bengal Medical College Hospital', nameBn: 'নর্থ বেঙ্গল মেডিকেল কলেজ ও হাসপাতাল', type: 'private', address: 'জে সি রোড, ধানবান্দি, সিরাজগঞ্জ-৬৭০০', phone: '0751-62633', bedCount: 200, hasEmergency: true, departments: ['কার্ডিওলজি', 'অর্থোপেডিক', 'শিশু ও নবজাতক', 'গাইনি ও প্রসূতি', 'নাক-কান-গলা', 'ডেন্টাল', 'মেডিসিন', 'ডায়াবেটিস'], latitude: 24.4550, longitude: 89.6980, doctorCount: 17),
    Hospital(id: '15', name: 'Avicenna Hospital Ltd.', nameBn: 'আভিসিনা হাসপাতাল লিমিটেড', type: 'private', address: 'মুজিব রোড, বড় গোলপট্টি, সিরাজগঞ্জ', phone: '01711-333301', bedCount: 100, hasEmergency: true, departments: ['মেডিসিন', 'সার্জারি', 'গাইনি ও প্রসূতি', 'কার্ডিওলজি', 'বক্ষব্যাধি', 'প্লাস্টিক সার্জারি'], latitude: 24.4525, longitude: 89.6985, doctorCount: 12),
    Hospital(id: '16', name: 'Sirajganj Community Hospital', nameBn: 'সিরাজগঞ্জ কমিউনিটি হাসপাতাল', type: 'private', address: 'মুজিব রোড, সিরাজগঞ্জ', phone: '01717-821697', bedCount: 50, hasEmergency: true, departments: ['মেডিসিন', 'সার্জারি', 'গাইনি ও প্রসূতি', 'শিশু'], latitude: 24.4528, longitude: 89.6990, doctorCount: 10),
    Hospital(id: '17', name: 'Medinova Hospital Complex', nameBn: 'মেডিনোভা হাসপাতাল কমপ্লেক্স', type: 'private', address: 'দরগাহ রোড, সিরাজগঞ্জ', phone: '01751-627300', bedCount: 50, hasEmergency: false, departments: ['মেডিসিন', 'সার্জারি', 'গাইনি ও প্রসূতি', 'ডায়াগনস্টিক'], latitude: 24.4530, longitude: 89.6975, doctorCount: 8),
    Hospital(id: '18', name: 'Prime Hospital', nameBn: 'প্রাইম হাসপাতাল', type: 'private', address: 'সিরাজগঞ্জ সদর', phone: '01739-686676', bedCount: 30, hasEmergency: false, departments: ['মেডিসিন', 'গাইনি ও প্রসূতি'], latitude: 24.4535, longitude: 89.7005, doctorCount: 5),
    Hospital(id: '19', name: 'Unique Hospital & Diagnostic', nameBn: 'ইউনিক হাসপাতাল ও ডায়াগনস্টিক সেন্টার', type: 'private', address: 'এম এ মতিন রোড, সিরাজগঞ্জ', phone: '01716-266352', bedCount: 30, hasEmergency: false, departments: ['মেডিসিন', 'গাইনি ও প্রসূতি', 'ডায়াগনস্টিক'], latitude: 24.4520, longitude: 89.7015, doctorCount: 6),
    Hospital(id: '20', name: 'Sheba General Hospital Ullapara', nameBn: 'শেবা জেনারেল হাসপাতাল, উল্লাপাড়া', type: 'private', address: 'এস এন কমপ্লেক্স, উল্লাপাড়া, সিরাজগঞ্জ', phone: '01730-190759', bedCount: 30, hasEmergency: true, departments: ['মেডিসিন', 'গাইনি ও প্রসূতি', 'শিশু'], latitude: 24.3170, longitude: 89.5505, doctorCount: 5),
    Hospital(id: '21', name: 'Health Care Hospital Hatikumrul', nameBn: 'হেলথ কেয়ার হাসপাতাল, হাটিকুমরুল', type: 'private', address: 'সিরাজগঞ্জ রোড, হাটিকুমরুল', phone: '01723-805642', bedCount: 25, hasEmergency: false, departments: ['মেডিসিন', 'গাইনি ও প্রসূতি'], latitude: 24.3500, longitude: 89.5840, doctorCount: 4),
  ];

  final List<Doctor> _doctors = [
    // সিরাজগঞ্জ ২৫০ শয্যা জেলা সদর হাসপাতাল
    Doctor(id: '1', name: 'Dr. Md. Abdul Mojid', nameBn: 'ডাঃ মোঃ আব্দুল মজিদ', specialty: 'Medicine', specialtyBn: 'সিভিল সার্জন, মেডিসিন', qualification: 'MBBS, FCPS (Medicine)', hospital: 'সিরাজগঞ্জ ২৫০ শয্যা জেলা সদর হাসপাতাল', chamber: 'সদর হাসপাতাল, সিরাজগঞ্জ', phone: '01711-400001', visitingHours: 'সকাল ৮টা - দুপুর ২টা', fee: 500),
    Doctor(id: '2', name: 'Dr. Nasrin Akter', nameBn: 'ডাঃ নাসরিন আক্তার', specialty: 'Gynecology', specialtyBn: 'গাইনি ও প্রসূতি', qualification: 'MBBS, MS (Gynae)', hospital: 'সিরাজগঞ্জ ২৫০ শয্যা জেলা সদর হাসপাতাল', chamber: 'সদর হাসপাতাল, সিরাজগঞ্জ', phone: '01711-400002', visitingHours: 'বিকাল ৪টা - রাত ৮টা', fee: 600),
    Doctor(id: '3', name: 'Dr. Md. Kamal Uddin', nameBn: 'ডাঃ মোঃ কামাল উদ্দিন', specialty: 'Surgery', specialtyBn: 'সার্জারি', qualification: 'MBBS, FCPS (Surgery)', hospital: 'সিরাজগঞ্জ ২৫০ শয্যা জেলা সদর হাসপাতাল', chamber: 'সদর হাসপাতাল', phone: '01711-400003', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 500),
    Doctor(id: '4', name: 'Dr. Md. Shafiqul Islam', nameBn: 'ডাঃ মোঃ শফিকুল ইসলাম', specialty: 'Orthopedics', specialtyBn: 'অর্থোপেডিক', qualification: 'MBBS, MS (Ortho)', hospital: 'সিরাজগঞ্জ ২৫০ শয্যা জেলা সদর হাসপাতাল', chamber: 'সদর হাসপাতাল', phone: '01711-400004', visitingHours: 'সকাল ১০টা - দুপুর ২টা', fee: 500),
    Doctor(id: '5', name: 'Dr. Md. Rahim Uddin', nameBn: 'ডাঃ মোঃ রহিম উদ্দিন', specialty: 'Pediatrics', specialtyBn: 'শিশু রোগ', qualification: 'MBBS, DCH', hospital: 'সিরাজগঞ্জ ২৫০ শয্যা জেলা সদর হাসপাতাল', chamber: 'সদর হাসপাতাল', phone: '01711-400005', visitingHours: 'বিকাল ৩টা - রাত ৭টা', fee: 500),
    Doctor(id: '6', name: 'Dr. Md. Hasanuzzaman', nameBn: 'ডাঃ মোঃ হাসানুজ্জামান', specialty: 'Eye', specialtyBn: 'চক্ষু বিশেষজ্ঞ', qualification: 'MBBS, DO, FCPS', hospital: 'সিরাজগঞ্জ ২৫০ শয্যা জেলা সদর হাসপাতাল', chamber: 'সদর হাসপাতাল', phone: '01711-400006', visitingHours: 'সকাল ৮টা - দুপুর ১২টা', fee: 500),
    Doctor(id: '7', name: 'Dr. Fatema Khatun', nameBn: 'ডাঃ ফাতেমা খাতুন', specialty: 'Skin', specialtyBn: 'চর্ম ও যৌন রোগ', qualification: 'MBBS, DDV', hospital: 'সিরাজগঞ্জ ২৫০ শয্যা জেলা সদর হাসপাতাল', chamber: 'সদর হাসপাতাল', phone: '01711-400007', visitingHours: 'বিকাল ৪টা - রাত ৮টা', fee: 500),
    Doctor(id: '8', name: 'Dr. Md. Tarikul Islam', nameBn: 'ডাঃ মোঃ তারিকুল ইসলাম', specialty: 'ENT', specialtyBn: 'নাক-কান-গলা', qualification: 'MBBS, DLO', hospital: 'সিরাজগঞ্জ ২৫০ শয্যা জেলা সদর হাসপাতাল', chamber: 'সদর হাসপাতাল', phone: '01711-400017', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 500),
    Doctor(id: '9', name: 'Dr. Md. Sohel Rana', nameBn: 'ডাঃ মোঃ সোহেল রানা', specialty: 'Dental', specialtyBn: 'দন্ত চিকিৎসা', qualification: 'BDS, DDS', hospital: 'সিরাজগঞ্জ ২৫০ শয্যা জেলা সদর হাসপাতাল', chamber: 'সদর হাসপাতাল', phone: '01711-400018', visitingHours: 'সকাল ৮টা - দুপুর ১টা', fee: 300),
    // খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল
    Doctor(id: '10', name: 'Prof. Dr. Md. Nurul Islam', nameBn: 'প্রফেসর ডাঃ মোঃ নুরুল ইসলাম', specialty: 'Cardiology', specialtyBn: 'হৃদরোগ বিশেষজ্ঞ', qualification: 'MBBS, MD (Cardiology)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400008', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 1000),
    Doctor(id: '11', name: 'Dr. Md. Anisur Rahman', nameBn: 'ডাঃ মোঃ আনিসুর রহমান', specialty: 'Neurology', specialtyBn: 'নিউরোলজি', qualification: 'MBBS, MD (Neuro)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400009', visitingHours: 'বিকাল ২টা - রাত ৬টা', fee: 800),
    Doctor(id: '12', name: 'Dr. Md. Jahangir Alam', nameBn: 'ডাঃ মোঃ জাহাঙ্গীর আলম', specialty: 'Urology', specialtyBn: 'ইউরোলজি', qualification: 'MBBS, MS (Urology)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400010', visitingHours: 'সকাল ১০টা - দুপুর ২টা', fee: 800),
    Doctor(id: '13', name: 'Dr. Md. Mizanur Rahman', nameBn: 'ডাঃ মোঃ মিজানুর রহমান', specialty: 'Surgery', specialtyBn: 'সার্জারি', qualification: 'MBBS, FCPS (Surgery)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400019', visitingHours: 'সকাল ৮টা - দুপুর ১২টা', fee: 700),
    Doctor(id: '14', name: 'Dr. Salma Akter', nameBn: 'ডাঃ সালমা আক্তার', specialty: 'Gynecology', specialtyBn: 'গাইনি ও প্রসূতি', qualification: 'MBBS, MS (Gynae)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400020', visitingHours: 'বিকাল ৩টা - রাত ৭টা', fee: 700),
    Doctor(id: '15', name: 'Dr. Md. Abdur Rashid', nameBn: 'ডাঃ মোঃ আব্দুর রশিদ', specialty: 'Nephrology', specialtyBn: 'কিডনি বিশেষজ্ঞ (নেফ্রোলজি)', qualification: 'MBBS, MD (Nephro)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400021', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 1000),
    Doctor(id: '23', name: 'Dr. Md. Saiful Islam', nameBn: 'ডাঃ মোঃ সাইফুল ইসলাম', specialty: 'Cardiology', specialtyBn: 'কার্ডিওলজি বিভাগ প্রধান', qualification: 'MBBS, DTCD, MD, FACC (USA)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400023', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 1000),
    Doctor(id: '24', name: 'Dr. Md. Lutfor Rahman', nameBn: 'প্রফেস��� ডাঃ মোঃ লুৎফর রহমান', specialty: 'Cardiothoracic Surgery', specialtyBn: 'কার্ডিওথোরাসিক সার্জারি (প্রধান সার্জন)', qualification: 'MBBS, FCPS, FRCS', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400024', visitingHours: 'সকাল ১০টা - দুপুর ২টা', fee: 1200),
    Doctor(id: '25', name: 'Prof. Dr. MA Hai', nameBn: 'প্রফেসর ডাঃ এম এ হাই', specialty: 'Oncology', specialtyBn: 'ক্যান্সার বিশেষজ্ঞ (���্যান্সার সেন্টার প্রধান)', qualification: 'MBBS, DMRT, FCPS', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400025', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 1000),
    Doctor(id: '26', name: 'Dr. Khan Asaduzzaman', nameBn: 'ডাঃ খান আসাদুজ্জামান', specialty: 'Neurosurgery', specialtyBn: 'নিউরোসার্জারি (মস্তিষ্ক সার্জন)', qualification: 'MBBS, MRCS (UK)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400026', visitingHours: 'সকাল ১০টা - দুপুর ১টা', fee: 1000),
    Doctor(id: '27', name: 'Dr. Ashraf Uddin Mollick', nameBn: 'ডাঃ (ক্যাপ্টেন) আশরাফ উদ্দিন মোল্লিক', specialty: 'Urology', specialtyBn: 'ইউরোলজি বিভাগ প্রধান', qualification: 'MBBS, PhD (Japan)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400027', visitingHours: 'সকাল ৯টা - দুপুর ২টা', fee: 1000),
    Doctor(id: '28', name: 'Dr. Mujibur Rahman', nameBn: 'ডাঃ মুজিবুর রহমান', specialty: 'Anesthesiology', specialtyBn: 'এনেসথেসিওলজি ও ICU প্রধান', qualification: 'MBBS, DA, MCPS, Fellow (WHO)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400028', visitingHours: 'সকাল ৮টা - বিকাল ৪টা', fee: 800),
    Doctor(id: '29', name: 'Dr. Sheikh Salah Uddin', nameBn: 'ডাঃ শেখ সালাহ উদ্দিন আহমেদ', specialty: 'Medicine', specialtyBn: 'মেডিসিন বিভাগ প্রধান', qualification: 'MBBS, FCPS (Medicine)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400029', visitingHours: 'সকাল ৮টা - দুপুর ১২টা', fee: 800),
    Doctor(id: '30', name: 'Dr. Abdur Razzak', nameBn: 'প্রফেসর ডাঃ আব্দুর রাজ্জাক', specialty: 'Dermatology', specialtyBn: 'চর্মরোগ বিভাগ প্রধান', qualification: 'MBBS, DDV, FCPS', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400030', visitingHours: 'বিকাল ৩টা - রাত ৭টা', fee: 800),
    Doctor(id: '31', name: 'Dr. Shafi Ahmed', nameBn: 'ডাঃ শফি আহমেদ', specialty: 'Pediatrics', specialtyBn: 'শিশু রোগ বিভাগ প্রধান', qualification: 'MBBS, DCH, MD', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400031', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 700),
    Doctor(id: '32', name: 'Dr. Shahida Begum', nameBn: 'ডাঃ শাহিদা বেগম', specialty: 'Gynecology', specialtyBn: 'গাইনি ও ল্যাপারোস্কপিক সার্জন', qualification: 'MBBS, DGO, MCPS, FCPS', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400032', visitingHours: 'বিকাল ৪টা - রাত ৮টা', fee: 800),
    Doctor(id: '33', name: 'Dr. Md. Abdur Bari', nameBn: 'ডাঃ মোঃ আব্দুল বারী', specialty: 'Oncology', specialtyBn: 'ক্যান্সার বিশেষজ্ঞ (রেডি���়েশন)', qualification: 'MBBS, M.Phil (RT)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400033', visitingHours: 'সকাল ১০টা - দুপুর ২টা', fee: 800),
    Doctor(id: '34', name: 'Dr. Md. Abdur Rashid (Ortho)', nameBn: 'ডাঃ মোঃ আব্দুর রশিদ', specialty: 'Orthopedics', specialtyBn: 'অর্থোপেডিক সার্জারি', qualification: 'MBBS, D-Ortho', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400034', visitingHours: 'সকাল ৮টা - দুপুর ১২টা', fee: 700),
    Doctor(id: '35', name: 'Dr. P.P. De', nameBn: 'ডাঃ পি পি দে', specialty: 'Endocrinology', specialtyBn: 'ডায়াবেটিস ও হরমোন বিশেষজ্ঞ', qualification: 'MBBS, MD', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400035', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 800),
    Doctor(id: '36', name: 'Dr. ASM Shariful Islam', nameBn: 'ডাঃ এ এস এম শরিফুল ইসলাম', specialty: 'Cardiothoracic Surgery', specialtyBn: 'কার্ডিওথোরাসিক সার্জারি', qualification: 'MBBS, MS', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400036', visitingHours: 'বিকাল ৩টা - রাত ৭টা', fee: 800),
    Doctor(id: '37', name: 'Dr. Kazi Shihab Uddin', nameBn: 'ডাঃ কাজী শিহাব উদ্দিন', specialty: 'Gastroenterology', specialtyBn: 'গ্যাস্ট্রোএন্টারোলজি বিভাগ প্রধান', qualification: 'MBBS, MD', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400037', visitingHours: 'সকাল ���০টা - দুপুর ২টা', fee: 800),
    Doctor(id: '38', name: 'Dr. Orpan Kumar Basak', nameBn: 'ডাঃ অর্পণ কুমার বসাক', specialty: 'Dermatology', specialtyBn: 'চর্মরোগ বিশেষজ্ঞ', qualification: 'MBBS, DDV', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400038', visitingHours: 'বিকাল ৪টা - রাত ৮টা', fee: 600),
    Doctor(id: '39', name: 'Dr. Ummul Nusrat Jahan', nameBn: 'ডাঃ উম্মুল নুসরাত জাহান', specialty: 'Gynecology', specialtyBn: 'গাইনি ও প্রসূতি', qualification: 'MBBS, MS (Gynae)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400039', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 700),
    Doctor(id: '40', name: 'Dr. Mossamat Afruza Jinnat', nameBn: 'ডাঃ মোসাম্মাৎ আফরুজা জিন্নাত', specialty: 'Pediatrics', specialtyBn: 'শিশু রোগ বিশেষজ্ঞ', qualification: 'MBBS, DCH', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400040', visitingHours: 'বিকাল ৩টা - রাত ৭টা', fee: 600),
    Doctor(id: '41', name: 'Dr. Md. Nazrul Alam', nameBn: 'ডাঃ মোঃ নজরুল আলম', specialty: 'Oncology', specialtyBn: 'অনকোলজি বিভাগ প্রধান', qualification: 'MBBS, FCPS', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400041', visitingHours: 'সকাল ১০টা - দুপুর ২টা', fee: 800),
    Doctor(id: '42', name: 'Dr. Md. Julfiqar Ali', nameBn: 'প্রফেসর ডাঃ মোঃ জুলফিকার আলী', specialty: 'Medicine', specialtyBn: 'মেডিসিন বিশেষজ্ঞ (প্রফেসর)', qualification: 'MBBS, FCPS, MD', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400042', visitingHours: 'সকাল ৮টা - দুপুর ১২টা', fee: 800),
    Doctor(id: '43', name: 'Dr. Deepak Shankar Roy', nameBn: 'ডাঃ দীপক শংকর রায়', specialty: 'Oncology', specialtyBn: 'ক্যান্সার সিনিয়র কনসালটেন্ট', qualification: 'MBBS, FCPS', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400043', visitingHours: 'বিকাল ২টা - সন্ধ্যা ৬টা', fee: 800),
    Doctor(id: '44', name: 'Dr. Sharmin Sultana', nameBn: 'ডাঃ শারমিন সুলতানা', specialty: 'Nutrition', specialtyBn: 'পুষ্টিবিদ ও ডায়েট বিশেষজ্ঞ', qualification: 'MBBS, MPH (Nutrition)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400044', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 500),
    Doctor(id: '45', name: 'Dr. Imrul Kayes', nameBn: 'ডাঃ ইমরুল কায়েস', specialty: 'Pediatrics', specialtyBn: 'শিশু রোগ বিশেষজ্ঞ', qualification: 'MBBS, MD (Pediatrics)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400045', visitingHours: 'বিকাল ৪টা - রাত ৮টা', fee: 600),
    Doctor(id: '46', name: 'Dr. Md. Raisul Islam', nameBn: 'ডাঃ মোঃ রইসুল ইসলাম', specialty: 'Medicine', specialtyBn: 'মেডিসিন বিশেষজ্ঞ', qualification: 'MBBS, MD', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400046', visitingHours: 'সকাল ৮টা - দুপুর ১২টা', fee: 600),
    Doctor(id: '47', name: 'Dr. Nasreen Nigar', nameBn: 'ডাঃ নাসরিন নিগার', specialty: 'Gynecology', specialtyBn: 'গাইনি ও প্রসূতি', qualification: 'MBBS, DGO', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400047', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 600),
    Doctor(id: '48', name: 'Dr. Mahbub Ahsan', nameBn: 'ডাঃ মাহবুব আহসান', specialty: 'Cardiothoracic Surgery', specialtyBn: 'কার্ডিওথোরাসিক সার্জারি', qualification: 'MBBS, MS', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400048', visitingHours: 'বিকাল ২টা - সন্ধ্যা ৬টা', fee: 700),
    Doctor(id: '49', name: 'Dr. SM Atik Hasan Khan', nameBn: 'ডাঃ এস এম আতিক হাসান খান', specialty: 'Dermatology', specialtyBn: 'চর্মরোগ বিশেষজ্ঞ', qualification: 'MBBS, DDV', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400049', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 600),
    Doctor(id: '50', name: 'Dr. Safayet Ahmed', nameBn: 'ডাঃ সাফায়েত আহমেদ', specialty: 'Medicine', specialtyBn: 'মেডিসিন বিশেষজ্ঞ', qualification: 'MBBS, FCPS', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400050', visitingHours: 'বিকাল ৩টা - রাত ৭টা', fee: 600),
    Doctor(id: '51', name: 'Dr. Ujjal Kumar Ghosh', nameBn: 'ডাঃ উজ্জ্বল কুমার ঘোষ', specialty: 'Pediatrics', specialtyBn: 'শিশু রোগ বিশেষজ্ঞ', qualification: 'MBBS, DCH', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400051', visitingHours: 'সকাল ১০টা - দুপুর ২টা', fee: 600),
    Doctor(id: '52', name: 'Dr. Barun Kumar Das', nameBn: 'ডাঃ বরুণ কুমার দাস', specialty: 'Oncology', specialtyBn: 'ক্যান্সার বিশেষজ্ঞ', qualification: 'MBBS, M.Phil', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400052', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 700),
    Doctor(id: '53', name: 'Dr. Mohammad Solayman', nameBn: 'ডাঃ ম���হাম্মদ সোলায়মান', specialty: 'Pediatrics', specialtyBn: 'শিশু রোগ বিশেষজ্ঞ', qualification: 'MBBS, MD (Pediatrics)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400053', visitingHours: 'সকাল ৮টা - দুপুর ১২টা', fee: 600),
    Doctor(id: '54', name: 'Dr. Shiuli Aktar', nameBn: 'ডাঃ শিউলী আক্তার', specialty: 'Gynecology', specialtyBn: 'গাইনি ও প্রসূতি', qualification: 'MBBS, MS (Gynae)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400054', visitingHours: 'বিকাল ৪টা - রাত ৮টা', fee: 600),
    Doctor(id: '55', name: 'Dr. Tanvir Ahmed', nameBn: 'ডাঃ তানভীর আহমেদ', specialty: 'Oncology', specialtyBn: 'ক্যান্সার বিশেষজ্ঞ', qualification: 'MBBS, FCPS', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400055', visitingHours: 'সকাল ১০টা - দুপুর ২টা', fee: 700),
    Doctor(id: '56', name: 'Dr. Asim K R Sengupta', nameBn: 'ডাঃ অসীম কে আর সেনগুপ্তা', specialty: 'Oncology', specialtyBn: 'ক্যান্সার বিশেষজ্ঞ (জুনিয়র কনসালটেন্ট)', qualification: 'MBBS, M.Phil (RT)', hospital: 'খাজা ইউনুছ আলী মেডিকেল কলেজ ও হাসপাতাল', chamber: 'এনায়েতপুর, সিরাজগঞ্জ', phone: '01711-400056', visitingHours: 'বিকাল ২টা - সন্ধ্যা ৬টা', fee: 700),
    // ইবনে সিনা হাসপাতাল
    Doctor(id: '16', name: 'Dr. Md. Rafiqul Islam', nameBn: 'ডাঃ মোঃ রফিকুল ইসলাম', specialty: 'Surgery', specialtyBn: 'সার্জারি', qualification: 'MBBS, FCPS (Surgery)', hospital: 'ইবনে সিনা হাসপাতাল', chamber: 'বড় বাজার, সিরাজগঞ্জ', phone: '01711-400011', visitingHours: 'সকাল ১০টা - দুপুর ১টা', fee: 800),
    Doctor(id: '17', name: 'Dr. Md. Anowar Hossain', nameBn: 'ডাঃ মোঃ আনোয়ার হোসেন', specialty: 'Cardiology', specialtyBn: 'হৃদরোগ', qualification: 'MBBS, MD (Cardio)', hospital: 'ইবনে সিনা হাসপাতাল', chamber: 'বড় বাজার, সিরাজগঞ্জ', phone: '01711-400012', visitingHours: 'সকাল ৯টা - দুপুর ১২টা', fee: 1000),
    // পপুলার হাসপাতাল
    Doctor(id: '18', name: 'Dr. Md. Shahadat Hossain', nameBn: 'ডাঃ মোঃ শাহাদাত হোসেন', specialty: 'Pediatrics', specialtyBn: 'শিশু রোগ বিশেষজ্ঞ', qualification: 'MBBS, DCH', hospital: 'পপুলার হাসপাতাল', chamber: 'বড় বাজার, সিরাজগঞ্জ', phone: '01711-400013', visitingHours: 'বিকাল ৫টা - রাত ৯টা', fee: 600),
    Doctor(id: '19', name: 'Dr. Rehana Begum', nameBn: 'ডাঃ রেহানা বেগম', specialty: 'Gynecology', specialtyBn: 'গাইনি ও প্রসূতি', qualification: 'MBBS, DGO', hospital: 'পপুলার হাসপাতাল', chamber: 'বড় বাজার, সিরাজগঞ্জ', phone: '01711-400014', visitingHours: 'সকাল ৯টা - দুপুর ১টা', fee: 600),
    // শাহজাদপুর উপজেলা স্বাস্থ্য কমপ্লেক্স
    Doctor(id: '20', name: 'Dr. Md. Moniruzzaman', nameBn: 'ডাঃ মোঃ মনিরুজ্জামান', specialty: 'Medicine', specialtyBn: 'মেডিসিন বিশেষজ্ঞ', qualification: 'MBBS, FCPS', hospital: 'শাহজাদপুর উপজেলা স্বাস্থ্য কমপ্লেক্স', chamber: 'শাহজাদপুর, সিরাজগঞ্জ', phone: '01711-400015', visitingHours: 'সকাল ৮টা - দুপুর ২টা', fee: 500),
    Doctor(id: '21', name: 'Dr. Mst. Shirin Akter', nameBn: 'ডাঃ মোসাঃ শিরিন আক্তার', specialty: 'Gynecology', specialtyBn: 'গাইনি ও প্রসূতি', qualification: 'MBBS, DGO', hospital: 'শাহজাদপুর উপজেলা স্বাস্থ্য কমপ্লেক্স', chamber: 'শাহজাদপুর, সিরাজগঞ্জ', phone: '01711-400022', visitingHours: 'বিকাল ৪টা - রাত ৮টা', fee: 400),
    // উল্লাপাড়া উপজেলা স্বাস্থ্য কমপ্লেক্স
    Doctor(id: '22', name: 'Dr. Md. Zakir Hossain', nameBn: 'ডাঃ মোঃ জাকির হোসেন', specialty: 'Medicine', specialtyBn: 'মেডিসিন', qualification: 'MBBS', hospital: 'উল্লাপাড়া উপজেলা স্বাস্থ্য কমপ্লেক্স', chamber: 'উল্লাপাড়া, সিরাজগঞ্জ', phone: '01711-400016', visitingHours: 'সকাল ৮টা - দুপুর ২টা', fee: 400),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Builder(
        builder: (ctx) {
          final tabController = DefaultTabController.of(ctx);
          return AnimatedBuilder(
            animation: tabController,
            builder: (context, _) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('চিকিৎসা'),
                  bottom: const TabBar(
                    isScrollable: true,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(text: 'হাসপাতাল'),
                      Tab(text: 'ডাক্তার'),
                      Tab(text: 'ফার্মেসি'),
                      Tab(text: 'অ্যাম্বুলেন্স'),
                      Tab(text: 'রক্তদাতা'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    _buildHospitalList(),
                    _buildDoctorList(),
                    _buildPharmacyList(),
                    _buildAmbulanceList(),
                    _buildBloodDonors(),
                  ],
                ),
                floatingActionButton: tabController.index == 4
                    ? FloatingActionButton.extended(
                        onPressed: () => _showDonorRegistrationForm(),
                        backgroundColor: AppColors.error,
                        icon: const Icon(Icons.volunteer_activism_rounded, color: Colors.white),
                        label: const Text('রক্তদাতা হন', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                        elevation: 6,
                      )
                    : null,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHospitalList() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final govtCount = _hospitals.where((h) => h.type == 'government').length;
    final pvtCount = _hospitals.where((h) => h.type == 'private').length;
    final filtered = _hospitalFilter == 'সব' ? _hospitals
        : _hospitalFilter == 'সরকারি' ? _hospitals.where((h) => h.type == 'government').toList()
        : _hospitals.where((h) => h.type == 'private').toList();

    return Column(
      children: [
        // Filter chips
        SizedBox(
          height: 52,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            children: [
              _buildHospitalFilterChip('সব', '${_hospitals.length}', AppColors.primary, isDark),
              const SizedBox(width: 8),
              _buildHospitalFilterChip('সরকারি', '$govtCount', AppColors.primary, isDark),
              const SizedBox(width: 8),
              _buildHospitalFilterChip('বেসরকারি', '$pvtCount', const Color(0xFF8B5CF6), isDark),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final hospital = filtered[index];
        final color = hospital.type == 'government' ? AppColors.primary : AppColors.secondary;
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
                  color: color.withValues(alpha: isDark ? 0.15 : 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.local_hospital_rounded, color: color),
              ),
              title: Text(hospital.nameBn, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: isDark ? 0.15 : 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        hospital.type == 'government' ? 'সরকারি' : 'বেসরকারি',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: color),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (hospital.hasEmergency)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: isDark ? 0.15 : 0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('জরুরি বিভাগ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.error)),
                      ),
                  ],
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHospitalDetail('ঠিকানা', hospital.address),
                      _buildHospitalDetail('ফোন', hospital.phone),
                      _buildHospitalDetail('বেড সংখ্যা', '${hospital.bedCount} টি'),
                      _buildHospitalDetail('ডাক্তার সংখ্যা', '${hospital.doctorCount} জন'),
                      const SizedBox(height: 8),
                      const Text('সেবাসমূহ / বিভাগ:', style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: hospital.departments.map((d) => Chip(
                          label: Text(d, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: color)),
                          padding: EdgeInsets.zero,
                          side: BorderSide(color: color.withValues(alpha: 0.3)),
                          backgroundColor: color.withValues(alpha: isDark ? 0.15 : 0.05),
                        )).toList(),
                      ),
                      const SizedBox(height: 14),
                      // ডাক্তার দেখুন button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _showHospitalDoctors(hospital),
                          icon: const Icon(Icons.medical_services_rounded, size: 18),
                          label: Text('ডাক্তার দেখুন (${hospital.doctorCount} জন)', style: const TextStyle(fontWeight: FontWeight.w600)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7C3AED),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Helpers.makePhoneCall(hospital.phone),
                              icon: const Icon(Icons.call_rounded, size: 18),
                              label: const Text('কল'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Helpers.openMap(hospital.latitude, hospital.longitude),
                              icon: const Icon(Icons.map_rounded, size: 18),
                              label: const Text('ম্যাপ'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
          ),
        ),
      ],
    );
  }

  void _showHospitalDoctors(Hospital hospital) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hospitalDoctors = _doctors.where((d) => d.hospital == hospital.nameBn).toList();
    final color = hospital.type == 'government' ? AppColors.primary : const Color(0xFF8B5CF6);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle + Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
                    const SizedBox(height: 14),
                    // Hospital info header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.04)]),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: color.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                            child: Icon(Icons.local_hospital_rounded, color: color, size: 24),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(hospital.nameBn, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                                      child: Text(hospital.type == 'government' ? 'সরকারি' : 'বেসরকারি', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
                                    ),
                                    const SizedBox(width: 6),
                                    Text('${hospital.bedCount} শয্যা', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                    const SizedBox(width: 6),
                                    Text('${hospital.doctorCount} ডাক্তার', style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Doctor count header
                    Row(
                      children: [
                        Container(width: 4, height: 18, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
                        const SizedBox(width: 8),
                        Text(hospitalDoctors.isEmpty ? 'ডাক্তারের বিস্তারিত তথ্য শীঘ্রই আসছে' : 'বিশেষজ্ঞ ডাক্তার (${hospitalDoctors.length} জন)', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              // Doctor list
              Expanded(
                child: hospitalDoctors.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.medical_services_rounded, size: 56, color: Colors.grey[300]),
                            const SizedBox(height: 12),
                            const Text('বিস্তারিত তথ্য শীঘ্রই যোগ হবে', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text('মোট ${hospital.doctorCount} জন ডাক্তার কর্মরত', style: TextStyle(color: color, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        physics: const BouncingScrollPhysics(),
                        itemCount: hospitalDoctors.length,
                        itemBuilder: (context, index) {
                          final doctor = hospitalDoctors[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkCard : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: isDark ? [] : AppColors.softShadow,
                              border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.withValues(alpha: 0.1)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Doctor header
                                  Row(
                                    children: [
                                      Container(
                                        width: 48, height: 48,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.05)]),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Icon(Icons.person_rounded, color: color, size: 26),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(doctor.nameBn, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                                            const SizedBox(height: 2),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                              decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(8)),
                                              child: Text(doctor.specialtyBn, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  // Doctor details
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: isDark ? AppColors.darkSurface : const Color(0xFFF9FAFB),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        _buildDoctorInfoRow('🎓 যোগ্যতা', doctor.qualification),
                                        _buildDoctorInfoRow('🏥 চেম্বার', doctor.chamber),
                                        _buildDoctorInfoRow('🕐 সময়', doctor.visitingHours),
                                        _buildDoctorInfoRow('💰 ফি', '৳${doctor.fee.toInt()} টাকা'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Call button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: () => Helpers.makePhoneCall(doctor.phone),
                                      icon: const Icon(Icons.call_rounded, size: 18),
                                      label: Text('কল করুন: ${doctor.phone}'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.success,
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 90, child: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildHospitalFilterChip(String label, String count, Color color, bool isDark) {
    final isSelected = _hospitalFilter == label;
    return FilterChip(
      avatar: null,
      label: Text(
        '$label ($count)',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: isSelected ? Colors.white : (isDark ? Colors.white : AppColors.textPrimary)),
      ),
      selected: isSelected,
      showCheckmark: false,
      onSelected: (_) => setState(() => _hospitalFilter = label),
      selectedColor: color,
      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
      side: BorderSide(color: isSelected ? color : color.withValues(alpha: 0.3)),
      elevation: isSelected ? 3 : 0,
      shadowColor: color.withValues(alpha: 0.4),
    );
  }

  Widget _buildHospitalDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildDoctorList() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredDoctors = _doctors.where((d) => _searchQuery.isEmpty || d.nameBn.contains(_searchQuery) || d.specialtyBn.contains(_searchQuery)).toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: isDark ? [] : AppColors.softShadow,
            ),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'ডাক্তার অনুসন্ধান...',
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: filteredDoctors.length,
            itemBuilder: (context, index) {
              final doctor = filteredDoctors[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isDark ? [] : AppColors.softShadow,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: isDark ? 0.15 : 0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.medical_services_rounded, color: AppColors.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(doctor.nameBn, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: isDark ? 0.15 : 0.08),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(doctor.specialtyBn, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
                            ),
                            const SizedBox(height: 6),
                            Text(doctor.qualification, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
                            const SizedBox(height: 2),
                            Text('${doctor.hospital} | ফি: ৳${doctor.fee.toInt()}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 2),
                            Text('সময়: ${doctor.visitingHours}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: isDark ? 0.15 : 0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.call_rounded, color: AppColors.success),
                          onPressed: () => Helpers.makePhoneCall(doctor.phone),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPharmacyList() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pharmacies = [
      Pharmacy(name: 'লাজ ফার্মেসি', address: 'বড় বাজার, সিরাজগঞ্জ সদর', phone: '01711-500001', openingHours: 'সকাল ৮টা - রাত ১০টা', isOpen24Hours: false),
      Pharmacy(name: 'পপুলার ফার্মেসি', address: 'হাসপাতাল রোড, সিরাজগঞ্জ সদর', phone: '01711-500002', openingHours: '২৪ ঘন্টা', isOpen24Hours: true),
      Pharmacy(name: 'মডেল ফার্মেসি', address: 'স্টেশন রোড, সিরাজগঞ্জ সদর', phone: '01711-500003', openingHours: 'সকাল ৭টা - রাত ১১টা', isOpen24Hours: false),
      Pharmacy(name: 'ন্যাশনাল ফার্মেসি', address: 'শাহজাদপুর রোড, সিরাজগঞ্জ', phone: '01711-500004', openingHours: '২৪ ঘন্টা', isOpen24Hours: true),
    ];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: pharmacies.length,
      itemBuilder: (context, index) {
        final pharmacy = pharmacies[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDark ? [] : AppColors.softShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: isDark ? 0.15 : 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.local_pharmacy_rounded, color: Colors.green),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pharmacy.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text(pharmacy.address, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded, size: 14, color: pharmacy.isOpen24Hours ? AppColors.success : AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            pharmacy.openingHours,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: pharmacy.isOpen24Hours ? AppColors.success : AppColors.textSecondary),
                          ),
                          if (pharmacy.isOpen24Hours) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: isDark ? 0.15 : 0.08),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text('Open', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.success)),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: isDark ? 0.15 : 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.call_rounded, color: AppColors.success),
                    onPressed: () => Helpers.makePhoneCall(pharmacy.phone),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Blood donor data
  final List<BloodDonor> _bloodDonors = [
    BloodDonor(name: 'মোঃ রাকিবুল হাসান', phone: '01711-200001', bloodGroup: 'A+', area: 'সদর, সিরাজগঞ্জ', lastDonation: DateTime(2026, 1, 15), isAvailable: true, age: 28, gender: 'পুরুষ', district: 'সিরাজগঞ্জ', upazila: 'সদর', weight: 68, profession: 'ব্যবসায়ী'),
    BloodDonor(name: 'মোঃ তানভীর আহমেদ', phone: '01711-200002', bloodGroup: 'B+', area: 'শাহজাদপুর, সিরাজগঞ্জ', lastDonation: DateTime(2026, 2, 10), isAvailable: true, age: 25, gender: 'পুরুষ', district: 'সিরাজগঞ্জ', upazila: 'শাহজাদপুর', weight: 72, profession: 'শিক্ষক'),
    BloodDonor(name: 'মোঃ সোহেল রানা', phone: '01711-200003', bloodGroup: 'O+', area: 'উল্লাপাড়া, সিরাজগঞ্জ', lastDonation: DateTime(2025, 12, 20), isAvailable: true, age: 30, gender: 'পুরুষ', district: 'সিরাজগঞ্জ', upazila: 'উল্লাপাড়া', weight: 75, profession: 'কৃষক'),
    BloodDonor(name: 'মোঃ আরিফুল ইসলাম', phone: '01711-200004', bloodGroup: 'AB+', area: 'কাজীপুর, সিরাজগঞ্জ', lastDonation: DateTime(2026, 3, 1), isAvailable: false, age: 22, gender: 'পুরুষ', district: 'সিরাজগঞ্জ', upazila: 'কাজীপুর', weight: 60, profession: 'ছাত্র'),
    BloodDonor(name: 'মোঃ ইমরান হোসেন', phone: '01711-200005', bloodGroup: 'A-', area: 'বেলকুচি, সিরাজগঞ্জ', lastDonation: DateTime(2026, 1, 5), isAvailable: true, age: 35, gender: 'পুরুষ', district: 'সিরাজগঞ্জ', upazila: 'বেলকুচি', weight: 80, profession: 'চাকরিজীবী'),
    BloodDonor(name: 'ফাতেমা আক্তার', phone: '01711-200006', bloodGroup: 'O-', area: 'তাড়াশ, সিরাজগঞ্জ', lastDonation: DateTime(2025, 11, 25), isAvailable: true, age: 27, gender: 'মহিলা', district: 'সিরাজগঞ্জ', upazila: 'তাড়াশ', weight: 58, profession: 'গৃহিণী'),
    BloodDonor(name: 'মোঃ নাঈম হোসেন', phone: '01711-200007', bloodGroup: 'B-', area: 'সদর, সিরাজগঞ্জ', lastDonation: DateTime(2026, 2, 28), isAvailable: true, age: 24, gender: 'পুরুষ', district: 'সিরাজগঞ্জ', upazila: 'সদর', weight: 65, profession: 'ছাত্র'),
  ];

  Widget _buildAmbulanceList() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final ambulances = [
      // সিরাজগঞ্জ সদর
      {'name': 'সদর হাসপাতাল অ্যাম্বুলেন্স-১', 'area': 'সিরাজগঞ্জ সদর', 'phone': '01711-301001', 'type': 'সরকারি', 'available': true},
      {'name': 'সদর হাসপাতাল অ্যাম্বুলেন্স-২', 'area': 'সিরাজগঞ্জ সদর', 'phone': '01711-301002', 'type': 'সরকারি', 'available': true},
      {'name': 'ইবনে সিনা অ্যাম্বুলেন্স', 'area': 'সিরাজগঞ্জ সদর', 'phone': '01711-301003', 'type': 'বেসরকারি', 'available': true},
      {'name': 'সিরাজগঞ্জ ক্লিনিক অ্যাম্বুলেন্স', 'area': 'সিরাজগঞ্জ সদর', 'phone': '01711-301004', 'type': 'বেসরকারি', 'available': true},
      {'name': 'রেড ক্রিসেন্ট অ্যাম্বুলেন্স', 'area': 'সিরাজগঞ্জ সদর', 'phone': '01711-301005', 'type': 'সংস্থা', 'available': true},
      // শাহজাদপুর
      {'name': 'শাহজাদপুর স্বাস্থ্য কমপ্লেক্স অ্যাম্বুলেন্স', 'area': 'শাহজাদপুর', 'phone': '01711-301006', 'type': 'সরকারি', 'available': true},
      {'name': 'শাহজাদপুর বেসরকারি অ্যাম্বুলেন্স', 'area': 'শাহজাদপুর', 'phone': '01711-301007', 'type': 'বেসরকারি', 'available': true},
      // উল্লাপাড়া
      {'name': 'উল্লাপাড়া স্বাস্থ্য কমপ্লেক্স অ্যাম্বুলেন্স', 'area': 'উল্লাপাড়া', 'phone': '01711-301008', 'type': 'সরকারি', 'available': true},
      {'name': 'উল্লাপাড়া প্রাইভেট অ্যাম্বুলেন্স', 'area': 'উল্লাপাড়া', 'phone': '01711-301009', 'type': 'বেসরকারি', 'available': false},
      // কাজীপুর
      {'name': 'কাজীপুর স্বাস্থ্য কমপ্লেক্স অ্যাম্বুলেন্স', 'area': 'কাজীপুর', 'phone': '01711-301010', 'type': 'সরকারি', 'available': true},
      // বেলকুচি
      {'name': 'বেলকুচি স্বাস্থ্য কমপ্লেক্স অ্যাম্বুলেন্স', 'area': 'বেলকুচি', 'phone': '01711-301011', 'type': 'সরকারি', 'available': true},
      // তাড়াশ
      {'name': 'তাড়াশ স্বাস্থ্য কমপ্লেক্স অ্যাম্বুলেন্স', 'area': 'তাড়াশ', 'phone': '01711-301012', 'type': 'সরকারি', 'available': true},
      // কামারখন্দ
      {'name': 'খাজা ইউনুছ আলী হাসপাতাল অ্যাম্বুলেন্স-১', 'area': 'কামারখন্দ (এনায়েতপুর)', 'phone': '01711-301013', 'type': 'বেসরকারি', 'available': true},
      {'name': 'খাজা ইউনুছ আলী হাসপাতাল অ্যাম্বুলেন্স-২', 'area': 'কামারখন্দ (এনায়েতপুর)', 'phone': '01711-301014', 'type': 'বেসরকারি', 'available': true},
      {'name': 'কামারখন্দ স্বাস্থ্য কমপ্লেক্স অ্যাম্বুলেন্স', 'area': 'কামারখন্দ', 'phone': '01711-301015', 'type': 'সরকারি', 'available': true},
      // রায়গঞ্জ
      {'name': 'রায়গঞ্জ স্বাস্থ্য কমপ্লেক্স অ্যাম্বুলেন্স', 'area': 'রায়গঞ্জ', 'phone': '01711-301016', 'type': 'সরকারি', 'available': true},
      // চৌহালী
      {'name': 'চৌহালী স্বাস্থ্য কমপ্লেক্স অ্যাম্বুলেন্স', 'area': 'চৌহালী', 'phone': '01711-301017', 'type': 'সরকারি', 'available': true},
    ];

    return ListView(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      children: [
        // Emergency 199 call banner
        Container(
          margin: const EdgeInsets.fromLTRB(4, 4, 4, 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFDC2626), Color(0xFFEF4444)]),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: AppColors.error.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Helpers.makePhoneCall('199'),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.local_hospital_rounded, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('জরুরি অ্যাম্বুলেন্স', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                          Text('জাতীয় অ্যাম্বুলেন্স সেবা কল করুন', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: const Text('১৯৯', style: TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.w900, fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Count
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Row(
            children: [
              Container(width: 4, height: 16, decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              Text('সিরাজগঞ্জ জেলায় মোট ${ambulances.length}টি অ্যাম্বুলেন্স', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        // Ambulance list
        ...ambulances.map((amb) {
          final isGovt = amb['type'] == 'সরকারি';
          final isAvailable = amb['available'] as bool;
          final color = isGovt ? AppColors.primary : const Color(0xFF8B5CF6);
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: isDark ? [] : AppColors.softShadow,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: isDark ? 0.15 : 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.local_shipping_rounded, color: AppColors.error, size: 22),
              ),
              title: Text(amb['name'] as String, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, size: 12, color: Colors.grey[400]),
                      const SizedBox(width: 3),
                      Text(amb['area'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                        child: Text(amb['type'] as String, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: isAvailable ? AppColors.success.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(isAvailable ? 'সচল' : 'অসচল', style: TextStyle(fontSize: 10, color: isAvailable ? AppColors.success : Colors.grey, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: isAvailable
                  ? GestureDetector(
                      onTap: () => Helpers.makePhoneCall(amb['phone'] as String),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.call_rounded, color: AppColors.success, size: 20),
                      ),
                    )
                  : Icon(Icons.block_rounded, color: Colors.grey[400], size: 20),
              isThreeLine: true,
              onTap: isAvailable ? () => Helpers.makePhoneCall(amb['phone'] as String) : null,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildBloodDonors() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bloodGroups = ['সব', 'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
    final filtered = _selectedBloodGroup == 'সব'
        ? _bloodDonors
        : _bloodDonors.where((d) => d.bloodGroup == _selectedBloodGroup).toList();

    return Column(
      children: [
        // Blood group filter
        SizedBox(
          height: 56,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            itemCount: bloodGroups.length,
            itemBuilder: (context, index) {
              final group = bloodGroups[index];
              final isSelected = group == _selectedBloodGroup;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(
                    group,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : (isDark ? Colors.white : AppColors.textPrimary),
                    ),
                  ),
                  selected: isSelected,
                  showCheckmark: false,
                  onSelected: (_) => setState(() => _selectedBloodGroup = group),
                  selectedColor: AppColors.error,
                  backgroundColor: isDark ? AppColors.darkCard : Colors.white,
                  side: BorderSide(color: isSelected ? AppColors.error : AppColors.error.withValues(alpha: 0.3)),
                  elevation: isSelected ? 3 : 0,
                  shadowColor: AppColors.error.withValues(alpha: 0.4),
                ),
              );
            },
          ),
        ),
        // Donor count
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Row(
            children: [
              Container(width: 4, height: 16, decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              Text('মোট ${filtered.length} জন রক্তদাতা', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        // Donor list
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bloodtype_rounded, size: 64, color: Colors.grey[300]),
                      const SizedBox(height: 12),
                      const Text('এই গ্রুপের রক্তদাতা পাওয়া যায়নি', style: TextStyle(color: AppColors.textSecondary)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 70),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final donor = filtered[index];
                    return GestureDetector(
                      onTap: () => _showDonorDetails(donor),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkCard : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: isDark ? [] : AppColors.softShadow,
                        ),
                        child: Row(
                          children: [
                            // Blood group badge
                            Container(
                              width: 50, height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.error.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
                              ),
                              child: Center(child: Text(donor.bloodGroup, style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.w900, fontSize: 15))),
                            ),
                            const SizedBox(width: 12),
                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Text(donor.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14))),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: donor.isAvailable ? AppColors.success.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(donor.isAvailable ? 'সচল' : 'অসচল', style: TextStyle(color: donor.isAvailable ? AppColors.success : Colors.grey, fontSize: 10, fontWeight: FontWeight.w700)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_rounded, size: 12, color: Colors.grey[400]),
                                      const SizedBox(width: 3),
                                      Expanded(child: Text(donor.area, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary))),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      if (donor.age != null) ...[
                                        Icon(Icons.cake_rounded, size: 11, color: Colors.grey[400]),
                                        const SizedBox(width: 3),
                                        Text('${donor.age} বছর', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                        const SizedBox(width: 10),
                                      ],
                                      if (donor.gender != null) ...[
                                        Icon(Icons.person_rounded, size: 11, color: Colors.grey[400]),
                                        const SizedBox(width: 3),
                                        Text(donor.gender!, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                        const SizedBox(width: 10),
                                      ],
                                      Icon(Icons.calendar_today_rounded, size: 11, color: Colors.grey[400]),
                                      const SizedBox(width: 3),
                                      Text('${donor.lastDonation.day}/${donor.lastDonation.month}/${donor.lastDonation.year}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Call button
                            donor.isAvailable
                                ? GestureDetector(
                                    onTap: () => Helpers.makePhoneCall(donor.phone),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                                      child: const Icon(Icons.call_rounded, color: AppColors.success, size: 20),
                                    ),
                                  )
                                : Icon(Icons.block_rounded, color: Colors.grey[400], size: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showDonorDetails(BloodDonor donor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            // Header
            Row(
              children: [
                Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.error.withValues(alpha: 0.3), width: 2),
                  ),
                  child: Center(child: Text(donor.bloodGroup, style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.w900, fontSize: 18))),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(donor.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: donor.isAvailable ? AppColors.success.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(donor.isAvailable ? 'রক্তদানে সচল' : 'বর্তমানে অসচল', style: TextStyle(color: donor.isAvailable ? AppColors.success : Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Details grid
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildDonorDetailRow('মোবাইল', donor.phone),
                  _buildDonorDetailRow('রক্তের গ্রুপ', donor.bloodGroup),
                  _buildDonorDetailRow('ঠিকানা', donor.area),
                  if (donor.age != null) _buildDonorDetailRow('বয়স', '${donor.age} বছর'),
                  if (donor.gender != null) _buildDonorDetailRow('লিঙ্গ', donor.gender!),
                  if (donor.district != null) _buildDonorDetailRow('জেলা', donor.district!),
                  if (donor.upazila != null) _buildDonorDetailRow('উপজেলা', donor.upazila!),
                  _buildDonorDetailRow('সর্বশেষ রক্তদান', '${donor.lastDonation.day}/${donor.lastDonation.month}/${donor.lastDonation.year}'),
                  if (donor.weight != null) _buildDonorDetailRow('ওজন', '${donor.weight!.toInt()} কেজি'),
                  if (donor.profession != null) _buildDonorDetailRow('পেশা', donor.profession!),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (donor.isAvailable)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () { Navigator.pop(context); Helpers.makePhoneCall(donor.phone); },
                  icon: const Icon(Icons.call_rounded),
                  label: Text('কল করুন: ${donor.phone}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.success, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                ),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildDonorDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(width: 130, child: Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  void _showDonorRegistrationForm() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final areaController = TextEditingController();
    final ageController = TextEditingController();
    final weightController = TextEditingController();
    final professionController = TextEditingController();
    String selectedGroup = 'A+';
    String selectedGender = 'পুরুষ';
    String selectedUpazila = 'সদর';
    final allGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
    final genders = ['পুরুষ', 'মহিলা', 'অন্যান্য'];
    final upazilas = ['সদর', 'বেলকুচি', 'চৌহালী', 'কামারখন্দ', 'কাজীপুর', 'রায়গঞ্জ', 'শাহজাদপুর', 'তাড়াশ', 'উল্লাপাড়া'];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(height: 16),
                  // Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFFDC2626), Color(0xFFEF4444)]),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('রক্তদাতা রেজিস্ট্রেশন', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                          Text('আপনার তথ্য দিয়ে যোগ দিন', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // নাম
                  TextField(controller: nameController, decoration: const InputDecoration(labelText: 'আপনার নাম *', prefixIcon: Icon(Icons.person_rounded), hintText: 'পূর্ণ নাম লিখুন')),
                  const SizedBox(height: 12),
                  // ফোন নম্বর
                  TextField(controller: phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'মোবাইল নম্বর *', prefixIcon: Icon(Icons.phone_rounded), hintText: '01XXXXXXXXX')),
                  const SizedBox(height: 12),
                  // বয়স ও ওজন
                  Row(
                    children: [
                      Expanded(child: TextField(controller: ageController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'বয়স *', prefixIcon: Icon(Icons.cake_rounded), hintText: 'যেমন: ২৫'))),
                      const SizedBox(width: 10),
                      Expanded(child: TextField(controller: weightController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'ওজন (কেজি)', prefixIcon: Icon(Icons.monitor_weight_rounded), hintText: 'ঐচ্ছিক'))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // লিঙ্গ
                  const Text('লিঙ্গ *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(
                    children: genders.map((g) {
                      final isSelected = g == selectedGender;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setModalState(() => selectedGender = g),
                          child: Container(
                            margin: const EdgeInsets.only(right: 6),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : (isDark ? AppColors.darkCard : Colors.white),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: isSelected ? AppColors.primary : AppColors.primary.withValues(alpha: 0.3)),
                            ),
                            child: Center(child: Text(g, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: isSelected ? Colors.white : AppColors.textPrimary))),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  // উপজেলা
                  DropdownButtonFormField<String>(
                    initialValue: selectedUpazila,
                    decoration: const InputDecoration(labelText: 'উপজেলা *', prefixIcon: Icon(Icons.location_city_rounded)),
                    items: upazilas.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                    onChanged: (v) => setModalState(() => selectedUpazila = v ?? 'সদর'),
                  ),
                  const SizedBox(height: 12),
                  // এলাকা
                  TextField(controller: areaController, decoration: const InputDecoration(labelText: 'বিস্তারিত ঠিকানা *', prefixIcon: Icon(Icons.location_on_rounded), hintText: 'গ্রাম/মহল্লা, পোস্ট অফিস')),
                  const SizedBox(height: 12),
                  // পেশা
                  TextField(controller: professionController, decoration: const InputDecoration(labelText: 'পেশা (ঐচ্ছিক)', prefixIcon: Icon(Icons.work_rounded), hintText: 'যেমন: ছাত্র, চাকরিজীবী')),
                  const SizedBox(height: 16),
                  // রক্তের গ্রুপ
                  const Text('রক্তের গ্রুপ নির্বাচন করুন *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: allGroups.map((group) {
                      final isSelected = group == selectedGroup;
                      return GestureDetector(
                        onTap: () => setModalState(() => selectedGroup = group),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 60,
                          height: 44,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.error : (isDark ? AppColors.darkCard : Colors.white),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? AppColors.error : AppColors.error.withValues(alpha: 0.3),
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: isSelected ? [BoxShadow(color: AppColors.error.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2))] : [],
                          ),
                          child: Center(
                            child: Text(
                              group,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: isSelected ? Colors.white : AppColors.error,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (nameController.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('আপনার নাম লিখুন'), backgroundColor: AppColors.error)); return; }
                        if (phoneController.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('মোবাইল নম্বর লিখুন'), backgroundColor: AppColors.error)); return; }
                        if (ageController.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('বয়স লিখুন'), backgroundColor: AppColors.error)); return; }
                        if (areaController.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ঠিকানা লিখুন'), backgroundColor: AppColors.error)); return; }

                        final area = '$selectedUpazila, সিরাজগঞ্জ - ${areaController.text.trim()}';
                        setState(() {
                          _bloodDonors.insert(0, BloodDonor(
                            name: nameController.text.trim(),
                            phone: phoneController.text.trim(),
                            bloodGroup: selectedGroup,
                            area: area,
                            lastDonation: DateTime.now(),
                            isAvailable: true,
                            age: int.tryParse(ageController.text.trim()),
                            gender: selectedGender,
                            district: 'সিরাজগঞ্জ',
                            upazila: selectedUpazila,
                            weight: double.tryParse(weightController.text.trim()),
                            profession: professionController.text.trim().isEmpty ? null : professionController.text.trim(),
                          ));
                        });

                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), shape: BoxShape.circle), child: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 44)),
                                  const SizedBox(height: 12),
                                  const Text('ধন্যবাদ!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                                  const SizedBox(height: 8),
                                  Text('নাম: ${nameController.text.trim()}\nগ্রুপ: $selectedGroup | বয়স: ${ageController.text.trim()}\nউপজেলা: $selectedUpazila', textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, height: 1.5)),
                                  const SizedBox(height: 6),
                                  const Text('তালিকায় যোগ হয়েছে।', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                                ],
                              ),
                            ),
                            actions: [SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(ctx), child: const Text('ঠিক আছে')))],
                          ),
                        );
                      },
                      icon: const Icon(Icons.volunteer_activism_rounded),
                      label: const Text('রক্তদাতা হিসেবে যোগ দিন', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
