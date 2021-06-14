import 'package:factoryapp/presentation/theme.dart';
import 'package:flutter/material.dart';

class FactoryPurpleButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final EdgeInsets padding;
  final double spread;
  const FactoryPurpleButton(
      {Key? key,
      required this.onTap,
      required this.text,
      required this.padding,
      required this.spread})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: FactoryColors.purpleLight,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: FactoryColors.purpleLight,
              spreadRadius: 1.0,
              blurRadius: spread,
            ),
          ],
        ),
        child: ElevatedButton(
          child: Container(
              width: double.infinity,
              height: 50,
              child: Center(child: Text(this.text))),
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            primary: FactoryColors.purpleLight,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
