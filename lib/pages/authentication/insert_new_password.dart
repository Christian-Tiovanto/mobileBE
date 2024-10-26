import 'package:flutter/material.dart';

class InsertNewPassword extends StatefulWidget {
  const InsertNewPassword({super.key});

  @override
  State<InsertNewPassword> createState() => _InsertNewPasswordState();
}

class _InsertNewPasswordState extends State<InsertNewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 200,
              width: 300,
              child: Image(image: AssetImage('./../../image/logo.jpeg')),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 233, 186, 115),
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text('NEW PASSWORD'),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Insert Your New Password',
                      fillColor: const Color.fromARGB(255, 231, 225, 213),
                      filled: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    constraints: const BoxConstraints.tightFor(width: 200),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.blue,
                        backgroundColor: const Color.fromARGB(255, 227, 132, 36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/dashboard');
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
