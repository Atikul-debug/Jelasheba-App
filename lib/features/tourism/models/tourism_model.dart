class TouristPlace {
  final String id;
  final String name;
  final String nameBn;
  final String description;
  final String category; // scenic, historical, religious
  final String categoryBn;
  final String address;
  final String? imageUrl;
  final double latitude;
  final double longitude;
  final String? entryFee;
  final String? openingHours;
  final double rating;

  TouristPlace({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.description,
    required this.category,
    required this.categoryBn,
    required this.address,
    this.imageUrl,
    required this.latitude,
    required this.longitude,
    this.entryFee,
    this.openingHours,
    required this.rating,
  });
}

class Hotel {
  final String name;
  final String address;
  final String phone;
  final String priceRange;
  final double rating;
  final List<String> amenities;

  Hotel({
    required this.name,
    required this.address,
    required this.phone,
    required this.priceRange,
    required this.rating,
    required this.amenities,
  });
}

class Restaurant {
  final String name;
  final String address;
  final String phone;
  final String cuisine;
  final String priceRange;
  final double rating;

  Restaurant({
    required this.name,
    required this.address,
    required this.phone,
    required this.cuisine,
    required this.priceRange,
    required this.rating,
  });
}

class Transport {
  final String type; // bus, train, launch
  final String typeBn;
  final String route;
  final String schedule;
  final String fare;
  final String operator;
  final String phone;

  Transport({
    required this.type,
    required this.typeBn,
    required this.route,
    required this.schedule,
    required this.fare,
    required this.operator,
    required this.phone,
  });
}
