import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/src/data/bloc/tarefa_event.dart';
import 'package:todolist/src/data/bloc/tarefa_state.dart';
import 'package:todolist/src/data/model/tarefa_model.dart';

import '../data/bloc/tarefa_bloc.dart';

class TarefasPages extends StatefulWidget {
  const TarefasPages({super.key});

  @override
  State<TarefasPages> createState() => _TarefasPagesState();
}

class _TarefasPagesState extends State<TarefasPages> {
  late final TarefaBloc _tarefaBloc;

  @override
  void initState() {
    super.initState();
    _tarefaBloc = TarefaBloc();
    _tarefaBloc.add(GetTarefas());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Exemple Bloc')),
        body: BlocBuilder<TarefaBloc, TarefaState>(
            bloc: _tarefaBloc,
            builder: (context, state) {
              if (state is TarefaLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TarefaLoadedState) {
                final list = state.tarefas;
                return ListView.separated(
                    separatorBuilder: (_, __) => const Divider(),
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Center(
                            child: Text(list[index].nome[0]),
                          ),
                        ),
                        title: Text(list[index].nome),
                        trailing: IconButton(
                          onPressed: () {
                            _tarefaBloc.add(DeleteTarefa(tarefa: list[index]));
                          },
                          icon: const Icon(
                            Icons.delete_rounded,
                            color: Colors.red,
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text('Error'),
                );
              }
            }),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _tarefaBloc.add(PostTarefa(tarefa: TarefaModel(nome: 'Pedalar')));
          },
        ));
  }

  @override
  void dispose() {
    _tarefaBloc.close();
    super.dispose();
  }
}
