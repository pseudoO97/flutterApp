import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hilmy/constants/app_styles.dart';
import 'package:hilmy/constants/app_colors.dart';
import 'package:hilmy/services/firestore_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TextInput extends StatelessWidget {
  final bool isRequired;
  final String attribute;
  final String label;
  final dynamic value;
  final int? maxLines;
  final String? hintText;

  const TextInput({
    Key? key,
    required this.label,
    required this.isRequired,
    required this.attribute,
    this.value,
    this.maxLines,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final firestoreDatabase =  Provider.of<FirestoreDatabase>(context, listen: false);
   final _auth = FirebaseAuth.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: darkSubtitleText
        ),
       const SizedBox(
          height: 4,
        ),
       Container(
          height: 40,
          child: TextFormField( // Permet de raffraîchir
            initialValue: value ?? '',
            key: Key(attribute),
            maxLines: maxLines,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                  color: kLightGrey.withOpacity(0.8),
                  width: 1.0,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 8,
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: kLightGrey),
            ),
            style: darkSubtitleText,
            cursorColor: kLightGreen,
            onSaved: (value) {
              firestoreDatabase.updateService(
                attribute: attribute,
                value: value,
                id: _auth.currentUser!.uid
              );
            },
            validator: (value) {
              if (isRequired == true && (value == null || value.isEmpty)) {
                return 'Veuillez remplir ce champ';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
