import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/loading.dart';
import '../components/text_button.dart';
import '../components/text_form_field.dart';
import '../configs/colors.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String? error;

  bool isRegistering = false;

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
                              'Registration',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              children: [
                                Expanded(
                                  child: MvTextFormField(
                                    label: 'First Name',
                                    controller: _firstNameController,
                                    focusNode: _firstNameFocus,
                                    inputType: TextInputType.name,
                                    validator: (name) =>
                                        name == null || name.isEmpty
                                            ? 'Please enter first name'
                                            : null,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: MvTextFormField(
                                    label: 'Last Name',
                                    controller: _lastNameController,
                                    focusNode: _lastNameFocus,
                                    inputType: TextInputType.name,
                                    validator: (name) =>
                                        name == null || name.isEmpty
                                            ? 'Please enter last name'
                                            : null,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            MvTextFormField(
                              label: 'Username',
                              controller: _usernameController,
                              focusNode: _usernameFocus,
                              inputType: TextInputType.text,
                              validator: (username) =>
                                  username == null || username.isEmpty
                                      ? 'Please enter username'
                                      : null,
                            ),
                            SizedBox(height: 1.h),
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
                            SizedBox(height: 1.h),
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
                                label: 'Register',
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    isRegistering = true;
                                  });

                                  if (_formKey.currentState!.validate()) {
                                    AuthService authService =
                                        Provider.of(context, listen: false);
                                    String? error = await authService.register(
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
                                      username: _usernameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );

                                    if (error != null) {
                                      if (mounted) {
                                        setState(() {
                                          this.error = error;
                                        });
                                      }
                                    } else {
                                      if (mounted) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  }

                                  if (mounted) {
                                    setState(() {
                                      isRegistering = false;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 1.h),
                            SizedBox(
                              width: 100.w,
                              child: MvTextButton(
                                label: 'Login',
                                isOutlined: true,
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    isRegistering
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
