import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/loading.dart';
import '../components/text_button.dart';
import '../components/text_form_field.dart';
import '../configs/colors.dart';
import '../services/auth_service.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String? error;

  bool isLoginIn = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        color: secondaryColor,
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 1.h,
              ),
              child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/muvee.png',
                              width: 35.w,
                            ),
                            SizedBox(height: 1.5.h),
                            const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            MvTextFormField(
                              label: 'E-mail',
                              controller: _emailController,
                              focusNode: _emailFocus,
                              inputType: TextInputType.emailAddress,
                              validator: (email) =>
                                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(email.toString())
                                      ? null
                                      : 'E-mail is not valid',
                            ),
                            SizedBox(height: 2.h),
                            MvTextFormField(
                              label: 'Password',
                              controller: _passwordController,
                              focusNode: _passwordFocus,
                              inputType: TextInputType.text,
                              isObscured: true,
                              validator: (password) => password
                                          .toString()
                                          .isEmpty ||
                                      password.toString().length < 6
                                  ? 'Password should atleast 6 characters long'
                                  : null,
                            ),
                            SizedBox(height: 3.5.h),
                            error == null
                                ? const SizedBox.shrink()
                                : Column(
                                    children: [
                                      Text(
                                        error.toString(),
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                      SizedBox(height: 0.5.h),
                                    ],
                                  ),
                            SizedBox(
                              width: 100.w,
                              child: MvTextButton(
                                label: 'Login',
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    isLoginIn = true;
                                  });

                                  if (_formKey.currentState!.validate()) {
                                    AuthService authService =
                                        Provider.of(context, listen: false);
                                    String? error = await authService.login(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );

                                    if (error != null) {
                                      if (mounted) {
                                        setState(() {
                                          this.error = error;
                                        });
                                      }
                                    }
                                  }

                                  if (mounted) {
                                    setState(() {
                                      isLoginIn = false;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 1.h),
                            SizedBox(
                              width: 100.w,
                              child: MvTextButton(
                                label: 'Register',
                                isOutlined: true,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    isLoginIn
                        ? Container(
                            color: secondaryColor.withOpacity(0.5),
                            child: const Loading(),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
