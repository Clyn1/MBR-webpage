import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../generated/app_localizations.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class BookingScreen extends StatefulWidget {
  final RoomModel room;
  const BookingScreen({super.key, required this.room});
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _key = GlobalKey<FormState>();
  MealPlan _plan = MealPlan.bb;
  OccupancyType _occ = OccupancyType.single;
  DateTime? _in, _out;
  final _fn = TextEditingController(), _ln = TextEditingController(),
        _em = TextEditingController(), _ph = TextEditingController(),
        _sr = TextEditingController();

  @override
  void dispose() { _fn.dispose(); _ln.dispose(); _em.dispose(); _ph.dispose(); _sr.dispose(); super.dispose(); }

  int get _nights => (_in != null && _out != null) ? _out!.difference(_in!).inDays : 0;
  int get _total  => widget.room.rate(_plan, _occ) * _nights;

  Widget _dateTheme(BuildContext ctx, Widget? w) => Theme(
    data: Theme.of(ctx).copyWith(colorScheme: const ColorScheme.light(
      primary: MColors.lakeTeal, onPrimary: MColors.shell, surface: MColors.shell)),
    child: w!);

  Future<void> _pickIn() async {
    final d = await showDatePicker(context: context, builder: _dateTheme,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
    if (d != null) setState(() { _in = d; if (_out != null && !_out!.isAfter(d)) _out = null; });
  }

  Future<void> _pickOut() async {
    if (_in == null) { await _pickIn(); return; }
    final d = await showDatePicker(context: context, builder: _dateTheme,
      initialDate: _in!.add(const Duration(days: 1)),
      firstDate: _in!.add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 366)));
    if (d != null) setState(() => _out = d);
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    if (_in == null || _out == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select check-in and check-out dates')));
      return;
    }
    context.pushNamed('booking-confirm', extra: BookingRequest(
      room: widget.room, mealPlan: _plan, occupancy: _occ,
      checkIn: _in!, checkOut: _out!,
      firstName: _fn.text.trim(), lastName: _ln.text.trim(),
      email: _em.text.trim(), phone: _ph.text.trim(),
      guests: _occ == OccupancyType.single ? 1 : 2,
      specialRequests: _sr.text.trim().isEmpty ? null : _sr.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final name = localizedRoomName(l, widget.room.nameKey);
    return Scaffold(
      backgroundColor: MColors.shell,
      appBar: AppBar(backgroundColor: MColors.obsidian,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: MColors.shell, size: 18),
          onPressed: () => context.pop()),
        title: Text(l.bookNow.toUpperCase())),
      body: Form(key: _key, child: ListView(padding: const EdgeInsets.all(24), children: [
        // Room summary
        Container(padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: MColors.obsidian, borderRadius: BorderRadius.circular(MRadius.lg)),
          child: Row(children: [
            MRoomTypeTag(type: widget.room.type), const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: MTextStyles.h3.copyWith(color: MColors.shell)),
              Text(widget.room.roomNumbers, style: MTextStyles.bodySmall.copyWith(color: MColors.shell.withOpacity(0.6))),
            ])),
          ])),
        const SizedBox(height: 24),
        _Lbl(l.numberOfGuests),
        const SizedBox(height: 8),
        MOccupancySelector(selected: _occ, onChanged: (o) => setState(() => _occ = o)),
        const SizedBox(height: 24),
        _Lbl(l.mealPlan),
        const SizedBox(height: 8),
        MMealPlanSelector(selected: _plan, onChanged: (p) => setState(() => _plan = p)),
        const SizedBox(height: 24),
        _Lbl(l.selectDates),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: _DateTile(l.checkInDate, _in, _pickIn)),
          const SizedBox(width: 12),
          Expanded(child: _DateTile(l.checkOutDate, _out, _pickOut)),
        ]),
        if (_nights > 0) ...[
          const SizedBox(height: 12),
          Container(padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: MColors.lakeGold.withOpacity(0.12),
              borderRadius: BorderRadius.circular(MRadius.md),
              border: Border.all(color: MColors.lakeGold.withOpacity(0.3))),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('$_nights night${_nights > 1 ? 's' : ''} × ${fmtPrice(widget.room.rate(_plan, _occ))}',
                style: MTextStyles.bodySmall),
              Text(fmtPrice(_total), style: MTextStyles.priceSmall),
            ])),
        ],
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 24),
        _Lbl(l.guestDetails),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _Field(_fn, l.firstName, req: true)),
          const SizedBox(width: 12),
          Expanded(child: _Field(_ln, l.lastName, req: true)),
        ]),
        const SizedBox(height: 12),
        _Field(_em, l.email, type: TextInputType.emailAddress, req: true,
          validator: (v) => (v != null && v.contains('@')) ? null : 'Enter valid email'),
        const SizedBox(height: 12),
        _Field(_ph, l.phone, type: TextInputType.phone, req: true),
        const SizedBox(height: 12),
        _Field(_sr, l.specialRequests, maxLines: 3),
        const SizedBox(height: 32),
        GestureDetector(onTap: _submit,
          child: Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(color: MColors.sunset, borderRadius: BorderRadius.circular(MRadius.pill),
              boxShadow: [BoxShadow(color: MColors.sunset.withOpacity(0.35), blurRadius: 16, offset: const Offset(0, 5))]),
            child: Text(l.confirmBooking, style: MTextStyles.button.copyWith(color: MColors.shell),
              textAlign: TextAlign.center))),
        const SizedBox(height: 24),
      ])),
    );
  }
}

class _Lbl extends StatelessWidget {
  final String t;
  const _Lbl(this.t);
  @override
  Widget build(BuildContext context) => Text(t.toUpperCase(), style: MTextStyles.label);
}

class _Field extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final TextInputType? type;
  final int maxLines;
  final bool req;
  final String? Function(String?)? validator;
  const _Field(this.ctrl, this.label, {this.type, this.maxLines = 1, this.req = false, this.validator});
  @override
  Widget build(BuildContext context) => TextFormField(
    controller: ctrl, keyboardType: type, maxLines: maxLines,
    style: MTextStyles.body.copyWith(height: 1),
    decoration: InputDecoration(labelText: label),
    validator: validator ?? (req ? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null : null),
  );
}

class _DateTile extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;
  const _DateTile(this.label, this.date, this.onTap);
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap,
    child: Container(padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: date != null ? MColors.lakeTeal.withOpacity(0.08) : Colors.white,
        borderRadius: BorderRadius.circular(MRadius.md),
        border: Border.all(color: date != null ? MColors.lakeTeal : MColors.warmSand)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: MTextStyles.bodySmall.copyWith(fontSize: 10)),
        const SizedBox(height: 4),
        Text(date != null ? '${date!.day}/${date!.month}/${date!.year}' : 'Tap to select',
          style: date != null ? MTextStyles.h3.copyWith(fontSize: 14) : MTextStyles.bodySmall),
      ])));
}
