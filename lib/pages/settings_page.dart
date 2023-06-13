import 'package:flutter/material.dart';
import '../utils/color_util.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Purple,
        backgroundColor: Colors.transparent,
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(
                color: Purple,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(
                Icons.language,
                color: Purple,
              ),
              title: Text('Language'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Purple,
              ),
              onTap: () {
                // Handle language settings
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.color_lens,
                color: Purple,
              ),
              title: Text('Theme'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Purple,
              ),
              onTap: () {
                // Handle theme settings
              },
            ),
            SizedBox(height: 24.0),
            Text(
              'Account Settings',
              style: TextStyle(
                color: Purple,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Purple,
              ),
              title: Text('Profile'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Purple,
              ),
              onTap: () {
                // Handle profile settings
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.lock,
                color: Purple,
              ),
              title: Text('Change Password'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Purple,
              ),
              onTap: () {
                // Handle change password settings
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.delete,
                color: Purple,
              ),
              title: Text('Delete Account'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Purple,
              ),
              onTap: () {
                // Handle account deletion
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Example usage in your app:
