import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rebuild_counter_provider.g.dart';

class CounterData {
  final int countA;
  final int countB;

  const CounterData({this.countA = 0, this.countB = 0});

  CounterData copyWith({int? countA, int? countB}) {
    return CounterData(
      countA: countA ?? this.countA,
      countB: countB ?? this.countB,
    );
  }
}

@riverpod
class CounterDataNotifier extends _$CounterDataNotifier {
  @override
  CounterData build() => const CounterData();

  void incrementA() {
    state = state.copyWith(countA: state.countA + 1);
  }

  void incrementB() {
    state = state.copyWith(countB: state.countB + 1);
  }
}
