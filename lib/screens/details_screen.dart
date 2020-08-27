import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/screens/cart_screen.dart';
import 'package:fruts/src/blocs/cart/cart_bloc.dart';
import 'package:fruts/src/models/category.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:fruts/widgets/add_to_cart_button.dart';
import 'package:fruts/widgets/app_background.dart';
import 'package:fruts/widgets/cart_bag.dart';
import 'package:fruts/widgets/fade_page_route.dart';
import 'package:fruts/widgets/fruts_app_bar.dart';
import 'package:fruts/widgets/custom_back_button.dart';
import 'package:fruts/widgets/nutrient_widget.dart';
import 'package:fruts/widgets/plant_cost.dart';

class _TopChild extends StatelessWidget {
  const _TopChild({Key key, @required this.plant}) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final topChildHeight = height * 0.7;
    final imageHeight = topChildHeight * 0.45;

    final category = enumFormatter(plant.category);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: FrutsAppBar(
          title: '',
          leading: FrutsBackButton(),
          action: StreamBuilder<int>(
            stream: context.bloc<CartBloc>().cartQuantityStream,
            builder: (context, snapshot) {
              return buildCartBag(context, snapshot);
            },
          ),
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
                    tag: '${plant.id}__tag',
                    child: Image.asset(plant.image),
                  ),
                ),
              ),
              Spacer(),
              Text(
                plant.name,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: textTheme.headline3.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                plant.genus,
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
              PlantCost(plant: plant),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCartBag(context, snapshot) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          FadePageRoute(
            child: CartScreen(showBackButton: true),
          ),
        );
      },
      child: CartBag(value: snapshot.data),
    );
  }
}

class _BottomChild extends StatelessWidget {
  const _BottomChild({Key key, @required this.plant}) : super(key: key);

  final Plant plant;

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
              itemCount: plant.nutritions.length,
              scrollDirection: Axis.horizontal,
              primary: false,
              itemBuilder: (context, index) {
                return NutritionWidget(
                  height: height,
                  plant: plant,
                  nutrient: plant.nutritions[index],
                );
              },
            ),
          ),
          Spacer(),
          Container(
            height: 100,
            child: StreamBuilder<int>(
              stream: BlocProvider.of<CartBloc>(context).cartQuantityStream,
              builder: (context, snapshot) {
                return AddToCartButton(
                  plant: plant,
                  cartQuantity: snapshot.data,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key key, @required this.plant}) : super(key: key);

  final Plant plant;

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
          child: _TopChild(plant: widget.plant),
        ),
        bottomChild: _BottomChild(plant: widget.plant),
      ),
    );
  }
}
