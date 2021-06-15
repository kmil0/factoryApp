import 'package:factoryapp/domain/model/factory_model.dart';
import 'package:factoryapp/presentation/theme.dart';
import 'package:factoryapp/presentation/widgets/factory_button.dart';
import 'package:flutter/material.dart';

class ItemFactory extends StatelessWidget {
  final Factory factory;
  final VoidCallback onTap;
  final String textButton;
  const ItemFactory(
      {Key? key,
      required this.factory,
      required this.onTap,
      required this.textButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: FactoryColors.white,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  factory.rate.toString(),
                  style: TextStyle(color: FactoryColors.purple),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
                  child: Icon(
                    factory.rate > 4
                        ? Icons.star_rounded
                        : Icons.star_half_rounded,
                    color: factory.rate > 4
                        ? FactoryColors.yellow
                        : FactoryColors.purpleLight,
                  ),
                )
              ],
            ),
            Expanded(
                child: CircleAvatar(
                    backgroundColor: FactoryColors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ))),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(factory.name),
                  const SizedBox(height: 3),
                  Text(
                    factory.location,
                    style: TextStyle(color: FactoryColors.purple),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text('Employess: ${factory.employees.toInt()}'),
                ],
              ),
            ),
            FactoryPurpleButton(
              text: textButton,
              onTap: onTap,
              padding: const EdgeInsets.symmetric(vertical: 4),
              spread: 5,
            )
          ],
        ),
      ),
    );
  }
}
