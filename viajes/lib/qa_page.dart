// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class QAPage extends StatefulWidget {
  const QAPage({super.key});

  @override
  State<QAPage> createState() => _QAPage();
}

class _QAPage extends State<QAPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ Questions"),
      ),
      body: ListView(
        children: [
          Container(
            width:  MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height) * 0.35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://cdn.pixabay.com/photo/2018/05/17/11/20/faq-3408300_960_720.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),

          SizedBox(height: 10),

          Container(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Question 1", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                    ],
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Text(
                        "Ut at facilisis urna. Donec ut mi ut elit blandit sagittis. Etiam eleifend dapibus neque quis luctus. Nunc mollis lorem sit amet tristique laoreet.", textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                    )
                  ),

                  Divider(thickness: 4),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Text("Question 2", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                    ],
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Text(
                        "Ut at facilisis urna. Donec ut mi ut elit blandit sagittis. Etiam eleifend dapibus neque quis luctus. Nunc mollis lorem sit amet tristique laoreet.", textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                    )
                  ),

                  Divider(thickness: 4),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Text("Question 3", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                    ],
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Text(
                        "Ut at facilisis urna. Donec ut mi ut elit blandit sagittis. Etiam eleifend dapibus neque quis luctus. Nunc mollis lorem sit amet tristique laoreet.", textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                    )
                  ),

                  Divider(thickness: 4),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Text("Question 4", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                    ],
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Text(
                        "Ut at facilisis urna. Donec ut mi ut elit blandit sagittis. Etiam eleifend dapibus neque quis luctus. Nunc mollis lorem sit amet tristique laoreet.", textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                    )
                  ),

                  Divider(thickness: 4),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Text("Question 5", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                    ],
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Text(
                        "Ut at facilisis urna. Donec ut mi ut elit blandit sagittis. Etiam eleifend dapibus neque quis luctus. Nunc mollis lorem sit amet tristique laoreet.", textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                    )
                  ),

                  Divider(thickness: 4),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Text("Question 6", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                    ],
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Text(
                        "Ut at facilisis urna. Donec ut mi ut elit blandit sagittis. Etiam eleifend dapibus neque quis luctus. Nunc mollis lorem sit amet tristique laoreet.", textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                    )
                  ),

                  Divider(thickness: 4),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Text("Question 7", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                    ],
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Text(
                        "Ut at facilisis urna. Donec ut mi ut elit blandit sagittis. Etiam eleifend dapibus neque quis luctus. Nunc mollis lorem sit amet tristique laoreet.", textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                    )
                  ),
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}