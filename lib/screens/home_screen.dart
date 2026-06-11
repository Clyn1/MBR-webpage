import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../generated/app_localizations.dart';
import '../theme/app_theme.dart';
import '../data/hotel_data.dart';
import '../data/app_state.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _leftCtrl  = PageController();
  final _rightCtrl = PageController();
  final _scrollCtrl = ScrollController();
  Timer? _timer;
  int  _page       = 0;
  double _scrollOffset = 0;
  double _navOpacity   = 0; // nav becomes more opaque as user scrolls

  // Lake Victoria / hotel actual images
  final List<String> _leftImages = [
    'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800&q=85', // hotel room
    'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?w=800&q=85', // luxury suite
    'https://images.unsplash.com/photo-1611892440504-42a792e24d32?w=800&q=85', // hotel pool
  ];

  final List<String> _rightImages = [
    'https://images.unsplash.com/photo-1500916434205-0c77489c6cf7?w=1200&q=85', // African lake sunset
    'https://images.unsplash.com/photo-1504432842672-1a79f78e4084?w=1200&q=85', // lake boat
    'https://images.unsplash.com/photo-1516026672322-bc52d61a55d5?w=1200&q=85', // Africa landscape
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (_) {
      final next = (_page + 1) % _leftImages.length;
      setState(() => _page = next);
      _leftCtrl.animateToPage(next,
          duration: const Duration(milliseconds: 1200), curve: Curves.easeInOut);
      _rightCtrl.animateToPage(next,
          duration: const Duration(milliseconds: 1200), curve: Curves.easeInOut);
    });

    _scrollCtrl.addListener(() {
      final offset = _scrollCtrl.offset;
      setState(() {
        _scrollOffset = offset;
        _navOpacity   = (offset / 200).clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _leftCtrl.dispose();
    _rightCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l     = AppLocalizations.of(context)!;
    final state = context.watch<AppState>();
    final h     = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MColors.obsidian,
      body: Stack(children: [

        // ── SCROLLABLE BODY ────────────────────────────────────
        CustomScrollView(
          controller: _scrollCtrl,
          physics: const BouncingScrollPhysics(),
          slivers: [

            // ── HERO (full screen height) ──────────────────────
            SliverToBoxAdapter(child: SizedBox(
              height: h,
              child: _SplitHero(
                leftCtrl:    _leftCtrl,
                rightCtrl:   _rightCtrl,
                leftImages:  _leftImages,
                rightImages: _rightImages,
                scrollOffset: _scrollOffset,
              ),
            )),

            // ── STATS STRIP ────────────────────────────────────
            SliverToBoxAdapter(child: _FadeInSection(
              delay: 0,
              child: _StatsStrip(l: l),
            )),

            // ── INTRO TEXT ─────────────────────────────────────
            SliverToBoxAdapter(child: _FadeInSection(
              delay: 100,
              child: _IntroSection(l: l),
            )),

            // ── ROOMS ──────────────────────────────────────────
            SliverToBoxAdapter(child: _FadeInSection(
              delay: 150,
              child: _RoomsSection(l: l),
            )),

            // ── FULL WIDTH IMAGE BANNER ────────────────────────
            SliverToBoxAdapter(child: _FadeInSection(
              delay: 0,
              child: _FullWidthBanner(),
            )),

            // ── EXPERIENCES ────────────────────────────────────
            SliverToBoxAdapter(child: _FadeInSection(
              delay: 100,
              child: _ExperiencesSection(l: l),
            )),

            // ── AMENITIES ──────────────────────────────────────
            SliverToBoxAdapter(child: _FadeInSection(
              delay: 100,
              child: _AmenitiesSection(l: l),
            )),

            // ── POLICIES ───────────────────────────────────────
            SliverToBoxAdapter(child: _FadeInSection(
              delay: 100,
              child: _PoliciesSection(l: l),
            )),

            // ── FOOTER ─────────────────────────────────────────
            SliverToBoxAdapter(child: _Footer()),
          ],
        ),

        // ── FLOATING NAV (always on top) ──────────────────────
        _FloatingNav(
          l:          l,
          locale:     state.locale,
          onToggle:   state.toggleLocale,
          bgOpacity:  _navOpacity,
          scrollOffset: _scrollOffset,
        ),

        // ── HERO OVERLAYS (dots + arrow + price button) ────────
        // Only visible when near top
        AnimatedOpacity(
          opacity: (1 - _scrollOffset / 120).clamp(0.0, 1.0),
          duration: const Duration(milliseconds: 200),
          child: Stack(children: [
            // Animated down arrow
            Positioned(
              bottom: 72, left: 0, right: 0,
              child: const Center(child: _DownArrow()),
            ),
            // Slide dots
            Positioned(
              bottom: 44, left: 0, right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_leftImages.length, (i) =>
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width:  _page == i ? 24 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: _page == i ? Colors.white : Colors.white.withOpacity(0.38),
                      borderRadius: BorderRadius.circular(4)),
                  )),
              ),
            ),
            // From price button
            Positioned(
              bottom: 28, right: 24,
              child: _FromPriceButton(onTap: () => context.pushNamed('rooms')),
            ),
            // WhatsApp
            Positioned(
              bottom: 24, left: 20,
              child: _WhatsAppBubble(),
            ),
          ]),
        ),

      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  SPLIT HERO with parallax + fade overlay on scroll
// ─────────────────────────────────────────────────────────────
class _SplitHero extends StatelessWidget {
  final PageController leftCtrl, rightCtrl;
  final List<String> leftImages, rightImages;
  final double scrollOffset;

  const _SplitHero({
    required this.leftCtrl, required this.rightCtrl,
    required this.leftImages, required this.rightImages,
    required this.scrollOffset,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    // Parallax: images move up slightly as user scrolls
    final parallax = scrollOffset * 0.3;

    return ClipRect(child: Stack(children: [
      // Images with parallax offset
      Transform.translate(
        offset: Offset(0, -parallax),
        child: SizedBox(height: h + parallax, width: w,
          child: Row(children: [
            // LEFT panel
            SizedBox(width: w * 0.38,
              child: PageView.builder(
                controller: leftCtrl,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: leftImages.length,
                itemBuilder: (_, i) => MImage(url: leftImages[i], height: h),
              )),
            // Divider
            Container(width: 2, color: Colors.white.withOpacity(0.30)),
            // RIGHT panel
            Expanded(child: PageView.builder(
              controller: rightCtrl,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rightImages.length,
              itemBuilder: (_, i) => MImage(url: rightImages[i], height: h),
            )),
          ]),
        ),
      ),

      // Bottom fade-to-white gradient (so content below blends in)
      Positioned(
        bottom: 0, left: 0, right: 0,
        child: Container(height: 160,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Color(0xFF1A1A1A)],
            ))),
      ),

      // Center text overlay on right panel
      Positioned(
        bottom: 180, left: w * 0.38 + 40, right: 40,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: MColors.lakeGold.withOpacity(0.85),
              borderRadius: BorderRadius.circular(20)),
            child: const Text('📍 Kisumu, Lake Victoria',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                color: MColors.obsidian)),
          ),
          const SizedBox(height: 14),
          const Text('Where the Lake\nMeets Luxury',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800,
              color: Colors.white, height: 1.15, letterSpacing: -0.5,
              shadows: [Shadow(color: Colors.black45, blurRadius: 12)])),
        ]),
      ),

      // Left panel dark overlay (subtle)
      Positioned(
        left: 0, top: 0, bottom: 0, width: w * 0.38,
        child: DecoratedBox(decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Colors.black26, Colors.transparent])))),
    ]));
  }
}

