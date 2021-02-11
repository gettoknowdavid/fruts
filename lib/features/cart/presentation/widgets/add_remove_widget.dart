import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../../../crop/domain/entities/crop.dart';

class AddRemoveWidget extends StatelessWidget {
  const AddRemoveWidget({
    Key key,
    @required this.cropsToQuantity,
    @required this.crop,
  }) : super(key: key);

  final Map<int, int> cropsToQuantity;
  final Crop crop;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<CartBloc>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final itemQuantity = cropsToQuantity[crop.id];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove_circle),
          color: colorScheme.secondaryVariant,
          iconSize: 26,
          onPressed: () => bloc.add(RemoveFromCartEvent(id: crop.id)),
        ),
        Text(
          '$itemQuantity',
          style: textTheme.headline5.copyWith(
            fontSize: 20,
            color: Colors.black54,
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_circle),
          color: colorScheme.secondaryVariant,
          padding: EdgeInsets.zero,
          iconSize: 26,
          onPressed: () => bloc.add(AddToCartEvent(id: crop.id)),
        ),
      ],
    );
  }
}
