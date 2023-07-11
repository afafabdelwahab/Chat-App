

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/bloc/auth_bloc/auth_events.dart';
import 'package:scholar_chat/bloc/auth_bloc/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents,AuthStates>{
  AuthBloc() : super(AuthInitial()){
    on<AuthEvents>((event, emit)async{
      if (event is LoginEvent){
        emit(LoginLoading());
        try{
          UserCredential user= await FirebaseAuth.instance.signInWithEmailAndPassword(email: event.email, password:event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'user-not-found') {
            emit(LoginFailure(errorMessage: 'user not found'));
          } else if (ex.code == 'wrong-password') {
            emit(LoginFailure(errorMessage: 'wrong password'));
          }
        } catch(ex){
          emit(LoginFailure(errorMessage: 'something wrong'));
        }
      }

      else if(event is RegisterEvent){
        emit(RegisterLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: event.email!, password: event.password!);
          emit(RegisterSuccess());
        }on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(RegisterFailure(errorMessage: 'weak-password'));
          } else if (ex.code == 'email-already-in-use') {
            emit(RegisterFailure(errorMessage:'email-already-in-use'));
          }
        }
        catch(ex){
          emit(RegisterFailure(errorMessage: 'there was an error '));
        }
      }



    });
  }



}