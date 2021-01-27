import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/core/presentation/widgets/fade_page_route.dart';
import 'package:fruts/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';
import 'package:fruts/features/crop/presentation/pages/details_page.dart';
import 'package:intl/intl.dart';

class CropCard extends StatelessWidget {
  const CropCard({Key key, this.crop}) : super(key: key);

  final Crop crop;

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

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            FadePageRoute(child: DetailsScreen(crop: crop)),
          );
        },
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
                  height: containerHeight * 0.6,
                  width: containerWidth,
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Hero(
                      tag: '${crop.id}__tag',
                      child: Image.asset(crop.imageUrl),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 4, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          crop.name,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          crop.genus,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: textTheme.subtitle1.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          formatter.format(crop.price),
                          style: textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'per kilo',
                          style: textTheme.caption.copyWith(
                            color: Colors.black38,
                            fontStyle: FontStyle.italic,
                          ),
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
                        context.read<CartBloc>()..add(AddToCartEvent(id: crop.id));
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
