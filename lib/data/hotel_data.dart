import '../models/models.dart';

const String _b = 'https://images.unsplash.com';

class HotelData {
  HotelData._();

  static const List<RoomModel> rooms = [
    RoomModel(
      type: RoomType.standard, nameKey: 'roomStandard', descKey: 'roomStandardDesc',
      roomNumbers: 'Rooms 401 – 403',
      imageUrls: ['$_b/photo-1631049307264-da0ec9d70304?w=800&q=80','$_b/photo-1562438668-bcf0ca6578f0?w=800&q=80'],
      rates: {
        MealPlan.bb: {OccupancyType.single: 8000, OccupancyType.double_: 9000},
        MealPlan.hb: {OccupancyType.single: 10000, OccupancyType.double_: 13000},
        MealPlan.fb: {OccupancyType.single: 12000, OccupancyType.double_: 17000},
      },
      maxOccupancy: 2,
      amenityKeys: ['amenityFreeWifi','amenityDSTV','amenityTeaCoffee','amenityHairdryer','amenityBalcony'],
      hasLakeView: true,
    ),
    RoomModel(
      type: RoomType.deluxe, nameKey: 'roomDeluxe', descKey: 'roomDeluxeDesc',
      roomNumbers: 'Room 404',
      imageUrls: ['$_b/photo-1616594039964-ae9021a400a0?w=800&q=80','$_b/photo-1582719478250-c89cae4dc85b?w=800&q=80'],
      rates: {
        MealPlan.bb: {OccupancyType.single: 9000, OccupancyType.double_: 10000},
        MealPlan.hb: {OccupancyType.single: 11000, OccupancyType.double_: 14000},
        MealPlan.fb: {OccupancyType.single: 13000, OccupancyType.double_: 18000},
      },
      maxOccupancy: 2,
      amenityKeys: ['amenityFreeWifi','amenityDSTV','amenityTeaCoffee','amenityHairdryer','amenityBalcony','amenityBathrobe'],
      hasLakeView: true,
    ),
    RoomModel(
      type: RoomType.superior, nameKey: 'roomSuperior', descKey: 'roomSuperiorDesc',
      roomNumbers: 'Rooms 103 – 106',
      imageUrls: ['$_b/photo-1611892440504-42a792e24d32?w=800&q=80','$_b/photo-1629140727571-9b5c6f6267b4?w=800&q=80'],
      rates: {
        MealPlan.bb: {OccupancyType.single: 12000, OccupancyType.double_: 13000},
        MealPlan.hb: {OccupancyType.single: 14000, OccupancyType.double_: 17000},
        MealPlan.fb: {OccupancyType.single: 16000, OccupancyType.double_: 21000},
      },
      maxOccupancy: 3,
      amenityKeys: ['amenityFreeWifi','amenityDSTV','amenityTeaCoffee','amenityHairdryer','amenityBalcony','amenityBathrobe','amenityRoomService'],
      hasLakeView: true,
    ),
    RoomModel(
      type: RoomType.executive, nameKey: 'roomExecutive', descKey: 'roomExecutiveDesc',
      roomNumbers: 'Rooms 101 & 102',
      imageUrls: ['$_b/photo-1578683010236-d716f9a3f461?w=800&q=80','$_b/photo-1560185007-cde436f6a4d0?w=800&q=80','$_b/photo-1571896349842-33c89424de2d?w=800&q=80'],
      rates: {
        MealPlan.bb: {OccupancyType.single: 15000, OccupancyType.double_: 17000},
        MealPlan.hb: {OccupancyType.single: 17000, OccupancyType.double_: 21000},
        MealPlan.fb: {OccupancyType.single: 19000, OccupancyType.double_: 25000},
      },
      maxOccupancy: 2,
      amenityKeys: ['amenityFreeWifi','amenityDSTV','amenityTeaCoffee','amenityHairdryer','amenityJacuzzi','amenityBalcony','amenityBathrobe','amenityRoomService'],
      hasJacuzzi: true,
      hasLakeView: true,
    ),
  ];

  static const List<AmenityModel> hotelAmenities = [
    AmenityModel(key: 'amenityLakefront',   colorHex: 'D0EAF5'),
    AmenityModel(key: 'amenityBoatRiding',  colorHex: 'D4EAE4'),
    AmenityModel(key: 'amenityKidsPool',    colorHex: 'C8E8F2'),
    AmenityModel(key: 'amenityRestaurant',  colorHex: 'FDE8C8'),
    AmenityModel(key: 'amenityFreeWifi',    colorHex: 'E8E0D4'),
    AmenityModel(key: 'amenityDSTV',        colorHex: 'E4D8F0'),
    AmenityModel(key: 'amenityJacuzzi',     colorHex: 'F5D8D0'),
    AmenityModel(key: 'amenityBathrobe',    colorHex: 'D8ECD0'),
    AmenityModel(key: 'amenityBalcony',     colorHex: 'FDE8C8'),
    AmenityModel(key: 'amenityTeaCoffee',   colorHex: 'E8E0D4'),
    AmenityModel(key: 'amenityRoomService', colorHex: 'D4EAE4'),
    AmenityModel(key: 'amenityHairdryer',   colorHex: 'E4D8F0'),
  ];

  static const List<ExperienceModel> experiences = [
    ExperienceModel(titleKey: 'expBoatRide',   descKey: 'expBoatRideDesc',   imageUrl: '$_b/photo-1548032885-b5e38734688a?w=800&q=80'),
    ExperienceModel(titleKey: 'expSunset',     descKey: 'expSunsetDesc',     imageUrl: '$_b/photo-1566438480900-0609be27a4be?w=800&q=80'),
    ExperienceModel(titleKey: 'expRestaurant', descKey: 'expRestaurantDesc', imageUrl: '$_b/photo-1414235077428-338989a2e8c0?w=800&q=80'),
  ];

  static const List<String> heroImages = [
    '$_b/photo-1506905925346-21bda4d32df4?w=1200&q=90',
    '$_b/photo-1548032885-b5e38734688a?w=1200&q=90',
    '$_b/photo-1566438480900-0609be27a4be?w=1200&q=90',
    '$_b/photo-1414235077428-338989a2e8c0?w=1200&q=90',
  ];

  static const String phone   = '+254 792 672 962';
  static const String email   = 'reservations@milimanibeachresort.com';
  static const String website = 'www.milimanibeachresort.com';
  static const String address = 'Off Dunga Beach Road, P.O. Box 2652 – 40100, Kisumu, Kenya';
}
