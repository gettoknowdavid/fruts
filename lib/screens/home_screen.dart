import 'package:flutter/material.dart';
import 'package:fruts/src/data/enum_helper.dart';
import 'package:fruts/src/models/category.dart';
import 'package:fruts/widgets/app_background.dart';
import 'package:fruts/widgets/custom_app_bar.dart';
import 'package:fruts/widgets/home_tab_views.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: Category.values.length,
      vsync: this,
    );
  }

  List<Widget> get _tabs {
    List<Widget> list = [];

    for (Category category in Category.values) {
      list.add(
        Container(
          width: 170,
          child: Text(
            enumToString(category),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    // final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    var tabBar = TabBar(
      indicatorColor: Colors.transparent,
      isScrollable: true,
      controller: tabController,
      labelColor: textTheme.headline6.color,
      unselectedLabelStyle: textTheme.headline6,
      unselectedLabelColor: Colors.black26,
      labelStyle: textTheme.headline6,
      tabs: _tabs,
    );

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: AppBackground(
        topChild: Scaffold(
          appBar: FrutsAppBar(bottom: tabBar),
          body: HomeTabViews(
            tabController: tabController,
          ),
        ),
      ),
    );
  }
}
