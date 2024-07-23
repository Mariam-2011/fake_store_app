// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BtnWidget extends StatelessWidget {
  void Function()? fun;
  String btnText;
  BtnWidget({super.key, required this.fun, required this.btnText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fun,
      child: Container(
        margin: EdgeInsets.all(5),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.40,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Text(
          btnText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
