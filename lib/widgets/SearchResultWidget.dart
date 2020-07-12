
import 'package:brickars/models/route_argument.dart';
import 'package:brickars/models/utilities.dart';
import 'package:flutter/material.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({
    Key key,
    @required this.utilitie,
    @required this.heroTag,
  }) : super(key: key);

  final Utilitie utilitie;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Utilities',
            arguments: new RouteArgument(argumentsList: [this.utilitie, this.heroTag], id: this.utilitie.id));
      },
      child: Container(
        //margin: EdgeInsets.all(20),
        //alignment: AlignmentDirectional.topCenter,
        //padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: this.heroTag + utilitie.id,
              child: Image.asset(utilitie.image),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                utilitie.name,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                '${utilitie.available} Viewers',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
