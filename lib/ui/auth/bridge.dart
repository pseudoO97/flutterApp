import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_colors.dart';
import 'package:hilmy/routes.dart';

class Bridge extends StatelessWidget {
  const Bridge({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
          //trigger leaving and use own data
          Navigator.of(context).popAndPushNamed(Routes.login);
          return Future.value(false);
      },
      child: Scaffold( 
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Image.asset('images/people.png', height: 70, width: 70),
                      const Text('Êtes-vous : '),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () => { 
                          Navigator.of(context).pushReplacementNamed(Routes.professionalRegister)
                          },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: kBlue
                          ),
                          child: const Text('Professionnel'),
                        ),
                      ),
                      const SizedBox(width: 18,),
                      GestureDetector(
                        onTap: () => {
                           Navigator.of(context).pushReplacementNamed(Routes.individualRegister)
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                           decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: kBlue
                          ),
                          child: const Text('Particulier'),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}