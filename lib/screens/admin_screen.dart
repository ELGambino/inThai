import 'package:flutter/material.dart';
import '../widgets//admin_navbar.dart'; // Import AdminNavBar widget
import 'admin_screens/admin_calendar_screen.dart';
import 'admin_screens/admin_statistic_screen.dart';
import 'admin_screens/admin_clients_screen.dart';
import 'admin_screens/admin_chat_screen.dart';
import 'admin_screens/admin_profile_screen.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: _getBody(_selectedIndex),
      bottomNavigationBar: AdminNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return AdminCalendarScreen(); // Display calendar screen
      case 1:
        return AdminStatisticScreen(); // Display statistics screen
      case 2:
        return AdminClientsScreen(); // Display clients screen
      case 3:
        return AdminChatScreen(); // Display chat screen
      case 4:
        return AdminProfileScreen(); // Display profile screen
      default:
        return Container(); // Default case, can return any widget or null
    }
  }
}
