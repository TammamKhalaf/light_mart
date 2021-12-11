import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_mart/layout/cubit/cubit.dart';
import 'package:light_mart/layout/cubit/states.dart';
import 'package:light_mart/shared/components/component_s.dart';
import 'package:light_mart/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) =>
            {if (state is ShopSuccessUserDataStates) {}},
        builder: (context, state) {
          var usermodel = ShopCubit.get(context).userModel;
          nameController.text = usermodel!.data.name;
          emailController.text = usermodel.data.email;
          phoneController.text = usermodel.data.phone;

          return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) => Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      label: 'Name',
                      prefix: Icons.person,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email Address',
                      prefix: Icons.email,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone',
                      prefix: Icons.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  //button
                  defaultButton(
                      function: () {
                        signout(context);
                      },
                      text: 'Logout')
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }
}
