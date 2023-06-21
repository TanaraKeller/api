import 'package:api/data/repositories/conselho_repository.dart';
import 'package:flutter/cupertino.dart';
import '../../data/http/exception.dart';
import '../../data/models/model_conselho.dart';

class ConselhoStore {
  final ConselhosRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  final ValueNotifier<ConselhoModel?> state = ValueNotifier<ConselhoModel?>(null);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ConselhoStore({required this.repository});

  Future getConselhos() async {
    isLoading.value = true;

    try {
      final result = await repository.getConselhos();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
