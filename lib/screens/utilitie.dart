import 'dart:convert';
import 'dart:io';

import 'package:brickars/config/ui_icons.dart';
import 'package:brickars/models/UrlList.dart';
import 'package:brickars/models/get_network_data.dart';
import 'package:brickars/models/single_listing_details.dart';
import 'package:brickars/models/user.dart';
import 'package:brickars/widgets/ContactDetailsWidget.dart';
import 'package:brickars/widgets/HomeSliderWidget.dart';
import 'package:brickars/widgets/ProductDetailsWidget.dart';
import 'package:brickars/widgets/ReviewsListWidget.dart';
import 'package:brickars/widgets/UtilitiesHomeTabWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/utilities.dart';
import '../models/route_argument.dart';
import '../widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';

class UtilitieWidget extends StatefulWidget {
  RouteArgument routeArgument;
  Utilitie _utilitie;
  String _heroTag;

  UtilitieWidget({Key key, this.routeArgument}) {
    _utilitie = this.routeArgument.argumentsList[0] as Utilitie;
    _heroTag = this.routeArgument.argumentsList[1] as String;
  }

  @override
  _UtilitieWidgetState createState() => _UtilitieWidgetState();
}

class _UtilitieWidgetState extends State<UtilitieWidget> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _tabIndex = 0;

  SingleListingDetails singleListingDetails;
  List<Utilitie> listUtitle = [];

  UrlList urlList = new UrlList();
  GetNetworkData getNetworkData = GetNetworkData();
  Future<SingleListingDetails> getListData(String id) async{

    String url = urlList.getSingleListingDetails+"$id";
    HttpClientResponse httpClientResponse = await getNetworkData.getNetworkDataUsingGetMethid(url);

    if (httpClientResponse.statusCode == 200) {

      String reply = await httpClientResponse.transform(utf8.decoder).join();
      var response = jsonDecode(reply);

      String listing_id = response['listing_id'];
      String listing_name = response['listing_name'];
      String address = response['address'];
      String address_locations_lat_lang = response['address_locations_lat_lang'];
      String listing_email_id = response['listing_email_id'];
      String contact_person = response['contact_person'];
      String contact_number = response['contact_number'];
      String website_address = response['website_address'];
      String facebook_link = response['facebook_link'];
      String google_link = response['google_link'];
      String linkedin_link = response['linkedin_link'];
      String google_plus_link = response['google_plus_link'];
      String instagram_link = response['instagram_link'];
      String servicing_location = response['servicing_location'];
      String site_pincode = response['site_pincode'];
      String establishment_year = response['establishment_year'];
      String company_status = response['company_status'];
      String company_details = response['company_details'];
      String service_product_list = response['service_product_list'];
      String listing_date = response['listing_date'];
      String listing_logo_url = response['listing_logo_url'];
      String youtube_link = response['youtube_link'];
      String site_home_page_image_url = response['site_home_page_image_url'];
      List<dynamic> site_more_images_for_slider = response['site_more_images_for_slider'];
      String profile_pdf_link = response['profile_pdf_link'];
      String gst_number = response['gst_number'];
      String bussiness_nature = response['bussiness_nature'];
      String openhours = response['openhours'];
      String highlighted_data = response['highlighted_data'];
      List<dynamic> productdataarr = response['productdataarr'];
      String service_available_in = response['service_available_in'];
      List<Product> productList = [];

      for(int m = 0; m < productdataarr.length; m++)
        {
          String pname = productdataarr[m]['product_name'];
          String product_cost = productdataarr[m]['product_cost'];
          String product_image = productdataarr[m]['product_image'];
          String product_description = productdataarr[m]['product_description'];
          productList.add(new Product(pname, product_image, product_cost, product_description));
        }


      setState(() {
        singleListingDetails = new SingleListingDetails(listing_id, listing_name, site_home_page_image_url, bussiness_nature, 0, site_more_images_for_slider, company_details, address, address_locations_lat_lang, listing_email_id, contact_person, contact_number, website_address, facebook_link, google_link, google_plus_link, instagram_link, linkedin_link, servicing_location, site_pincode, establishment_year, company_status, service_product_list, productList, gst_number, openhours, highlighted_data, youtube_link, profile_pdf_link, service_available_in);
      });

    }
    return singleListingDetails;
  }

  Future<List<Utilitie>> getRelatedData(String id) async{

    String url = urlList.getSingleListingDetailsRelatedSuggestion+"$id";
    HttpClientResponse httpClientResponse = await getNetworkData.getNetworkDataUsingGetMethid(url);

    if (httpClientResponse.statusCode == 200) {

      String reply = await httpClientResponse.transform(utf8.decoder).join();
      var response = jsonDecode(reply);

    }
    return listUtitle;
  }



  @override
  void initState(){

    _tabController = TabController(length: 3, initialIndex: _tabIndex, vsync: this);
    _tabController.addListener(_handleTabSelection);
    getListData(widget._utilitie.id);
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
    int _current = 0;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(UiIcons.share),
        onPressed: ()
        {
          print("share this");
        },
      ),
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      bottomNavigationBar:BottomAppBar(
        elevation: 0,
        child: Container(
          height: 20,
        ),),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          floating: true,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            //new ShoppingCartButtonWidget(
                //iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
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
          backgroundColor: Theme.of(context).primaryColor,
          expandedHeight: 210,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Hero(
              tag: widget._heroTag + widget.routeArgument.id,
              child: singleListingDetails == null ? Image.asset('img/loading1.gif') : Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: <Widget>[
                        CarouselSlider(
                            items: singleListingDetails.allImageArray.map((dynamic slide) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 4), blurRadius: 9)
                                      ],
                                    ),
                                      height: 210,
                                      alignment: AlignmentDirectional.center,
                                      width: double.infinity,
                                      child: FadeInImage.assetNetwork(placeholder: 'img/loading1.gif', image: slide, fit: BoxFit.cover, height: 210.0,),
                                  );
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 210,
                              viewportFraction: 1.0,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                      Theme.of(context).primaryColor,
                      Colors.white.withOpacity(0),
                      Colors.white.withOpacity(0),
                      Theme.of(context).scaffoldBackgroundColor
                    ], stops: [
                      0,
                      0.4,
                      0.6,
                      1
                    ])),
                  ),
                ],
              ) ,
            ),
          ),
          bottom: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              unselectedLabelColor: Theme.of(context).focusColor.withOpacity(1),
              labelColor: Theme.of(context).primaryColor,
              indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Theme.of(context).focusColor.withOpacity(0.6)),
              tabs: [
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        //border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.6), width: 1)
                        ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Detail"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      //border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.6), width: 1)
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Profile"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        //border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.2), width: 1)
                        ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Products"),
                    ),
                  ),
                ),
              ]),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Offstage(
              offstage: 0 != _tabIndex,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        UiIcons.chat_1,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Listing Details',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                  ),
                  singleListingDetails == null ?
                      Container(child: Image.asset('img/loading1.gif'),) : UtilitieHomeTabWidget(utilitie: singleListingDetails),
                ],
              ),
            ),
            Offstage(
              offstage: 1 != _tabIndex,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        UiIcons.chat_1,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Profil Details',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                  ),
                  singleListingDetails == null ? Container(child: Image.asset('img/loading1.gif'),) :  ContactDetailsWidget(utilitie: singleListingDetails,),
                ],
              ),
            ),
            Offstage(
              offstage: 2 != _tabIndex,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        UiIcons.chat_1,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Prouct Details',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                  ),
                  singleListingDetails == null ? Container(child: Image.asset('img/loading1.gif'),) :  ProductDetailWidget(utilitie: singleListingDetails,),
                ],
              ),
            )
          ]),
        )
      ]),
    );
  }
}
