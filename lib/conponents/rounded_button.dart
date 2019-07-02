import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String btn_txt;
  final Color btn_clr;
  final Function on_btn_clk;

  RoundedButton(this.btn_txt, this.btn_clr, this.on_btn_clk);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: btn_clr,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: on_btn_clk,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            btn_txt,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
