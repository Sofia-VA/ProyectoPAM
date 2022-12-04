// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_print, unused_label
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/bloc/google_auth_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:proyecto/add_experience.dart';
// import 'package:proyecto/calendar.dart';
// import 'package:proyecto/map/map.dart';
//import 'package:proyecto/qa_page.dart';
// import 'package:proyecto/register_page.dart';
// import 'package:proyecto/user_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.ghostWhite,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height) * 0.35,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://cdn.pixabay.com/photo/2019/08/11/15/48/road-trip-4399206_960_720.png"),
                    fit: BoxFit.cover)),
          ),
          SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome!",
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                Text("Sign up",
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                SizedBox(height: 30),
                Center(
                  child: MaterialButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Calendar()));
                      BlocProvider.of<GoogleAuthBloc>(context)
                          .add(NewGoogleAuthEvent());
                    },
                    child: Text("Sign up"),
                    minWidth: 300,
                    height: 55,
                    color: Colors.blue[300],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
