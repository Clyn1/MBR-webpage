enum RoomType { standard, deluxe, superior, executive }
enum MealPlan { bb, hb, fb }
enum OccupancyType { single, double_ }

class RoomModel {
  final RoomType type;
  final String nameKey;
  final String descKey;
  final String roomNumbers;
  final List<String> imageUrls;
  final Map<MealPlan, Map<OccupancyType, int>> rates;
  final int maxOccupancy;
  final List<String> amenityKeys;
  final bool hasJacuzzi;
  final bool hasLakeView;

  const RoomModel({
    required this.type, required this.nameKey, required this.descKey,
    required this.roomNumbers, required this.imageUrls, required this.rates,
    required this.maxOccupancy, required this.amenityKeys,
    this.hasJacuzzi = false, this.hasLakeView = false,
  });

  int rate(MealPlan plan, OccupancyType occ) => rates[plan]![occ]!;
  int get lowestRate => rates[MealPlan.bb]![OccupancyType.single]!;
}

class AmenityModel {
  final String key;
  final String colorHex;
  const AmenityModel({required this.key, required this.colorHex});
}

class ExperienceModel {
  final String titleKey;
  final String descKey;
  final String imageUrl;
  const ExperienceModel({required this.titleKey, required this.descKey, required this.imageUrl});
}

class BookingRequest {
  final RoomModel room;
  final MealPlan mealPlan;
  final OccupancyType occupancy;
  final DateTime checkIn;
  final DateTime checkOut;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final int guests;
  final String? specialRequests;

  const BookingRequest({
    required this.room, required this.mealPlan, required this.occupancy,
    required this.checkIn, required this.checkOut, required this.firstName,
    required this.lastName, required this.email, required this.phone,
    required this.guests, this.specialRequests,
  });

  int get nights => checkOut.difference(checkIn).inDays;
  int get totalPrice => room.rate(mealPlan, occupancy) * nights;
}
