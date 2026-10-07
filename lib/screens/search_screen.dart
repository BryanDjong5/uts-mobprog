import 'package:flutter/material.dart';

import '../Models/club.dart';
import '../Models/event_model.dart';
import '../daftarClub/ClubDetail.dart';
import '../daftarClub/ClubRepository.dart';
import '../services/event_repository.dart';
import '../widgets/club_card.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/notification_bell.dart';

enum JoinFilter { semua, sudah, belum }

enum MemberRange { semua, kecil, sedang, besar }

enum ClubSort { nama, anggota }

enum EventSort { terdekat, nama }

String _joinLabel(JoinFilter v) {
  switch (v) {
    case JoinFilter.semua:
      return 'Semua';
    case JoinFilter.sudah:
      return 'Sudah bergabung';
    case JoinFilter.belum:
      return 'Belum bergabung';
  }
}

String _rangeLabel(MemberRange v) {
  switch (v) {
    case MemberRange.semua:
      return 'Semua';
    case MemberRange.kecil:
      return '< 25 anggota';
    case MemberRange.sedang:
      return '25 - 50 anggota';
    case MemberRange.besar:
      return '> 50 anggota';
  }
}

String _clubSortLabel(ClubSort v) {
  switch (v) {
    case ClubSort.nama:
      return 'Nama A-Z';
    case ClubSort.anggota:
      return 'Anggota terbanyak';
  }
}

String _eventSortLabel(EventSort v) {
  switch (v) {
    case EventSort.terdekat:
      return 'Terdekat';
    case EventSort.nama:
      return 'Nama A-Z';
  }
}

const List<String> _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Jun',
  'Jul',
  'Agu',
  'Sep',
  'Okt',
  'Nov',
  'Des',
];

String _formatDate(DateTime d) {
  final hh = d.hour.toString().padLeft(2, '0');
  final mm = d.minute.toString().padLeft(2, '0');
  return '${d.day} ${_months[d.month - 1]} ${d.year}, $hh:$mm';
}

String _formatShortDate(DateTime d) => '${d.day} ${_months[d.month - 1]}';

String _rupiah(int value) {
  final text = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < text.length; i++) {
    final remaining = text.length - i;
    buffer.write(text[i]);
    if (remaining > 1 && remaining % 3 == 1) buffer.write('.');
  }
  return 'Rp $buffer';
}

class ClubFilters {
  final JoinFilter join;
  final MemberRange range;
  final ClubSort sort;

  const ClubFilters({
    this.join = JoinFilter.semua,
    this.range = MemberRange.semua,
    this.sort = ClubSort.nama,
  });

  ClubFilters copyWith({JoinFilter? join, MemberRange? range, ClubSort? sort}) {
    return ClubFilters(
      join: join ?? this.join,
      range: range ?? this.range,
      sort: sort ?? this.sort,
    );
  }

  int get activeCount {
    var count = 0;
    if (join != JoinFilter.semua) count++;
    if (range != MemberRange.semua) count++;
    return count;
  }
}

class EventFilters {
  final String? kategori;
  final DateTimeRange? tanggal;
  final bool gratis;
  final EventSort sort;

  const EventFilters({
    this.kategori,
    this.tanggal,
    this.gratis = false,
    this.sort = EventSort.terdekat,
  });

  EventFilters copyWith({
    String? kategori,
    bool clearKategori = false,
    DateTimeRange? tanggal,
    bool clearTanggal = false,
    bool? gratis,
    EventSort? sort,
  }) {
    return EventFilters(
      kategori: clearKategori ? null : (kategori ?? this.kategori),
      tanggal: clearTanggal ? null : (tanggal ?? this.tanggal),
      gratis: gratis ?? this.gratis,
      sort: sort ?? this.sort,
    );
  }

  int get activeCount {
    var count = 0;
    if (kategori != null) count++;
    if (tanggal != null) count++;
    if (gratis) count++;
    return count;
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  String _query = '';
  ClubFilters _clubFilters = const ClubFilters();
  EventFilters _eventFilters = const EventFilters();

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
    _tab.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  bool _matchText(String haystack) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return true;
    final text = haystack.toLowerCase();
    for (final word in q.split(RegExp(r'\s+'))) {
      if (!text.contains(word)) return false;
    }
    return true;
  }

