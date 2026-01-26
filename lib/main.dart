import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const WebsitePromoterApp());
}

class WebsitePromoterApp extends StatelessWidget {
  const WebsitePromoterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motaung Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        fontFamily: 'Inter', // Make sure you have Inter in pubspec.yaml or remove
      ),
      home: const HomeScreen(),
    );
  }
}

class Website {
  final String name;
  final String url;
  final String description;
  final IconData icon;
  final Color color;

  Website({
    required this.name,
    required this.url,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  // ✅ FIXED: Removed trailing spaces in URLs
  final List<Website> websites = [
    Website(
      name: 'Portfolio',
      url: 'https://motaungmandla.github.io',
      description: 'My professional portfolio & case studies',
      icon: Icons.person,
      color: Colors.blue,
    ),
    Website(
      name: 'Entertainment',
      url: 'https://movietree.vercel.app',
      description: 'Movies & shows to brighten your day',
      icon: Icons.movie,
      color: Colors.green,
    ),
    Website(
      name: 'Blog',
      url: 'https://eatingbattle.vercel.app',
      description: 'Tech insights & tutorials',
      icon: Icons.article,
      color: Colors.orange,
    ),
    Website(
      name: 'GitHub',
      url: 'https://github.com/motaungmandla',
      description: 'Open source projects & datasets',
      icon: Icons.code,
      color: Colors.black,
    ),
    Website(
      name: 'Client Portal',
      url: 'https://motaunginc.vercel.app',
      description: 'AI-powered business tools',
      icon: Icons.business,
      color: Colors.purple,
    ),
    Website(
      name: 'Personal Gallery',
      url: 'https://motaung.gt.tc',
      description: 'Private photo vault & memories',
      icon: Icons.photo_library,
      color: Colors.pink,
    ),
    Website(
      name: 'Contact Me',
      url: 'https://motaungmandla.vercel.app',
      description: 'Get in touch for collabs or help',
      icon: Icons.contact_mail,
      color: Colors.red,
    ),
  ];

  // 🔥 NEW: Tutoring Service Card (not just a link — actionable!)
  final tutoringService = TutoringService(
    subjects: ['Mathematics (Calculus 1)', 'Physics', 'Python Programming'],
    price: 'M90 per subject',
    features: [
      'Personalized 1-on-1 sessions',
      'Follow-up tests & quizzes',
      'Shared study materials (PDFs, notes)',
      'Flexible scheduling'
    ],
    contactUrl: 'https://motaungmandla.vercel.app',
  );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Website> get _filteredWebsites {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) return websites;
    return websites.where((w) =>
        w.name.toLowerCase().contains(query) ||
        w.description.toLowerCase().contains(query)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Motaung Hub',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'All my projects & services in one place',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.rocket_launch,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),

              // Stats Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Active Projects',
                        '${websites.length}',
                        Icons.trending_up,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        'Tutoring',
                        'M90',
                        Icons.school,
                      ),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search projects...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  onChanged: (_) => setState(() {}),
                ),
              ),

              // Tutoring Banner (NEW!)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: GestureDetector(
                  onTap: () => _launchWebsite(tutoringService.contactUrl),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.amber[600],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.menu_book, color: Colors.white, size: 32),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '📚 First-Year Tutoring Available!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tutoringService.price,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: tutoringService.subjects.map((sub) =>
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.amber[800],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      sub,
                                      style: TextStyle(color: Colors.white, fontSize: 11),
                                    ),
                                  )
                                ).toList(),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),

              // Website Grid
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'My Websites',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple[50],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Tap to visit',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.deepPurple[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.85,
                              ),
                              itemCount: _filteredWebsites.length,
                              itemBuilder: (context, index) {
                                return _buildWebsiteCard(_filteredWebsites[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWebsiteCard(Website website) {
    return GestureDetector(
      onTap: () => _launchWebsite(website.url),
      onLongPress: () => _copyToClipboard(website.url),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: website.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  website.icon,
                  color: website.color,
                  size: 28,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    website.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    website.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: website.color.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Visit Now',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: website.color,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: 14,
                      color: website.color,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchWebsite(String url) async {
    // Ensure URL starts with http(s)
    String cleanUrl = url.trim();
    if (!cleanUrl.startsWith('http')) {
      cleanUrl = 'https://$cleanUrl';
    }
    final uri = Uri.parse(cleanUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open $url'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('URL copied to clipboard!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// 🔥 Tutoring Service Model
class TutoringService {
  final List<String> subjects;
  final String price;
  final List<String> features;
  final String contactUrl;

  TutoringService({
    required this.subjects,
    required this.price,
    required this.features,
    required this.contactUrl,
  });
}
