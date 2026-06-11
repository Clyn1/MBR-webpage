import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('sw')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Milimani Beach Resort'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Where the Lake Meets Luxury'**
  String get tagline;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Kisumu, Lake Victoria'**
  String get location;

  /// No description provided for @exploreRooms.
  ///
  /// In en, this message translates to:
  /// **'Explore Rooms'**
  String get exploreRooms;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @ourRooms.
  ///
  /// In en, this message translates to:
  /// **'Our Rooms'**
  String get ourRooms;

  /// No description provided for @amenities.
  ///
  /// In en, this message translates to:
  /// **'Amenities'**
  String get amenities;

  /// No description provided for @experiences.
  ///
  /// In en, this message translates to:
  /// **'Experiences'**
  String get experiences;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Guest Reviews'**
  String get reviews;

  /// No description provided for @policies.
  ///
  /// In en, this message translates to:
  /// **'Hotel Policies'**
  String get policies;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @callUs.
  ///
  /// In en, this message translates to:
  /// **'Call Us'**
  String get callUs;

  /// No description provided for @emailUs.
  ///
  /// In en, this message translates to:
  /// **'Email Us'**
  String get emailUs;

  /// No description provided for @fromPrice.
  ///
  /// In en, this message translates to:
  /// **'From KES {price}'**
  String fromPrice(String price);

  /// No description provided for @perNight.
  ///
  /// In en, this message translates to:
  /// **'/ night'**
  String get perNight;

  /// No description provided for @children12Free.
  ///
  /// In en, this message translates to:
  /// **'Children under 12 stay free'**
  String get children12Free;

  /// No description provided for @roomStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard Room'**
  String get roomStandard;

  /// No description provided for @roomDeluxe.
  ///
  /// In en, this message translates to:
  /// **'Deluxe Room'**
  String get roomDeluxe;

  /// No description provided for @roomSuperior.
  ///
  /// In en, this message translates to:
  /// **'Superior Room'**
  String get roomSuperior;

  /// No description provided for @roomExecutive.
  ///
  /// In en, this message translates to:
  /// **'Executive Suite'**
  String get roomExecutive;

  /// No description provided for @roomStandardDesc.
  ///
  /// In en, this message translates to:
  /// **'Comfortable lake-view rooms with modern amenities. Perfect for a relaxing lakeside getaway on the shores of Lake Victoria.'**
  String get roomStandardDesc;

  /// No description provided for @roomDeluxeDesc.
  ///
  /// In en, this message translates to:
  /// **'Elevated comfort with premium furnishings, a private balcony, and stunning lake vistas. Ideal for couples and solo travellers.'**
  String get roomDeluxeDesc;

  /// No description provided for @roomSuperiorDesc.
  ///
  /// In en, this message translates to:
  /// **'Spacious and beautifully appointed rooms with panoramic lake views. Enjoy the finest facilities Milimani has to offer.'**
  String get roomSuperiorDesc;

  /// No description provided for @roomExecutiveDesc.
  ///
  /// In en, this message translates to:
  /// **'Our most prestigious accommodation. Floor-to-ceiling views of Lake Victoria, a Jacuzzi, and personal butler service on request.'**
  String get roomExecutiveDesc;

  /// No description provided for @roomNumbersStandard.
  ///
  /// In en, this message translates to:
  /// **'Rooms 401 – 403'**
  String get roomNumbersStandard;

  /// No description provided for @roomNumbersDeluxe.
  ///
  /// In en, this message translates to:
  /// **'Room 404'**
  String get roomNumbersDeluxe;

  /// No description provided for @roomNumbersSuperior.
  ///
  /// In en, this message translates to:
  /// **'Rooms 103 – 106'**
  String get roomNumbersSuperior;

  /// No description provided for @roomNumbersExecutive.
  ///
  /// In en, this message translates to:
  /// **'Rooms 101 & 102'**
  String get roomNumbersExecutive;

  /// No description provided for @sleeps.
  ///
  /// In en, this message translates to:
  /// **'Sleeps {count}'**
  String sleeps(int count);

  /// No description provided for @mealPlan.
  ///
  /// In en, this message translates to:
  /// **'Meal Plan'**
  String get mealPlan;

  /// No description provided for @mealBB.
  ///
  /// In en, this message translates to:
  /// **'Bed & Breakfast'**
  String get mealBB;

  /// No description provided for @mealBBShort.
  ///
  /// In en, this message translates to:
  /// **'BB'**
  String get mealBBShort;

  /// No description provided for @mealHB.
  ///
  /// In en, this message translates to:
  /// **'Half Board'**
  String get mealHB;

  /// No description provided for @mealHBShort.
  ///
  /// In en, this message translates to:
  /// **'HB'**
  String get mealHBShort;

  /// No description provided for @mealFB.
  ///
  /// In en, this message translates to:
  /// **'Full Board'**
  String get mealFB;

  /// No description provided for @mealFBShort.
  ///
  /// In en, this message translates to:
  /// **'FB'**
  String get mealFBShort;

  /// No description provided for @singleRoom.
  ///
  /// In en, this message translates to:
  /// **'Single'**
  String get singleRoom;

  /// No description provided for @doubleRoom.
  ///
  /// In en, this message translates to:
  /// **'Double'**
  String get doubleRoom;

  /// No description provided for @amenityLakefront.
  ///
  /// In en, this message translates to:
  /// **'Lakefront'**
  String get amenityLakefront;

  /// No description provided for @amenityBoatRiding.
  ///
  /// In en, this message translates to:
  /// **'Boat Riding'**
  String get amenityBoatRiding;

  /// No description provided for @amenityKidsPool.
  ///
  /// In en, this message translates to:
  /// **'Kids Pool'**
  String get amenityKidsPool;

  /// No description provided for @amenityRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get amenityRestaurant;

  /// No description provided for @amenityFreeWifi.
  ///
  /// In en, this message translates to:
  /// **'Free Wifi'**
  String get amenityFreeWifi;

  /// No description provided for @amenityDSTV.
  ///
  /// In en, this message translates to:
  /// **'DSTV'**
  String get amenityDSTV;

  /// No description provided for @amenityJacuzzi.
  ///
  /// In en, this message translates to:
  /// **'Jacuzzi'**
  String get amenityJacuzzi;

  /// No description provided for @amenityHairdryer.
  ///
  /// In en, this message translates to:
  /// **'Hairdryer'**
  String get amenityHairdryer;

  /// No description provided for @amenityBalcony.
  ///
  /// In en, this message translates to:
  /// **'Balcony / Patio'**
  String get amenityBalcony;

  /// No description provided for @amenityTeaCoffee.
  ///
  /// In en, this message translates to:
  /// **'Tea & Coffee'**
  String get amenityTeaCoffee;

  /// No description provided for @amenityBathrobe.
  ///
  /// In en, this message translates to:
  /// **'Bathrobes'**
  String get amenityBathrobe;

  /// No description provided for @amenityRoomService.
  ///
  /// In en, this message translates to:
  /// **'Room Service'**
  String get amenityRoomService;

  /// No description provided for @expBoatRide.
  ///
  /// In en, this message translates to:
  /// **'Dhow & Boat Rides'**
  String get expBoatRide;

  /// No description provided for @expBoatRideDesc.
  ///
  /// In en, this message translates to:
  /// **'Sail across Lake Victoria on a traditional dhow or our modern pontoon boat as the sun sets over the horizon.'**
  String get expBoatRideDesc;

  /// No description provided for @expSunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset Viewing'**
  String get expSunset;

  /// No description provided for @expSunsetDesc.
  ///
  /// In en, this message translates to:
  /// **'Lake Victoria sunsets are among the most spectacular in East Africa. Watch from our lakefront terrace.'**
  String get expSunsetDesc;

  /// No description provided for @expRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Lakeside Dining'**
  String get expRestaurant;

  /// No description provided for @expRestaurantDesc.
  ///
  /// In en, this message translates to:
  /// **'Fresh fish from Lake Victoria served with local and international cuisine in our open-air restaurant.'**
  String get expRestaurantDesc;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get checkIn;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Check-out'**
  String get checkOut;

  /// No description provided for @checkInTime.
  ///
  /// In en, this message translates to:
  /// **'12:00 Noon'**
  String get checkInTime;

  /// No description provided for @checkOutTime.
  ///
  /// In en, this message translates to:
  /// **'10:00 AM'**
  String get checkOutTime;

  /// No description provided for @cancellationPolicy.
  ///
  /// In en, this message translates to:
  /// **'Cancellation Policy'**
  String get cancellationPolicy;

  /// No description provided for @cancelFull.
  ///
  /// In en, this message translates to:
  /// **'Full refund if cancelled 30+ days before'**
  String get cancelFull;

  /// No description provided for @cancelHalf.
  ///
  /// In en, this message translates to:
  /// **'50% refund if cancelled 8–30 days before'**
  String get cancelHalf;

  /// No description provided for @cancelNone.
  ///
  /// In en, this message translates to:
  /// **'No refund if cancelled within 7 days'**
  String get cancelNone;

  /// No description provided for @selectDates.
  ///
  /// In en, this message translates to:
  /// **'Select Dates'**
  String get selectDates;

  /// No description provided for @checkInDate.
  ///
  /// In en, this message translates to:
  /// **'Check-in Date'**
  String get checkInDate;

  /// No description provided for @checkOutDate.
  ///
  /// In en, this message translates to:
  /// **'Check-out Date'**
  String get checkOutDate;

  /// No description provided for @guestDetails.
  ///
  /// In en, this message translates to:
  /// **'Guest Details'**
  String get guestDetails;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @numberOfGuests.
  ///
  /// In en, this message translates to:
  /// **'Number of Guests'**
  String get numberOfGuests;

  /// No description provided for @specialRequests.
  ///
  /// In en, this message translates to:
  /// **'Special Requests (optional)'**
  String get specialRequests;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// No description provided for @bookingSummary.
  ///
  /// In en, this message translates to:
  /// **'Booking Summary'**
  String get bookingSummary;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalPrice;

  /// No description provided for @nights.
  ///
  /// In en, this message translates to:
  /// **'{count} nights'**
  String nights(int count);

  /// No description provided for @switchLanguage.
  ///
  /// In en, this message translates to:
  /// **'SW'**
  String get switchLanguage;

  /// No description provided for @mealPlanLabel.
  ///
  /// In en, this message translates to:
  /// **'Meal Plan'**
  String get mealPlanLabel;

  /// No description provided for @allRates.
  ///
  /// In en, this message translates to:
  /// **'All Rates (KES)'**
  String get allRates;

  /// No description provided for @occupancy.
  ///
  /// In en, this message translates to:
  /// **'Occupancy'**
  String get occupancy;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'sw':
      return AppLocalizationsSw();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
