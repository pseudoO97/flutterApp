import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_colors.dart';
import 'package:hilmy/providers/auth_provider.dart';
import 'package:hilmy/routes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlue,
        title: IconButton(
          icon: Icon(Icons.logout), 
          onPressed: (() => {
              authProvider.signOut(),
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.login, ModalRoute.withName(Routes.login))
            } 
          )
        ),
      ),
      body: Column(
        children: [
          Center(
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: const Text('Lol'),
            )
          ),
        ],
      )
    );
  }
}