import 'package:equatable/equatable.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Project> projects;
  final String? errorMessage;

  const HomeState({this.status = HomeStatus.initial, this.projects = const [], this.errorMessage});

  HomeState copyWith({HomeStatus? status, List<Project>? projects, String? errorMessage}) {
    return HomeState(status: status ?? this.status, projects: projects ?? this.projects, errorMessage: errorMessage);
  }

  @override
  List<Object?> get props => [status, projects, errorMessage];
}
