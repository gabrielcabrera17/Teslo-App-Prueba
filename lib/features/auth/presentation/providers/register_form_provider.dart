

// Paso 1 - crear el estado (state del provider)

import 'package:flutter_riverpod/legacy.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class RegisterFormState {

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Username username;
  final Email email;
  final Password password;
  final RepeatPassword repeatPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.repeatPassword = const RepeatPassword.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Username? username,
    Email? email,
    Password? password,
    RepeatPassword? repeatPassword,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    username: username ?? this.username,
    email: email ?? this.email,
    password: password ?? this.password,
    repeatPassword: repeatPassword ?? this.repeatPassword,
  );

  @override
  String toString() {
    return '''
      RegisterFormState:
        isPosting: $isPosting,
        isFormPosted: $isFormPosted,
        isValid: $isValid,
        username: $username,
        email: $email,
        password: $password,
        repeatPassword: $repeatPassword
    ''';
  }
}


// Paso 2 - Cómo implementamos un notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier() : super(RegisterFormState());

  onUsernameChange(String value) {
    final newUsername = Username.dirty(value);
    state = state.copyWith(
      username: newUsername,
      isValid: Formz.validate([newUsername, state.email, state.password, state.repeatPassword]),
    );
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.username, state.password, state.repeatPassword]),
    );
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    final newRepeatPassword = RepeatPassword.dirty(state.repeatPassword.value, value);
    state = state.copyWith(
      password: newPassword,
      repeatPassword: newRepeatPassword,
      isValid: Formz.validate([newPassword, newRepeatPassword, state.email, state.username]),
    );
  }

  onRepeatPasswordChange(String value) {
    final newRepeatPassword = RepeatPassword.dirty(value, state.password.value);
    state = state.copyWith(
      repeatPassword: newRepeatPassword,
      isValid: Formz.validate([newRepeatPassword, state.password, state.email, state.username]),
    );
  }

  onFormSubmit() {
    _touchEveryField();
    if (!state.isValid) return;
    print(state);
  }

  _touchEveryField() {
    final username = Username.dirty(state.username.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final repeatPassword = RepeatPassword.dirty(state.repeatPassword.value, state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      username: username,
      email: email,
      password: password,
      repeatPassword: repeatPassword,
      isValid: Formz.validate([username, email, password, repeatPassword]),
    );
  }
}

// Paso 3 - Cómo vamos a construir ese provider (StateNotifierProvider -> Esto se cosnume afuera)

final registerFormProvider = StateNotifierProvider<RegisterFormNotifier, RegisterFormState>((ref) {
  return RegisterFormNotifier();
});
