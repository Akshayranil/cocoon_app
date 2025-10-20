  import 'package:flutter/material.dart';

Widget buildTextField({
    required String hintText,
    required String labelText,
  }) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }