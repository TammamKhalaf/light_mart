import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_mart/layout/shop_layout.dart';
import 'package:light_mart/modules/login/cubit/cubit.dart';
import 'package:light_mart/modules/login/cubit/states.dart';
import 'package:light_mart/modules/register/register_screen.dart';
import 'package:light_mart/shared/components/component_s.dart';
import 'package:light_mart/shared/components/constants.dart';
import 'package:light_mart/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            //logged in
            if (state.loginModel.status) {
              //go to home screen
              print(state.loginModel.data);
              print(state.loginModel.message);
              print('token is ${state.loginModel.data.token}');
              CacheHelper.saveData('token', state.loginModel.data.token)
                  .then((value) {
                    token = state.loginModel.data.token;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ShopLayout()),
                    (Route<dynamic> route) => false);
              });
            } else {
              //error
              print(state.loginModel.message);
              showToast(
                  msg: state.loginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login',
                            style: Theme.of(context).textTheme.headline5),
                        Text('login now to browse our hot offers',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                    )),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: Icons.email_outlined,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                            }), //defaultFormField email address
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: LoginCubit.get(context).suffix,
                            onSubmit: (value) {
                              if (formkey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isPassword: LoginCubit.get(context).isPassword,
                            suffixPressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            label: 'Password',
                            prefix: Icons.lock_outlined,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter valid password';
                              }
                            }), //defaultFormField Password address
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                            text: 'Login',
                            function: () {
                              if (formkey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: const CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              RegisterScreen()));
                                },
                                child: Text('Register'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
