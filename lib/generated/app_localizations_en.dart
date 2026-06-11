// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Milimani Beach Resort';

  @override
  String get tagline => 'Where the Lake Meets Luxury';

  @override
  String get location => 'Kisumu, Lake Victoria';

  @override
  String get exploreRooms => 'Explore Rooms';

  @override
  String get bookNow => 'Book Now';

  @override
  String get viewDetails => 'View Details';

  @override
  String get viewAll => 'View All';

  @override
  String get ourRooms => 'Our Rooms';

  @override
  String get amenities => 'Amenities';

  @override
  String get experiences => 'Experiences';

  @override
  String get reviews => 'Guest Reviews';

  @override
  String get policies => 'Hotel Policies';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get callUs => 'Call Us';

  @override
  String get emailUs => 'Email Us';

  @override
  String fromPrice(String price) {
    return 'From KES $price';
  }

  @override
  String get perNight => '/ night';

  @override
  String get children12Free => 'Children under 12 stay free';

  @override
  String get roomStandard => 'Standard Room';

  @override
  String get roomDeluxe => 'Deluxe Room';

  @override
  String get roomSuperior => 'Superior Room';

  @override
  String get roomExecutive => 'Executive Suite';

  @override
  String get roomStandardDesc =>
      'Comfortable lake-view rooms with modern amenities. Perfect for a relaxing lakeside getaway on the shores of Lake Victoria.';

  @override
  String get roomDeluxeDesc =>
      'Elevated comfort with premium furnishings, a private balcony, and stunning lake vistas. Ideal for couples and solo travellers.';

  @override
  String get roomSuperiorDesc =>
      'Spacious and beautifully appointed rooms with panoramic lake views. Enjoy the finest facilities Milimani has to offer.';

  @override
  String get roomExecutiveDesc =>
      'Our most prestigious accommodation. Floor-to-ceiling views of Lake Victoria, a Jacuzzi, and personal butler service on request.';

  @override
  String get roomNumbersStandard => 'Rooms 401 – 403';

  @override
  String get roomNumbersDeluxe => 'Room 404';

  @override
  String get roomNumbersSuperior => 'Rooms 103 – 106';

  @override
  String get roomNumbersExecutive => 'Rooms 101 & 102';

  @override
  String sleeps(int count) {
    return 'Sleeps $count';
  }

  @override
  String get mealPlan => 'Meal Plan';

  @override
  String get mealBB => 'Bed & Breakfast';

  @override
  String get mealBBShort => 'BB';

  @override
  String get mealHB => 'Half Board';

  @override
  String get mealHBShort => 'HB';

  @override
  String get mealFB => 'Full Board';

  @override
  String get mealFBShort => 'FB';

  @override
  String get singleRoom => 'Single';

  @override
  String get doubleRoom => 'Double';

  @override
  String get amenityLakefront => 'Lakefront';

  @override
  String get amenityBoatRiding => 'Boat Riding';

  @override
  String get amenityKidsPool => 'Kids Pool';

  @override
  String get amenityRestaurant => 'Restaurant';

  @override
  String get amenityFreeWifi => 'Free Wifi';

  @override
  String get amenityDSTV => 'DSTV';

  @override
  String get amenityJacuzzi => 'Jacuzzi';

  @override
  String get amenityHairdryer => 'Hairdryer';

  @override
  String get amenityBalcony => 'Balcony / Patio';

  @override
  String get amenityTeaCoffee => 'Tea & Coffee';

  @override
  String get amenityBathrobe => 'Bathrobes';

  @override
  String get amenityRoomService => 'Room Service';

  @override
  String get expBoatRide => 'Dhow & Boat Rides';

  @override
  String get expBoatRideDesc =>
      'Sail across Lake Victoria on a traditional dhow or our modern pontoon boat as the sun sets over the horizon.';

  @override
  String get expSunset => 'Sunset Viewing';

  @override
  String get expSunsetDesc =>
      'Lake Victoria sunsets are among the most spectacular in East Africa. Watch from our lakefront terrace.';

  @override
  String get expRestaurant => 'Lakeside Dining';

  @override
  String get expRestaurantDesc =>
      'Fresh fish from Lake Victoria served with local and international cuisine in our open-air restaurant.';

  @override
  String get checkIn => 'Check-in';

  @override
  String get checkOut => 'Check-out';

  @override
  String get checkInTime => '12:00 Noon';

  @override
  String get checkOutTime => '10:00 AM';

  @override
  String get cancellationPolicy => 'Cancellation Policy';

  @override
  String get cancelFull => 'Full refund if cancelled 30+ days before';

  @override
  String get cancelHalf => '50% refund if cancelled 8–30 days before';

  @override
  String get cancelNone => 'No refund if cancelled within 7 days';

  @override
  String get selectDates => 'Select Dates';

  @override
  String get checkInDate => 'Check-in Date';

  @override
  String get checkOutDate => 'Check-out Date';

  @override
  String get guestDetails => 'Guest Details';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get email => 'Email Address';

  @override
  String get phone => 'Phone Number';

  @override
  String get numberOfGuests => 'Number of Guests';

  @override
  String get specialRequests => 'Special Requests (optional)';

  @override
  String get confirmBooking => 'Confirm Booking';

  @override
  String get bookingSummary => 'Booking Summary';

  @override
  String get totalPrice => 'Total';

  @override
  String nights(int count) {
    return '$count nights';
  }

  @override
  String get switchLanguage => 'SW';

  @override
  String get mealPlanLabel => 'Meal Plan';

  @override
  String get allRates => 'All Rates (KES)';

  @override
  String get occupancy => 'Occupancy';

  @override
  String get backToHome => 'Back to Home';
}
