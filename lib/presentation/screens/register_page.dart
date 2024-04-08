import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text(
          'Register',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/personal.png'),
          ),
          SizedBox(height: 20),
          const Text('Personal information'),
          SizedBox(height: 20),
          Container(
            height: 54,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Full name',
                border: OutlineInputBorder(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(5)),
                  borderSide:
                  BorderSide(color: Color(int.parse('0xDDDDDD'))),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