  bool _matchClub(Club club) {
    if (!_matchText('${club.namaClub} ${club.deskripsiClub}')) return false;
    final f = _clubFilters;
    if (f.join == JoinFilter.sudah && !club.isJoined) return false;
    if (f.join == JoinFilter.belum && club.isJoined) return false;
    switch (f.range) {
      case MemberRange.semua:
        break;
      case MemberRange.kecil:
        if (club.members >= 25) return false;
        break;
      case MemberRange.sedang:
        if (club.members < 25 || club.members > 50) return false;
        break;
      case MemberRange.besar:
        if (club.members <= 50) return false;
        break;
    }
    return true;
  }

  bool _matchEvent(EventItem event) {
    final text =
        '${event.nama} ${event.deskripsi} ${event.lokasi} ${event.kategori}';
    if (!_matchText(text)) return false;
    final f = _eventFilters;
    if (f.kategori != null && event.kategori != f.kategori) return false;
    if (f.gratis && event.harga > 0) return false;
    final range = f.tanggal;
    if (range != null) {
      final start = DateTime(
        range.start.year,
        range.start.month,
        range.start.day,
      );
      final end = DateTime(
        range.end.year,
        range.end.month,
        range.end.day,
        23,
        59,
        59,
      );
      if (event.tanggal.isBefore(start) || event.tanggal.isAfter(end)) {
        return false;
      }
    }
    return true;
  }

