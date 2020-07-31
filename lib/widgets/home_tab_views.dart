import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/src/blocs/tabs/tabs_bloc.dart';
import 'package:fruts/src/models/category.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:fruts/widgets/assymetric_view.dart';
import 'package:fruts/widgets/featured_widget.dart';

class HomeTabViews extends StatelessWidget {
  final TabController tabController;

  const HomeTabViews({
    Key key,
    this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    List<Widget> _views(Category category, List<Plant> plants) {
      for (category in Category.values) {
        if (category == Category.all) {
          children.add(
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  FeaturedWidget(),
                  SizedBox(height: 20),
                  AssymetricView(plants: plants),
                ],
              ),
            ),
          );
        } else {
          final thePlants =
              plants.where((c) => c.category == category).toList();
          children.add(
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 20),
              child: AssymetricView(plants: thePlants),
            ),
          );
        }
      }

      return children;
    }

    return BlocBuilder<TabsBloc, TabsState>(
      bloc: context.bloc<TabsBloc>(),
      builder: (context, state) {
        if (state is TabsLoaded) {
          return TabBarView(
            controller: tabController,
            children: _views(
              state.category,
              state.plants,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
