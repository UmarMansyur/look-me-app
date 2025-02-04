import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_me/components/indicators.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final List<String> imagePath = [
    'assets/images/home_screen/1.svg',
    'assets/images/home_screen/2.svg',
    'assets/images/home_screen/3.svg',
  ];
  // object untuk title and subtitle
  final List<Map<String, String>> title = [
    {
      'title': 'Smart Attendace',
      'subtitle': 'with Face Technology',
      'desc':
          'Make the LookMe application easier to record attendance accurately and securely.'
    },
    {
      'title': 'Seamless Face',
      'subtitle': 'Recognition',
      'desc':
          'With LookMe, attendance is just a glance away. Use advanced face recognition for effortless presence.'
    },
    {
      'title': 'Efficiency Meets',
      'subtitle': 'Innovation',
      'desc':
          'LookMe simplifies attendance, saving time and ensuring accuracy with quick, reliable records.'
    }
  ];

  int currentIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // heightnya 30% dari height
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: imagePath.length,
                    itemBuilder: (context, index) {
                      return SvgPicture.asset(
                        imagePath[index],
                        width: MediaQuery.of(context).size.width,
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  if (i == currentIndex)
                    Indicator(
                      color: const Color(0xFF2CD097),
                      width: 35,
                      onTap: () {
                        _pageController.animateToPage(
                          i,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                    )
                  else
                    Indicator(
                      color: const Color(0xFFE0DFDF),
                      onTap: () {
                        _pageController.animateToPage(
                          i,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
              ],
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${title[currentIndex]['title'] ?? ''}\n',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF0B3D41),
                    ),
                  ),
                  //
                  TextSpan(
                    text: title[currentIndex]['subtitle'] ?? '',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B3D41),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(title[currentIndex]['desc'] ?? '',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentIndex == imagePath.length - 1) {
                      // Navigasi ke halaman berikutnya
                      Navigator.pushNamed(context, '/login');
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  // width button berikan padding 20
                  child: Container(
                    // berikan drop shadow
                    // minimal width 100
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2CD097),
                      borderRadius: BorderRadius.circular(50),
                      // minimal width 100
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: const Color(0xFF2CD097).withOpacity(0.5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                      child: Center(
                        child: Text(
                          currentIndex == 0 ? 'Mulai' : 'Selanjutnya',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
