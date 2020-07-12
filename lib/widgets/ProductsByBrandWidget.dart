import 'dart:convert';
import 'dart:io';

import 'package:brickars/models/UrlList.dart';
import 'package:brickars/models/category.dart';
import 'package:brickars/models/get_network_data.dart';
import 'package:brickars/models/utilities.dart';
import 'package:brickars/widgets/FavoriteListItemWidget.dart';
import 'package:flutter/material.dart';

class UtilitiesByBrandWidget extends StatefulWidget {
  Category category;

  UtilitiesByBrandWidget({Key key, this.category}) : super(key: key);

  @override
  _UtilitiesByBrandWidgetState createState() => _UtilitiesByBrandWidgetState();
}

class _UtilitiesByBrandWidgetState extends State<UtilitiesByBrandWidget> {

  String startListingId = "0";
  UrlList urlList = UrlList();
  GetNetworkData getNetworkData = GetNetworkData();
  List<Utilitie> utl = new List();
  String layout = 'list';
  ScrollController controller;

  Future<List<Utilitie>> getAllCategoryListData(int categoryid, String startListingId) async {
    UrlList urlList = new UrlList();
    GetNetworkData getNetworkData = new GetNetworkData();
    String url = urlList.catgosryWiseDataUrl+"$categoryid&listinglastid=$startListingId";
    HttpClientResponse httpClientResponse = await getNetworkData.getNetworkDataUsingGetMethid(url);

    if (httpClientResponse.statusCode == 200) {
      String reply = await httpClientResponse.transform(utf8.decoder).join();
      var response = jsonDecode(reply);
      if (response['msg'] == "success") {
        for (int i = 0; i < response['loop']; i++) {
          var jsob = response['data'][i];
          if(i == (response['loop'] - 1)) {
            setState(() {
              Utilitie u =new Utilitie(jsob['listing_id'], jsob['listing_name'], jsob['site_home_page_image_url'], jsob['sub_category_name'], 25);
              startListingId = jsob['listing_id'];
              utl.add(u);
              controller = new ScrollController()..addListener(_scrollListener);
            });
          }
          else{

            Utilitie u = new Utilitie(
                jsob['listing_id'], jsob['listing_name'], jsob['site_home_page_image_url'],
                jsob['sub_category_name'], 12);
            utl.add(u);

          }
        }
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategoryListData(widget.category.id, startListingId);
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Offstage(
          offstage: this.layout != 'list',
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    controller: controller,
                  scrollDirection: Axis.vertical,
                  itemCount: utl.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      if(index == (utl.length - 1))
                        {
                          getAllCategoryListData(widget.category.id, utl[index].id);
                        }
                    return FavoriteListItemWidget(
                    heroTag: 'Utilities_by_category_list',
                    utilitie: utl[index],
                    onDismissed: () {
                    setState(() {
                      utl[index];
                    });
                    },
                   );
                    },
                    ),
                ),
                  ),
                 ],
                  );
  }
}
