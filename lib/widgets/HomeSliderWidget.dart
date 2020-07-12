import 'dart:convert';
import 'dart:io';

import 'package:brickars/models/UrlList.dart';
import 'package:brickars/models/get_network_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/slider.dart';
import '../models/slider.dart' as prefix0;
import 'package:flutter/material.dart';

class HomeSliderWidget extends StatefulWidget {
  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;

  List<prefix0.Slider> list = [
    new prefix0.Slider(image:'https://www.brickars.com/images/1577343072_slider.jpg'),
  ];
  UrlList urlList = UrlList();
  GetNetworkData getNetworkData = GetNetworkData();


  Future<List<prefix0.Slider>> getListData() async{
    String sliderImagesFromHomePage = urlList.sliderImagesFromHomePage;
    List<prefix0.Slider> listm = [];
    HttpClientResponse httpClientResponse = await getNetworkData.getNetworkDataUsingGetMethid(sliderImagesFromHomePage);
    if (httpClientResponse.statusCode == 200) {

      String reply = await httpClientResponse.transform(utf8.decoder).join();
      var response = jsonDecode(reply);
      if (response['msg'] != "success") {
      } else {

        for (int i = 0; i < response['loop']; i++) {
          if(i == (response['loop'] - 1))
          {
            list = [];
            listm.add(new prefix0.Slider(image: response['data'][i]['slider_image']));
          }
          else{
            listm.add(new prefix0.Slider(image: response['data'][i]['slider_image']));
          }
        }
      }
    }
    return listm;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getListData().then((value) =>
      list = value,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        CarouselSlider(
          items: list.map((prefix0.Slider slide) {
            return Builder(
              builder: (BuildContext context) {
                return
                  Container(
                    child: FadeInImage.assetNetwork(placeholder: 'img/loading1.gif', image: slide.image, fit: BoxFit.fill, height: 200.0,),
                    alignment: AlignmentDirectional.center,
                    width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 4), blurRadius: 9)
                        ],
                      )
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 200,
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
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: list.map((prefix0.Slider slide) {
              return Container(
                width: 20.0,
                height: 3.0,
                margin: EdgeInsets.symmetric(vertical: 70.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: _current == list.indexOf(slide)
                        ? Theme.of(context).hintColor
                        : Theme.of(context).hintColor.withOpacity(0.3)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