  Future<void> _openFilter() async {
    if (_tab.index == 0) {
      final result = await showModalBottomSheet<ClubFilters>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => _ClubFilterSheet(initial: _clubFilters),
      );
      if (result != null) setState(() => _clubFilters = result);
    } else {
      final kategori =
          EventRepository.instance.events.value
              .map((e) => e.kategori)
              .toSet()
              .toList()
            ..sort();
      final result = await showModalBottomSheet<EventFilters>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => _EventFilterSheet(
          initial: _eventFilters,
          kategoriOptions: kategori,
        ),
      );
      if (result != null) setState(() => _eventFilters = result);
    }
  }

  Widget _removableChip(String label, VoidCallback onDeleted) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InputChip(label: Text(label), onDeleted: onDeleted),
    );
  }

  List<Widget> _activeChips() {
    final chips = <Widget>[];
    if (_tab.index == 0) {
      final f = _clubFilters;
      if (f.join != JoinFilter.semua) {
        chips.add(
          _removableChip(
            _joinLabel(f.join),
            () => setState(
              () => _clubFilters = f.copyWith(join: JoinFilter.semua),
            ),
          ),
        );
      }
      if (f.range != MemberRange.semua) {
        chips.add(
          _removableChip(
            _rangeLabel(f.range),
            () => setState(
              () => _clubFilters = f.copyWith(range: MemberRange.semua),
            ),
          ),
        );
      }
    } else {
      final f = _eventFilters;
      if (f.kategori != null) {
        chips.add(
          _removableChip(
            f.kategori!,
            () =>
                setState(() => _eventFilters = f.copyWith(clearKategori: true)),
          ),
        );
      }
      if (f.tanggal != null) {
        chips.add(
          _removableChip(
            '${_formatShortDate(f.tanggal!.start)} - ${_formatShortDate(f.tanggal!.end)}',
            () =>
                setState(() => _eventFilters = f.copyWith(clearTanggal: true)),
          ),
        );
      }
      if (f.gratis) {
        chips.add(
          _removableChip(
            'Gratis',
            () => setState(() => _eventFilters = f.copyWith(gratis: false)),
          ),
        );
      }
    }
    return chips;
  }

  Widget _emptyResult(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 72, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Coba ubah kata kunci atau filter pencarian',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClubTab() {
    return ValueListenableBuilder<List<Club>>(
      valueListenable: ClubRepository.instance.clubs,
      builder: (context, clubs, _) {
        final results = clubs.where(_matchClub).toList();
        if (_clubFilters.sort == ClubSort.nama) {
          results.sort(
            (a, b) =>
                a.namaClub.toLowerCase().compareTo(b.namaClub.toLowerCase()),
          );
        } else {
          results.sort((a, b) => b.members.compareTo(a.members));
        }

        if (results.isEmpty) return _emptyResult('Klub tidak ditemukan');

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          itemCount: results.length,
          separatorBuilder: (_, _) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final club = results[index];
            final caption = club.isJoined
                ? '${club.members} anggota • Sudah bergabung'
                : '${club.members} anggota';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClubCard(
                  title: club.namaClub,
                  subtitle: club.deskripsiClub,
                  iconData: Icons.groups,
                  fotoPath: club.fotoPath,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ClubDetail(
                          title: club.namaClub,
                          subtitle: club.deskripsiClub,
                          iconData: '👥',
                          members: club.members,
                          description: club.deskripsiClub,
                          fotoPath: club.fotoPath,
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
                  child: Text(
                    caption,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildEventTab() {
    return ValueListenableBuilder<List<EventItem>>(
      valueListenable: EventRepository.instance.events,
      builder: (context, events, _) {
        final results = events.where(_matchEvent).toList();
        if (_eventFilters.sort == EventSort.terdekat) {
          results.sort((a, b) => a.tanggal.compareTo(b.tanggal));
        } else {
          results.sort(
            (a, b) => a.nama.toLowerCase().compareTo(b.nama.toLowerCase()),
          );
        }

        if (results.isEmpty) return _emptyResult('Event tidak ditemukan');

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          itemCount: results.length,
          separatorBuilder: (_, _) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final event = results[index];
            return _EventCard(
              event: event,
              onTap: () => _showEventDetail(event),
            );
          },
        );
      },
    );
  }

  void _showEventDetail(EventItem event) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        final penuh = event.peserta >= event.kuota;
        final bisaDaftar = !event.isJoined && !penuh;
        final label = event.isJoined
            ? 'Sudah terdaftar'
            : (penuh ? 'Kuota penuh' : 'Daftar event');

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CategoryTag(text: event.kategori),
                const SizedBox(height: 8),
                Text(
                  event.nama,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _InfoRow(
                  icon: Icons.schedule,
                  text: _formatDate(event.tanggal),
                ),
                _InfoRow(icon: Icons.location_on_outlined, text: event.lokasi),
                _InfoRow(
                  icon: Icons.people_outline,
                  text: '${event.peserta} / ${event.kuota} peserta',
                ),
                _InfoRow(
                  icon: Icons.payments_outlined,
                  text: event.harga == 0 ? 'Gratis' : _rupiah(event.harga),
                ),
                const SizedBox(height: 12),
                Text(event.deskripsi),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF2B2D42),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: bisaDaftar
                        ? () {
                            EventRepository.instance.join(event.id);
                            Navigator.pop(sheetContext);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Berhasil mendaftar ke ${event.nama}',
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Text(label),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final chips = _activeChips();
    final filterCount = _tab.index == 0
        ? _clubFilters.activeCount
        : _eventFilters.activeCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cari Klub & Event',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2B2D42),
        foregroundColor: Colors.white,
        actions: const [NotificationBell(color: Colors.white)],
        bottom: TabBar(
          controller: _tab,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Klub'),
            Tab(text: 'Event'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    hintText: _tab.index == 0
                        ? 'Cari komunitas impianmu...'
                        : 'Cari event seru...',
                    onChanged: (value) => setState(() => _query = value),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  tooltip: 'Filter',
                  onPressed: _openFilter,
                  icon: Badge(
                    isLabelVisible: filterCount > 0,
                    label: Text('$filterCount'),
                    child: const Icon(Icons.tune),
                  ),
                ),
              ],
            ),
          ),
          if (chips.isNotEmpty)
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: chips,
              ),
            ),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [_buildClubTab(), _buildEventTab()],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTag extends StatelessWidget {
  final String text;

  const _CategoryTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          color: Colors.blueAccent,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(icon, size: 15, color: Colors.grey),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventItem event;
  final VoidCallback onTap;

  const _EventCard({required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 56,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B2D42),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      '${event.tanggal.day}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _months[event.tanggal.month - 1],
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CategoryTag(text: event.kategori),
                    const SizedBox(height: 4),
                    Text(
                      event.nama,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      text: event.lokasi,
                    ),
                    _InfoRow(
                      icon: Icons.people_outline,
                      text: '${event.peserta} / ${event.kuota} peserta',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    event.harga == 0 ? 'Gratis' : _rupiah(event.harga),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: event.harga == 0
                          ? Colors.green
                          : const Color(0xFF2B2D42),
                    ),
                  ),
                  if (event.isJoined)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Icon(
                        Icons.check_circle,
                        size: 18,
                        color: Colors.green,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionChips<T> extends StatelessWidget {
  final List<T> values;
  final T selected;
  final String Function(T) label;
  final ValueChanged<T> onSelected;

  const _OptionChips({
    required this.values,
    required this.selected,
    required this.label,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: values.map((value) {
        return ChoiceChip(
          label: Text(label(value)),
          selected: value == selected,
          onSelected: (_) => onSelected(value),
        );
      }).toList(),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class _SheetFrame extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback onReset;
  final VoidCallback onApply;

  const _SheetFrame({
    required this.title,
    required this.children,
    required this.onReset,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...children,
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReset,
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF2B2D42),
                      ),
                      onPressed: onApply,
                      child: const Text('Terapkan'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClubFilterSheet extends StatefulWidget {
  final ClubFilters initial;

  const _ClubFilterSheet({required this.initial});

  @override
  State<_ClubFilterSheet> createState() => _ClubFilterSheetState();
}

class _ClubFilterSheetState extends State<_ClubFilterSheet> {
  late ClubFilters _filters;

  @override
  void initState() {
    super.initState();
    _filters = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return _SheetFrame(
      title: 'Filter klub',
      onReset: () => Navigator.pop(context, const ClubFilters()),
      onApply: () => Navigator.pop(context, _filters),
      children: [
        const _SectionLabel('Status'),
        _OptionChips<JoinFilter>(
          values: JoinFilter.values,
          selected: _filters.join,
          label: _joinLabel,
          onSelected: (v) =>
              setState(() => _filters = _filters.copyWith(join: v)),
        ),
        const _SectionLabel('Jumlah anggota'),
        _OptionChips<MemberRange>(
          values: MemberRange.values,
          selected: _filters.range,
          label: _rangeLabel,
          onSelected: (v) =>
              setState(() => _filters = _filters.copyWith(range: v)),
        ),
        const _SectionLabel('Urutkan'),
        _OptionChips<ClubSort>(
          values: ClubSort.values,
          selected: _filters.sort,
          label: _clubSortLabel,
          onSelected: (v) =>
              setState(() => _filters = _filters.copyWith(sort: v)),
        ),
      ],
    );
  }
}

class _EventFilterSheet extends StatefulWidget {
  final EventFilters initial;
  final List<String> kategoriOptions;

  const _EventFilterSheet({
    required this.initial,
    required this.kategoriOptions,
  });

  @override
  State<_EventFilterSheet> createState() => _EventFilterSheetState();
}

class _EventFilterSheetState extends State<_EventFilterSheet> {
  late EventFilters _filters;

  @override
  void initState() {
    super.initState();
    _filters = widget.initial;
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
      initialDateRange: _filters.tanggal,
    );
    if (picked != null) {
      setState(() => _filters = _filters.copyWith(tanggal: picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    final range = _filters.tanggal;

    return _SheetFrame(
      title: 'Filter event',
      onReset: () => Navigator.pop(context, const EventFilters()),
      onApply: () => Navigator.pop(context, _filters),
      children: [
        const _SectionLabel('Kategori'),
        _OptionChips<String?>(
          values: [null, ...widget.kategoriOptions],
          selected: _filters.kategori,
          label: (v) => v ?? 'Semua',
          onSelected: (v) => setState(() {
            _filters = v == null
                ? _filters.copyWith(clearKategori: true)
                : _filters.copyWith(kategori: v);
          }),
        ),
        const _SectionLabel('Tanggal'),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _pickDateRange,
                icon: const Icon(Icons.date_range),
                label: Text(
                  range == null
                      ? 'Pilih rentang tanggal'
                      : '${_formatShortDate(range.start)} - ${_formatShortDate(range.end)}',
                ),
              ),
            ),
            if (range != null)
              IconButton(
                onPressed: () => setState(
                  () => _filters = _filters.copyWith(clearTanggal: true),
                ),
                icon: const Icon(Icons.close),
              ),
          ],
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Hanya event gratis'),
          value: _filters.gratis,
          onChanged: (v) =>
              setState(() => _filters = _filters.copyWith(gratis: v)),
        ),
        const _SectionLabel('Urutkan'),
        _OptionChips<EventSort>(
          values: EventSort.values,
          selected: _filters.sort,
          label: _eventSortLabel,
          onSelected: (v) =>
              setState(() => _filters = _filters.copyWith(sort: v)),
        ),
      ],
    );
  }
}
