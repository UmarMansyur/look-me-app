import 'package:flutter/material.dart';

class Step2 extends StatelessWidget {
  const Step2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.asset('assets/images/home_screen/2.png'),
              ),
              const SizedBox(height: 10),
              const Text('Seamless Face',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',),),
              const Text('Recognition',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',)),
              const SizedBox(height: 20),
              const Text(
                'With LookMe, attendance is just a glance away. Use advanced face recognition for effortless check-ins',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF0B3D41),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
