import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/loading.dart';
import '../components/text_button.dart';
import '../components/text_form_field.dart';
import '../configs/colors.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  bool isLoggingOut = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Consumer<AuthService>(
        builder: (context, authService, child) {
          User user = authService.user!;

          _firstNameController.text = user.firstName.toString();
          _lastNameController.text = user.lastName.toString();
          _usernameController.text = user.username.toString();
          _emailController.text = user.email.toString();

          return Scaffold(
            appBar: AppBar(
              title: Image.asset(
                'assets/images/muvee.png',
                width: 18.w,
              ),
              centerTitle: true,
            ),
            body: Container(
              width: 100.w,
              padding: EdgeInsets.only(
                left: 5.w,
                right: 5.w,
                top: 2.h,
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Setting',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: quaternaryColor,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: MvTextFormField(
                              label: 'First Name',
                              controller: _firstNameController,
                              focusNode: _firstNameFocus,
                            ),
                          ),
                          SizedBox(width: 1.w),
                          Expanded(
                            child: MvTextFormField(
                              label: 'Last Name',
                              controller: _lastNameController,
                              focusNode: _lastNameFocus,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      MvTextFormField(
                        label: 'Username',
                        controller: _usernameController,
                        focusNode: _usernameFocus,
                      ),
                      SizedBox(height: 1.h),
                      MvTextFormField(
                        label: 'E-mail',
                        controller: _emailController,
                        focusNode: _emailFocus,
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: 100.w,
                        child: MvTextButton(
                          label: 'Log Out',
                          onPressed: () async {
                            setState(() {
                              isLoggingOut = true;
                            });

                            await authService.logout();

                            if (mounted) {
                              setState(() {
                                isLoggingOut = true;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  isLoggingOut
                      ? Container(
                          alignment: Alignment.center,
                          color: secondaryColor.withOpacity(0.5),
                          child: const Loading(),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
