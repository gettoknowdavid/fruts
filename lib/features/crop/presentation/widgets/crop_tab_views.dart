import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/core/constants/enums/category.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';
import 'package:fruts/features/crop/presentation/blocs/tabs/tabs_bloc.dart';
import 'package:fruts/features/crop/presentation/widgets/assymetric_view.dart';
import 'package:fruts/features/crop/presentation/widgets/featured_widget.dart';

class HomeTabViews extends StatelessWidget {
  final TabController tabController;

  const HomeTabViews({
    Key key,
    this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    List<Widget> _views(Category category, List<Crop> crops) {
      for (category in Category.values) {
        if (category == Category.all) {
          children.add(
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  FeaturedWidget(),
                  SizedBox(height: 20),
                  AssymetricView(crops: crops),
                ],
              ),
            ),
          );
        } else {
          final theCrops =
              crops.where((c) => c.category == category).toList();
          children.add(
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 20),
              child: AssymetricView(crops: theCrops),
            ),
          );
        }
      }

      return children;
    }

    return BlocBuilder<TabsBloc, TabsState>(
      cubit: context.watch<TabsBloc>(),
      builder: (context, state) {
        if (state is TabsLoaded) {
          return TabBarView(
            controller: tabController,
            children: _views(
              state.category,
              state.crops,
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
