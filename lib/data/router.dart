import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/rooms_list_screen.dart';
import '../screens/room_detail_screen.dart';
import '../screens/booking_screen.dart';
import '../screens/booking_confirm_screen.dart';
import '../models/models.dart';
import 'hotel_data.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/',        name: 'home',    builder: (c, s) => const HomeScreen()),
    GoRoute(path: '/rooms',   name: 'rooms',   builder: (c, s) => const RoomsListScreen()),
    GoRoute(
      path: '/rooms/:type', name: 'room-detail',
      builder: (c, s) {
        final typeStr = s.pathParameters['type']!;
        final roomType = RoomType.values.firstWhere((e) => e.name == typeStr);
        final room = HotelData.rooms.firstWhere((r) => r.type == roomType);
        return RoomDetailScreen(room: room);
      },
    ),
    GoRoute(path: '/booking', name: 'booking',
      builder: (c, s) => BookingScreen(room: s.extra as RoomModel)),
    GoRoute(path: '/booking/confirm', name: 'booking-confirm',
      builder: (c, s) => BookingConfirmScreen(booking: s.extra as BookingRequest)),
  ],
);
