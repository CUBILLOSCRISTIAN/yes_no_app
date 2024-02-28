import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/infrastructure/models/yes_no_model.dart';

class GetYesNoAnswer {
  final _dio = Dio();

  Future<Message> getYesNoAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    final YesNoModel yesNoModel = YesNoModel.fromJson(response.data);

    return Message(
      text: yesNoModel.answer,
      imageUrl: yesNoModel.image,
      fromWho: FromWho.hers,
    );
  }
}