// ─────────────────────────────────────────────────────────────
//  FLOATING NAV — transparent at top, dark when scrolled
// ─────────────────────────────────────────────────────────────
class _FloatingNav extends StatelessWidget {
  final AppLocalizations l;
  final Locale locale;
  final VoidCallback onToggle;
  final double bgOpacity;
  final double scrollOffset;

  const _FloatingNav({
    required this.l, required this.locale, required this.onToggle,
    required this.bgOpacity, required this.scrollOffset,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: MColors.obsidian.withOpacity(bgOpacity * 0.92),
        boxShadow: bgOpacity > 0.5 ? [
          BoxShadow(color: Colors.black.withOpacity(0.2 * bgOpacity),
            blurRadius: 8, offset: const Offset(0, 2))
        ] : [],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [

            // LOGO
            _Logo(compact: bgOpacity > 0.5),

            const Spacer(),

            // NAV LINKS
            if (MediaQuery.of(context).size.width > 700) ...[
              _NavLink(l.ourRooms,    () => context.pushNamed('rooms')),
              _NavLink(l.amenities,   () {}),
              _NavLink(l.experiences, () {}),
              _NavLink(l.contactUs,   () {}),
              const SizedBox(width: 8),
            ],

            // Search
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white, size: 22),
              onPressed: () {}),

            // Language toggle
            MLanguageToggle(onToggle: onToggle, currentLocale: locale),

            // Hamburger
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 26),
              onPressed: () => _showMenu(context, l)),
          ]),
        ),
      ),
    );
  }

  void _showMenu(BuildContext ctx, AppLocalizations l) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: MColors.obsidian,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 12),
        Container(width: 40, height: 4,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.24),
            borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 20),
        _MenuItem(Icons.bed_outlined,         l.ourRooms,    () { Navigator.pop(ctx); ctx.pushNamed('rooms'); }),
        _MenuItem(Icons.pool_outlined,        l.amenities,   () => Navigator.pop(ctx)),
        _MenuItem(Icons.directions_boat_outlined, l.experiences, () => Navigator.pop(ctx)),
        _MenuItem(Icons.restaurant_outlined,  'Restaurant',  () => Navigator.pop(ctx)),
        _MenuItem(Icons.phone_outlined,       l.contactUs,   () => Navigator.pop(ctx)),
        const SizedBox(height: 24),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  LOGO
