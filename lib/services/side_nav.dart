import 'package:flutter/material.dart';
import 'package:notes/main.dart';

class SideNav extends StatefulWidget {
  final HomeState homeState;
  SideNav(this.homeState);

  @override
  SideNavState createState() => SideNavState();
}

class SideNavState extends State<SideNav> {
  void setIsTrashTo(bool isTrash) {
    Navigator.of(context).pop();
    widget.homeState.setState(() {
      HomeState.isTrash = isTrash;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () => setIsTrashTo(false),
            leading: Icon(Icons.note_add_outlined),
            title: Text(
              'Notes',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () => setIsTrashTo(true),
            leading: Icon(Icons.delete_outlined),
            title: Text(
              'Trash',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () => Navigator.of(context).pop(),
            leading: Icon(Icons.settings_outlined),
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}

// Navigator.of(context).push(
//   MaterialPageRoute(
//     builder: (BuildContext context) => Home(),
//   ),
// );
