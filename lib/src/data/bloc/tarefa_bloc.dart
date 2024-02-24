import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todolist/src/data/bloc/tarefa_event.dart';
import 'package:todolist/src/data/bloc/tarefa_state.dart';
import 'package:todolist/src/data/model/tarefa_model.dart';
import 'package:todolist/src/data/repositories/tarefa_repository.dart';

class TarefaBloc extends Bloc<TarefaEvent, TarefaState> {
  final _repository = TarefaRepository();

  TarefaBloc() : super(TarefaInitialState()) {
    on(_mapEventToState);
  }

  void _mapEventToState(TarefaEvent event, Emitter emit) async {
    List<TarefaModel> tarefas = [];

    emit(TarefaLoadingState());

    if (event is GetTarefas) {
      tarefas = await _repository.getTarefas();
    } else if (event is PostTarefa) {
      tarefas = await _repository.postTarefa(tarefa: event.tarefa);
    } else if (event is DeleteTarefa) {
      tarefas = await _repository.deleteTarefa(tarefa: event.tarefa);
    }

    emit(TarefaLoadedState(tarefas: tarefas));
  }
}
