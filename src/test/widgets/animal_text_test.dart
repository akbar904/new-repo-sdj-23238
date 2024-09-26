
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:cat_dog_switcher/cubits/animal_cubit.dart';
import 'package:cat_dog_switcher/widgets/animal_text.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

class FakeAnimalState extends Fake implements AnimalState {}

void main() {
	group('AnimalText Widget', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
			whenListen(
				animalCubit,
				Stream<AnimalState>.fromIterable([
					AnimalState(name: 'Cat', icon: Icons.access_time),
					AnimalState(name: 'Dog', icon: Icons.person),
				]),
				initialState: AnimalState(name: 'Cat', icon: Icons.access_time),
			);
		});

		testWidgets('displays Cat with a clock icon initially', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AnimalCubit>.value(
							value: animalCubit,
							child: AnimalText(),
						),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with a person icon when state changes', (WidgetTester tester) async {
			whenListen(
				animalCubit,
				Stream<AnimalState>.fromIterable([
					AnimalState(name: 'Dog', icon: Icons.person),
				]),
				initialState: AnimalState(name: 'Dog', icon: Icons.person),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AnimalCubit>.value(
							value: animalCubit,
							child: AnimalText(),
						),
					),
				),
			);

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('toggles state when text is tapped', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AnimalCubit>.value(
							value: animalCubit,
							child: AnimalText(),
						),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			verify(() => animalCubit.toggleAnimal()).called(1);
		});
	});
}
