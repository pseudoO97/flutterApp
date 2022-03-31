import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/routes.dart';

class BottomAppBarWidget extends StatefulWidget {
  final String type;
  const BottomAppBarWidget({ Key? key, required this.type }) : super(key: key);

  @override
  State<BottomAppBarWidget> createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    var _auth = FirebaseAuth.instance;
    return Container(
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent.shade200
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => {
                  Navigator.of(context).pushNamed(
                    Routes.appointmentHistory,
                    arguments: widget.type,
                  ),
                }, 
                icon: const Icon(Icons.person),
              ),
              IconButton(
                onPressed: () => {
                  Navigator.of(context).pushNamed(
                    Routes.appointmentHistory,
                    arguments: widget.type,                  
                  ),
                }, 
                icon: const Icon(Icons.history),
              ),
              IconButton(
                onPressed: () => {
                  widget.type == 'professionnal_id' ?
                  Navigator.of(context).pushNamed(Routes.servicePage) :
                   Navigator.of(context).pushNamed(Routes.home),
                }, 
                icon: widget.type == 'professionnal_id' ? 
                      const Icon(Icons.table_chart_rounded) :
                      const Icon(Icons.search)
              ),
            ]
          ),
        ),
      );
  }
}