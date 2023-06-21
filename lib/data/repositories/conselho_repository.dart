import 'dart:convert';
import 'package:api/data/http/exception.dart';
import 'package:api/data/models/model_conselho.dart';
import '../http/http_client.dart';

abstract class IConselhoRepository {
  Future<ConselhoModel?> getConselhos();
}

class ConselhosRepository implements IConselhoRepository {
  final IHttpClient client;

  ConselhosRepository({required this.client});

  @override
  Future<ConselhoModel?> getConselhos() async {
    final response = await client.get(url: 'https://api.adviceslip.com/advice');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return ConselhoModel.fromJson(json);
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é valida');
    } else {
      throw Exception('Não foi possivel carregar um conselho');
    }
  }
}
