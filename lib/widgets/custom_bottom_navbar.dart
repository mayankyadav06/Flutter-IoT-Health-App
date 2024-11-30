import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iot_health_app/providers/current_screen_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    // Custom bottom navigation bar component
    return GNav(
      textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      color: Colors.red,
      backgroundColor: Colors.grey.shade400,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      rippleColor: Colors.grey.shade400,
      tabBorderRadius: 20.0,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      iconSize: 32,
      gap: 10,
      onTabChange: (value) {
        // Update the current screen index in the provider
        Provider.of<CurrentScreenProvider>(context, listen: false)
            .changeScreen(value);
      },
      tabBackgroundColor: Colors.white30,
      activeColor: Colors.black,
      tabs: const [
        GButton(
          textColor: Colors.black,
          iconColor: Colors.black,
          icon: Icons.table_chart_rounded,
          text: "Home",
        ),
        GButton(
          gap: 3.0,
          textColor: Colors.black,
          iconColor: Colors.black,
          icon: Icons.show_chart,
          text: "Devices",
        ),
      ],
    );
  }
}
