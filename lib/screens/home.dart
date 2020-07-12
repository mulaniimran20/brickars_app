import 'dart:convert';
import 'dart:io';

import 'package:brickars/config/ui_icons.dart';
import 'package:brickars/models/UrlList.dart';
import 'package:brickars/models/get_network_data.dart';
import 'package:brickars/models/user.dart';

import '../models/category.dart';
import '../models/utilities.dart';
import '../widgets/CategoriesIconsContainerWidget.dart';
import '../widgets/CategorizedUtilitiesWidget.dart';
import '../widgets/HomeSliderWidget.dart';
import 'package:flutter/material.dart';
import '../widgets/PopularLocationCarouselWidget.dart';
import '../widgets/SearchBarHomeWidget.dart';
class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with SingleTickerProviderStateMixin {
  List<Utilitie> _utilitiesOfCategoryList;
  List<Utilitie> _utilitiesfBrandList;
  static List<Category> _categoriesList = [];
  UtilitiesList _utilitiesList = new UtilitiesList();
  Animation animationOpacity;
  AnimationController animationController;
  UrlList urlList = new UrlList();
  GetNetworkData getNetworkData = new GetNetworkData();

  static Widget catmdata = FadeInImage.assetNetwork(
    placeholder: 'img/loading1.gif',
    image: "https://aarfaatechnovision.com/aarfaasociety/tenor.gif",
    fit: BoxFit.cover,
    width: 100.0,
    height: 50.0,
  );

  static List<Widget> catlistwidget = [];

  Widget allCategorySlider = Container(
    child: Column(
      children: catlistwidget,
    ),
  );



  Widget recomndationWidget = Container(
    child: Column(
      children: <Widget>[FadeInImage.assetNetwork(
        placeholder: 'img/loading1.gif',
        image: "https://aarfaatechnovision.com/aarfaasociety/tenor.gif",
        fit: BoxFit.cover,
        width: 100.0,
        height: 50.0,
      ),],
    ),
  );

  Future<List<Utilitie>> getPopularListData() async {
    List<Utilitie> listRecomendation = [];
    UrlList urlList = new UrlList();
    GetNetworkData getNetworkData = new GetNetworkData();
    String categoriesHomePageData = urlList.getRecommendationUrl;
    HttpClientResponse httpClientResponse = await getNetworkData
        .getNetworkDataUsingGetMethid(categoriesHomePageData);
    if (httpClientResponse.statusCode == 200) {
      String reply = await httpClientResponse.transform(utf8.decoder).join();
      var response = jsonDecode(reply);
      if (response['msg'] == "success") {
        for (int i = 0; i < response['loop']; i++) {
          var jsob = response['data'][i];
          if(i == (response['loop'] - 1)) {
            listRecomendation.add(
              new Utilitie(
                  jsob['listing_id'], jsob['listing_name'], jsob['site_home_page_image_url'],
                  jsob['sub_category_name'], 25),
            );
            setState(() {
              _utilitiesfBrandList = listRecomendation;
              recomndationWidget = PopularLocationCarouselWidget(heroTag: 'home_flash_sales', utilitiesList: _utilitiesfBrandList);
            });
          }
          else{
            listRecomendation.add(
              new Utilitie(
                  jsob['listing_id'], jsob['listing_name'], jsob['site_home_page_image_url'],
                  jsob['sub_category_name'], 12),
            );
          }
        }
      }
    }
  }



