// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFormWidget extends StatefulWidget {
  String? Function(String?)? validate;
  String textHint;
  bool hidePassword = true;
  TextEditingController? controller;
  Widget? prefix;
  bool isPass;
  TextFormWidget(
      {super.key,
      this.prefix,
      this.validate,
      required this.textHint,
      this.isPass = false,
      this.controller}) {
    validate ??= (value) {
      if (value == null || value!.isEmpty) {
        return ("this feild can't be empty");
      } else {
        return null;
      }
    };
  }

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: TextFormField(
          validator: widget.validate,
          obscureText: widget.isPass && widget.hidePassword,
          controller: widget.controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: widget.prefix,
            suffixIconColor: Colors.blue,
            suffixIcon: widget.isPass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        if (widget.hidePassword) {
                          widget.hidePassword = false;
                        } else {
                          widget.hidePassword = true;
                        }
                      });
                    },
                    icon: widget.hidePassword
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off))
                : null,
            hintText: widget.textHint,
            hintStyle: TextStyle(color: Colors.black),
          ),
        ));
  }
}
