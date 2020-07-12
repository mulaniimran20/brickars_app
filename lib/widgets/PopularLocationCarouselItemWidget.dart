import 'package:brickars/models/route_argument.dart';
import 'package:flutter/material.dart';
import '../models/utilities.dart';
class PopularLocationCarouselItemWidget extends StatelessWidget {
  String heroTag;
  double marginLeft;
  Utilitie utilitie;

  PopularLocationCarouselItemWidget({
    Key key,
    this.heroTag,
    this.marginLeft,
    this.utilitie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/Utilities', arguments: new RouteArgument(id: utilitie.id, argumentsList: [utilitie, heroTag]));
      },
      child: Container(
        margin: EdgeInsets.only(left: this.marginLeft, right: 20),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Hero(
              tag: heroTag + utilitie.id.toString(),
              child: Container(
                width: 160,
                height: 175,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 4), blurRadius: 9)
                    ],
                  ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage.assetNetwork(placeholder: 'img/loading1.gif', image: utilitie.image, height: 185, fit: BoxFit.fill,),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 150),
              width: 140,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                ]),
              child: Center(
                child:Text(
                  utilitie.name,
                  style: Theme.of(context).textTheme.body2,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
                  //SizedBox(height: 7),
                  //Text(
                    //'${utilitie.available} Available',
                    //style: Theme.of(context).textTheme.body1,
                    //overflow: TextOverflow.ellipsis,
                  //),
              ),
            )
          ],
        ),
      ),
    );
  }
}
