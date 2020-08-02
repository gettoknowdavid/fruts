import 'package:flutter/material.dart';
import 'package:fruts/src/data/enum_helper.dart';
import 'package:fruts/src/models/category.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:fruts/widgets/app_background.dart';
import 'package:fruts/widgets/custom_app_bar.dart';
import 'package:fruts/widgets/custom_back_button.dart';
import 'package:intl/intl.dart';

class _PlantCost extends StatelessWidget {
  const _PlantCost({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final NumberFormat formatter = NumberFormat.simpleCurrency(
      decimalDigits: 2,
      locale: Localizations.localeOf(context).toString(),
    );
    return Row(
      children: <Widget>[
        Text(
          formatter.format(plant.price),
          style: textTheme.headline6.copyWith(
            fontWeight: FontWeight.w500,
            color: colorScheme.secondaryVariant,
          ),
        ),
        Text(
          ' per kilo',
          style: textTheme.subtitle1.copyWith(
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurface.withOpacity(0.5),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key key, @required this.plant}) : super(key: key);

  final Plant plant;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final topChildHeight = height * 0.8;
    final imageHeight = topChildHeight * 0.45;

    final category = enumFormatter(widget.plant.category);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: AppBackground(
        topChildHeight: topChildHeight,
        topChild: Scaffold(
          appBar: FrutsAppBar(
            title: '',
            leading: FrutsBackButton(),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Container(
                  height: imageHeight,
                  width: width,
                  // color: Colors.pink,
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.asset(widget.plant.image),
                  ),
                ),
                Spacer(),
                Text(
                  widget.plant.name,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: textTheme.headline4.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.plant.genus,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: textTheme.subtitle1.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
                Text(
                  category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: textTheme.caption.copyWith(
                    color: Colors.black26,
                  ),
                ),
                SizedBox(height: 16),
                _PlantCost(plant: widget.plant),
              ],
            ),
          ),
        ),
        bottomChild: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              NutritionWidget(
                height: height,
                plant: widget.plant,
              ),
              MaterialButton(
                elevation: 0.0,
                onPressed: () {},
                minWidth: width,
                height: 60,
                color: colorScheme.secondaryVariant,
                child: Text(
                  'Add to cart',
                  style: textTheme.button.copyWith(
                    fontSize: 20,
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NutritionWidget extends StatelessWidget {
  const NutritionWidget({
    Key key,
    @required this.plant,
    @required this.height,
  }) : super(key: key);

  final Plant plant;
  final double height;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final width = MediaQuery.of(context).size.width;

    // print(plant.nutritions.map((e) => e.values).toList());
    final nutrients = plant.nutritions.map((e) => e.keys).toList();
    final values = plant.nutritions.map((e) => e).toList();
    final v = values.map((e) => e.values).toList();
    print(v);

    nutrientsList() {
      final _nutrients = [];
      for (int i = 0; i > nutrients.length; i++) {
        print(nutrients[i].first);
        _nutrients.add(
          Column(
            children: <Widget>[
              // Text(nutrients[o])
            ],
          ),
        );
      }
      return _nutrients;
    }

    return Container(
      color: Colors.pink,
      height: height * 0.2,
      child: Column(
        children: <Widget>[
          Text('Protein', style: textTheme.headline6),
          Container(
            height: 30,
          ),
        ],
      ),
    );
  }
}
