// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account", style: TextStyle(color: Colors.black)),
        backgroundColor: Colours.lightSteelBlue,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              
              Container(
                color: Colors.grey,
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2018/04/13/02/33/graphic-3315401_960_720.png',
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
        
              Positioned(
                top: 200,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey.shade600,
                  backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                ),
              )
            ],
          ),
          
          SizedBox(height: 88),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Username", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 10),
              Text("Name")
            ],
          ),

        SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: (){
                  null;
                }, 
                icon: Icon(FontAwesomeIcons.google),
                label: Text("Goggle", style: TextStyle(color: Colors.black)),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[200])),
              ),

              TextButton.icon(
                onPressed: (){
                  null;
                }, 
                icon: Icon(FontAwesomeIcons.facebook),
                label: Text("Facebook", style: TextStyle(color: Colors.black)),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[200])),
              ),

            ],
          ),

          SizedBox(height: 30),

          Text("Learn more about me", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,)), 

          SizedBox(height: 30),

          Container(
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Text(
                "Ut at facilisis urna. Donec ut mi ut elit blandit sagittis. Etiam eleifend dapibus neque quis luctus. Nunc mollis lorem sit amet tristique laoreet. Donec ut fringilla enim. Aenean molestie sem purus, at sagittis arcu rhoncus sed. Ut at blandit mi, ac finibus dui. Curabitur interdum magna quis ex elementum porta. Sed dignissim nunc non commodo posuere. Suspendisse ornare nibh est. Etiam ultrices neque ante, id facilisis dui sodales ut. Proin rhoncus imperdiet diam et lacinia. Nunc posuere, mi et accumsan dictum, arcu ipsum pellentesque enim, quis tincidunt felis massa non augue. Nulla ac libero convallis, pulvinar eros non, dignissim nunc. Curabitur at ante odio. Mauris a elit ornare, convallis libero quis, sodales libero.", textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
            )
          )
        ]
      ),
    );
  } 
}