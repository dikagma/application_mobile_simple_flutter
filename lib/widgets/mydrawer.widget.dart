import 'package:app_homepage_sidemenu/widgets/drawer.header.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global/global.parameters.dart';
import 'drawer.item.widget.dart';

class MyDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
         children: [
           MyDrawerHeaderWidge(),
           Expanded(
             child: ListView.separated(
               separatorBuilder: (context, index) => Divider(height: 2,color:
               Colors.deepOrange,), itemCount: GlobalParameters.menus.length,
               itemBuilder: (context, index)
               => DrawerItemWidget(GlobalParameters.menus[index]['title'] as String,
                   GlobalParameters.menus[index]['route']  as String,
                   GlobalParameters.menus[index]['icon'] as Icon) ,
             ),
           ),
         ],
      ),
    );
  }
  
}

