
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cat_dog_switcher/models/animal.dart';

void main() {
  group('Animal Model Tests', () {
    test('Animal model should correctly initialize with given name and icon', () {
      // Arrange
      const animalName = 'Cat';
      const animalIcon = Icons.access_time;

      // Act
      final animal = Animal(name: animalName, icon: animalIcon);

      // Assert
      expect(animal.name, animalName);
      expect(animal.icon, animalIcon);
    });

    test('Animal model should correctly convert to JSON', () {
      // Arrange
      const animalName = 'Dog';
      const animalIcon = Icons.person;
      final animal = Animal(name: animalName, icon: animalIcon);
      final expectedJson = {
        'name': animalName,
        'icon': animalIcon.codePoint,
      };

      // Act
      final json = animal.toJson();

      // Assert
      expect(json, expectedJson);
    });

    test('Animal model should correctly initialize from JSON', () {
      // Arrange
      const animalName = 'Dog';
      const animalIcon = Icons.person;
      final json = {
        'name': animalName,
        'icon': animalIcon.codePoint,
      };

      // Act
      final animal = Animal.fromJson(json);

      // Assert
      expect(animal.name, animalName);
      expect(animal.icon, animalIcon);
    });
  });
}
