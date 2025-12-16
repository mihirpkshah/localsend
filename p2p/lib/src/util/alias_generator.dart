import 'dart:math';

const _adj = [
  'Nice',
  'Cool',
  'Great',
  'Awesome',
  'Best',
  'Super',
  'Fast',
  'Big',
  'Small',
  'Red',
  'Blue',
  'Green',
  'Yellow',
  'Black',
  'White'
];

const _fruits = [
  'Apple',
  'Banana',
  'Cherry',
  'Date',
  'Elderberry',
  'Fig',
  'Grape',
  'Honeydew',
  'Kiwi',
  'Lemon',
  'Mango',
  'Nectarine',
  'Orange',
  'Papaya',
  'Quince'
];

String generateRandomAlias() {
  final random = Random();
  final adj = _adj[random.nextInt(_adj.length)];
  final fruit = _fruits[random.nextInt(_fruits.length)];
  return '$adj $fruit';
}
