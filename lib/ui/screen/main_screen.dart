import 'package:flutter/material.dart';
import 'package:mirc_chat/ui/screen/channel/channels_screen.dart';
import 'package:mirc_chat/ui/screen/direct_messages/direct_messages_screen.dart';
import 'package:mirc_chat/ui/screen/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          ChannelsScreen(),
          DirectMessagesScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Channels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Direct Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
