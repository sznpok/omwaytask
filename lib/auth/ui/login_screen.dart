import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omwaytech/auth/bloc/login_bloc/login_bloc.dart';
import 'package:omwaytech/auth/ui/register_screen.dart';
import 'package:omwaytech/home/ui/home_screen.dart';
import 'package:omwaytech/utils/token.dart';
import 'package:omwaytech/utils/validation.dart';

import '../../constants/color_constant.dart';
import '../../utils/size.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void login() {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      BlocProvider.of<LoginBloc>(context).add(
        OnLoginEvent(
          password: _passwordController.text.trim(),
          email: _emailController.text,
          userName: _userNameController.text,
        ),
      );
    }
  }

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.padding! * 0.035),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.05,
                ),
                Icon(
                  Icons.album,
                  size: SizeConfig.padding! * 0.1,
                  color: primaryLightColor,
                ),
                Text(
                  'News App',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: primaryLightColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.05,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: shadowColor,
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.padding! * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.05,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: _userNameController,
                            validator: (value) => ValidationMixin()
                                .validateName(value!, title: "username"),
                            decoration: InputDecoration(
                              isDense: true,
                              //prefix: Text("+977"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  SizeConfig.padding! * 0.01,
                                ),
                              ),
                              hintText: "Enter your username",
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.01,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: (value) =>
                                ValidationMixin().validateEmail(value!),
                            decoration: InputDecoration(
                              isDense: true,
                              //prefix: Text("+977"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  SizeConfig.padding! * 0.01,
                                ),
                              ),
                              hintText: "Enter your email address",
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.01,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: _passwordController,
                            obscureText: visible,
                            validator: (value) =>
                                ValidationMixin().validatePassword(value!),
                            decoration: InputDecoration(
                              isDense: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visible = !visible;
                                  });
                                },
                                icon: Icon(visible
                                    ? Icons.visibility_sharp
                                    : Icons.visibility_off),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.padding! * 0.01),
                              ),
                              hintText: "Password",
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.01,
                          ),
                          InkWell(
                            onTap: () {},
                            splashColor: Colors.transparent,
                            child: Text(
                              'Forgot Password ?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.01,
                          ),
                          BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state is LoginErrorState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Credential Error"),
                                  ),
                                );
                              } else if (state is LoginSuccessState) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                        id: AccessToken.userId,
                                      ),
                                    ),
                                    (route) => false);
                              }
                            },
                            builder: (context, state) {
                              return state is LoginLoadingState
                                  ? const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        login();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(
                                          SizeConfig.screenWidth!,
                                          SizeConfig.screenHeight! * 0.05,
                                        ),
                                      ),
                                      child: Text(
                                        'Login',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.05,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New To Register?",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: textLightColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth! * 0.1,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Register Now",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: primaryLightColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
