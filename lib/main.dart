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
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        cardTheme: const CardTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          elevation: 2,
          color: Colors.white,
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
        title: const Text('Lesotho Mineral Atlas', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A365D))),
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 28),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      drawer: _buildDrawer(context),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Minerals'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.business_center), label: 'Consulting'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'About'),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.grain, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Lesotho Mineral Atlas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'by Phala & Motaung',
                  style: TextStyle(
                    color: Colors.blue[100],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          _drawerItem(context, Icons.layers, 'Mineral Deposits', 0),
          _drawerItem(context, Icons.map, 'Exploration Map', 1),
          _drawerItem(context, Icons.business_center, 'Consulting Services', 2),
          _drawerItem(context, Icons.people, 'About Us', 3),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1A365D)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: () {
        Navigator.pop(context);
        setState(() => _currentIndex = index);
      },
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
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Expert geological consulting for diamond, coal, clay & uranium exploration',
                  style: TextStyle(
                    color: Colors.blue[100],
                    fontSize: 16,
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
                return _buildMineralCard(context, mineralData[index]);
              },
              childCount: mineralData.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMineralCard(BuildContext context, Mineral mineral) {
    return Card(
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
                  style: const TextStyle(color: Colors.grey),
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
                    color: Colors.blue[100],
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
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF88C9A1), Color(0xFF4A7C59)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Lesotho Mineral Map\n(Coming Soon: Interactive GIS)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
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
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Phala & Motaung provide geological expertise for mineral exploration in Lesotho',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
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
                context,
                icon: Icons.science,
                title: 'Site Assessment',
                description: 'Geological surveys and kimberlite pipe analysis',
              ),
              _buildServiceCard(
                context,
                icon: Icons.map,
                title: 'Resource Mapping',
                description: 'Detailed mapping of mineral deposits',
              ),
              _buildServiceCard(
                context,
                icon: Icons.analytics,
                title: 'Investment Analysis',
                description: 'ROI projections for mining operations',
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(BuildContext context, {required IconData icon, required String title, required String description}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 28, color: Colors.blue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(description, style: const TextStyle(color: Colors.grey)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
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
            height: 250,
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
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Icon(Icons.group, size: 45, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Phala & Motaung',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Lesotho Mineral Consulting',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 17,
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
              _buildAboutCard(
                context,
                title: 'Our Mission',
                content: 'To unlock Lesotho\'s mineral potential through expert geological analysis and sustainable exploration practices.',
              ),
              _buildTeamMember(context, name: 'Phala', role: 'Lead Geologist', expertise: 'Diamond exploration, kimberlite analysis'),
              _buildTeamMember(context, name: 'Motaung', role: 'Technical Director', expertise: 'GIS mapping, resource modeling, investor relations'),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutCard(BuildContext context, {required String title, required String content}) {
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
                  child: const Icon(Icons.flag, color: Color(0xFF1A365D)),
                ),
                const SizedBox(width: 12),
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 14),
            Text(content, style: const TextStyle(height: 1.6)),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(BuildContext context, {required String name, required String role, required String expertise}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              name[0],
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.purple),
            ),
          ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(role, style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(expertise, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// ===== DATA MODELS =====
class Mineral {
  final String name;
  final String primaryLocation;
  final String status;
  final IconData icon;
  final Color color;
  final List<Color> gradientColors;

  const Mineral({
    required this.name,
    required this.primaryLocation,
    required this.status,
    required this.icon,
    required this.color,
    required this.gradientColors,
  });
}

const List<Mineral> mineralData = [
  Mineral(
    name: 'Diamonds',
    primaryLocation: 'Letšeng, Mothae, Kao',
    status: 'ACTIVE EXPLORATION',
    icon: Icons.diamond,
    color: Colors.blue,
    gradientColors: [Colors.blue, Colors.indigo],
  ),
  Mineral(
    name: 'Coal & Anthracite',
    primaryLocation: 'Maloma Colliery',
    status: 'OPERATIONAL',
    icon: Icons.grain,
    color: Colors.brown,
    gradientColors: [Colors.brown, Colors.grey],
  ),
  Mineral(
    name: 'Clay & Pottery',
    primaryLocation: 'Phoqoane',
    status: 'LOCAL USE',
    icon: Icons.factory,
    color: Colors.orange,
    gradientColors: [Colors.orange, Colors.deepOrange],
  ),
  Mineral(
    name: 'Uranium & Base Metals',
    primaryLocation: 'Northern Districts',
    status: 'EXPLORATION PHASE',
    icon: Icons.science,
    color: Colors.green,
    gradientColors: [Colors.green, Colors.teal],
  ),
];
