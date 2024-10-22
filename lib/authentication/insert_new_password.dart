import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InsertNewPassword extends StatefulWidget {
  const InsertNewPassword({super.key});

  @override
  State<InsertNewPassword> createState() => _InsertNewPasswordState();
}

class _InsertNewPasswordState extends State<InsertNewPassword> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: 200,
            width: 300,
            child: const Image(image: AssetImage('./../../image/logo.jpeg')),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 300,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 233, 186, 115),
                borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('NEW PASSWORD'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Insert Your New Password',
                    fillColor: Color.fromARGB(255, 231, 225, 213),
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  constraints: BoxConstraints.tightFor(width: 200),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.blue,
                      backgroundColor: Color.fromARGB(255, 227, 132, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
