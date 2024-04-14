import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import '../../constants/error_codes.dart';
import '../../models/user_model.dart';

// Align(
// alignment: Alignment.topCenter,
// child: Image.asset('assets/images/personal.png'),
// ),
// SizedBox(height: 20),
// const Text('Personal information'),
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  Color grey = Color(int.parse('0xFF888888'));
  String phone = '';
  String name = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          } else if (state is AuthError) {
            switch (state.errorCode) {
              case ErrorCodes.INPUT_LENGTH:
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Fields must not be less than 4 characters'),
                    ),
                  );
                }
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset('assets/images/personal.png'),
                      ),
                      const SizedBox(height: 20),
                      const Text('Personal information'),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 54,
                    child: TextField(
                      onChanged: (string) {
                        name = string;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your phone number',
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
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 54,
                    child: TextField(
                      onChanged: (string) {
                        phone = string;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        hintText: 'Enter your password',
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
                  const SizedBox(height: 18),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      UserModel model = UserModel(name: name, phone: phone);
                      context.read<AuthBloc>().add(AddUser(name, phone));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black),
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
