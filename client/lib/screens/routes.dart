import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  late AppRouterDelegate _routerDelegate;
  late AppRouteInformationParser _routeInformationParser;

  @override
  void initState() {
    super.initState();
    _routerDelegate = AppRouterDelegate();
    _routeInformationParser = AppRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Example App',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.uri?.toString() ?? '/');
    if (uri.pathSegments.isEmpty) {
      return AppRoutePath.home();
    } else if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'about') {
        return AppRoutePath.about();
      } else if (uri.pathSegments[0] == 'contact') {
        return AppRoutePath.contact();
      }
    }
    return AppRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoutePath configuration) {
    if (configuration.isUnknown) {
      return RouteInformation(uri: Uri.parse('/404'));
    } else if (configuration.isHome) {
      return RouteInformation(uri: Uri.parse('/'));
    } else if (configuration.isAbout) {
      return RouteInformation(uri: Uri.parse('/about'));
    } else if (configuration.isContact) {
      return RouteInformation(uri: Uri.parse('/contact'));
    }
    return null;
  }
}

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  String? _selectedPage;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  AppRoutePath get currentConfiguration {
    if (_selectedPage == null) {
      return AppRoutePath.home();
    } else if (_selectedPage == 'about') {
      return AppRoutePath.about();
    } else if (_selectedPage == 'contact') {
      return AppRoutePath.contact();
    }
    return AppRoutePath.unknown();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: const ValueKey('HomePage'),
          child: HomePage(
            onTapHome: () => _handleNavigate(''),
            onTapAbout: () => _handleNavigate('about'),
            onTapContact: () => _handleNavigate('contact'),
            isActive: _selectedPage == '',
          ),
        ),
        if (_selectedPage == 'about')
          MaterialPage(
            key: const ValueKey('AboutPage'),
            child: AboutPage(
              onTapHome: () => _handleNavigate(''),
              onTapAbout: () => _handleNavigate('about'),
              onTapContact: () => _handleNavigate('contact'),
              isActive: true,
            ),
          ),
        if (_selectedPage == 'contact')
          MaterialPage(
            key: const ValueKey('ContactPage'),
            child: ContactPage(
              onTapHome: () => _handleNavigate(''),
              onTapAbout: () => _handleNavigate('about'),
              onTapContact: () => _handleNavigate('contact'),
              isActive: true,
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _selectedPage = null;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    if (configuration.isUnknown) {
      _selectedPage = null;
      return;
    } else if (configuration.isHome) {
      _selectedPage = '';
    } else if (configuration.isAbout) {
      _selectedPage = 'about';
    } else if (configuration.isContact) {
      _selectedPage = 'contact';
    }
  }

  void _handleNavigate(String page) {
    if (_selectedPage != page) {
      navigatorKey.currentState?.popUntil((route) {
        return false; // Always return false to iterate over all routes
      });
    }

    _selectedPage = page;
    notifyListeners();
  }
}

class AppRoutePath {
  static const String homePath = '/';
  static const String aboutPath = '/about';
  static const String contactPath = '/contact';
  static const String unknownPath = '/404';

  final String path;

  AppRoutePath.home() : path = homePath;

  AppRoutePath.about() : path = aboutPath;

  AppRoutePath.contact() : path = contactPath;

  AppRoutePath.unknown() : path = unknownPath;

  bool get isHome => path == homePath;

  bool get isAbout => path == aboutPath;

  bool get isContact => path == contactPath;

  bool get isUnknown => path == unknownPath;
}

class HomePage extends StatelessWidget {
  final VoidCallback onTapHome;
  final VoidCallback onTapAbout;
  final VoidCallback onTapContact;
  final bool isActive;

  const HomePage({
    required this.onTapAbout,
    required this.onTapContact,
    required this.onTapHome,
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        leading: MediaQuery.of(context).size.width > 600
            ? null
            : Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
        title: Row(
          children: [
            MediaQuery.of(context).size.width > 600
                ? Row(
                    children: [
                      GestureDetector(
                        onTap: onTapHome,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isActive ? Colors.grey : Colors.white,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onTapAbout,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'About',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onTapContact,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Contact',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            const Expanded(
              child: Center(
                child: Text(
                  'Home Page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
      drawer: MediaQuery.of(context).size.width > 600
          ? null
          : Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text('Menu'),
                  ),
                  ListTile(
                    title: const Text('Home'),
                    onTap: onTapHome,
                    tileColor:
                        isActive ? Colors.blueGrey.shade100 : Colors.white,
                  ),
                  ListTile(
                    title: const Text('About'),
                    onTap: onTapAbout,
                  ),
                  ListTile(
                    title: const Text('Contact'),
                    onTap: onTapContact,
                  ),
                ],
              ),
            ),
    );
  }
}

class AboutPage extends StatelessWidget {
  final VoidCallback onTapHome;
  final VoidCallback onTapAbout;
  final VoidCallback onTapContact;
  final bool isActive;

  const AboutPage({
    required this.onTapAbout,
    required this.onTapContact,
    required this.onTapHome,
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          leading: MediaQuery.of(context).size.width > 600
              ? null
              : Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
          title: Row(
            children: [
              MediaQuery.of(context).size.width > 600
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: onTapHome,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Home',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onTapAbout,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'About',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isActive ? Colors.grey : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onTapContact,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Contact',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Expanded(
                child: Center(
                  child: Text(
                    'About Page',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Text('About Page'),
        ),
        drawer: MediaQuery.of(context).size.width > 600
            ? null
            : Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Text('Menu'),
                    ),
                    ListTile(
                      title: Text('Home'),
                      onTap: onTapHome,
                    ),
                    ListTile(
                      title: Text('About'),
                      onTap: onTapAbout,
                      tileColor:
                          isActive ? Colors.blueGrey.shade100 : Colors.white,
                    ),
                    ListTile(
                      title: Text('Contact'),
                      onTap: onTapContact,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  final VoidCallback onTapHome;
  final VoidCallback onTapAbout;
  final VoidCallback onTapContact;
  final bool isActive;

  const ContactPage({
    required this.onTapAbout,
    required this.onTapContact,
    required this.onTapHome,
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          leading: MediaQuery.of(context).size.width > 600
              ? null
              : Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
          title: Row(
            children: [
              MediaQuery.of(context).size.width > 600
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: onTapHome,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Home',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onTapAbout,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'About',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onTapContact,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Contact',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isActive ? Colors.grey : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Expanded(
                child: Center(
                  child: Text(
                    'Contact Page',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Text('Contact Page'),
        ),
        drawer: MediaQuery.of(context).size.width > 600
            ? null
            : Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Text('Menu'),
                    ),
                    ListTile(
                      title: Text('Home'),
                      onTap: onTapHome,
                    ),
                    ListTile(
                      title: Text('About'),
                      onTap: onTapAbout,
                    ),
                    ListTile(
                      title: Text('Contact'),
                      onTap: onTapContact,
                      tileColor:
                          isActive ? Colors.blueGrey.shade100 : Colors.white,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
