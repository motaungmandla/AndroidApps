import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const AllianceDemoHub());
}

class AllianceDemoHub extends StatefulWidget {
  const AllianceDemoHub({super.key});

  @override
  State<AllianceDemoHub> createState() => _AllianceDemoHubState();
}

class _AllianceDemoHubState extends State<AllianceDemoHub> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alliance Demo Hub',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red[700],
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red[700]!,
          primary: Colors.red[700]!,
          secondary: Colors.red[400]!,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[700],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        primaryColor: Colors.red[700],
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: HomeScreen(onToggleTheme: toggleTheme),
    );
  }
}

// ===== WEBSITE MODEL =====
class Website {
  final int id;
  final String name;
  final String url;
  final String description;
  final IconData icon;
  final Color color;
  final String category;
  final String? badge;

  Website({
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

// ===== HOME SCREEN =====
class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const HomeScreen({super.key, required this.onToggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalVisits = 0;
  int totalCopies = 0;

  final List<Website> websites = [
    Website(
      id: 0,
      name: 'Alliance Insurance',
      url: 'https://www.alliance.co.ls/',
      description: 'Visit the official Alliance Insurance Lesotho website',
      icon: Icons.public,
      color: Colors.red[700]!,
      category: 'Official',
      badge: 'Official Site',
    ),
    Website(
      id: 1,
      name: 'AI Chat Assistant',
      url: 'https://huggingface.co/spaces/MandlaZwane/motaunginc',
      description: 'Working contextual chatbot - see it in action!',
      icon: Icons.chat_bubble,
      color: Colors.red[700]!,
      category: 'AI/ML',
      badge: 'Live Demo',
    ),
    Website(
      id: 2,
      name: 'Bot Demo Video',
      url: 'https://youtu.be/n6Yh9bJsIkY',
      description: 'Watch the chatbot handle real conversations',
      icon: Icons.video_library,
      color: Colors.red[600]!,
      category: 'AI/ML',
    ),
    Website(
      id: 3,
      name: 'NLP Publication',
      url: 'https://youtu.be/GoXAQVTiv8Q?si=6CtfyvFk3OLDCznz',
      description: 'Published paper & presentation on NLP work',
      icon: Icons.article,
      color: Colors.deepPurple,
      category: 'Research',
      badge: 'Published',
    ),
    Website(
      id: 4,
      name: 'ASR Project',
      url: 'https://youtu.be/GoXAQVTiv8Q?si=6CtfyvFk3OLDCznz', 
      description: 'Sesotho speech recognition - seeking funding to deploy for our nation',
      icon: Icons.mic,
      color: Colors.orange,
      category: 'AI/ML',
      badge: 'Needs Support',
    ),
    Website(
      id: 5,
      name: 'SeSoDa Dataset',
      url: 'https://upjournals.up.ac.za/index.php/dhasa/article/view/6742',
      description: 'Sesotho Dataset for AI research - read & cite our published paper',
      icon: Icons.dataset,
      color: Colors.green[700]!,
      category: 'Research',
      badge: 'Open Paper',
    ),
    Website(
      id: 6,
      name: 'MovieTree API',
      url: 'https://movietree.vercel.app',
      description: 'TheMovieDB API integration - proves API expertise',
      icon: Icons.api,
      color: Colors.blue,
      category: 'Development',
      badge: 'API Demo',
    ),
    Website(
      id: 7,
      name: 'Lucky Bets Dev Demo',
      url: 'https://youtu.be/_gURXvlqRBc?si=X5WDj48xDzDm04fR',
      description: 'Full-stack development demo showcasing real-time state management.',
      icon: Icons.casino,
      color: Colors.amber[700]!,
      category: 'Development',
      badge: 'Live Demo',
    ),
    Website(
      id: 8,
      name: 'Coin Tossing Demo',
      url: 'https://youtu.be/o3DjSXh-t_A?si=JG_vREmiP7GIGG0N',
      description: 'Interactive probabilistic simulation demonstrating clean architecture.',
      icon: Icons.flip,
      color: Colors.blueGrey,
      category: 'Development',
    ),
    Website(
      id: 9,
      name: 'Horse Racing Demo',
      url: 'https://youtu.be/q5MzADBpOSA?si=5YdfZfcQBXfy-ffi',
      description: 'Dynamic UI and event-driven architecture demonstration.',
      icon: Icons.sports_score,
      color: Colors.teal,
      category: 'Development',
      badge: 'Interactive',
    ),
    Website(
      id: 10,
      name: 'GitHub Profile',
      url: 'https://github.com/motaungmandla',
      description: 'Open source projects & AI models',
      icon: Icons.code,
      color: Colors.black87,
      category: 'Development',
    ),
    Website(
      id: 11,
      name: 'Contact Me',
      url: 'mailto:maxphin21@gmail.com',
      description: 'Let\'s discuss how I can add value to Alliance',
      icon: Icons.email,
      color: Colors.red[700]!,
      category: 'Professional',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
              child: Icon(Icons.shield, color: Colors.red[700], size: 24),
            ),
            const SizedBox(width: 8),
            const Text('Alliance Demo Hub', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_themeMode == ThemeMode.dark ? Icons.wb_sunny : Icons.nightlight),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          // Hero Banner
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red[700]!, Colors.red[400]!]),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.white, size: 28),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Building AI for Sesotho Speakers',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'This role would fund my ASR project to deploy inclusive AI models for our nation.',
                  style: TextStyle(color: Colors.white.withOpacity(0.95), fontSize: 13),
                ),
              ],
            ),
          ),
          // Stats Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red[200]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat(Icons.link, 'Demos', websites.length.toString(), Colors.red[700]!),
                _buildStat(Icons.remove_red_eye, 'Visits', totalVisits.toString(), Colors.red[700]!),
                _buildStat(Icons.content_copy, 'Copies', totalCopies.toString(), Colors.red[700]!),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Project Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: websites.length,
              itemBuilder: (context, index) => _buildCard(websites[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String label, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
      ],
    );
  }

  Widget _buildCard(Website site) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () async {
          setState(() => totalVisits++);
          await _launchUrl(site.url);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: site.badge != null
                ? LinearGradient(
                    colors: [site.color.withOpacity(0.05), site.color.withOpacity(0.1)],
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
                        color: site.color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(site.icon, color: site.color, size: 24),
                    ),
                    const Spacer(),
                    if (site.badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: site.color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          site.badge!,
                          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(site.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Text(site.description, style: TextStyle(color: Colors.grey[600], fontSize: 11, height: 1.3),
                    maxLines: 3, overflow: TextOverflow.ellipsis),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Text(site.category,
                          style: TextStyle(color: Colors.grey[500], fontSize: 10, fontWeight: FontWeight.w500)),
                    ),
                    // ✅ COPY BUTTON (Built-in, no external package needed)
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      splashRadius: 18,
                      icon: Icon(Icons.content_copy, size: 16, color: Colors.grey[600]),
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: site.url));
                        setState(() => totalCopies++);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('✓ Link copied!'),
                              backgroundColor: Colors.green[700],
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
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
      if (uri.scheme.isEmpty) throw Exception('Invalid URL scheme');
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Cannot launch URL');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to open: ${e.toString()}'),
          backgroundColor: Colors.red[700],
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
