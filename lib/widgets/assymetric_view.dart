import 'package:flutter/material.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:fruts/widgets/plant_card.dart';

class AssymetricView extends StatelessWidget {
  const AssymetricView({Key key, this.plants}) : super(key: key);

  final List<Plant> plants;

  List<Widget> _buildRows(BuildContext context) {
    if (plants == null || plants.isEmpty) {
      return const <Container>[];
    }

    return List<Widget>.generate(plants.length, (int index) {
      final width = MediaQuery.of(context).size.width;

      final spacing = (width - ((width * 0.35) * 2)) / 3;

      final top = (width * 0.35) * 0.5;

      if (index % 2 == 0) {
        return Container();
      } else {
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: spacing,
          children: <Widget>[
            PlantCard(plant: plants[index]),
            Padding(
              padding: EdgeInsets.only(top: top),
              child: PlantCard(plant: plants[(index - 1)]),
            ),
          ],
        );
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 50.0),
      children: _buildRows(context),
    );
  }
}
