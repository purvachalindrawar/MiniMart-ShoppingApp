import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mini_mart/models/user.dart';

const _settingsBoxName = 'settingsBox';
const _authUserKey = 'authUser';
const _authPasswordKey = 'authPassword_demo';

class AuthState {
  const AuthState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  final User? user;
  final bool isLoading;
  final String? errorMessage;

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final box = Hive.box(_settingsBoxName);
  final storedUser = box.get(_authUserKey);
  final storedPassword = box.get(_authPasswordKey) as String?;

  User? initialUser;
  if (storedUser is Map) {
    initialUser = User.fromMap(storedUser);
  }

  return AuthNotifier(box, initialUser, storedPassword);
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._box, User? initialUser, this._storedPassword)
      : super(AuthState(user: initialUser));

  final Box _box;
  String? _storedPassword;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final user = User(
      id: email,
      name: name,
      email: email,
    );

    _storedPassword = password;
    await _box.put(_authUserKey, user.toMap());
    await _box.put(_authPasswordKey, password);

    state = AuthState(user: user, isLoading: false);
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final storedUser = _box.get(_authUserKey);
    final storedPassword = _storedPassword ??
        (_box.get(_authPasswordKey, defaultValue: null) as String?);

    if (storedUser is! Map || storedPassword == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No account found. Please create an account first.',
      );
      return;
    }

    final user = User.fromMap(storedUser);

    if (user.email != email || storedPassword != password) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Invalid email or password.',
      );
      return;
    }

    state = AuthState(user: user, isLoading: false);
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await Future<void>.delayed(const Duration(milliseconds: 200));

    state = const AuthState(user: null, isLoading: false);
  }
}
