import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../generated/app_localizations.dart';
import '../theme/app_theme.dart';
import '../data/hotel_data.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class RoomsListScreen extends StatefulWidget {
  const RoomsListScreen({super.key});
  @override
  State<RoomsListScreen> createState() => _RoomsListScreenState();
}

class _RoomsListScreenState extends State<RoomsListScreen> {
  MealPlan _plan = MealPlan.bb;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

          // ── HERO ──────────────────────────────────────────────
          SliverToBoxAdapter(child: _RoomsHero(l: l)),

          // ── INTRO TEXT ────────────────────────────────────────
          SliverToBoxAdapter(child: _IntroText(l: l)),

          // ── MEAL PLAN SELECTOR ────────────────────────────────
          SliverToBoxAdapter(child: _MealPlanBar(
            selected: _plan,
            onChanged: (p) => setState(() => _plan = p),
            l: l,
          )),

          // ── ROOM CARDS ────────────────────────────────────────
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => _RoomCard(
                room: HotelData.rooms[i],
                plan: _plan,
                l: l,
                onBook: () => ctx.pushNamed('room-detail',
                    pathParameters: {'type': HotelData.rooms[i].type.name}),
              ),
              childCount: HotelData.rooms.length,
            ),
          ),

          // ── FOOTER ────────────────────────────────────────────
          SliverToBoxAdapter(child: _Footer()),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  HERO — full screen, image + title + CTA (like Diani Reef)
// ─────────────────────────────────────────────────────────────
class _RoomsHero extends StatelessWidget {
  final AppLocalizations l;
  const _RoomsHero({required this.l});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return SizedBox(
      height: h * 0.78,
      child: Stack(fit: StackFit.expand, children: [

        // Background image
        MImage(
          url: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=1400&q=85',
          height: h * 0.78,
        ),

        // Dark overlay
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x55000000),
                Color(0x22000000),
                Color(0x88000000),
              ],
              stops: [0.0, 0.4, 1.0],
            ),
          ),
        ),

        // TOP NAV
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(children: [
              // Back + Logo
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white, size: 16),
                ),
              ),
              const SizedBox(width: 12),
              // Logo
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: MColors.lakeGold.withOpacity(0.7), width: 1.5),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset('assets/logo/milimani.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                        color: MColors.obsidian,
                        child: const Icon(Icons.hotel,
                            color: MColors.lakeGold, size: 20))),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Milimani Beach',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black54, blurRadius: 6)],
                      )),
                  Text('Resort & Spa',
                      style: TextStyle(
                          fontSize: 9,
                          color: MColors.lakeGold,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ]),
          ),
        ),

        // HERO CONTENT — bottom left (like Diani Reef)
        Positioned(
          bottom: 80,
          left: 32,
          right: 32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('HOME AWAY\nFROM HOME',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.1,
                  letterSpacing: -0.5,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 10)],
                )),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('View Rooms',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    )),
                ),
              ),
            ],
          ),
        ),

        // Down arrow
        Positioned(
          bottom: 24,
          left: 0, right: 0,
          child: const Center(child: _DownArrow()),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  INTRO TEXT (like "A BLEND OF LUXURY & COMFORT")
// ─────────────────────────────────────────────────────────────
class _IntroText extends StatelessWidget {
  final AppLocalizations l;
  const _IntroText({required this.l});

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(28, 52, 28, 40),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('A BLEND OF LUXURY & COMFORT',
        style: MTextStyles.h1.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: MColors.sunset,
          letterSpacing: -0.5,
        )),
      const SizedBox(height: 20),
      Text(
        'Whether you\'re planning a romantic lakefront getaway, a family vacation, '
        'or a peaceful retreat on Africa\'s greatest lake, Milimani Beach Resort '
        'offers the perfect sanctuary to relax, unwind, and recharge.',
        style: MTextStyles.body.copyWith(fontSize: 15, height: 1.8,
            color: const Color(0xFF444444)),
      ),
      const SizedBox(height: 16),
      Text(
        'Our rooms range from comfortable Standard rooms to premium Executive Suites, '
        'all with stunning Lake Victoria views, DSTV, free WiFi, tea & coffee '
        'facilities, hairdryer, and private balcony or patio. '
        'Choose your meal plan — Bed & Breakfast, Half Board, or Full Board.',
        style: MTextStyles.body.copyWith(fontSize: 15, height: 1.8,
            color: const Color(0xFF444444)),
      ),
      const SizedBox(height: 24),
      Container(width: 60, height: 3,
        decoration: BoxDecoration(
          color: MColors.sunset,
          borderRadius: BorderRadius.circular(2))),
    ]),
  );
}

// ─────────────────────────────────────────────────────────────
//  MEAL PLAN BAR
// ─────────────────────────────────────────────────────────────
class _MealPlanBar extends StatelessWidget {
  final MealPlan selected;
  final ValueChanged<MealPlan> onChanged;
  final AppLocalizations l;
  const _MealPlanBar({required this.selected, required this.onChanged, required this.l});

  @override
  Widget build(BuildContext context) => Container(
    color: MColors.grey100,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('SELECT MEAL PLAN',
        style: MTextStyles.label.copyWith(letterSpacing: 2)),
      const SizedBox(height: 10),
      MMealPlanSelector(selected: selected, onChanged: onChanged),
      const SizedBox(height: 8),
      Text(
        'BB = Bed & Breakfast  ·  HB = Half Board (+ lunch/dinner)  ·  FB = Full Board',
        style: MTextStyles.bodySmall.copyWith(fontSize: 11)),
    ]),
  );
}

