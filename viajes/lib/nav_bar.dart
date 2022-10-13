import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 130,
            child: DrawerHeader(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: ListTile(
                  leading: CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.person),
                      backgroundColor:
                          Theme.of(context).listTileTheme.iconColor),
                  title: Text("Username"),
                  subtitle: Text("user1234@email.com"),
                  onTap: () {
                    // TODO: Send to ProfilePage
                    Navigator.pop(context);
                  }),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // TODO: Send to HomePage
                Navigator.pop(context);
              }),
          _menuLoggedIn(context),
          //_menuNotLogged(context),
        ],
      ),
    );
  }

  Column _menuLoggedIn(BuildContext context) {
    return Column(
      children: [
        ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Liked'),
            onTap: () {
              // TODO: List of liked - LOW PRIO
              Navigator.pop(context);
            }),
        ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Schedule'),
            onTap: () {
              // TODO: Send to SchedulePage
              Navigator.pop(context);
            }),
        ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Activity'),
            trailing: _notificationCircle(context, 16),
            onTap: () {
              // TODO: List of notifications - LOW PRIO
              Navigator.pop(context);
            }),
        Divider(color: Colors.black),
        ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              // TODO: Alert to Log Out
            }),
      ],
    );
  }

  Column _menuNotLogged(BuildContext context) {
    return Column(
      children: [
        Divider(color: Colors.black),
        ListTile(
            leading: Icon(Icons.login),
            title: Text('Log In'),
            onTap: () {
              // TODO: Send to LogInPage
            }),
        ListTile(
            leading: Icon(Icons.hiking),
            title: Text('Sign Up'),
            onTap: () {
              // TODO: Send to SignUpPage
            }),
      ],
    );
  }

  Container _notificationCircle(BuildContext context, int notificationNumber) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Theme.of(context).primaryColor,
        ),
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 9.0),
        child: Text(notificationNumber.toString()));
  }
}
