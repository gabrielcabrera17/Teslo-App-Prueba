import 'package:formz/formz.dart';

enum UsernameError { empty, length }

class Username extends FormzInput<String, UsernameError> {
  const Username.pure() : super.pure('');
  const Username.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == UsernameError.empty) return 'El nombre es requerido';
    if (displayError == UsernameError.length) return 'Mínimo 3 caracteres';
    return null;
  }

  @override
  UsernameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return UsernameError.empty;
    if (value.trim().length < 3) return UsernameError.length;
    return null;
  }
}
