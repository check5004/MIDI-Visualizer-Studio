import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadProjects extends HomeEvent {
  const LoadProjects();
}

class DeleteProject extends HomeEvent {
  final String id;

  const DeleteProject(this.id);

  @override
  List<Object?> get props => [id];
}
