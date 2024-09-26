
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cat_dog_switcher/cubits/animal_cubit.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is AnimalState with name "Cat" and clock icon', () {
			expect(animalCubit.state.name, 'Cat');
			expect(animalCubit.state.icon, Icons.access_time);
		});

		blocTest<AnimalCubit, AnimalState>(
			'emits AnimalState with name "Dog" and person icon when toggleAnimal is called from initial state',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [AnimalState(name: 'Dog', icon: Icons.person)],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits AnimalState with name "Cat" and clock icon when toggleAnimal is called from Dog state',
			build: () => animalCubit,
			seed: () => AnimalState(name: 'Dog', icon: Icons.person),
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [AnimalState(name: 'Cat', icon: Icons.access_time)],
		);
	});
}
