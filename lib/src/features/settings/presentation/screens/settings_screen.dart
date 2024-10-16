import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          // Profile Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Replace with actual profile image
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "John Doe",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "+998 90 123 45 67",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    TextButton(
                      onPressed: () {
                        // Edit profile action
                      },
                      child: const Text("Edit Profile"),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(),

          // Settings options
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications and Sounds"),
            onTap: () {
              // Open notifications settings
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text("Privacy and Security"),
            onTap: () {
              // Open privacy settings
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text("Chat Settings"),
            onTap: () {
              // Open chat settings
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.devices),
            title: const Text("Devices"),
            onTap: () {
              // Open devices settings
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.data_usage),
            title: const Text("Data and Storage"),
            onTap: () {
              // Open data and storage settings
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            onTap: () {
              // Open language settings
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("Help"),
            onTap: () {
              // Open help and support
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            onTap: () {
              // Open about section
            },
          ),
          const Divider(),
          // Logout button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(double.infinity, 40),
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // Log out action
              },
              child: Text(
                "Log Out",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.instance.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
