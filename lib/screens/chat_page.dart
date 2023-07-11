import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/cubits/chat_cubit/chat_states.dart';
import 'package:scholar_chat/models/message.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  static String id = 'chatPage';
  final ScrollController _controller = ScrollController();


  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

            return Scaffold(
                appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/scholar.png',
                        height: 50,
                      ),
                      Text('Chat'),
                    ],
                  ),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<ChatCubit,ChatSatates>(

                        builder: (context,state) {
                          var messageList=BlocProvider.of<ChatCubit>(context).messageList;
                          return ListView.builder(
                              reverse: true,
                              controller: _controller,
                              itemCount: messageList.length,
                              itemBuilder: (context, index) {
                                return messageList[index].id == email
                                    ? ChatBubble(
                                  message: messageList[index],
                                )
                                    : ChatBubbleForFriend(
                                    message: messageList[index]);
                              });

                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        10,
                      ),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (data) {
                         BlocProvider.of<ChatCubit>(context).sendMessages(message:data,email: email!);
                          controller.clear();
                          _controller.animateTo(
                            0,
                            duration: Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                        decoration: InputDecoration(
                          hintText: 'Send Message',
                          suffix: Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          }
}
