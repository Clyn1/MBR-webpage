import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../generated/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import '../data/hotel_data.dart';

class BookingConfirmScreen extends StatelessWidget {
  final BookingRequest booking;
  const BookingConfirmScreen({super.key, required this.booking});

  String _fmtDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final room = booking.room;
    final name = localizedRoomName(l, room.nameKey);

    return Scaffold(
      backgroundColor: MColors.shell,
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(child: Container(
          color: MColors.obsidian,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 32,
            bottom: 40, left: 24, right: 24),
          child: Column(children: [
            Container(width: 60, height: 60,
              decoration: BoxDecoration(color: MColors.lakeGold.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(color: MColors.lakeGold.withOpacity(0.4))),
              child: const Center(child: Text('✓', style: TextStyle(fontSize: 26,
                color: MColors.lakeGold, fontWeight: FontWeight.bold)))),
            const SizedBox(height: 16),
            Text(l.bookingSummary.toUpperCase(), style: MTextStyles.label.copyWith(color: MColors.lakeGold)),
            const SizedBox(height: 8),
            Text('${booking.firstName} ${booking.lastName}',
              style: MTextStyles.h2.copyWith(color: MColors.shell)),
            const SizedBox(height: 4),
            Text(name, style: MTextStyles.body.copyWith(color: MColors.shell.withOpacity(0.7))),
          ]))),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(24),
          child: Container(padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(MRadius.lg),
              boxShadow: [BoxShadow(color: MColors.obsidian.withOpacity(0.06), blurRadius: 16)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              MRoomTypeTag(type: room.type),
              const SizedBox(height: 16),
              _Row('🏨', 'Room', '$name · ${room.roomNumbers}'),
              _Row('📅', l.checkInDate,  _fmtDate(booking.checkIn)),
              _Row('📅', l.checkOutDate, _fmtDate(booking.checkOut)),
              _Row('🌙', 'Nights', '${booking.nights}'),
              _Row('🍽', l.mealPlan, _mealLbl(l, booking.mealPlan)),
              _Row('🧍', 'Occupancy', _occLbl(l, booking.occupancy)),
              _Row('👤', l.guestDetails, '${booking.firstName} ${booking.lastName}'),
              _Row('✉️', l.email, booking.email),
              _Row('📞', l.phone, booking.phone),
              if (booking.specialRequests != null)
                _Row('📝', l.specialRequests, booking.specialRequests!),
              const Divider(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(l.totalPrice, style: MTextStyles.h3),
                Text(fmtPrice(booking.totalPrice), style: MTextStyles.price),
              ]),
              const SizedBox(height: 4),
              Text('${booking.nights} night${booking.nights > 1 ? 's' : ''} × ${fmtPrice(booking.room.rate(booking.mealPlan, booking.occupancy))}',
                style: MTextStyles.bodySmall),
            ])))),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            GestureDetector(
              onTap: () => launchUrl(Uri.parse('tel:${HotelData.phone}')),
              child: Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(color: MColors.sunset,
                  borderRadius: BorderRadius.circular(MRadius.pill),
                  boxShadow: [BoxShadow(color: MColors.sunset.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))]),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('📞', style: TextStyle(fontSize: 16)), const SizedBox(width: 8),
                  Text(l.callUs, style: MTextStyles.button.copyWith(color: MColors.shell)),
                ]))),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => launchUrl(Uri.parse('mailto:${HotelData.email}?subject=Room Booking - $name')),
              child: Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(border: Border.all(color: MColors.obsidian),
                  borderRadius: BorderRadius.circular(MRadius.pill)),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('✉️', style: TextStyle(fontSize: 16)), const SizedBox(width: 8),
                  Text(l.emailUs, style: MTextStyles.button),
                ]))),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => context.goNamed('home'),
              child: Text(l.backToHome, style: MTextStyles.bodySmall.copyWith(color: MColors.grey600))),
            const SizedBox(height: 12),
            Container(padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFFFF8E8),
                borderRadius: BorderRadius.circular(MRadius.md),
                border: Border.all(color: MColors.lakeGold.withOpacity(0.4))),
              child: Text('⚠️  ${l.cancellationPolicy}: ${l.cancelFull}',
                style: MTextStyles.bodySmall.copyWith(fontSize: 11))),
          ]))),
        const SliverPadding(padding: EdgeInsets.only(bottom: 48)),
      ]),
    );
  }
}

class _Row extends StatelessWidget {
  final String emoji, label, value;
  const _Row(this.emoji, this.label, this.value);
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 12),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(emoji, style: const TextStyle(fontSize: 14)), const SizedBox(width: 8),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: MTextStyles.bodySmall.copyWith(fontSize: 10)),
        Text(value, style: MTextStyles.body.copyWith(height: 1.3)),
      ])),
    ]));
}

String _mealLbl(AppLocalizations l, MealPlan p) => switch(p) {
  MealPlan.bb => l.mealBB, MealPlan.hb => l.mealHB, MealPlan.fb => l.mealFB };
String _occLbl(AppLocalizations l, OccupancyType o) => switch(o) {
  OccupancyType.single => l.singleRoom, OccupancyType.double_ => l.doubleRoom };
