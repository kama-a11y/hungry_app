import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/core/utils/pref_helper.dart';
import 'package:hungryapp/feature/auth/view/login_view.dart';
import 'package:hungryapp/feature/root.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _logoSlide;
  late Animation<Offset> _imageSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _logoSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _imageSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    /// بعد الأنيميشن نعمل check auth
    Future.delayed(
      const Duration(seconds: 2),
      checkAuth,
    );
  }

  /// ================= AUTH LOGIC =================

  Future<void> checkAuth() async {
    final token = await PrefHelper.getToken();

    if (!mounted) return;

    if (token == null) {
      goToLogin();
    } else {
      goToHome();
    }
  }


  /// ================= NAVIGATION =================

  void goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
    );
  }

  void goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Root()),
    );
  }

  /// ================= UI =================

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          children: [
            const Gap(300),

            /// LOGO
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _logoSlide,
                child: SvgPicture.asset(
                  'assets/logo/Hungry_.svg',
                ),
              ),
            ),

            const Spacer(),

            /// IMAGE
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _imageSlide,
                child: Image.asset(
                  'assets/splash/image 1.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
