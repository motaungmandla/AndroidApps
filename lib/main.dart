import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MotaungHubApp());
}

class MotaungHubApp extends StatefulWidget {
  const MotaungHubApp({super.key});

  @override
  State<MotaungHubApp> createState() => _MotaungHubAppState();
}

class _MotaungHubAppState extends State<MotaungHubApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motaung Hub',
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red[700],
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red[700]!,
          primary: Colors.red[700]!,
          secondary: Colors.red[400]!,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB71C1C),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        primaryColor: Colors.red[700],
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.dark(
          primary: Colors.red[400]!,
          secondary: Colors.red[300]!,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8B0000),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      home: HomeScreen(onToggleTheme: toggleTheme, currentTheme: _themeMode),
    );
  }
}

class AppItem {
  final int id;
  final String name;
  final String url;
  final String description;
  final IconData icon;
  final Color color;
  final String category;
  final String? badge;

  AppItem({
    required this.id,
    required this.name,
    required this.url,
    required this.description,
    required this.icon,
    required this.color,
    required this.category,
    this.badge,
  });
}

class HomeScreen extends StatefulWidget {
  final ThemeMode currentTheme;
  final VoidCallback onToggleTheme;

  const HomeScreen({
    super.key,
    required this.currentTheme,
    required this.onToggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  int totalVisits = 0;

  final List<AppItem> allItems = [
    // Projects from resume
    AppItem(
      id: 0,
      name: 'Sesotho ASR',
      url: 'https://github.com/motaungmandla',
      description: 'Sesotho Automatic Speech Recognition - AI for African languages',
      icon: Icons.mic,
      color: Colors.orange,
      category: 'AI/ML',
      badge: 'Active',
    ),
    AppItem(
      id: 1,
      name: 'Algebraic Chatbot',
      url: 'https://huggingface.co/spaces/MandlaZwane/motaunginc',
      description: 'Contextual chatbot that solves algebra problems conversationally',
      icon: Icons.chat_bubble,
      color: Colors.red[700]!,
      category: 'AI/ML',
      badge: 'Live',
    ),
    AppItem(
      id: 2,
      name: 'SeSoDa Dataset',
      url: 'https://upjournals.up.ac.za/index.php/dhasa/article/view/6742',
      description: 'Published academic paper - Sesotho Dataset for AI research',
      icon: Icons.dataset,
      color: Colors.green[700]!,
      category: 'Research',
      badge: 'Published',
    ),
    // Development demos
    AppItem(
      id: 3,
      name: 'Lucky Bets Demo',
      url: 'https://youtu.be/_gURXvlqRBc?si=X5WDj48xDzDm04fR',
      description: 'Real-time state management showcase with smooth UI',
      icon: Icons.casino,
      color: Colors.amber[700]!,
      category: 'Development',
      badge: 'Demo',
    ),
    AppItem(
      id: 4,
      name: 'Coin Toss Demo',
      url: 'https://youtu.be/o3DjSXh-t_A?si=JG_vREmiP7GIGG0N',
      description: 'Probabilistic simulation with clean architecture',
      icon: Icons.flip,
      color: Colors.blueGrey,
      category: 'Development',
    ),
    AppItem(
      id: 5,
      name: 'Horse Racing Demo',
      url: 'https://youtu.be/q5MzADBpOSA?si=5YdfZfcQBXfy-ffi',
      description: 'Event-driven UI with real-time animations',
      icon: Icons.sports_score,
      color: Colors.teal,
      category: 'Development',
      badge: 'Interactive',
    ),
    AppItem(
      id: 6,
      name: 'MovieTree API',
      url: 'https://movietree.vercel.app',
      description: 'TheMovieDB API integration - REST API expertise',
      icon: Icons.api,
      color: Colors.blue,
      category: 'Development',
      badge: 'API',
    ),
    // Professional links
    AppItem(
      id: 7,
      name: 'GitHub Profile',
      url: 'https://github.com/motaungmandla',
      description: 'Open source projects & AI models',
      icon: Icons.code,
      color: Colors.grey[800]!,
      category: 'Professional',
    ),
    AppItem(
      id: 8,
      name: 'Kaggle Profile',
      url: 'https://kaggle.com',
      description: 'Data science competitions & datasets',
      icon: Icons.bar_chart,
      color: Colors.indigo,
      category: 'Professional',
    ),
    AppItem(
      id: 9,
      name: 'Contact Me',
      url: 'mailto:mandlamotaung89@gmail.com',
      description: 'mandlamotaung89@gmail.com | +266 63973129',
      icon: Icons.email,
      color: Colors.red[700]!,
      category: 'Professional',
    ),
  ];

  List<String> get categories {
    final cats = allItems.map((e) => e.category).toSet().toList();
    return ['All', ...cats];
  }

  List<AppItem> get filteredItems {
    return allItems.where((item) {
      final matchesSearch =
          item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              item.description
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || item.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.currentTheme == ThemeMode.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.shield, color: Colors.red[700], size: 22),
            ),
            const SizedBox(width: 10),
            const Text(
              'Motaung Hub',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        actions: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                RotationTransition(turns: animation, child: child),
            child: IconButton(
              key: ValueKey(widget.currentTheme),
              icon: Icon(
                isDark ? Icons.wb_sunny : Icons.nightlight,
                color: Colors.white,
              ),
              onPressed: widget.onToggleTheme,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // About Me Card - Updated with actual resume info
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red[800]!, Colors.red[600]!],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Text(
                    'MM',
                    style: TextStyle(
                      color: Colors.red[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mandla Motaung',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'BSc Math & CS @ NUL | AI & ML Intern',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'SeSoDa Dataset Publisher',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Search projects, demos, or links...',
                prefixIcon: Icon(Icons.search, color: subTextColor),
                filled: true,
                fillColor: isDark ? Colors.white10 : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                    backgroundColor: isDark ? Colors.white10 : Colors.grey[200],
                    selectedColor: Colors.red[700],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat(
                  Icons.link,
                  'Total',
                  filteredItems.length.toString(),
                  Colors.red[700]!,
                  isDark,
                ),
                _buildStat(
                  Icons.remove_red_eye,
                  'Visits',
                  totalVisits.toString(),
                  Colors.red[700]!,
                  isDark,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Text(
                      'No items found.',
                      style: TextStyle(color: subTextColor),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) =>
                        _buildCard(filteredItems[index], isDark),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(
    IconData icon,
    String label,
    String value,
    Color color,
    bool isDark,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.white60 : Colors.black54,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(AppItem item, bool isDark) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () async {
          setState(() => totalVisits++);
          await _launchUrl(item.url);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: item.badge != null
                ? LinearGradient(
                    colors: [
                      item.color.withOpacity(0.05),
                      item.color.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: item.color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(item.icon, color: item.color, size: 24),
                    ),
                    const Spacer(),
                    if (item.badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: item.color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item.badge!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                    fontSize: 11,
                    height: 1.3,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.category,
                        style: TextStyle(
                          color: isDark ? Colors.white54 : Colors.black45,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.open_in_new,
                      size: 16,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    try {
      final uri = Uri.parse(urlString.trim());
      if (!uri.hasScheme) {
        throw Exception('Invalid URL: missing scheme');
      }

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open link: ${e.toString()}'),
          backgroundColor: Colors.red[700],
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
