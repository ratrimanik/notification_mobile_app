import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pd_app/ui/screen/login_screen.dart';
import 'package:pd_app/ui/theme/theme.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 19),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 120.0),
        child: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          scrollPhysics: const BouncingScrollPhysics(),
          pages: [
            PageViewModel(
              title: "Jadwalkan Kegiatan Sekarang",
              body: "Atur kegiatan anda dengan mudah dan cepat.",
              image: Image.asset(
                "images/screen1.jpg",
                height: 400,
                width: 400,
              ),
            ),
            PageViewModel(
              title: "Kategorikan Kegiatan",
              body:
              "Kelompokkan kegiatan anda untuk manajemen waktu yang lebih baik.",
              image: Image.asset(
                "images/screen2.jpg",
                height: 400,
                width: 400,
              ),
            ),
            PageViewModel(
              title: "Maksimalkan Produktivitas",
              body:
              "Tuntaskan produktivitas anda dengan maksimal dan capai tujuan anda.",
              image: Image.asset(
                "images/screen3.jpg",
                height: 400,
                width: 400,
              ),
            ),
          ],
          onDone: () {},
          onSkip: () {},
          showSkipButton: true,
          done: GestureDetector(
            child: const Text(
              "Mulai",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: primaryClr,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          next: const Text(
            "Lanjut",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: primaryClr,
            ),
          ),
          skip: GestureDetector(
            child: const Text(
              "Lewati",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            color: Colors.black26,
            activeColor: primaryClr,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }
}
