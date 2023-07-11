import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/bloc/auth_bloc/auth_bloc.dart';
import 'package:scholar_chat/bloc/auth_bloc/auth_events.dart';
import 'package:scholar_chat/bloc/auth_bloc/auth_states.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/register_cubit/register_cubit.dart';

import 'package:scholar_chat/screens/chat_page.dart';

import '../helper/show_snack.dart';
import '../widgets/custom text_field .dart';
import '../widgets/custom_button.dart';

class RegisterPage extends StatelessWidget {
  String? email;

  String? password;
  static String id = 'RegisterPage';
  bool isLoading = false;

  GlobalKey<FormState> fromKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc,AuthStates>(
      listener:(context,state){
        if (state is RegisterLoading){
          isLoading=true;
        }else if (state is RegisterSuccess){
          Navigator.pushNamed(context, ChatPage.id);
          isLoading=false;
        }else if(state is RegisterFailure){
          showSnackBar(context,state.errorMessage);
          isLoading=false;
        }
      },
      builder:(context,state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: fromKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scholar chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                  CustomFormTextField(
                      onChanged: (data) {
                        email = data;
                      },
                      hint: 'Email'),
                  CustomFormTextField(
                      obscureText: true,
                      onChanged: (data) {
                        password = data;
                      },
                      hint: 'Password'),
                  SizedBox(
                    height: 70,
                  ),
                  CustomButton(
                    onPressed: () async {
                      if (fromKey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context).add(RegisterEvent(email: email!, password: password!));
                      } else {}
                    },
                    text: 'Register',
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'already have an account',
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          '   Login',
                          style: TextStyle(color: Color(0xffC7EDE6)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
