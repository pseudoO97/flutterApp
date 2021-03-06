import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_colors.dart';
import 'package:hilmy/routes.dart';
import 'package:hilmy/services/firestore_database.dart';
import 'package:hilmy/ui/professional/professional_home.dart';
import 'package:hilmy/ui/widgets/form/text_input.dart';
import 'package:provider/provider.dart';

class FormAddService extends StatefulWidget {
  const FormAddService({ Key? key }) : super(key: key);

  @override
  State<FormAddService> createState() => _FormAddServiceState();
}

class _FormAddServiceState extends State<FormAddService> {
  static final _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

   final firestoreDatabase =  Provider.of<FirestoreDatabase>(context, listen: false);
   var args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publiez votre service'),
      ),
      body: WillPopScope(
        onWillPop: () {
           Navigator.of(context).popAndPushNamed(Routes.home);
          return Future.value(false);
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
             key: _formKey,
            child: Column(
              children: [
                const TextInput(label: 'Votre créneau', isRequired: true, attribute: 'hour'),
                const TextInput(label: 'Prix', isRequired: true, attribute: 'price'),
                ElevatedButton(
                  child: const Text('Publiez'), 
                  onPressed: () => {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save(),
                      firestoreDatabase.updateService(attribute: 'online', value: true, id: FirebaseAuth.instance.currentUser!.uid)
                    }
                  },
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}