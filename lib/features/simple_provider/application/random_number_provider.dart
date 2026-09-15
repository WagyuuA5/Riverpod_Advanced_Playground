import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'random_number_provider.g.dart';

@riverpod
int randomNumber(RandomNumberRef ref) {
  ref.onDispose(() {
    debugPrint('randomNumberProvider di-dispose!');
  });

  return Random().nextInt(1000);
}
