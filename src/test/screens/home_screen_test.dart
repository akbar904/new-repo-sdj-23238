
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_dog_switcher/screens/home_screen.dart';
import 'package:cat_dog_switcher/cubits/animal_cubit.dart';
import 'package:cat_dog_switcher/models/animal.dart';

// Mock class for AnimalCubit
class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('Initial state shows Cat with clock icon', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState(name: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>(
					create: (_) => animalCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('Tapping the text toggles to Dog with person icon', (WidgetTester tester) async {
			whenListen(
				animalCubit,
				Stream.fromIterable([
					AnimalState(name: 'Cat', icon: Icons.access_time),
					AnimalState(name: 'Dog', icon: Icons.person),
				]),
				initialState: AnimalState(name: 'Cat', icon: Icons.access_time),
			);

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>(
					create: (_) => animalCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
