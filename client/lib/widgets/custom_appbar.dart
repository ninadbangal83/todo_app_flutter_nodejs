import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter_nodejs/screens/about_screen.dart';
import 'package:todo_app_flutter_nodejs/screens/contact_screen.dart';
import 'package:todo_app_flutter_nodejs/screens/home_screen.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '../services/user_services/user_get_service.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isTokenAvailable = false; // Flag to track token availability
  BuildContext? _context;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This callback will be called after the widget is built
      _context = context;
      checkAccessToken(_context);
      // Now you can use _context here
    });
    // Check access token when the widget is initialized
  }

  // Function to check access token availability
  Future<void> checkAccessToken(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    if (!context.mounted) return; // Check if widget is still mounted

    setState(() {
      isTokenAvailable = accessToken != null;
    });

    if (isTokenAvailable) {
      if (!context.mounted) return;
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final Map<String, dynamic>? userData =
          (await getUser(accessToken!)) as Map<String, dynamic>?;

      if (!context.mounted) return;

      if (userData != null) {
        String name = userData['user']['name'];
        String email = userData['user']['email'];
        final user = User(
          username: name, // Explicitly cast 'name' to String
          email: email, // Explicitly cast 'email' to String
        );

        userProvider.setUser(user);
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.blue,
      leading: PopupMenuButton(
        icon: const Icon(
          Icons.menu,
          size: 35,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text(
                'About',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(Icons.contact_phone),
              title: const Text('Contact', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactScreen()),
                );
              },
            ),
          ),
        ],
      ),
      actions: [
        if (isTokenAvailable)
          IconButton(
            icon: const Icon(Icons.account_circle),
            iconSize: 35,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
