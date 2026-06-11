import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../generated/app_localizations.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';

// ── Helpers ───────────────────────────────────────────────────
String fmtPrice(int n) =>
    'KES ${n.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},')}';

String amenityEmoji(String key) => switch (key) {
  'amenityLakefront'   => '🌊', 'amenityBoatRiding' => '⛵',
  'amenityKidsPool'    => '🏊', 'amenityRestaurant' => '🍽',
  'amenityFreeWifi'    => '📶', 'amenityDSTV'       => '📺',
  'amenityJacuzzi'     => '🛁', 'amenityHairdryer'  => '💨',
  'amenityBalcony'     => '🌅', 'amenityTeaCoffee'  => '☕',
  'amenityBathrobe'    => '🧖', 'amenityRoomService'=> '🔔',
  _ => '✓',
};

String localizedAmenity(AppLocalizations l, String key) => switch (key) {
  'amenityLakefront'   => l.amenityLakefront,
  'amenityBoatRiding'  => l.amenityBoatRiding,
  'amenityKidsPool'    => l.amenityKidsPool,
  'amenityRestaurant'  => l.amenityRestaurant,
  'amenityFreeWifi'    => l.amenityFreeWifi,
  'amenityDSTV'        => l.amenityDSTV,
  'amenityJacuzzi'     => l.amenityJacuzzi,
  'amenityHairdryer'   => l.amenityHairdryer,
  'amenityBalcony'     => l.amenityBalcony,
  'amenityTeaCoffee'   => l.amenityTeaCoffee,
  'amenityBathrobe'    => l.amenityBathrobe,
  'amenityRoomService' => l.amenityRoomService,
  _ => key,
};

String localizedRoomName(AppLocalizations l, String key) => switch (key) {
  'roomStandard'  => l.roomStandard,
  'roomDeluxe'    => l.roomDeluxe,
  'roomSuperior'  => l.roomSuperior,
  'roomExecutive' => l.roomExecutive,
  _ => key,
};

String localizedRoomDesc(AppLocalizations l, String key) => switch (key) {
  'roomStandardDesc'  => l.roomStandardDesc,
  'roomDeluxeDesc'    => l.roomDeluxeDesc,
  'roomSuperiorDesc'  => l.roomSuperiorDesc,
  'roomExecutiveDesc' => l.roomExecutiveDesc,
  _ => key,
};

Color hexColor(String hex) => Color(int.parse('FF$hex', radix: 16));

// ── Network image ─────────────────────────────────────────────
class MImage extends StatelessWidget {
  final String url;
  final double? width, height;
  const MImage({super.key, required this.url, this.width, this.height});

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
    imageUrl: url, width: width ?? double.infinity, height: height, fit: BoxFit.cover,
    placeholder: (_, __) => Shimmer.fromColors(
      baseColor: MColors.warmSand, highlightColor: MColors.shell,
      child: Container(color: MColors.warmSand, width: width, height: height),
    ),
    errorWidget: (_, __, ___) => Container(
      color: MColors.warmSand, width: width, height: height,
      child: const Icon(Icons.image_outlined, color: MColors.grey400),
    ),
  );
}

// ── Section header ────────────────────────────────────────────
class MSectionHeader extends StatelessWidget {
  final String label;
  final String? actionText;
  final VoidCallback? onAction;
  const MSectionHeader({super.key, required this.label, this.actionText, this.onAction});

  @override
  Widget build(BuildContext context) => Row(children: [
    Container(width: 3, height: 18, decoration: BoxDecoration(
      color: MColors.sunset, borderRadius: BorderRadius.circular(2))),
    const SizedBox(width: 8),
    Expanded(child: Text(label.toUpperCase(), style: MTextStyles.label)),
    if (actionText != null)
      GestureDetector(onTap: onAction, child: Text(actionText!,
        style: MTextStyles.bodySmall.copyWith(color: MColors.lakeTeal,
          decoration: TextDecoration.underline, decorationColor: MColors.lakeTeal))),
  ]);
}

// ── Room type tag ─────────────────────────────────────────────
class MRoomTypeTag extends StatelessWidget {
  final RoomType type;
  const MRoomTypeTag({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final (bg, fg, lbl) = switch (type) {
      RoomType.standard  => (const Color(0xFFE8E0D4), MColors.grey800,  'STANDARD'),
      RoomType.deluxe    => (const Color(0xFFD4EAE4), MColors.lakeTeal, 'DELUXE'),
      RoomType.superior  => (const Color(0xFFFDE8C8), MColors.dusk,     'SUPERIOR'),
      RoomType.executive => (MColors.obsidian,        MColors.shell,     'EXECUTIVE'),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(MRadius.pill)),
      child: Text(lbl, style: MTextStyles.tag.copyWith(color: fg)),
    );
  }
}

