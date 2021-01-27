import 'package:flutter/material.dart';
import 'package:fruts/core/constants/enums/category.dart';
import 'package:fruts/core/presentation/widgets/app_background.dart';
import 'package:fruts/core/presentation/widgets/fruts_app_bar.dart';
import 'package:fruts/core/utils/enum_to_string.dart';
import 'package:fruts/features/crop/presentation/widgets/crop_tab_views.dart';

class CropsPage extends StatefulWidget {
  @override
  _CropsPageState createState() => _CropsPageState();
}

class _CropsPageState extends State<CropsPage> with TickerProviderStateMixin {
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
          body: HomeTabViews(tabController: tabController),
        ),
      ),
    );
  }
}