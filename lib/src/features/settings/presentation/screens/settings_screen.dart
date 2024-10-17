import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isScaleEnabled = true; 
  double interfaceScale = 100; 

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.instance.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Settings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.qr_code_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/jamol.png'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Jamol Bro",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "+998 94 222 29 75",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "@JamolBro",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 12),
              buildSettingsOption(Icons.account_circle, "My Account", context,),
              buildSettingsOption(
                  Icons.notifications, "Notifications and Sounds", context),
              buildSettingsOption(
                  Icons.privacy_tip, "Privacy and Security", context),
              buildSettingsOption(Icons.chat, "Chat Settings", context),
              buildSettingsOption(Icons.folder, "Folders", context),
              buildSettingsOption(Icons.settings, "Advanced", context),
              buildSettingsOption(
                  Icons.speaker, "Speakers and Camera", context),
              buildSettingsOption(Icons.battery_charging_full,
                  "Battery and Animations", context),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text("Language"),
                trailing: const Text(
                  "English",
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {},
              ),
              const Divider(thickness: 12),

              
              SwitchListTile(
                title: const Text("Default interface scale"),
                value: isScaleEnabled,
                activeColor: Colors.blue,
          
                onChanged: (value) {
                  setState(() {
                    isScaleEnabled = value; 
                  });
                },
                secondary: const Icon(Icons.remove_red_eye),
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  SizedBox(
                    width: 340,
                    child: Slider(
                      value: interfaceScale,
                      min: 50, 
                      max: 300, 
                      divisions: 25, 
                      activeColor: Colors.blue,
                      onChanged: isScaleEnabled
                          ? (double newValue) {
                              setState(() {
                                interfaceScale = newValue; 
                              });
                            }
                          : null, 
                    ),
                  ),
                   Text(
                    '${interfaceScale.round()}%',
                    style: TextStyle(color: isScaleEnabled ? AppColors.instance.blue : Colors.grey),
                  ),
                ],
              ),
              
              const Divider(thickness: 12),
              
              ListTile(
                leading: const Icon(Icons.star, color: Colors.purple),
                title: const Text("Telegram Premium"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.star, color: Colors.yellow),
                title: const Text("My Stars"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.home),
                title: const Text("Telegram Business"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.gift_fill),
                title: const Text("Send a Gift"),
                onTap: () {},
              ),
              const Divider(thickness: 12),
              ListTile(
                leading: const Icon(CupertinoIcons.question_circle),
                title: const Text("Telegram Faq"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.text_badge_checkmark),
                title: const Text("Telegram Features"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.question_mark),
                title: const Text("Ask a Question"),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSettingsOption(
      IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {},
    );
  }
}
