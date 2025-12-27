import 'package:flutter/material.dart';
import 'package:referral_app/styles.dart';

class InputHelper extends StatelessWidget {
  const InputHelper({
    required this.name,
    required this.controller,
    this.type = TextInputType.text,
    this.hintText,
    this.validator,
    this.editable = true,
    super.key,
  });
  final String name;
  final TextEditingController controller;
  final TextInputType type;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUnfocus,
        enabled: editable,
        readOnly: !editable,
        controller: controller,
        keyboardType: type,
        validator: validator,
        decoration: InputDecoration(
          focusColor: MyColors.blue,
          hintText: hintText,
          label: Text(name, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
