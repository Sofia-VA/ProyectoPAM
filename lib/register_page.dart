// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account", style: TextStyle(color: Colors.black)),
        backgroundColor: Colours.silver,
      ),
      backgroundColor: Colours.white,
      body: Column(
        children: <Widget>[

          Container(
            width:  MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height) * 0.25,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://cdn.pixabay.com/photo/2018/01/31/05/43/web-3120321_960_720.png"),
                fit: BoxFit.cover
              )
            ),
          ),

          Container(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Name"
                ),
              ),
            ),
          ),

          SizedBox(height: (MediaQuery.of(context).size.height) * 0.03),

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Mobile Number"
              ),
            ),
          ),

          SizedBox(height: (MediaQuery.of(context).size.height) * 0.03),

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              decoration: InputDecoration(
                labelText: "User"
              ),
            ),
          ),

          SizedBox(height: (MediaQuery.of(context).size.height) * 0.03),

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pasword"
              ),
              obscureText: true,
            ),
          ),

          SizedBox(height: (MediaQuery.of(context).size.height) * 0.03),

          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: TextButton(
              onPressed:(){
                null;
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(240, 255, 255, 255),
                      Color.fromARGB(0, 40, 178, 194)
                    ]
                  )
                ),
                child: Text("Sign Up", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ),
          ),

          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: GestureDetector(
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()))
              },
              child: Text("Already Have an Account? Sign in", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Color(0xFF2661FA))),
            ),
          )
        ],
      )
    );    
  }
}