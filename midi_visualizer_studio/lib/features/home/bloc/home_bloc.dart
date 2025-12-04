import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midi_visualizer_studio/data/repositories/project_repository.dart';
import 'package:midi_visualizer_studio/data/models/project.dart';
import 'package:midi_visualizer_studio/features/home/bloc/home_event.dart';
import 'package:midi_visualizer_studio/features/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProjectRepository _projectRepository;

  HomeBloc({required ProjectRepository projectRepository})
    : _projectRepository = projectRepository,
      super(const HomeState()) {
    on<LoadProjects>(_onLoadProjects);
    on<DeleteProject>(_onDeleteProject);
    on<UpdateProject>(_onUpdateProject);
  }

  Future<void> _onUpdateProject(UpdateProject event, Emitter<HomeState> emit) async {
    try {
      await _projectRepository.saveProject(event.project);
      add(const LoadProjects());
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to update project: $e'));
    }
  }

  Future<void> _onLoadProjects(LoadProjects event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final projects = await _projectRepository.getProjects();
      print('HomeBloc: Loaded ${projects.length} projects');
      emit(state.copyWith(status: HomeStatus.success, projects: projects));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onDeleteProject(DeleteProject event, Emitter<HomeState> emit) async {
    try {
      await _projectRepository.deleteProject(event.id);
      add(const LoadProjects());
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to delete project: $e'));
    }
  }
}
