import 'package:todolist/src/data/model/tarefa_model.dart';

abstract class TarefaEvent {}

class GetTarefas extends TarefaEvent {}

class PostTarefa extends TarefaEvent {
  final TarefaModel tarefa;

  PostTarefa({required this.tarefa});
}

class DeleteTarefa extends TarefaEvent {
  final TarefaModel tarefa;

  DeleteTarefa({required this.tarefa});
}
