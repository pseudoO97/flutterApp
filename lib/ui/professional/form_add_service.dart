import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_colors.dart';
import 'package:hilmy/routes.dart';
import 'package:hilmy/ui/widgets/form/text_input.dart';

class FormAddService extends StatefulWidget {
  const FormAddService({ Key? key }) : super(key: key);

  @override
  State<FormAddService> createState() => _FormAddServiceState();
}

class _FormAddServiceState extends State<FormAddService> {
  static final _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publiez votre service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
           key: _formKey,
          child: Column(
            children: [
              const TextInput(label: 'Votre créneau', isRequired: false, attribute: 'hour'),
              const TextInput(label: 'hehe', isRequired: false, attribute: 'hehe'),
              ElevatedButton(
          child: const Text('Valider'), 
          onPressed: () => {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save(),
            }
          },
        ),
            ],
          )
        ),
      ),
    );
  }
}