// ─────────────────────────────────────────────────────────────
class _Logo extends StatelessWidget {
  final bool compact;
  const _Logo({this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // Logo image with glowing ring
      Container(
        width:  compact ? 44 : 54,
        height: compact ? 44 : 54,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: MColors.lakeGold.withOpacity(0.7), width: 1.5),
          boxShadow: [
            BoxShadow(color: MColors.lakeGold.withOpacity(0.25),
              blurRadius: 10, spreadRadius: 1)
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset('assets/logo/milimani.jpg',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: MColors.obsidian,
            child: const Icon(Icons.hotel, color: MColors.lakeGold, size: 22))),
      ),
      const SizedBox(width: 10),
      Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, children: [
        Text('Milimani Beach',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: compact ? 14 : 17,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            letterSpacing: 0.3,
            shadows: const [Shadow(color: Colors.black54, blurRadius: 6)],
          )),
        Text('Resort & Spa',
          style: TextStyle(
            fontSize: compact ? 9 : 10,
            color: MColors.lakeGold,
            letterSpacing: 2,
            fontWeight: FontWeight.w500,
          )),
      ]),
    ]);
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink(this.label, this.onTap);
  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onTap,
    style: TextButton.styleFrom(foregroundColor: Colors.white),
    child: Text(label, style: const TextStyle(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.3)),
  );
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuItem(this.icon, this.label, this.onTap);
  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: MColors.lakeGold, size: 20),
    title: Text(label, style: const TextStyle(color: Colors.white, fontSize: 15)),
    onTap: onTap,
  );
}

// ─────────────────────────────────────────────────────────────
//  ANIMATED DOWN ARROW
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
    _anim = Tween(begin: 0.0, end: 10.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _anim,
    builder: (_, __) => Transform.translate(
      offset: Offset(0, _anim.value),
      child: Icon(Icons.keyboard_arrow_down_rounded,
        color: Colors.white.withOpacity(0.9), size: 40)));
}

// ─────────────────────────────────────────────────────────────
//  FROM PRICE BUTTON
// ─────────────────────────────────────────────────────────────
class _FromPriceButton extends StatelessWidget {
  final VoidCallback onTap;
  const _FromPriceButton({required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
      decoration: BoxDecoration(
        color: MColors.obsidian.withOpacity(0.82),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.24)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Text('From KES 8,000', style: TextStyle(
          color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(width: 10),
        Container(width: 32, height: 32,
          decoration: BoxDecoration(
            color: MColors.sunset, shape: BoxShape.circle),
          child: const Icon(Icons.search_rounded,
            color: Colors.white, size: 17)),
      ]),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
//  WHATSAPP BUBBLE
// ─────────────────────────────────────────────────────────────
class _WhatsAppBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    width: 50, height: 50,
    decoration: BoxDecoration(
      color: const Color(0xFF25D366), shape: BoxShape.circle,
      boxShadow: [BoxShadow(color: const Color(0xFF25D366).withOpacity(0.4),
        blurRadius: 12, spreadRadius: 2)]),
    child: const Icon(Icons.chat_rounded, color: Colors.white, size: 24),
  );
}

// ─────────────────────────────────────────────────────────────
//  FADE IN SECTION WRAPPER
// ─────────────────────────────────────────────────────────────
class _FadeInSection extends StatefulWidget {
  final Widget child;
  final int delay;
  const _FadeInSection({required this.child, this.delay = 0});
  @override
  State<_FadeInSection> createState() => _FadeInSectionState();
}

class _FadeInSectionState extends State<_FadeInSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 700));
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _fade,
    child: SlideTransition(position: _slide, child: widget.child));
}

