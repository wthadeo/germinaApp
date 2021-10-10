import 'package:flutter/material.dart';

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: const Color.fromRGBO(66, 174, 181, 95),
  primary: const Color.fromRGBO(228, 241, 241, 8),
  minimumSize: const Size(88, 100),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);