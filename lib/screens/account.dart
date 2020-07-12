import 'package:brickars/config/ui_icons.dart';
import 'package:brickars/models/user.dart';
import 'package:brickars/widgets/ProfileSettingsDialog.dart';
import 'package:brickars/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatefulWidget {
  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  User _user = new User.init().getTempUser();

  List<Widget> listWidget = [
    Container(
    child: Image.asset("img/loading1.gif"),
  )];

  Future<User> getUserProfile() async
  {
    User u = await User.init().getCurrentUser();

    setState(() {
     _user = u;

     var address = _user.address;

     listWidget = [
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20),
         child: SearchBarWidget(),
       ),
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
         child: Row(
           children: <Widget>[
             Expanded(
               child: Column(
                 children: <Widget>[
                   Text(
                     _user.name,
                     textAlign: TextAlign.left,
                     style: Theme.of(context).textTheme.display2,
                   ),
                   Text(
                     _user.email,
                     style: Theme.of(context).textTheme.caption,
                   )
                 ],
                 crossAxisAlignment: CrossAxisAlignment.start,
               ),
             ),
             SizedBox(
                 width: 55,
                 height: 55,
                 child: InkWell(
                   borderRadius: BorderRadius.circular(300),
                   onTap: () {
                     Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                   },
                   child: CircleAvatar(
                     backgroundImage: AssetImage(_user.avatar),
                   ),
                 )),
           ],
         ),
       ),
       Container(
         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
         decoration: BoxDecoration(
           color: Theme.of(context).primaryColor,
           borderRadius: BorderRadius.circular(6),
           boxShadow: [
             BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
           ],
         ),
         child: ListView(
           shrinkWrap: true,
           primary: false,
           children: <Widget>[
             ListTile(
               leading: Icon(UiIcons.user_1),
               title: Text(
                 'Profile Settings',
                 style: Theme.of(context).textTheme.body2,
               ),
               trailing: ButtonTheme(
                 padding: EdgeInsets.all(0),
                 minWidth: 50.0,
                 height: 25.0,
                 child: ProfileSettingsDialog(
                   user: this._user,
                   onChanged: () {
                     setState(() {});
                   },
                 ),
               ),
             ),
             ListTile(
               onTap: () {},
               dense: true,
               title: Text(
                 'Full name',
                 style: Theme.of(context).textTheme.body1,
               ),
               trailing: Text(
                 _user.name,
                 style: TextStyle(color: Theme.of(context).focusColor),
               ),
             ),
             ListTile(
               onTap: () {},
               dense: true,
               title: Text(
                 'Email',
                 style: Theme.of(context).textTheme.body1,
               ),
               trailing: Text(
                 _user.email,
                 style: TextStyle(color: Theme.of(context).focusColor),
               ),
             ),
             ListTile(
               onTap: () {},
               dense: true,
               title: Text(
                 'Contact Number',
                 style: Theme.of(context).textTheme.body1,
               ),
               trailing: Text(
                 _user.contactNumber,
                 style: TextStyle(color: Theme.of(context).focusColor),
               ),
             ),
             ListTile(
               onTap: () {},
               dense: true,
               title: Text(
                 'Address',
                 style: Theme.of(context).textTheme.body1,
               ),
               trailing: Text(
                 "$address",
                 style: TextStyle(color: Theme.of(context).focusColor),
               ),
             ),
             ListTile(
               onTap: () {},
               dense: true,
               title: Text(
                 'Pincode',
                 style: Theme.of(context).textTheme.body1,
               ),
               trailing: Text(
                 _user.pincode,
                 style: TextStyle(color: Theme.of(context).focusColor),
               ),
             ),
           ],
         ),
       ),
     ];
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 7),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: listWidget,
      ),
    );
  }
}
