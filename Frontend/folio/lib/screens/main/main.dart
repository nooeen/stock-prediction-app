import 'package:flutter/material.dart';
import 'package:folio/screens/main/picksscreen.dart';
import 'package:folio/screens/main/portfolioscreen.dart';
import 'package:folio/screens/main/searchscreen.dart';
import 'package:folio/screens/main/homescreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentIndex = 0;

  final List<Widget> _children = [
    const HomeScreen(),
    const PortfolioScreen(),
    const SearchStock(),
    const PicksScreen()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          selectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xffFFCF00),
            fontFamily: "Trueno",
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xffFFCF00).withOpacity(0.5),
            fontFamily: "Trueno",
          ),
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFFF3AF00),
          unselectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: SizedBox(width: 27, child: Icon(Icons.home_rounded)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(width: 27, child: Icon(Icons.wallet_rounded)),
              label: 'Portfolio',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(width: 27, child: Icon(Icons.search)),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(width: 27, child: Icon(Icons.pages_rounded)),
              label: 'Picks',
            ),
          ],
        ),
      ),
    );
  }
}
