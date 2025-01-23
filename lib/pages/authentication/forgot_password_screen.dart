import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
              child: Image(image: AssetImage('image/logo.jpeg')),
            ),
            const Text(
              "Forgot",
              style: TextStyle(fontSize: 40),
            ),
            const Text(
              "Passwords",
              style: TextStyle(fontSize: 40),
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
                    child: Text('TEACHER ID'),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Enter Your ID',
                      fillColor: const Color.fromARGB(255, 231, 225, 213),
                      filled: true,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text('PASSWORD'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 231, 225, 213),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: 'Your Password',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.blue,
                          padding: const EdgeInsets.all(10),
                          backgroundColor:
                              const Color.fromARGB(255, 227, 132, 36),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Get OTP',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    constraints: const BoxConstraints.tightFor(width: 200),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.blue,
                        backgroundColor:
                            const Color.fromARGB(255, 227, 132, 36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/insert-new-password');
                      },
                      child: const Text(
                        'Submit',
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
