import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/screens/Authentication/WelcomePage.dart';
import 'package:attendance_system_nodejs/screens/Home/HomePageBody.dart';
import 'package:attendance_system_nodejs/screens/Home/NotificationsPage.dart';
import 'package:attendance_system_nodejs/screens/Home/Profile.dart';
import 'package:attendance_system_nodejs/screens/Home/ReportPage.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = SecureStorage();
  String? accessToken;
  String? refreshToken;
  int _bottomNavIndex = 0;
  bool activeFormAttendance = false;

  final List<IconData> _iconList = [
    Icons.home_outlined,
    Icons.mail_outline,
    Icons.notifications_none_outlined,
    Icons.person_2_outlined
  ];

  @override
  void dispose() {
    // controller.dispose(); controller QRCODE
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _loadToken();
  }

  Future<void> _loadToken() async {
    String? loadToken = await storage.readSecureData('accessToken');
    String? refreshToken1 = await storage.readSecureData('refreshToken');
    if (loadToken.isEmpty ||
        refreshToken1.isEmpty ||
        loadToken.contains('No Data Found') ||
        refreshToken1.contains('No Data Found')) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    } else {
      setState(() {
        accessToken = loadToken;
        refreshToken = refreshToken1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppColors.primaryButton,
          foregroundColor: Colors.white,
          elevation: 2,
          onPressed: () {},
          child: const Icon(
            Icons.location_on_outlined,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: _iconList,
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            activeColor: AppColors.primaryButton,
            iconSize: 25,
            backgroundColor: Colors.white,
            onTap: onTapHandler),
        body: _buildBody());
  }

  void onTapHandler(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_bottomNavIndex) {
      case 0:
        return HomePageBody(); // Thay thế bằng trang chính của bạn
      case 1:
        return ReportPage(); // Thay thế bằng trang thư của bạn
      case 2:
        return NotificationsPage(); // Thay thế bằng trang thông báo của bạn
      case 3:
        return ProfilePage(); // Thay thế bằng trang hồ sơ của bạn
      default:
        return HomePageBody(); // Mặc định hiển thị trang chính
    }
  }
}