// ── Room card ─────────────────────────────────────────────────
class MRoomCard extends StatelessWidget {
  final RoomModel room;
  final VoidCallback? onTap;
  final bool horizontal;
  const MRoomCard({super.key, required this.room, this.onTap, this.horizontal = false});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final name  = localizedRoomName(l, room.nameKey);
    final price = fmtPrice(room.lowestRate);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(MRadius.lg),
          boxShadow: [BoxShadow(color: MColors.obsidian.withOpacity(0.07), blurRadius: 14, offset: const Offset(0, 4))],
        ),
        clipBehavior: Clip.antiAlias,
        child: horizontal ? _horizontal(l, name, price) : _vertical(l, name, price),
      ),
    );
  }

  Widget _vertical(AppLocalizations l, String name, String price) => SizedBox(
    width: 200,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(children: [
        MImage(url: room.imageUrls.first, height: 140),
        Positioned(top: 8, left: 8, child: MRoomTypeTag(type: room.type)),
        if (room.hasLakeView)
          Positioned(bottom: 8, right: 8, child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: MColors.lakeTeal.withOpacity(0.9),
              borderRadius: BorderRadius.circular(MRadius.pill)),
            child: const Text('🏞 Lake View', style: TextStyle(fontSize: 10, color: MColors.shell)),
          )),
      ]),
      Padding(padding: const EdgeInsets.all(12), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: MTextStyles.h3, maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        Text(room.roomNumbers, style: MTextStyles.bodySmall),
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(price, style: MTextStyles.priceSmall),
            Text(l.perNight, style: MTextStyles.bodySmall.copyWith(fontSize: 10)),
          ]),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: MColors.obsidian,
              borderRadius: BorderRadius.circular(MRadius.pill)),
            child: Text(l.viewDetails, style: MTextStyles.buttonSmall.copyWith(color: MColors.shell)),
          ),
        ]),
      ])),
    ]),
  );

  Widget _horizontal(AppLocalizations l, String name, String price) => Row(children: [
    Stack(children: [
      MImage(url: room.imageUrls.first, width: 130, height: 130),
      Positioned(top: 8, left: 8, child: MRoomTypeTag(type: room.type)),
    ]),
    Expanded(child: Padding(padding: const EdgeInsets.all(12), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(name, style: MTextStyles.h3),
      const SizedBox(height: 4),
      Text(room.roomNumbers, style: MTextStyles.bodySmall),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(price, style: MTextStyles.priceSmall),
          Text(l.perNight, style: MTextStyles.bodySmall.copyWith(fontSize: 10)),
        ]),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: MColors.obsidian,
            borderRadius: BorderRadius.circular(MRadius.pill)),
          child: Text(l.viewDetails, style: MTextStyles.buttonSmall.copyWith(color: MColors.shell)),
        ),
      ]),
    ]))),
  ]);
}

// ── Amenity chip ──────────────────────────────────────────────
class MAmenityChip extends StatelessWidget {
  final String labelKey;
  const MAmenityChip({super.key, required this.labelKey});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: MColors.warmSand,
        borderRadius: BorderRadius.circular(MRadius.pill)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(amenityEmoji(labelKey), style: const TextStyle(fontSize: 13)),
        const SizedBox(width: 5),
        Text(localizedAmenity(l, labelKey), style: MTextStyles.bodySmall),
      ]),
    );
  }
}

// ── Amenity grid item ─────────────────────────────────────────
class MAmenityGridItem extends StatelessWidget {
  final String amentiyKey;
  final String colorHex;
  const MAmenityGridItem({super.key, required this.amentiyKey, required this.colorHex});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final bg = hexColor(colorHex);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: bg.withOpacity(0.5),
        borderRadius: BorderRadius.circular(MRadius.md),
        border: Border.all(color: bg, width: 0.5)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 36, height: 36, decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          child: Center(child: Text(amenityEmoji(amentiyKey), style: const TextStyle(fontSize: 17)))),
        const SizedBox(height: 6),
        Text(localizedAmenity(l, amentiyKey), style: MTextStyles.bodySmall,
          textAlign: TextAlign.center, maxLines: 2),
      ]),
    );
  }
}

// ── Image gallery ─────────────────────────────────────────────
class MImageGallery extends StatefulWidget {
  final List<String> imageUrls;
  final double height;
  const MImageGallery({super.key, required this.imageUrls, this.height = 280});

  @override
  State<MImageGallery> createState() => _MImageGalleryState();
}

class _MImageGalleryState extends State<MImageGallery> {
  final _ctrl = PageController();
  int _page = 0;

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Stack(children: [
    SizedBox(height: widget.height, child: PageView.builder(
      controller: _ctrl, itemCount: widget.imageUrls.length,
      onPageChanged: (i) => setState(() => _page = i),
      itemBuilder: (_, i) => MImage(url: widget.imageUrls[i], height: widget.height),
    )),
    Positioned(bottom: 12, left: 0, right: 0, child: Center(child: SmoothPageIndicator(
      controller: _ctrl, count: widget.imageUrls.length,
      effect: WormEffect(dotWidth: 7, dotHeight: 7,
        activeDotColor: MColors.shell, dotColor: MColors.shell.withOpacity(0.4), spacing: 5),
    ))),
    Positioned(top: 12, right: 12, child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(color: MColors.obsidian.withOpacity(0.55),
        borderRadius: BorderRadius.circular(MRadius.pill)),
      child: Text('${_page + 1} / ${widget.imageUrls.length}',
        style: MTextStyles.bodySmall.copyWith(color: MColors.shell, fontSize: 11)),
    )),
  ]);
}

