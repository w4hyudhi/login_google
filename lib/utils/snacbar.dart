import 'package:flutter/material.dart';

void openSnacbar(_scaffoldkey, snacMessage) {
  _scaffoldkey.currentState.showSnackBar(
    SnackBar(
      content: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        child: Text(
          snacMessage,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.blueAccent,
        onPressed: () {},
      ),
    ),
  );
}
