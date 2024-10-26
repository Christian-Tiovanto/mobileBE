import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            const Text(
              "Welcome Back",
              style: TextStyle(fontSize: 40),
            ),
            const Text(
              "Teachers",
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
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 231, 225, 213),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 231, 225, 213),
                        ),
                      ),
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
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 231, 225, 213),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 231, 225, 213),
                        ),
                      ),
                      fillColor: const Color.fromARGB(255, 231, 225, 213),
                      filled: true,
                      hintText: 'Your Password',
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
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgot-password');
                      },
                      child: const Text('Forget Password'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