// ── Experience card ───────────────────────────────────────────
class MExperienceCard extends StatelessWidget {
  final String imageUrl, title, description;
  const MExperienceCard({super.key, required this.imageUrl, required this.title, required this.description});

  @override
  Widget build(BuildContext context) => Container(
    width: 230,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(MRadius.lg),
      boxShadow: [BoxShadow(color: MColors.obsidian.withOpacity(0.08), blurRadius: 12)]),
    clipBehavior: Clip.antiAlias,
    child: Stack(children: [
      MImage(url: imageUrl, height: 155),
      Positioned.fill(child: DecoratedBox(decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Colors.transparent, MColors.obsidian.withOpacity(0.82)], stops: const [0.4, 1.0])))),
      Positioned(bottom: 0, left: 0, right: 0, child: Padding(padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: MTextStyles.h3.copyWith(color: MColors.shell)),
          const SizedBox(height: 3),
          Text(description, style: MTextStyles.bodySmall.copyWith(color: MColors.shell.withOpacity(0.8)),
            maxLines: 2, overflow: TextOverflow.ellipsis),
        ]))),
    ]),
  );
}

// ── Policy card ───────────────────────────────────────────────
class MPolicyCard extends StatelessWidget {
  final String emoji, title, value;
  const MPolicyCard({super.key, required this.emoji, required this.title, required this.value});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(MRadius.md),
      border: Border.all(color: MColors.warmSand)),
    child: Row(children: [
      Text(emoji, style: const TextStyle(fontSize: 20)),
      const SizedBox(width: 12),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: MTextStyles.bodySmall),
        Text(value, style: MTextStyles.h3.copyWith(fontSize: 14)),
      ]),
    ]),
  );
}

// ── Language toggle ───────────────────────────────────────────
class MLanguageToggle extends StatelessWidget {
  final VoidCallback onToggle;
  final Locale currentLocale;
  const MLanguageToggle({super.key, required this.onToggle, required this.currentLocale});

  @override
  Widget build(BuildContext context) {
    final lbl = currentLocale.languageCode == 'en' ? 'SW' : 'EN';
    return GestureDetector(onTap: onToggle, child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: MColors.shell.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(MRadius.pill)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Text('🌐', style: TextStyle(fontSize: 12)),
        const SizedBox(width: 4),
        Text(lbl, style: MTextStyles.buttonSmall.copyWith(color: MColors.shell)),
      ]),
    ));
  }
}

// ── Meal plan selector ────────────────────────────────────────
class MMealPlanSelector extends StatelessWidget {
  final MealPlan selected;
  final ValueChanged<MealPlan> onChanged;
  const MMealPlanSelector({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final plans = [(MealPlan.bb, l.mealBBShort, l.mealBB),
                   (MealPlan.hb, l.mealHBShort, l.mealHB),
                   (MealPlan.fb, l.mealFBShort, l.mealFB)];
    return Row(children: plans.map((p) {
      final (plan, short, full) = p;
      final sel = selected == plan;
      return Expanded(child: GestureDetector(
        onTap: () => onChanged(plan),
        child: AnimatedContainer(duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: sel ? MColors.obsidian : MColors.warmSand,
            borderRadius: BorderRadius.circular(MRadius.md)),
          child: Column(children: [
            Text(short, style: MTextStyles.h3.copyWith(fontSize: 14,
              color: sel ? MColors.shell : MColors.obsidian)),
            const SizedBox(height: 2),
            Text(full, style: MTextStyles.bodySmall.copyWith(fontSize: 10,
              color: sel ? MColors.shell.withOpacity(0.7) : MColors.grey600),
              textAlign: TextAlign.center),
          ]))),
      );
    }).toList());
  }
}

// ── Occupancy selector ────────────────────────────────────────
class MOccupancySelector extends StatelessWidget {
  final OccupancyType selected;
  final ValueChanged<OccupancyType> onChanged;
  const MOccupancySelector({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Row(children: [
      _OccBtn(label: l.singleRoom, emoji: '🧍',
        isSelected: selected == OccupancyType.single, onTap: () => onChanged(OccupancyType.single)),
      const SizedBox(width: 8),
      _OccBtn(label: l.doubleRoom, emoji: '👫',
        isSelected: selected == OccupancyType.double_, onTap: () => onChanged(OccupancyType.double_)),
    ]);
  }
}

class _OccBtn extends StatelessWidget {
  final String label, emoji;
  final bool isSelected;
  final VoidCallback onTap;
  const _OccBtn({required this.label, required this.emoji, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) => Expanded(child: GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? MColors.lakeTeal : MColors.warmSand,
        borderRadius: BorderRadius.circular(MRadius.md)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 6),
        Text(label, style: MTextStyles.bodySmall.copyWith(
          color: isSelected ? MColors.shell : MColors.obsidian, fontWeight: FontWeight.w600)),
      ])),
  ));
}
