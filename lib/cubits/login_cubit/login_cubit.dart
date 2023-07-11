import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/cubits/login_cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitial());


  Future <void> loginUser({required String email,required String password}) async{
    emit(LoginLoading());
    try{
      UserCredential user= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
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



}}