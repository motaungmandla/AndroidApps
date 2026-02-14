import 'package:flutter/material.dart';

void main() {
  runApp(const MineralConsultingApp());
}

class MineralConsultingApp extends StatelessWidget {
  const MineralConsultingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lesotho Mineral Atlas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A365D),
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          color: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF1A365D),
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    const MineralsOverview(),
    const ExplorationMap(),
    const ConsultingServices(),
    const AboutCreators(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Lesotho Mineral Atlas'),
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 28),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showComingSoon(context, 'Notifications'),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.layers_outlined),
            activeIcon: Icon(Icons.layers),
            label: 'Minerals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center_outlined),
            activeIcon: Icon(Icons.business_center),
            label: 'Consulting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined),
            activeIcon: Icon(Icons.people),
            label: 'About',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A365D), Color(0xFF2C5282)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment-end,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.grain, size: 40, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Lesotho Mineral Atlas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'by Phala & Motaung',
                  style: TextStyle(
                    color: Colors.blueAccent.shade100,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          _drawerItem(Icons.layers, 'Mineral Deposits', 0),
          _drawerItem(Icons.map, 'Exploration Map', 1),
          _drawerItem(Icons.science, 'Resource Analysis', 2),
          _drawerItem(Icons.business_center, 'Consulting Services', 3),
          _drawerItem(Icons.people, 'About Us', 4),
          _drawerItem(Icons.contact_mail, 'Contact Experts', 5),
          const Divider(height: 1, color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFF1A365D)),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              _showComingSoon(context, 'Settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Color(0xFF1A365D)),
            title: const Text('App Information'),
            onTap: () {
              Navigator.pop(context);
              _showComingSoon(context, 'App Information');
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1A365D)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: () {
        Navigator.pop(context);
        if (index < _pages.length) {
          setState(() => _currentIndex = index);
        } else {
          _showComingSoon(context, title);
        }
      },
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature coming soon!'),
        backgroundColor: const Color(0xFF2C5282),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class MineralsOverview extends StatelessWidget {
  const MineralsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A365D), Color(0xFF2C5282)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lesotho Mineral Atlas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Expert geological consulting for diamond, coal, clay & uranium exploration across the Mountain Kingdom',
                  style: TextStyle(
                    color: Colors.blueAccent.shade100,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildMineralCard(mineralData[index]);
              },
              childCount: mineralData.length,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: _buildInfoCard(),
          ),
        ),
      ],
    );
  }

  Widget _buildMineralCard(Mineral mineral) {
    return Card(
      child: InkWell(
        onTap: () => _showMineralDetail(mineral),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: mineral.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Center(
                  child: Icon(
                    mineral.icon,
                    size: 60,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mineral.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A365D),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mineral.primaryLocation,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: mineral.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      mineral.status,
                      style: TextStyle(
                        color: mineral.color,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A365D).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.info_outline, color: Color(0xFF1A365D)),
                ),
                const SizedBox(width: 12),
                const Text(
                  'About Lesotho Minerals',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Lesotho is renowned for its rich diamond deposits, particularly within its northern highlands. The country possesses significant mineral resources including clay, sandstone, coal, and uranium. Mining operations concentrate on kimberlite pipes in mountainous regions, with over 400 identified intrusions across northern districts.',
              style: TextStyle(
                height: 1.6,
                color: Colors.grey[700],
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _InfoChip('💎 High-value diamonds'),
                _InfoChip('⛰️ 3,100m+ elevation mines'),
                _InfoChip('💧 Alluvial river deposits'),
                _InfoChip('⛏️ 400+ kimberlite pipes'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMineralDetail(Mineral mineral) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(mineral.icon, color: mineral.color, size: 28),
            const SizedBox(width: 12),
            Text(mineral.name),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Text(
            mineral.description,
            style: const TextStyle(height: 1.6),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Consultation request sent!')),
              );
            },
            child: const Text(
              'REQUEST CONSULTATION',
              style: TextStyle(color: Color(0xFF1A365D)),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;

  const _InfoChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.blue.withOpacity(0.3), width: 1),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF1A365D),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class ExplorationMap extends StatelessWidget {
  const ExplorationMap({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF1A365D),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Exploration Map',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Mineral-rich zones across the Mountain Kingdom',
                  style: TextStyle(
                    color: Colors.blueAccent.shade100,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Stylized Lesotho map using Flutter widgets (no external deps)
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF88C9A1), Color(0xFF4A7C59)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      child: Stack(
                        children: [
                          // Mountain silhouettes
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _MountainPainter(),
                            ),
                          ),
                          // Mineral location markers
                          ..._mineralLocations.map((location) => _buildMapMarker(location)),
                          // Lesotho label
                          Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: Text(
                              'KINGDOM OF LESOTHO',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                shadows: const [
                                  Shadow(color: Colors.black54, offset: Offset(0, 2), blurRadius: 3),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMapLegend('💎', 'Diamond Sites'),
                        _buildMapLegend('⛏️', 'Coal/Clay'),
                        _buildMapLegend('🟡', 'Uranium Potential'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Key Mining Districts',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ..._districts.map((district) => _buildDistrictRow(district)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapMarker(MapLocation location) {
    return Positioned(
      left: location.xPercent,
      top: location.yPercent,
      child: GestureDetector(
        onTap: () => _showLocationDetail(location),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: location.color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: location.color.withOpacity(0.6),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(location.icon, size: 20, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                location.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapLegend(String icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
          ),
          child: Text(icon, style: const TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDistrictRow(District district) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: district.color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  district.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 2),
                Text(
                  district.resources,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
            onPressed: () => _showComingSoon(context, '${district.name} details'),
          ),
        ],
      ),
    );
  }

  void _showLocationDetail(MapLocation location) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(location.icon, color: location.color),
            const SizedBox(width: 10),
            Text(location.name),
          ],
        ),
        content: Text(location.description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature details coming soon!'),
        backgroundColor: const Color(0xFF2C5282),
      ),
    );
  }
}

class _MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2D5D4F).withOpacity(0.7)
      ..style = PaintingStyle.fill;

    // Draw mountain silhouettes
    final path1 = Path();
    path1.moveTo(0, size.height * 0.7);
    path1.lineTo(size.width * 0.2, size.height * 0.4);
    path1.lineTo(size.width * 0.4, size.height * 0.65);
    path1.lineTo(size.width * 0.6, size.height * 0.35);
    path1.lineTo(size.width * 0.8, size.height * 0.55);
    path1.lineTo(size.width, size.height * 0.45);
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint);

    // Snow caps
    final snowPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final snowPath = Path();
    snowPath.moveTo(size.width * 0.15, size.height * 0.45);
    snowPath.lineTo(size.width * 0.2, size.height * 0.4);
    snowPath.lineTo(size.width * 0.25, size.height * 0.45);
    snowPath.close();
    canvas.drawPath(snowPath, snowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ConsultingServices extends StatelessWidget {
  const ConsultingServices({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6B4423), Color(0xFFA67C52)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Expert Consulting',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Phala & Motaung provide geological expertise for mineral exploration, site assessment, and investment opportunities across Lesotho',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildServiceCard(
                icon: Icons.science,
                title: 'Site Assessment',
                description: 'Geological surveys and kimberlite pipe analysis for diamond exploration potential',
                color: Colors.blue,
              ),
              _buildServiceCard(
                icon: Icons.map,
                title: 'Resource Mapping',
                description: 'Detailed mapping of mineral deposits including coal, clay, uranium and alluvial diamond zones',
                color: Colors.green,
              ),
              _buildServiceCard(
                icon: Icons.analytics,
                title: 'Investment Analysis',
                description: 'ROI projections and risk assessment for mining operations in Lesotho\'s challenging terrain',
                color: Colors.purple,
              ),
              _buildServiceCard(
                icon: Icons.handyman,
                title: 'Technical Advisory',
                description: 'Equipment selection, logistics planning, and regulatory compliance for mountain mining',
                color: Colors.orange,
              ),
              _buildComingSoonSection(),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 28, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            description,
            style: TextStyle(height: 1.5, color: Colors.grey[700]),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios, size: 18),
          onPressed: () => _showComingSoon(context, title),
        ),
      ),
    );
  }

  Widget _buildComingSoonSection() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF5F7FA), Color(0xFFE4E7EB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(Icons.cloud_download, size: 60, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Real-time Mineral Database',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Coming Q3 2026: Live API integration with geological survey data, satellite imagery analysis, and drill core databases',
                  style: TextStyle(
                    color: Colors.grey[700],
                    height: 1.6,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _showComingSoon(context, 'Database Access'),
                  icon: const Icon(Icons.notifications_active),
                  label: const Text('GET NOTIFIED AT LAUNCH'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A365D),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Consulting service for $feature coming soon! Contact us directly for immediate assistance.'),
        backgroundColor: const Color(0xFF2C5282),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class AboutCreators extends StatelessWidget {
  const AboutCreators({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: 280,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Icon(Icons.group, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Phala & Motaung',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(color: Colors.black45, offset: Offset(0, 2), blurRadius: 4),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Lesotho Mineral Consulting',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildAboutSection(
                title: 'Our Mission',
                content: 'To unlock Lesotho\'s mineral potential through expert geological analysis, sustainable exploration practices, and transparent consulting for local communities and international investors.',
                icon: Icons.flag,
              ),
              _buildAboutSection(
                title: 'Expertise',
                content: 'Combined 15+ years in geological surveying, diamond valuation, resource mapping, and regulatory compliance across Southern Africa. Specialized knowledge of Lesotho\'s unique kimberlite pipe formations and mountainous terrain challenges.',
                icon: Icons.science,
              ),
              _buildTeamMember(
                name: 'Phala',
                role: 'Lead Geologist',
                expertise: 'Diamond exploration, kimberlite analysis, alluvial deposit mapping',
                color: Colors.blue,
              ),
              _buildTeamMember(
                name: 'Motaung',
                role: 'Technical Director',
                expertise: 'GIS mapping, resource modeling, investor relations, regulatory strategy',
                color: Colors.purple,
              ),
              _buildContactSection(),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection({required String title, required String content, required IconData icon}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A365D).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: const Color(0xFF1A365D)),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              content,
              style: TextStyle(height: 1.6, color: Colors.grey[800], fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember({
    required String name,
    required String role,
    required String expertise,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.4), width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name[0],
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(role, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(expertise, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.email_outlined),
          onPressed: () => _showComingSoon(context, '$name contact'),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.contact_mail, size: 48, color: Color(0xFF1A365D)),
            const SizedBox(height: 16),
            const Text(
              'Contact Us for Consulting',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'For immediate mineral exploration consulting in Lesotho, contact our team directly:',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildContactChip(Icons.email, 'consult@lesothominerals.co.ls'),
                _buildContactChip(Icons.phone, '+266 2231 7890'),
                _buildContactChip(Icons.location_on, 'Maseru, Lesotho'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF1A365D), width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF1A365D)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1A365D),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Direct contact with $feature coming soon! For now, email consult@lesothominerals.co.ls'),
        backgroundColor: const Color(0xFF2C5282),
      ),
    );
  }
}

// ===== DATA MODELS =====

class Mineral {
  final String name;
  final String primaryLocation;
  final String description;
  final String status;
  final IconData icon;
  final Color color;
  final List<Color> gradientColors;

  Mineral({
    required this.name,
    required this.primaryLocation,
    required this.description,
    required this.status,
    required this.icon,
    required this.color,
    required this.gradientColors,
  });
}

final List<Mineral> mineralData = [
  Mineral(
    name: 'Diamonds',
    primaryLocation: 'Letšeng, Mothae, Kao',
    description: 'Lesotho produces some of the world\'s largest and highest-value diamonds. The Letšeng mine (3,100m elevation) is renowned for exceptional white diamonds. Over 400 kimberlite pipes identified across northern highlands.',
    status: 'ACTIVE EXPLORATION',
    icon: Icons.diamond,
    color: Colors.blue,
    gradientColors: [Colors.blue.shade300, Colors.blue.shade700],
  ),
  Mineral(
    name: 'Coal & Anthracite',
    primaryLocation: 'Maloma Colliery',
    description: 'Anthracite coal deposits at Maloma support domestic energy needs. Bituminous shale reserves identified in multiple districts with potential for expanded mining operations.',
    status: 'OPERATIONAL',
    icon: Icons.snowflake,
    color: Colors.grey,
    gradientColors: [Colors.brown.shade300, Colors.grey.shade700],
  ),
  Mineral(
    name: 'Clay & Pottery',
    primaryLocation: 'Phoqoane',
    description: 'High-quality clay deposits in Phoqoane region used extensively by local pottery industry. Additional sandstone and crushed stone quarries support construction sector nationwide.',
    status: 'LOCAL USE',
    icon: Icons.grain,
    color: Colors.orange,
    gradientColors: [Colors.orange.shade300, Colors.brown.shade600],
  ),
  Mineral(
    name: 'Uranium & Base Metals',
    primaryLocation: 'Northern Districts',
    description: 'Uranium deposits identified but remain under-explored due to infrastructure challenges. Significant potential for copper, nickel and other base metals in volcanic rock formations.',
    status: 'EXPLORATION PHASE',
    icon: Icons.radioactive,
    color: Colors.green,
    gradientColors: [Colors.green.shade400, Colors.green.shade800],
  ),
];

class MapLocation {
  final String name;
  final double xPercent;
  final double yPercent;
  final IconData icon;
  final Color color;
  final String description;

  MapLocation({
    required this.name,
    required this.xPercent,
    required this.yPercent,
    required this.icon,
    required this.color,
    required this.description,
  });
}

final List<MapLocation> _mineralLocations = [
  MapLocation(
    name: 'Letšeng',
    xPercent: 0.25,
    yPercent: 0.35,
    icon: Icons.diamond,
    color: Colors.blue,
    description: 'World-famous high-elevation diamond mine producing exceptional large white diamonds',
  ),
  MapLocation(
    name: 'Liqhobong',
    xPercent: 0.15,
    yPercent: 0.45,
    icon: Icons.diamond,
    color: Colors.blue,
    description: 'Major diamond pipe mine in Butha-Buthe District operated by Firestone Diamonds',
  ),
  MapLocation(
    name: 'Kao',
    xPercent: 0.45,
    yPercent: 0.55,
    icon: Icons.diamond,
    color: Colors.blue,
    description: 'Location of Lesotho\'s largest kimberlite pipe, operated by Storm Mountain Diamonds',
  ),
  MapLocation(
    name: 'Maloma',
    xPercent: 0.65,
    yPercent: 0.75,
    icon: Icons.snowflake,
    color: Colors.grey,
    description: 'Anthracite coal colliery supporting domestic energy production',
  ),
  MapLocation(
    name: 'Phoqoane',
    xPercent: 0.75,
    yPercent: 0.65,
    icon: Icons.grain,
    color: Colors.orange,
    description: 'Clay deposits used extensively by Lesotho\'s pottery industry',
  ),
];

class District {
  final String name;
  final String resources;
  final Color color;

  District({required this.name, required this.resources, required this.color});
}

final List<District> _districts = [
  District(
    name: 'Mokhotlong',
    resources: 'Letšeng & Mothae diamond mines • Highest elevation operations',
    color: Colors.blue,
  ),
  District(
    name: 'Butha-Buthe',
    resources: 'Liqhobong diamond pipe • Active exploration sites',
    color: Colors.blue,
  ),
  District(
    name: 'Leribe',
    resources: 'Kao kimberlite pipe • Largest single deposit',
    color: Colors.blue,
  ),
  District(
    name: 'Mafeteng',
    resources: 'Kolo mining area • Historical diamond production',
    color: Colors.blue,
  ),
  District(
    name: 'Thaba-Tseka',
    resources: 'Alluvial deposits • Riverbed exploration potential',
    color: Colors.green,
  ),
];
