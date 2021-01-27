import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/core/presentation/widgets/app_background.dart';
import 'package:fruts/core/presentation/widgets/custom_back_button.dart';
import 'package:fruts/core/presentation/widgets/fade_page_route.dart';
import 'package:fruts/core/presentation/widgets/fruts_app_bar.dart';
import 'package:fruts/core/utils/enum_to_category.dart';
import 'package:fruts/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fruts/features/cart/presentation/pages/cart_page.dart';
import 'package:fruts/features/cart/presentation/widgets/add_to_cart_button.dart';
import 'package:fruts/features/cart/presentation/widgets/cart_bag.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';
import 'package:fruts/features/crop/presentation/widgets/crop_cost.dart';
import 'package:fruts/features/crop/presentation/widgets/nutrient_widget.dart';

class _TopChild extends StatelessWidget {
  const _TopChild({Key key, @required this.crop}) : super(key: key);

  final Crop crop;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final topChildHeight = height * 0.7;
    final imageHeight = topChildHeight * 0.45;

    final category = enumFormatter(crop.category);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: FrutsAppBar(
          title: '',
          leading: FrutsBackButton(),
          action: buildCartBag(context),
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
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Hero(
                    tag: '${crop.id}__tag',
                    child: Image.asset(crop.imageUrl),
                  ),
                ),
              ),
              Spacer(),
              Text(
                crop.name,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: textTheme.headline3.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                crop.genus,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: textTheme.headline5.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
              Text(
                category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: textTheme.headline6.copyWith(
                  fontSize: 18,
                  color: Colors.black26,
                ),
              ),
              SizedBox(height: 16),
              CropCost(crop: crop),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildCartBag(context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          FadePageRoute(
            child: CartPage(showBackButton: true),
          ),
        );
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            return CartBag(value: state.crops.length);
          } else {
            return CartBag(value: 0);
          }
        },
      ),
    );
  }
}

class _BottomChild extends StatelessWidget {
  const _BottomChild({Key key, @required this.crop}) : super(key: key);

  final Crop crop;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Container(
      height: height - (height * 0.74),
      child: Column(
        children: <Widget>[
          Spacer(),
          LimitedBox(
            maxHeight: height * 0.1,
            child: ListView.builder(
              itemCount: crop.nutritions.length,
              scrollDirection: Axis.horizontal,
              primary: false,
              itemBuilder: (context, index) {
                return NutritionWidget(
                  height: height,
                  crop: crop,
                  nutrient: crop.nutritions[index],
                );
              },
            ),
          ),
          Spacer(),
          Container(
            height: 100,
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoaded) {
                  return AddToCartButton(
                    crop: crop,
                    cartQuantity: state.crops.length,
                  );
                } else {
                  return AddToCartButton(
                    crop: crop,
                    cartQuantity: 0,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key key, @required this.crop}) : super(key: key);

  final Crop crop;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animateTopChild;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );

    animateTopChild = Tween<double>(begin: 754, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    final topChildHeight = height * 0.74;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: AppBackground(
        topChildHeight: topChildHeight,
        topChild: Transform.translate(
          offset: Offset(0.0, -animateTopChild.value),
          child: _TopChild(crop: widget.crop),
        ),
        bottomChild: _BottomChild(crop: widget.crop),
      ),
    );
  }
}
