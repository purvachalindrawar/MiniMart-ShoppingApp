import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

const _settingsBoxName = 'settingsBox';
const _onboardingKey = 'onboardingCompleted';

final onboardingCompletedProvider =
    StateNotifierProvider<OnboardingNotifier, bool>((ref) {
  final box = Hive.box(_settingsBoxName);
  final stored = box.get(_onboardingKey, defaultValue: false) as bool;
  return OnboardingNotifier(box, stored);
});

class OnboardingNotifier extends StateNotifier<bool> {
  OnboardingNotifier(this._box, bool initial) : super(initial);

  final Box _box;

  void completeOnboarding() {
    state = true;
    _box.put(_onboardingKey, true);
  }
}
