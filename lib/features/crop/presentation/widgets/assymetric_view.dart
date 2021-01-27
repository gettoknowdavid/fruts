import 'package:flutter/material.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';
import 'package:fruts/features/crop/presentation/widgets/crop_card.dart';

class AssymetricView extends StatelessWidget {
  const AssymetricView({Key key, this.crops}) : super(key: key);

  final List<Crop> crops;

  List<Widget> _buildRows(BuildContext context) {
    if (crops == null || crops.isEmpty) {
      return const <Container>[];
    }

    return List<Widget>.generate(crops.length, (int index) {
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
            CropCard(crop: crops[index]),
            Padding(
              padding: EdgeInsets.only(top: top),
              child: CropCard(crop: crops[(index - 1)]),
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
