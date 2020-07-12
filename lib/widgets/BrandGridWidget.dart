import 'package:brickars/models/route_argument.dart';
import 'package:brickars/models/utilities.dart';
import 'package:brickars/widgets/PopularLocationCarouselItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BrandGridWidget extends StatelessWidget {
  const BrandGridWidget({
    Key key,
    @required List<Utilitie> categoriesList,
  })  : _categoriesList = categoriesList,
        super(key: key);

  final List<Utilitie> _categoriesList;

  @override
  Widget build(BuildContext context) {

    double _marginLeft = 0;
    
    return StaggeredGridView.countBuilder(
      primary: false,
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(14,  14,  0,  0),
      crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
      itemCount: _categoriesList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(
                alignment: AlignmentDirectional.topCenter,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
                    ],
                    gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                      Colors.white12,
                      Colors.white12.withOpacity(0.2),
                    ])),
                child: PopularLocationCarouselItemWidget(
                  heroTag: "search_list_item",
                  marginLeft: _marginLeft,
                  utilitie: _categoriesList.elementAt(index),
                ),
              ),
            ],
          ),
        );
      },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      mainAxisSpacing: 7.0,
      crossAxisSpacing: 7.0,
    );
  }
}
