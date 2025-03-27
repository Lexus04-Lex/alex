import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:good/screens/cart.dart';
import 'package:good/screens/favorite.dart';
import 'package:good/screens/home.dart';
import 'package:good/screens/profile.dart';

class Navbar extends StatefulWidget {
   const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
   late List<Widget> _pages= [
     HomeScreen(),
     Favorite(),
     Cart(),
     Profile()
   ];

   void iniState(){
     super.initState();
     _pages = [];
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
          items:
          [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.home),
              Text('Home')
            ],),
          ]
      ),
    );
  }
}
