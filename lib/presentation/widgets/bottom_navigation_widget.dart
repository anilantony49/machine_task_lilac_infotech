import 'package:flutter/material.dart';
import 'package:machine_task_lilac_infotech/presentation/widgets/home_screen_widgets.dart';
 
class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      decoration: const BoxDecoration(
        color: Color(0xFF2C0002),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border(top: BorderSide(color: Color(0x33FFFFFF), width: 2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          BottomNavItem(
            iconPath: "assets/images/home_icon.png",
            label: "Home",
            isActive: true,
          ),
          BottomNavItem(
            iconPath: "assets/images/find_icon.png",
            label: "Find",
            isActive: false,
          ),
          BottomNavItem(
            iconPath: "assets/images/saved_icon.png",
            label: "Saved",
            isActive: false,
          ),
          BottomNavItem(
            iconPath: "assets/images/profile_icon.jpg",
            label: "Profile",
            isActive: false,
            isProfile: true,
          ),
        ],
      ),
    );
  }
}