  Future<List<Utilitie>> getAllCategoryListData(int categoryid) async {
    List<Utilitie> listAllCategory = [];
    UrlList urlList = new UrlList();
    GetNetworkData getNetworkData = new GetNetworkData();
    String allCategoryList = urlList.getCategorywiseData;
    HttpClientResponse httpClientResponse = await getNetworkData.getNetworkDataUsingGetMethid('$allCategoryList?catid=$categoryid');


    if (httpClientResponse.statusCode == 200) {
      String reply = await httpClientResponse.transform(utf8.decoder).join();
      var response = jsonDecode(reply);
      if (response['msg'] == "success") {
        for (int i = 0; i < response['loop']; i++) {
          var jsob = response['data'][i];
          if(i == (response['loop'] - 1)) {
            listAllCategory.add(
              new Utilitie(
                  jsob['listing_id'], jsob['listing_name'], jsob['site_home_page_image_url'],
                  jsob['sub_category_name'], 25),
            );
            setState(() {
              _utilitiesfBrandList = listAllCategory;
              catmdata = Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child:Column(
                          children: <Widget>[
                            ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                              leading: Icon(
                                UiIcons.heart,
                                color: Theme.of(context).hintColor,
                              ),
                              title: Text(
                                response['categoryname'],
                                style: Theme.of(context).textTheme.display1,
                              ),
                            ),
                          ],
                        )

                    ),
                    PopularLocationCarouselWidget(heroTag: 'home_flash_sales_$categoryid', utilitiesList: _utilitiesfBrandList),
                  ],
                ),
              );

              catlistwidget.add(catmdata);
              allCategorySlider = Container(
                child: Column(
                  children: catlistwidget,
                ),
              );

            });
          }
          else{
            listAllCategory.add(
              new Utilitie(
                  jsob['listing_id'], jsob['listing_name'], jsob['site_home_page_image_url'],
                  jsob['sub_category_name'], 12),
            );
          }
        }
      }
    }
  }


  Widget catwid = Container(
    child: Column(
      children: <Widget>[FadeInImage.assetNetwork(
        placeholder: 'img/loading1.gif',
        image: "https://aarfaatechnovision.com/aarfaasociety/tenor.gif",
        fit: BoxFit.cover,
        width: 100.0,
        height: 50.0,
      ),],
    ),
  );

  Future<List<Category>> getAllCategories() async
  {
    List<Category> listCat = [];

    String categoriesHomePageData = urlList.categories;
    HttpClientResponse httpClientResponse = await getNetworkData.getNetworkDataUsingGetMethid(categoriesHomePageData);
    if (httpClientResponse.statusCode == 200) {

      String reply = await httpClientResponse.transform(utf8.decoder).join();
      var response = jsonDecode(reply);
      if (response['msg'] == "success") {

        for (int i = 0; i < response['loop']; i++) {

          var jsob = response['data'][i];
          List<Utilitie> subcat = [];
          for(int n = 0; n< jsob['subcatloop']; n++)
          {
            Utilitie u1 = new Utilitie(jsob['listing_id'], jsob['subcatdata'][n]['sub_category_name'], jsob['subcatdata'][n]['sub_category_image'], jsob['category_name'], 1,);
            subcat.add(u1);
          }

          getAllCategoryListData(jsob['id']);
          listCat.add(new Category(jsob['id'], jsob['category_name'], UiIcons.bar_chart, true, Colors.blueAccent, subcat));
          if(i == (response['loop']-1))
          {
            this.setState(() {
              _categoriesList = [];
              _categoriesList = listCat;
              _utilitiesOfCategoryList = _categoriesList.firstWhere((category) {
                return category.selected;
              }).utilities;
              catwid = CategoriesIconsContainerWidget(categoriesList: _categoriesList);
            });
            return listCat;
          }

        }

      } else {


      }
    }

  }




  @override
  void initState(){

      User.init();
      getAllCategories();
      getPopularListData();



    animationController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    CurvedAnimation curve = CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    animationController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              HomeSliderWidget(),
              Container(
                margin: const EdgeInsets.only(top: 150,bottom: 20),
                padding: const EdgeInsets.only(right: 20,left: 20),
                child: SearchBarHomeWidget(),
            ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(right: 2,left: 2),
            child: catwid
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child:Column(
              children: <Widget>[
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  leading: Icon(
                    UiIcons.favorites,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Text(
                    'Our Recommendation',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
              ],
            ) 
            
        ),
          recomndationWidget,
          allCategorySlider,
        ],
      )
    );
  }
}
