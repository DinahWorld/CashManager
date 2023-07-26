// ignore: file_names
import 'package:flutter/material.dart';

import 'package:client/screens/Home.dart';
import 'package:client/screens/Cart.dart';
import 'package:client/screens/History.dart';
import 'package:client/screens/Profile.dart';
import 'package:client/screens/Scan.dart';

class Navigation extends StatefulWidget {
  int? index;
  Navigation({super.key, this.index});

  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int _selectedIndex = 1;
  List<Widget> pageList = [
    const ProfileScreen(),
    const HomeScreen(),
    const BarcodeScanner(),
    const CartScreen(),
    const HistoryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index ?? 1;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pageList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner,
            ),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
            ),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 191, 146, 218),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
