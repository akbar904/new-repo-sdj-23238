
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/animal_cubit.dart';
import 'screens/home_screen.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	final AnimalCubit animalCubit;

	MyApp({Key? key, AnimalCubit? animalCubit})
		: animalCubit = animalCubit ?? AnimalCubit(),
		  super(key: key);

	@override
	Widget build(BuildContext context) {
		return BlocProvider(
			create: (_) => animalCubit,
			child: MaterialApp(
				title: 'Cat Dog Switcher',
				home: HomeScreen(),
			),
		);
	}
}
