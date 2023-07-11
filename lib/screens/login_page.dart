import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/bloc/auth_bloc/auth_bloc.dart';
import 'package:scholar_chat/bloc/auth_bloc/auth_events.dart';
import 'package:scholar_chat/bloc/auth_bloc/auth_states.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/cubits/login_cubit/login_cubit.dart';

import 'package:scholar_chat/screens/chat_page.dart';
import 'package:scholar_chat/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholar_chat/widgets/custom_button.dart';

import '../helper/show_snack.dart';
import '../widgets/custom text_field .dart';



class LoginPage extends StatelessWidget {
  String? email;

  String? password;
  static String id = 'loginPage';
  bool isLoading = false;

  GlobalKey<FormState> fromKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc,AuthStates>(
      listener: (context,state){
        if (state is LoginLoading){
          isLoading=true;
        }else if (state is LoginSuccess){
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id,arguments: email);
          isLoading=false;
        }else if(state is LoginFailure){
          showSnackBar(context,state.errorMessage);
          isLoading=false;
        }
      },
      child: ModalProgressHUD(
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
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                    CustomFormTextField(
                      hint: 'Email',
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                    CustomFormTextField(
                      obscureText: true,
                      hint: 'Password',
                      onChanged: (data) {
                        password = data;
                      },
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    CustomButton(
                        onPressed: () async {
                          if (fromKey.currentState!.validate()) {
                           BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: email!, password: password!));
                          } else {}
                        },
                        text: 'Login'),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'don\'t have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: Text(
                            '   Register',
                            style: TextStyle(color: Color(0xffC7EDE6)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