// ─────────────────────────────────────────────────────────────
//  ROOM CARD — horizontal, like Diani Reef
//  Image on left, details on right, Book Now button
// ─────────────────────────────────────────────────────────────
class _RoomCard extends StatelessWidget {
  final RoomModel room;
  final MealPlan plan;
  final AppLocalizations l;
  final VoidCallback onBook;

  const _RoomCard({
    required this.room,
    required this.plan,
    required this.l,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    final name   = localizedRoomName(l, room.nameKey);
    final desc   = localizedRoomDesc(l, room.descKey);
    final single = room.rate(plan, OccupancyType.single);
    final dbl    = room.rate(plan, OccupancyType.double_);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        // IMAGE — full width on top
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          child: MImage(url: room.imageUrls.first, height: 220),
        ),

        // CONTENT
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            // Room type badge + name
            Row(children: [
              MRoomTypeTag(type: room.type),
              if (room.hasLakeView) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: MColors.lakeTeal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text('🏞 Lake View',
                    style: TextStyle(fontSize: 10,
                        fontWeight: FontWeight.w600, color: MColors.lakeTeal)),
                ),
              ],
            ]),

            const SizedBox(height: 14),

            // Room name
            Text(name, style: MTextStyles.h2.copyWith(
              fontSize: 22, color: MColors.sunset)),

            const SizedBox(height: 6),

            // Room number + max occupancy
            Text('${room.roomNumbers}  ·  Max Occupancy ${room.maxOccupancy}',
              style: MTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600, color: MColors.grey600)),

            const SizedBox(height: 12),

            // Amenity icons row
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: room.amenityKeys.map((k) => Tooltip(
                message: localizedAmenity(l, k),
                child: Text(amenityEmoji(k),
                    style: const TextStyle(fontSize: 20)),
              )).toList(),
            ),

            const SizedBox(height: 16),

            // Description
            Text(desc, style: MTextStyles.body.copyWith(
              fontSize: 14, height: 1.75, color: const Color(0xFF555555))),

            const SizedBox(height: 20),

            // Price
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MColors.grey100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_planLabel(l, plan),
                      style: MTextStyles.label.copyWith(letterSpacing: 1.5)),
                    const SizedBox(height: 6),
                    Row(children: [
                      const Text('🧍 ', style: TextStyle(fontSize: 14)),
                      Text('KES ${_fmt(single)}/night',
                        style: MTextStyles.priceSmall),
                    ]),
                    const SizedBox(height: 3),
                    Row(children: [
                      const Text('👫 ', style: TextStyle(fontSize: 14)),
                      Text('KES ${_fmt(dbl)}/night',
                        style: MTextStyles.priceSmall),
                    ]),
                  ],
                )),
                const SizedBox(width: 16),
                // BOOK NOW button (like Diani Reef)
                GestureDetector(
                  onTap: onBook,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 14),
                    decoration: BoxDecoration(
                      color: MColors.sunset,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: MColors.sunset.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Text('Book Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      )),
                  ),
                ),
              ]),
            ),

          ]),
        ),
      ]),
    );
  }

  String _planLabel(AppLocalizations l, MealPlan p) => switch (p) {
    MealPlan.bb => l.mealBB,
    MealPlan.hb => l.mealHB,
    MealPlan.fb => l.mealFB,
  };

  String _fmt(int n) => n.toString()
      .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},');
}

// ─────────────────────────────────────────────────────────────
//  DOWN ARROW
// ─────────────────────────────────────────────────────────────
class _DownArrow extends StatefulWidget {
  const _DownArrow();
  @override
  State<_DownArrow> createState() => _DownArrowState();
}

class _DownArrowState extends State<_DownArrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 800))..repeat(reverse: true);
    _anim = Tween(begin: 0.0, end: 10.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _anim,
    builder: (_, __) => Transform.translate(
      offset: Offset(0, _anim.value),
      child: const Icon(Icons.keyboard_arrow_down_rounded,
          color: Colors.white, size: 40)));
}

// ─────────────────────────────────────────────────────────────
//  FOOTER
// ─────────────────────────────────────────────────────────────
class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    color: MColors.obsidian,
    padding: const EdgeInsets.fromLTRB(24, 36, 24, 36),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('MILIMANI BEACH RESORT',
        style: MTextStyles.label.copyWith(color: MColors.lakeGold)),
      const SizedBox(height: 8),
      Text(HotelData.address,
        style: MTextStyles.bodySmall.copyWith(
            color: Colors.white.withOpacity(0.54))),
      const SizedBox(height: 14),
      _FR('📞', HotelData.phone),
      _FR('✉️', HotelData.email),
      _FR('🌐', HotelData.website),
      const SizedBox(height: 24),
      Divider(color: Colors.white.withOpacity(0.12)),
      const SizedBox(height: 12),
      Text('© 2025 Milimani Beach Resort. All rights reserved.',
        style: MTextStyles.bodySmall.copyWith(
            color: Colors.white.withOpacity(0.30), fontSize: 10)),
    ]),
  );
}

class _FR extends StatelessWidget {
  final String e, t;
  const _FR(this.e, this.t);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(children: [
      Text(e, style: const TextStyle(fontSize: 13)),
      const SizedBox(width: 8),
      Text(t, style: MTextStyles.bodySmall.copyWith(
          color: Colors.white.withOpacity(0.60))),
    ]));
}