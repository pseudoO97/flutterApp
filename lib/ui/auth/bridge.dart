import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_colors.dart';
import 'package:hilmy/routes.dart';

class Bridge extends StatelessWidget {
  const Bridge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 150,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/people.png',
                      height: 100,
                      width: 100,
                      color: kViolet,
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      'Êtes-vous : ',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Roboto-Black',
                          color: kViolet),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.professionalRegister)
                      },
                      child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              color: kViolet),
                          child: const Center(
                            child: Text('Professionnel',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Roboto-Black')),
                          ),
                          width: 160),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.individualRegister)
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: kViolet),
                        child: const Center(
                          child: Text('Particulier',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'Roboto-Black')),
                        ),
                        width: 160,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