// ─────────────────────────────────────────────────────────────
//  STATS STRIP
// ─────────────────────────────────────────────────────────────
class _StatsStrip extends StatelessWidget {
  final AppLocalizations l;
  const _StatsStrip({required this.l});
  @override
  Widget build(BuildContext context) => Container(
    color: MColors.obsidian,
    padding: const EdgeInsets.symmetric(vertical: 18),
    child: Row(children: [
      _S('KES 8,000', 'From'),
      _D(), _S('★  4.9', l.reviews),
      _D(), _S('Kisumu', l.location),
      _D(), _S('4 Types', l.ourRooms),
    ]),
  );
}
class _S extends StatelessWidget {
  final String v, sub;
  const _S(this.v, this.sub);
  @override
  Widget build(BuildContext context) => Expanded(child: Column(children: [
    Text(v, style: const TextStyle(fontSize: 14,
      fontWeight: FontWeight.w700, color: MColors.lakeGold)),
    const SizedBox(height: 3),
    Text(sub, style: MTextStyles.bodySmall.copyWith(
      color: Colors.white.withOpacity(0.54), fontSize: 11), textAlign: TextAlign.center),
  ]));
}
class _D extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 30, color: Colors.white.withOpacity(0.15));
}

// ─────────────────────────────────────────────────────────────
//  INTRO SECTION
// ─────────────────────────────────────────────────────────────
class _IntroSection extends StatelessWidget {
  final AppLocalizations l;
  const _IntroSection({required this.l});
  @override
  Widget build(BuildContext context) => Container(
    color: MColors.shell,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 52),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('KISUMU · LAKE VICTORIA',
        style: MTextStyles.label.copyWith(color: MColors.sunset, letterSpacing: 3)),
      const SizedBox(height: 14),
      Text('A sanctuary on the\nshores of Africa\'s\ngreatest lake.',
        style: MTextStyles.h1.copyWith(fontSize: 32, height: 1.2,
          fontWeight: FontWeight.w700)),
      const SizedBox(height: 20),
      Container(width: 48, height: 2, color: MColors.sunset),
      const SizedBox(height: 20),
      Text(
        'Milimani Beach Resort sits on the edge of Lake Victoria in Kisumu, Kenya. '
        'Watch traditional dhow sailboats glide across golden waters at sunset, '
        'dine on fresh lake fish, and wake up to panoramic lake views every morning.',
        style: MTextStyles.body.copyWith(fontSize: 15, height: 1.8)),
    ]),
  );
}

// ─────────────────────────────────────────────────────────────
//  ROOMS SECTION
// ─────────────────────────────────────────────────────────────
class _RoomsSection extends StatelessWidget {
  final AppLocalizations l;
  const _RoomsSection({required this.l});
  @override
  Widget build(BuildContext context) => Container(
    color: MColors.shell,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
        child: MSectionHeader(label: l.ourRooms,
          actionText: l.viewAll, onAction: () => context.pushNamed('rooms'))),
      SizedBox(height: 290,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: HotelData.rooms.length,
          separatorBuilder: (_, __) => const SizedBox(width: 14),
          itemBuilder: (ctx, i) {
            final room = HotelData.rooms[i];
            return MRoomCard(room: room,
              onTap: () => ctx.pushNamed('room-detail',
                pathParameters: {'type': room.type.name}));
          })),
      const SizedBox(height: 40),
    ]),
  );
}

// ─────────────────────────────────────────────────────────────
//  FULL WIDTH BANNER (atmospheric divider)
// ─────────────────────────────────────────────────────────────
class _FullWidthBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Stack(children: [
    MImage(
      url: 'https://images.unsplash.com/photo-1504432842672-1a79f78e4084?w=1400&q=85',
      height: 280),
    Positioned.fill(child: DecoratedBox(decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft, end: Alignment.centerRight,
        colors: [Color(0xCC1A1A1A), Color(0x441A1A1A)])))),
    Positioned(left: 32, top: 0, bottom: 0,
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('EXPERIENCES', style: MTextStyles.label.copyWith(
          color: MColors.lakeGold, letterSpacing: 4)),
        const SizedBox(height: 10),
        const Text('Life on\nLake Victoria',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700,
            color: Colors.white, height: 1.2)),
      ])),
  ]);
}

