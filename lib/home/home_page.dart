import 'package:api/data/models/model_conselho.dart';
import 'package:api/data/repositories/conselho_repository.dart';
import 'package:api/home/stores/conselho_store.dart';
import 'package:flutter/material.dart';
import '../data/http/http_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ConselhoStore store = ConselhoStore(
    repository: ConselhosRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    store.getConselhos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Center(
          child: Text(
            'Conselho do dia',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.isLoading,
          store.erro,
          store.state,
        ]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (store.erro.value.isNotEmpty) {
            return Center(
              child: Text(
                store.erro.value,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (store.state.value == null) {
            return const Center(
              child: Text(
                'Nenhum conselho encontrado',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            ConselhoModel item = store.state.value!;
            return Center(
              child: Text(
                item.slip.advice,
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                    fontFamily: AutofillHints.birthday),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
