
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0B0B0D),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0B0B0D),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const LuckyBetsApp());
}

class LuckyBetsApp extends StatelessWidget {
  const LuckyBetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LuckyBets Lesotho',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0B0D),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFD000),
          surface: Color(0xFF15151A),
        ),
        useMaterial3: true,
      ),
      home: const LuckyBetsScreen(),
    );
  }
}

class LuckyBetsScreen extends StatefulWidget {
  const LuckyBetsScreen({super.key});

  @override
  State<LuckyBetsScreen> createState() => _LuckyBetsScreenState();
}

class _LuckyBetsScreenState extends State<LuckyBetsScreen> {
  static const String websiteUrl = 'https://luckybets.gt.tc';

  late final WebViewController controller;

  bool isLoading = true;
  bool hasError = false;
  int progress = 0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF0B0B0D))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (value) {
            if (!mounted) return;

            setState(() {
              progress = value;
            });
          },

          onPageStarted: (url) {
            if (!mounted) return;

            setState(() {
              isLoading = true;
              hasError = false;
            });
          },

          onPageFinished: (url) {
            if (!mounted) return;

            setState(() {
              isLoading = false;
              hasError = false;
            });
          },

          onWebResourceError: (error) {
            if (!mounted) return;

            if (error.isForMainFrame == true) {
              setState(() {
                isLoading = false;
                hasError = true;
              });
            }
          },

          onNavigationRequest: (request) {
            final uri = Uri.tryParse(request.url);

            if (uri == null) {
              return NavigationDecision.prevent;
            }

            if (uri.scheme == 'https' || uri.scheme == 'http') {
              return NavigationDecision.navigate;
            }

            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(websiteUrl));
  }

  Future<void> reloadWebsite() async {
    setState(() {
      isLoading = true;
      hasError = false;
      progress = 0;
    });

    await controller.reload();
  }

  Future<void> handleBack() async {
    if (await controller.canGoBack()) {
      await controller.goBack();
    } else {
      await SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          handleBack();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0B0B0D),
          elevation: 0,
          title: const Row(
            children: [
              Icon(
                Icons.bolt,
                color: Color(0xFFFFD000),
                size: 26,
              ),
              SizedBox(width: 8),
              Text(
                'LUCKYBETS',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                  color: Color(0xFFFFD000),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Reload',
              onPressed: reloadWebsite,
              icon: const Icon(
                Icons.refresh,
                color: Color(0xFFFFD000),
              ),
            ),
          ],
        ),

        body: Stack(
          children: [
            WebViewWidget(controller: controller),

            if (isLoading)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  value: progress == 100 ? null : progress / 100,
                  minHeight: 3,
                  backgroundColor: const Color(0xFF25252D),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(
                    Color(0xFFFFD000),
                  ),
                ),
              ),

            if (hasError)
              Container(
                color: const Color(0xFF0B0B0D),
                width: double.infinity,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.wifi_off_rounded,
                          size: 60,
                          color: Color(0xFFFFD000),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Connection unavailable',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Unable to connect to LuckyBets. '
                          'Please check your internet connection.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: reloadWebsite,
                          icon: const Icon(Icons.refresh),
                          label: const Text('TRY AGAIN'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFD000),
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
