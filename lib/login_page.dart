// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_print, unused_label
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto/add_experience.dart';
import 'package:proyecto/calendar.dart';
import 'package:proyecto/qa_page.dart';
import 'package:proyecto/register_page.dart';
import 'package:proyecto/user_page.dart';

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
            width:  MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height) * 0.35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://cdn.pixabay.com/photo/2019/08/11/15/48/road-trip-4399206_960_720.png"),
                fit: BoxFit.cover
              )
            ),
          ),

          SizedBox(height: 30),

          Container(
            margin: const EdgeInsets.only(left:20, right: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome!", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                Text("Sign up", style: TextStyle(fontSize: 20, color: Colors.grey)),
                
                SizedBox(height: 30),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: Offset(1,1),
                        color: Colors.grey.withOpacity(0.2)
                      )
                    ]
                  ),

                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(30)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
                
                SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: Offset(1,1),
                        color: Colors.grey.withOpacity(0.2)
                      )
                    ]
                  ),

                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.key_outlined, color: Colors.blueAccent),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(30)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                
                Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Text("Forgot your Password?", style: TextStyle(fontSize: 15, color: Colors.grey)),
                  ],
                ),

                SizedBox(height: 20),

                Center(
                  child: MaterialButton(
                    onPressed: (){
                      // CAMBIAR, aqui va el sign up correcto, mientras manda a Calendar
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Calendar()));
                    }, 
                    child: Text("Sign up"),
                    minWidth: 300,
                    height: 55,
                    color: Colors.blue[300],
                  ),
                ),

                SizedBox(height: 20),

                Divider(
                  color: Colors.black,
                  height: 10,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),

                SizedBox(height: 25),
                
                Center(
                  child: Text("Inicia sesión por: ", style: TextStyle(fontSize: 15)),
                ),
                
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    TextButton.icon(
                      onPressed: (){
                        // CAMBIAR, aqui va el sign up correcto, mientras manda a userPage
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage()));
                      }, 
                      icon: Icon(FontAwesomeIcons.google),
                      label: Text("Goggle", style: TextStyle(color: Colors.black)),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[200])),
                    ),

                    TextButton.icon(
                      onPressed: (){
                        // CAMBIAR, aqui va el sign up correcto, mientras manda a addExperience
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddExperience()));
                      }, 
                      icon: Icon(FontAwesomeIcons.facebook),
                      label: Text("Facebook", style: TextStyle(color: Colors.black)),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[200])),
                    ),
                  ],
                ),

                SizedBox(height: (MediaQuery.of(context).size.width) * 0.1 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No tienes una cuenta?"),
                    TextButton(
                      child: Text("Crear una", style: TextStyle(color: Colors.black)),
                      onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                      }
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.question_mark_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const QAPage()));
                      },
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}