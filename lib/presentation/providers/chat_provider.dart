import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [];

//This method is used to send a message
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessagge = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessagge);

    if (text.endsWith('?')) {
      herReply();
    }

    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getYesNoAnswer();

    messageList.add(herMessage);
    notifyListeners();
    moveScrollToBottom();
  }

//This method is used to move the scroll to the bottom of the chat
  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  } //...
}
