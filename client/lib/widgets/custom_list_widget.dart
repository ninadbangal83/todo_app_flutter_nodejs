import 'package:flutter/material.dart';

import '../screens/change_password_screen.dart';
import '../screens/edit_user_screen.dart';

Widget buildListTile(String title, IconData icon, Function()? onTap) {
  return ListTile(
    title: Text(title),
    trailing: Icon(icon),
    onTap: onTap,
  );
}

Widget customDivider() {
  return Container(
    height: 1,
    color: Colors.grey[400], // Set the color of the divider
    margin: const EdgeInsets.symmetric(horizontal: 16),
  );
}

class CustomListWidget extends StatelessWidget {
  final BuildContext currentContext;
  final VoidCallback logoutAction;
  final VoidCallback deleteAccountAction;

  const CustomListWidget({
    super.key,
    required this.currentContext,
    required this.logoutAction,
    required this.deleteAccountAction,
  });

  Widget buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: onTap,
    );
  }

  Widget customDivider() {
    return const Divider(
      thickness: 1.5,
      height: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        buildListTile('Update Profile', Icons.edit, () {
          Navigator.push(
            currentContext,
            MaterialPageRoute(builder: (context) => const EditUserScreen()),
          );
        }),
        customDivider(),
        buildListTile('Change Password', Icons.lock, () {
          Navigator.push(
            currentContext,
            MaterialPageRoute(
                builder: (context) => const ChangePasswordScreen()),
          );
        }),
        customDivider(),
        buildListTile('Logout', Icons.logout, () {
          logoutAction();
        }),
        customDivider(),
        buildListTile('Delete Account', Icons.delete, () {
          deleteAccountAction();
        }),
        customDivider(),
      ],
    );
  }
}
