import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: HubColors.obsidianBlack,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: HubColors.obsidianBlack,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MotaungHubApp());
}

class HubColors {
  static const Color obsidianBlack = Color(0xFF0B0B0D);
  static const Color surfaceDark = Color(0xFF15151A);
  static const Color cardDark = Color(0xFF1C1C24);
  static const Color borderSubtle = Color(0xFF2E2E38);
  static const Color electricYellow = Color(0xFFFFD000);
  static const Color amberGold = Color(0xFFFFA800);
  static const Color logoEmber = Color(0xFFFF5E00);
  static const Color liveEmerald = Color(0xFF10B981);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFFA1A1AA);
}

class MotaungHubApp extends StatelessWidget {
  const MotaungHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motaung Hub & LuckyBets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: HubColors.obsidianBlack,
        primaryColor: HubColors.electricYellow,
        colorScheme: const ColorScheme.dark(
          primary: HubColors.electricYellow,
          secondary: HubColors.amberGold,
          surface: HubColors.surfaceDark,
        ),
        useMaterial3: true,
      ),
      home: const HubHomeScreen(),
    );
  }
}

class HubHomeScreen extends StatefulWidget {
  const HubHomeScreen({super.key});

  @override
  State<HubHomeScreen> createState() => _HubHomeScreenState();
}

class _HubHomeScreenState extends State<HubHomeScreen> {
  // Switch between the Portfolio Hub view and the Embedded LuckyBets View
  bool _isLuckyBetsOpen = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isLuckyBetsOpen,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        if (_isLuckyBetsOpen) {
          setState(() {
            _isLuckyBetsOpen = false;
          });
        }
      },
      child: Scaffold(
        appAppBar: AppBar(
          backgroundColor: HubColors.obsidianBlack,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 60,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: HubColors.borderSubtle),
          ),
          leading: _isLuckyBetsOpen
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, color: HubColors.electricYellow),
                  onPressed: () {
                    setState(() {
                      _isLuckyBetsOpen = false;
                    });
                  },
                )
              : null,
          title: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: HubColors.logoEmber,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: HubColors.electricYellow.withValues(alpha: 0.6),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    HubColors.electricYellow,
                    HubColors.amberGold,
                    HubColors.logoEmber,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: Text(
                  _isLuckyBetsOpen ? 'LUCKYBETS LESOTHO' : 'MOTAUNG HUB',
                  style: const TextStyle(
                    fontFamily: 'sans-serif',
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            if (_isLuckyBetsOpen)
              IconButton(
                tooltip: 'Home Hub',
                icon: const Icon(Icons.home_rounded, color: HubColors.electricYellow),
                onPressed: () {
                  setState(() {
                    _isLuckyBetsOpen = false;
                  });
                },
              )
            else
              Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: HubColors.liveEmerald.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: HubColors.liveEmerald.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: HubColors.liveEmerald,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'ONLINE',
                      style: TextStyle(
                        color: HubColors.liveEmerald,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        body: _isLuckyBetsOpen
            ? const LuckyBetsWebViewScreen()
            : _buildPortfolioHome(context),
      ),
    );
  }

  Widget _buildPortfolioHome(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Welcome Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: HubColors.cardDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: HubColors.borderSubtle),
              gradient: const LinearGradient(
                colors: [Color(0xFF1C1C24), Color(0xFF121217)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: HubColors.electricYellow,
                      child: Text(
                        'MM',
                        style: TextStyle(
                          color: HubColors.obsidianBlack,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mandla Motaung',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: HubColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Full-Stack Developer & Software Engineer',
                            style: TextStyle(
                              fontSize: 13,
                              color: HubColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Divider(color: HubColors.borderSubtle, height: 1),
                const SizedBox(height: 16),
                const Text(
                  'Welcome to your app hub. Tap LuckyBets below to open the platform natively inside your app experience, exactly like Facebook or native in-app browsers.',
                  style: TextStyle(
                    fontSize: 14,
                    color: HubColors.textMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'FEATURED PLATFORMS',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: HubColors.electricYellow,
            ),
          ),
          const SizedBox(height: 12),

          // In-App LuckyBets Launcher Card
          _buildAppCard(
            context,
            title: 'LuckyBets Lesotho',
            category: 'SPORTSBOOK & CASINO',
            description:
                'Launch the full betting platform natively within the app with active session cookies and instant odds rendering.',
            badgeColor: HubColors.liveEmerald,
            badgeText: 'IN-APP WEBVIEW',
            onTap: () {
              setState(() {
                _isLuckyBetsOpen = true;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppCard(
    BuildContext context, {
    required String title,
    required String category,
    required String description,
    required Color badgeColor,
    required String badgeText,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: HubColors.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HubColors.borderSubtle),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                        color: HubColors.textMuted,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: badgeColor.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(
                        badgeText,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: badgeColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: HubColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: HubColors.textMuted,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'Open In-App',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: HubColors.electricYellow,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: HubColors.electricYellow,
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
}

/// Standalone WebView Screen Widget handling the direct link inside the app
class LuckyBetsWebViewScreen extends StatefulWidget {
  const LuckyBetsWebViewScreen({super.key});

  @override
  State<LuckyBetsWebViewScreen> createState() => _LuckyBetsWebViewScreenState();
}

class _LuckyBetsWebViewScreenState extends State<LuckyBetsWebViewScreen> {
  late final WebViewController _controller;
  double _progress = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(HubColors.obsidianBlack)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                _progress = progress / 100.0;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('https://luckybets.gt.tc'));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading || _progress < 1.0)
          LinearProgressIndicator(
            value: _progress,
            minHeight: 3,
            backgroundColor: HubColors.surfaceDark,
            valueColor: const AlwaysStoppedAnimation<Color>(
              HubColors.electricYellow,
            ),
          ),
      ],
    );
  }
}