// ─────────────────────────────────────────────────────────────
//  EXPERIENCES SECTION
// ─────────────────────────────────────────────────────────────
class _ExperiencesSection extends StatelessWidget {
  final AppLocalizations l;
  const _ExperiencesSection({required this.l});

  String _title(AppLocalizations l, String k) => switch(k) {
    'expBoatRide' => l.expBoatRide, 'expSunset' => l.expSunset,
    'expRestaurant' => l.expRestaurant, _ => k };
  String _desc(AppLocalizations l, String k) => switch(k) {
    'expBoatRideDesc' => l.expBoatRideDesc, 'expSunsetDesc' => l.expSunsetDesc,
    'expRestaurantDesc' => l.expRestaurantDesc, _ => k };

  @override
  Widget build(BuildContext context) => Container(
    color: MColors.shell,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.fromLTRB(24, 40, 24, 20),
        child: MSectionHeader(label: l.experiences)),
      SizedBox(height: 165,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: HotelData.experiences.length,
          separatorBuilder: (_, __) => const SizedBox(width: 14),
          itemBuilder: (_, i) {
            final e = HotelData.experiences[i];
            return MExperienceCard(imageUrl: e.imageUrl,
              title: _title(l, e.titleKey), description: _desc(l, e.descKey));
          })),
      const SizedBox(height: 40),
    ]),
  );
}

// ─────────────────────────────────────────────────────────────
//  AMENITIES SECTION
// ─────────────────────────────────────────────────────────────
class _AmenitiesSection extends StatelessWidget {
  final AppLocalizations l;
  const _AmenitiesSection({required this.l});
  @override
  Widget build(BuildContext context) => Container(
    color: MColors.grey100,
    padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      MSectionHeader(label: l.amenities),
      const SizedBox(height: 20),
      GridView.builder(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 10,
          mainAxisSpacing: 10, childAspectRatio: 0.9),
        itemCount: HotelData.hotelAmenities.length,
        itemBuilder: (_, i) => MAmenityGridItem(
          amentiyKey: HotelData.hotelAmenities[i].key,
          colorHex:   HotelData.hotelAmenities[i].colorHex)),
    ]),
  );
}

// ─────────────────────────────────────────────────────────────
//  POLICIES SECTION
// ─────────────────────────────────────────────────────────────
class _PoliciesSection extends StatelessWidget {
  final AppLocalizations l;
  const _PoliciesSection({required this.l});
  @override
  Widget build(BuildContext context) => Container(
    color: MColors.shell,
    padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      MSectionHeader(label: l.policies),
      const SizedBox(height: 16),
      MPolicyCard(emoji: '🕐', title: l.checkIn,  value: l.checkInTime),
      const SizedBox(height: 8),
      MPolicyCard(emoji: '🕙', title: l.checkOut, value: l.checkOutTime),
      const SizedBox(height: 8),
      MPolicyCard(emoji: '👦', title: l.children12Free, value: 'Under 12 free'),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFFDF6EC),
          borderRadius: BorderRadius.circular(MRadius.md),
          border: Border.all(color: MColors.lakeGold.withOpacity(0.35))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(l.cancellationPolicy,
            style: MTextStyles.h3.copyWith(fontSize: 13)),
          const SizedBox(height: 10),
          _CR('✅', l.cancelFull),
          _CR('⚠️', l.cancelHalf),
          _CR('❌', l.cancelNone),
        ])),
    ]),
  );
}
class _CR extends StatelessWidget {
  final String e, t;
  const _CR(this.e, this.t);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(e, style: const TextStyle(fontSize: 13)),
      const SizedBox(width: 6),
      Expanded(child: Text(t, style: MTextStyles.bodySmall)),
    ]));
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
      const SizedBox(height: 6),
      Text(HotelData.address,
        style: MTextStyles.bodySmall.copyWith(color: Colors.white.withOpacity(0.54))),
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
      Text(t, style: MTextStyles.bodySmall.copyWith(color: Colors.white.withOpacity(0.60))),
    ]));
}