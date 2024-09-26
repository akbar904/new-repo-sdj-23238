
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:cat_dog_switcher/main.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('Main App Tests', () {
		late AnimalCubit mockAnimalCubit;

		setUp(() {
			mockAnimalCubit = MockAnimalCubit();
		});

		testWidgets('Displays initial text and icon', (WidgetTester tester) async {
			when(() => mockAnimalCubit.state).thenReturn(AnimalState(name: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(MyApp(animalCubit: mockAnimalCubit));

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('Toggles text and icon on tap', (WidgetTester tester) async {
			whenListen(
				mockAnimalCubit,
				Stream.fromIterable([AnimalState(name: 'Dog', icon: Icons.person)]),
				initialState: AnimalState(name: 'Cat', icon: Icons.access_time),
			);

			await tester.pumpWidget(MyApp(animalCubit: mockAnimalCubit));

			await tester.tap(find.text('Cat'));
			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
