
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimalState {
	final String name;
	final IconData icon;

	AnimalState({required this.name, required this.icon});
}

class AnimalCubit extends Cubit<AnimalState> {
	AnimalCubit() : super(AnimalState(name: 'Cat', icon: Icons.access_time));

	void toggleAnimal() {
		final newState = state.name == 'Cat'
			? AnimalState(name: 'Dog', icon: Icons.person)
			: AnimalState(name: 'Cat', icon: Icons.access_time);
		emit(newState);
	}
}
