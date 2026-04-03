class CropAdvice {
  final String name;
  final String nameBn;
  final String season;
  final String seasonBn;
  final String method;
  final String fertilizer;
  final String pesticide;
  final String? imageUrl;

  CropAdvice({
    required this.name,
    required this.nameBn,
    required this.season,
    required this.seasonBn,
    required this.method,
    required this.fertilizer,
    required this.pesticide,
    this.imageUrl,
  });
}

class FertilizerDealer {
  final String name;
  final String address;
  final String phone;
  final String licenseNo;
  final List<String> availableFertilizers;

  FertilizerDealer({
    required this.name,
    required this.address,
    required this.phone,
    required this.licenseNo,
    required this.availableFertilizers,
  });
}

class MarketPrice {
  final String cropName;
  final String cropNameBn;
  final double pricePerKg;
  final String market;
  final DateTime date;

  MarketPrice({
    required this.cropName,
    required this.cropNameBn,
    required this.pricePerKg,
    required this.market,
    required this.date,
  });
}

class AgricultureOffice {
  final String name;
  final String officerName;
  final String designation;
  final String phone;
  final String address;
  final String upazila;

  AgricultureOffice({
    required this.name,
    required this.officerName,
    required this.designation,
    required this.phone,
    required this.address,
    required this.upazila,
  });
}
