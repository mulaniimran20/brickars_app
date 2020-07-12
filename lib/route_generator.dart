import 'package:brickars/models/route_argument.dart';
import 'package:brickars/screens/Categorie.dart';
import 'package:brickars/screens/SearchResultScreen.dart';
import 'package:brickars/screens/SplashScreen.dart';
import 'package:brickars/screens/signin.dart';
import 'package:brickars/screens/signup.dart';
import 'package:brickars/screens/tabs.dart';
import 'package:brickars/screens/utilitie.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/SignIn':
        return MaterialPageRoute(builder: (_) => SignInWidget());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/Tabs':
        return MaterialPageRoute(builder: (_) => TabsWidget(currentTab: args,));
     case '/Utilities':
        return MaterialPageRoute(builder: (_) => UtilitieWidget(routeArgument: args as RouteArgument,));
    /*  case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());


      case '/Categories':
        return MaterialPageRoute(builder: (_) => CategoriesWidget());

     */
      case '/Categorie':
        return MaterialPageRoute(builder: (_) => CategorieWidget(routeArgument: args as  RouteArgument,));


      case '/SearchData':
        return MaterialPageRoute(builder: (_) => SearchResultScreen(routeArgument: args as  RouteArgument,));

      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
