


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/chat_cubit/chat_states.dart';
import 'package:scholar_chat/models/message.dart';

class ChatCubit extends Cubit<ChatSatates>{
  ChatCubit() : super(ChatInitial());

  List<Message> messageList=[];
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollection);
  void sendMessages ({required String message,required String email}){
    messages.add({kMessage: message, kCreatedAt: DateTime.now(), 'id': email,});
  }
  void getMessages(){
    messages.orderBy(kCreatedAt, descending: true,).snapshots().listen((event) {
    messageList.clear();
     for (var doc in event.docs){
       messageList.add(Message.fromJson(doc));
     }
     print('success');
      emit(ChatSuccess(messages: messageList));
    });
}

}