

import 'package:scholar_chat/models/message.dart';

abstract class ChatSatates{}
class ChatInitial extends ChatSatates{}
class ChatSuccess extends ChatSatates{
  List<Message> messages=[];
  ChatSuccess({required this.messages});

}