import 'package:factoryapp/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class FactoryFormWidget extends StatelessWidget {
  final String name;
  final String location;
  final String rate;
  final String employes;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedLocation;
  final ValueChanged<String> onChangedEmployes;
  final ValueChanged<String> onChangedrate;
  final VoidCallback onSavedFactor;

  const FactoryFormWidget({
    Key? key,
    this.name = '',
    required this.onChangedName,
    required this.onChangedLocation,
    required this.onSavedFactor,
    this.location = '',
    this.rate = '',
    this.employes = '',
    required this.onChangedEmployes,
    required this.onChangedrate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          SizedBox(height: 12),
          buildDescription(),
          SizedBox(height: 12),
          buildEmployes(),
          SizedBox(height: 12),
          buildRate(),
          SizedBox(height: 32),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    final _borderLight = OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(15));
    return TextFormField(
      style: TextStyle(color: Colors.white),
      maxLines: 1,
      initialValue: name,
      onChanged: onChangedName,
      validator: (name) {
        if (name!.isEmpty) {
          return 'The name cannot be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        labelStyle:
            TextStyle(color: FactoryColors.white, fontWeight: FontWeight.bold),
        filled: true,
        border: _borderLight,
        enabledBorder: _borderLight,
        fillColor: FactoryColors.dark.withOpacity(0.9),
        hintStyle:
            GoogleFonts.poppins(color: FactoryColors.white, fontSize: 10),
        focusedBorder: _borderLight,
        labelText: 'Name Factory',
      ),
    );
  }

  Widget buildDescription() {
    final _borderLight = OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(15));
    return TextFormField(
      style: TextStyle(color: Colors.white),
      maxLines: 1,
      initialValue: location,
      onChanged: onChangedLocation,
      decoration: InputDecoration(
        labelStyle:
            TextStyle(color: FactoryColors.white, fontWeight: FontWeight.bold),
        filled: true,
        border: _borderLight,
        enabledBorder: _borderLight,
        fillColor: FactoryColors.grey.withOpacity(0.8),
        hintStyle:
            GoogleFonts.poppins(color: FactoryColors.white, fontSize: 10),
        focusedBorder: _borderLight,
        labelText: 'Location',
      ),
    );
  }

  Widget buildEmployes() {
    final _borderLight = OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(15));
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLines: 1,
      initialValue: employes.toString(),
      onChanged: onChangedEmployes,
      decoration: InputDecoration(
        labelStyle:
            TextStyle(color: FactoryColors.white, fontWeight: FontWeight.bold),
        filled: true,
        border: _borderLight,
        enabledBorder: _borderLight,
        fillColor: FactoryColors.dark.withOpacity(0.9),
        hintStyle:
            GoogleFonts.poppins(color: FactoryColors.white, fontSize: 10),
        focusedBorder: _borderLight,
        labelText: 'Employes',
      ),
    );
  }

  Widget buildRate() {
    final _borderLight = OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(15));
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLines: 1,
      initialValue: rate,
      onChanged: onChangedrate,
      decoration: InputDecoration(
        labelStyle:
            TextStyle(color: FactoryColors.white, fontWeight: FontWeight.bold),
        filled: true,
        border: _borderLight,
        enabledBorder: _borderLight,
        fillColor: FactoryColors.grey.withOpacity(0.8),
        hintStyle:
            GoogleFonts.poppins(color: FactoryColors.white, fontSize: 10),
        focusedBorder: _borderLight,
        labelText: 'Rate',
      ),
    );
  }

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onSavedFactor,
          child: Text('Save'),
        ),
      );
}
