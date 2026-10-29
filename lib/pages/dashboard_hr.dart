import 'package:flutter/material.dart';

class DashboardHR extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const DashboardHR({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 600;
        return _buildDashboard(context, isTablet);
      },
    );
  }

  Widget _buildDashboard(BuildContext context, bool isTablet) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Logo Kiri Atas (Diganti ke Asset Universitas Bani Saleh)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/Foto_raju.jpeg',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.business, size: 32),
              ),
            ),
            const SizedBox(width: 8),
            const Flexible(
              child: Text('PT Maju Bersama', overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
            tooltip: 'Ganti Tema',
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          // Foto Profil Kanan Atas (Diganti ke Asset Universitas Bani Saleh)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: const AssetImage('assets/images/Foto_raju.jpeg'),
              onBackgroundImageError: (exception, stackTrace) {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: isDark
                          ? [colors.primaryContainer, colors.secondaryContainer]
                          : [colors.primary, colors.tertiary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Selamat Pagi, Admin!',
                        style: TextStyle(
                          color: isDark
                              ? colors.onPrimaryContainer
                              : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Senin, 7 Oktober 2024',
                        style: TextStyle(
                          color: isDark
                              ? colors.onPrimaryContainer.withValues(alpha: 0.7)
                              : Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  bottom: 20,
                  child: Icon(
                    Icons.waving_hand,
                    color: (isDark ? colors.onPrimaryContainer : Colors.white)
                        .withValues(alpha: 0.5),
                    size: 64,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isTablet ? 4 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isTablet ? 1.4 : 1.3,
              children: [
                _kartuStat('248', 'Karyawan', Icons.people, colors.primary),
                _kartuStat(
                  '95%',
                  'Hadir',
                  Icons.check_circle,
                  colors.secondary,
                ),
                _kartuStat('12', 'Cuti', Icons.beach_access, colors.tertiary),
                _kartuStat('3', 'Rekrut', Icons.person_add, colors.error),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Kehadiran per Divisi',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _barItem('Engineering', 0.92, '92%', colors.primary),
                    const SizedBox(height: 12),
                    _barItem('Sales', 0.85, '85%', colors.secondary),
                    const SizedBox(height: 12),
                    _barItem('HR', 0.97, '97%', colors.tertiary),
                    const SizedBox(height: 12),
                    _barItem('Finance', 0.90, '90%', colors.error),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Aktivitas Terkini',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('Lihat Semua')),
              ],
            ),
            const SizedBox(height: 8),
            ...List.generate(
              _aktivitas.length,
              (i) => _kartuAktivitas(_aktivitas[i]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _barItem(
    String divisi,
    double nilaiFlex,
    String persentase,
    Color warna,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(divisi, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(
              persentase,
              style: TextStyle(fontWeight: FontWeight.bold, color: warna),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              flex: (nilaiFlex * 100).toInt(),
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: warna,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Expanded(flex: ((1 - nilaiFlex) * 100).toInt(), child: Container()),
          ],
        ),
      ],
    );
  }

  Widget _kartuStat(String nilai, String label, IconData icon, Color warna) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: warna.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: warna, size: 28),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nilai,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: warna,
                ),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static const _aktivitas = [
    (
      nama: 'Budi Santoso',
      aksi: 'Mengajukan cuti',
      waktu: '09:14',
      icon: Icons.beach_access,
      warna: Colors.orange,
    ),
    (
      nama: 'Citra Dewi',
      aksi: 'Check-in absensi',
      waktu: '08:02',
      icon: Icons.check_circle,
      warna: Colors.green,
    ),
    (
      nama: 'Eko Wahyudi',
      aksi: 'Upload kontrak baru',
      waktu: '07:45',
      icon: Icons.description,
      warna: Colors.blue,
    ),
  ];

  Widget _kartuAktivitas(
    ({
      String nama,
      String aksi,
      String waktu,
      IconData icon,
      MaterialColor warna,
    })
    d,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: d.warna.withValues(alpha: 0.15),
          child: Icon(d.icon, color: d.warna, size: 20),
        ),
        title: Text(
          d.nama,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(d.aksi),
        trailing: Text(
          d.waktu,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
        ),
      ),
    );
  }
}
