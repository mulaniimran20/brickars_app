import 'package:brickars/config/ui_icons.dart';
import 'package:brickars/models/category.dart';
import 'package:brickars/models/route_argument.dart';
import 'package:brickars/models/user.dart';
import 'package:brickars/models/utilities.dart';
import 'package:brickars/widgets/BrandGridWidget.dart';
import 'package:brickars/widgets/DrawerWidget.dart';
import 'package:brickars/widgets/ProductsByBrandWidget.dart';
import 'package:brickars/widgets/SearchGridList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchResultScreen extends StatefulWidget {
  RouteArgument routeArgument;
  List<Utilitie> _searchString;

  SearchResultScreen({Key key, this.routeArgument}) {
    _searchString = this.routeArgument.argumentsList[0] as List<Utilitie>;
  }

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _tabIndex = 0;


  @override
  void initState(){
    _tabController = TabController(length: 1, initialIndex: _tabIndex, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      drawer: DrawerWidget(),

      body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              snap: true,
              floating: true,
              automaticallyImplyLeading: false,
              leading: new IconButton(
                icon: new Icon(UiIcons.return_icon, color: Theme.of(context).primaryColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: <Widget>[
                //new ShoppingCartButtonWidget(
                //  iconColor: Theme.of(context).primaryColor, labelColor: Theme.of(context).hintColor),
                Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(300),
                      onTap: () {
                        Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage('img/user2.jpg'),
                      ),
                    )),
              ],
              backgroundColor: Colors.blueAccent,
              expandedHeight: 55,
              elevation: 0,

            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Offstage(
                  offstage: 0 != _tabIndex,
                  child: Column(
                    children: <Widget>[
                      BrandGridWidget(categoriesList: widget._searchString)
                    ],
                  ),
                ),
              ]),
            )
          ]),
    );
  }
}
