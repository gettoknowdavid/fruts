import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/src/blocs/cart/cart_bloc.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:intl/intl.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({Key key, this.plant}) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      decimalDigits: 2,
      locale: Localizations.localeOf(context).toString(),
    );

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final containerHeight = height * 0.32;
    final containerWidth = width * 0.35;

    return GestureDetector(
      onTap: () {},
      child: Hero(
        tag: '${plant.id}__tag',
        child: SizedBox(
          height: containerHeight,
          width: containerWidth,
          child: Material(
            color: colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            elevation: 12,
            shadowColor: colorScheme.secondary.withOpacity(0.3),
            child: Stack(
              children: <Widget>[
                Container(
                  height: containerHeight * 0.65,
                  width: containerWidth,
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.asset(plant.image),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 4, 20, 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          plant.name,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: textTheme.headline5.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          plant.genus,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: textTheme.subtitle1.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          formatter.format(plant.price),
                          style: textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'per kilo',
                          style: textTheme.bodyText1
                              .copyWith(color: Colors.black38),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: containerWidth * 0.25,
                    width: containerWidth * 0.25,
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryVariant,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(26),
                        bottomLeft: Radius.circular(26),
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        context.bloc<CartBloc>().add(AddToCart(plant));
                      },
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
