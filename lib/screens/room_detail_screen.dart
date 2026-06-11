import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../generated/app_localizations.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class RoomDetailScreen extends StatefulWidget {
  final RoomModel room;
  const RoomDetailScreen({super.key, required this.room});
  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  MealPlan _plan = MealPlan.bb;
  OccupancyType _occ = OccupancyType.single;

  int get _rate => widget.room.rate(_plan, _occ);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final room = widget.room;
    final name = localizedRoomName(l, room.nameKey);
    final desc = localizedRoomDesc(l, room.descKey);

    return Scaffold(
      backgroundColor: MColors.shell,
      body: Stack(children: [
        CustomScrollView(slivers: [
          SliverToBoxAdapter(child: Stack(children: [
            MImageGallery(imageUrls: room.imageUrls, height: 300),
            SafeArea(child: Padding(padding: const EdgeInsets.all(12),
              child: GestureDetector(onTap: () => context.pop(),
                child: Container(width: 36, height: 36,
                  decoration: BoxDecoration(color: MColors.obsidian.withOpacity(0.55), shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, color: MColors.shell, size: 16))))),
          ])),
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                MRoomTypeTag(type: room.type),
                if (room.hasJacuzzi) ...[
                  const SizedBox(width: 6),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFFF5D8D0).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(MRadius.pill)),
                    child: const Text('🛁 Jacuzzi', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600))),
                ],
                if (room.hasLakeView) ...[
                  const SizedBox(width: 6),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: MColors.lakeTeal.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(MRadius.pill)),
                    child: const Text('🏞 Lake View', style: TextStyle(fontSize: 10,
                      fontWeight: FontWeight.w600, color: MColors.lakeTeal))),
                ],
              ]),
              const SizedBox(height: 12),
              Text(name, style: MTextStyles.h1),
              const SizedBox(height: 4),
              Text(room.roomNumbers, style: MTextStyles.bodySmall),
              Text(l.sleeps(room.maxOccupancy), style: MTextStyles.bodySmall),
            ]))),
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Text(desc, style: MTextStyles.body))),
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              MSectionHeader(label: l.amenities),
              const SizedBox(height: 12),
              Wrap(spacing: 8, runSpacing: 8,
                children: room.amenityKeys.map((k) => MAmenityChip(labelKey: k)).toList()),
            ]))),
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              MSectionHeader(label: l.occupancy),
              const SizedBox(height: 12),
              MOccupancySelector(selected: _occ, onChanged: (o) => setState(() => _occ = o)),
            ]))),
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              MSectionHeader(label: l.mealPlan),
              const SizedBox(height: 12),
              MMealPlanSelector(selected: _plan, onChanged: (p) => setState(() => _plan = p)),
            ]))),
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: _RateTable(room: room, l: l))),
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ]),
        Positioned(bottom: 0, left: 0, right: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            decoration: BoxDecoration(color: MColors.shell,
              boxShadow: [BoxShadow(color: MColors.obsidian.withOpacity(0.10), blurRadius: 20, offset: const Offset(0, -4))]),
            child: SafeArea(top: false, child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                Text(fmtPrice(_rate), style: MTextStyles.price),
                Text(l.perNight, style: MTextStyles.bodySmall.copyWith(fontSize: 11)),
              ])),
              GestureDetector(
                onTap: () => context.pushNamed('booking', extra: room),
                child: Container(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(color: MColors.sunset,
                    borderRadius: BorderRadius.circular(MRadius.pill),
                    boxShadow: [BoxShadow(color: MColors.sunset.withOpacity(0.35), blurRadius: 12, offset: const Offset(0, 4))]),
                  child: Text(l.bookNow, style: MTextStyles.button.copyWith(color: MColors.shell)))),
            ]))),
        ),
      ]),
    );
  }
}

class _RateTable extends StatelessWidget {
  final RoomModel room;
  final AppLocalizations l;
  const _RateTable({required this.room, required this.l});

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    MSectionHeader(label: l.allRates),
    const SizedBox(height: 12),
    Container(
      decoration: BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(MRadius.md),
        border: Border.all(color: MColors.warmSand)),
      child: Table(children: [
        TableRow(decoration: const BoxDecoration(color: MColors.warmSand),
          children: [_th(''), _th(l.mealBBShort), _th(l.mealHBShort), _th(l.mealFBShort)]),
        TableRow(children: [
          _td(l.singleRoom, true),
          _td(fmtPrice(room.rate(MealPlan.bb, OccupancyType.single))),
          _td(fmtPrice(room.rate(MealPlan.hb, OccupancyType.single))),
          _td(fmtPrice(room.rate(MealPlan.fb, OccupancyType.single))),
        ]),
        TableRow(decoration: const BoxDecoration(color: Color(0xFFFBF9F6)), children: [
          _td(l.doubleRoom, true),
          _td(fmtPrice(room.rate(MealPlan.bb, OccupancyType.double_))),
          _td(fmtPrice(room.rate(MealPlan.hb, OccupancyType.double_))),
          _td(fmtPrice(room.rate(MealPlan.fb, OccupancyType.double_))),
        ]),
      ])),
    const SizedBox(height: 6),
    Text('${l.mealBBShort}=${l.mealBB}  ·  ${l.mealHBShort}=${l.mealHB}  ·  ${l.mealFBShort}=${l.mealFB}',
      style: MTextStyles.bodySmall.copyWith(fontSize: 10)),
  ]);
}

Widget _th(String t) => TableCell(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  child: Text(t, style: MTextStyles.label.copyWith(fontSize: 10), textAlign: TextAlign.center)));

Widget _td(String t, [bool lbl = false]) => TableCell(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  child: Text(t, style: lbl ? MTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600) : MTextStyles.bodySmall,
    textAlign: lbl ? TextAlign.left : TextAlign.center)));
