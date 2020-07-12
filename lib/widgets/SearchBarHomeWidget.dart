import 'dart:convert';
import 'dart:io';

import 'package:brickars/config/ui_icons.dart';
import 'package:brickars/models/UrlList.dart';
import 'package:brickars/models/get_network_data.dart';
import 'package:brickars/models/route_argument.dart';
import 'package:brickars/models/utilities.dart';
import 'package:flutter/material.dart';

class SearchBarHomeWidget extends StatelessWidget {

  UrlList urlList = new UrlList();
  GetNetworkData getNetworkData = new GetNetworkData();
  List<Utilitie> listUtitle = new List();

  Future<List<Utilitie>> getRelatedData(String id, BuildContext context) async{

    String url = urlList.getSearchData+"$id";
    HttpClientResponse httpClientResponse = await getNetworkData.getNetworkDataUsingGetMethid(url);

    List<Utilitie> ut = new List();

    if (httpClientResponse.statusCode == 200) {

      String reply = await httpClientResponse.transform(utf8.decoder).join();
      var response = jsonDecode(reply);

      int count = response['loop'];
      for(int i=0; i < count; i++)
        {
          var ltd = response['data'][i]['listing_id'];
          Utilitie utilitie = new Utilitie("$ltd", response['data'][i]['listing_name'], response['data'][i]['site_home_page_image_url'], response['data'][i]['sub_category_name'], 1);
          ut.add(utilitie);
          if(i == (response['loop'] - 1)) {
            Navigator.of(context).pushNamed('/SearchData', arguments: new RouteArgument(id: "", argumentsList: [ut]));
          }

        }

    }
    return listUtitle;
  }



  var _searching = TextEditingController();
  SearchBarHomeWidget({
    Key key,
  }) : super(key: key);
  //List<String> suggestions=["Delux Room","Tripple Room","Single Room","King Room"];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
        ],
      ),
      child:Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.4),width: 1),
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                TextField(
                  controller: _searching,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.8)),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    var searchText = _searching.text;
                    getRelatedData(searchText, context);


                  },
                  icon: Icon(UiIcons.loupe, size: 20, color: Theme.of(context).hintColor.withOpacity(0.9)),
                ),
              ],
            ),
          ),
          /*SizedBox(height: 6),*/
        ],


      ),
       
    );
  }
}
  _buildSuggestions(List<String> list,BuildContext context) {
    List<Widget> choices = List();
    list.forEach((item) {
      choices.add(
        Container(
          margin: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).hintColor.withOpacity(0.2),
            ),
            padding: const EdgeInsets.only(left:10.0,right: 10,top: 3,bottom: 3),
            child: Text(
              item,
              style: Theme.of(context).textTheme.body1.merge(TextStyle(color: Theme.of(context).primaryColor),),
            
            ),
          ),
        ),
      );
    }
    );return choices;
  }