import 'package:equatable/equatable.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';

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

class UpdateProject extends HomeEvent {
  final Project project;

  const UpdateProject(this.project);

  @override
  List<Object?> get props => [project];
}
