import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_colors.dart';
import 'package:hilmy/routes.dart';

class Bridge extends StatelessWidget {
  const Bridge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
          //trigger leaving and use own data
          Navigator.of(context).popAndPushNamed(Routes.login);
          return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: kLightBlue,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/people.png', height: 140, width: 140),
                      const Text('Êtes-vous : '),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () => {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.professionalRegister)
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              color: kViolet),
                          child: const Text('Professionnel',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'Roboto-Black')),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.individualRegister)
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              color: kViolet),
                          child: const Text('Particulier',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ]
        ),
      
      ),
    );
  }
}
