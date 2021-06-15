import 'package:factoryapp/domain/model/factory_model.dart';
import 'package:factoryapp/presentation/home/item_factory.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FactoryDetail extends StatelessWidget {
  final Factory factorySelected;
  final String textButton;
  const FactoryDetail(
      {Key? key, required this.factorySelected, required this.textButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
          style: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ItemFactory(
        textButton: textButton,
        factory: factorySelected,
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
