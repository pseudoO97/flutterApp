import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_styles.dart';
import 'package:hilmy/services/firestore_database.dart';
import 'package:provider/provider.dart';

class DropdownInput extends StatelessWidget {
  final String label;
  final String hintText;
  final String initialValue;
  final List<Map<String, String>> items;
  final String attribute;
  final bool isRequired;
  final bool isBooleanValue;

  const DropdownInput({
    Key? key,
    required this.label,
    required this.items,
    required this.attribute,
    this.hintText = '',
    this.isRequired = false,
    this.initialValue = '',
    this.isBooleanValue = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          child: DropdownButtonFormField<String?>(
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 8,
              ),
            ),
            items: items.map((Map<String, String> item) {
              String? label = item['label'];
              return DropdownMenuItem<String?>(
                value: item['value'],
                child: Text(label ?? '', style: darkSubtitleText,),
              );
            }).toList(),
            value: items.indexWhere(
                        (element) => element['value'] == initialValue) >
                    -1
                ? initialValue
                : items.first['value'],
            onChanged: (value) {
              // if (isBooleanValue && value != null && value.isNotEmpty) {
              //   // firestoreDatabase.updateFieldForm(
              //   //   interventionId: interventionId,
              //   //   uid: equipmentId,
              //   //   attribute: attribute,
              //   //   value: value,
              //   // );
                
              // } else {
                // firestoreDatabase.updateFieldForm(
                //   interventionId: interventionId,
                //   uid: equipmentId,
                //   attribute: attribute,
                //   value: value,
                // );
              // }
            },
            onSaved: (value) {
              // if (isBooleanValue && value != null && value.isNotEmpty) {
              //   equipmentRef.update({attribute: value == '1' ? true : false});
              // } else {
              //   equipmentRef.update({attribute: value});
              // }
              // if (isBooleanValue && value != null && value.isNotEmpty) {
              //   firestoreDatabase.updateFieldForm(
              //     interventionId: interventionId,
              //     uid: equipmentId,
              //     attribute: attribute,
              //     value: value,
              //   );
              // } else {
              //   firestoreDatabase.updateFieldForm(
              //     interventionId: interventionId,
              //     uid: equipmentId,
              //     attribute: attribute,
              //     value: value,
              //   );
              // }
            },
            validator: (value) {
              if (isRequired == true && (value == null || value.isEmpty)) {
                return 'Veuillez remplir ce champ';
              }
              return null;
            },
          ),
        )
      ],
    );
  }
}
