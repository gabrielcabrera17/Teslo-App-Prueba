import 'package:formz/formz.dart';

enum RepeatPasswordError { empty, mismatch }

class RepeatPassword extends FormzInput<String, RepeatPasswordError> {
  final String originalPassword;

  const RepeatPassword.pure()
      : originalPassword = '',
        super.pure('');

  const RepeatPassword.dirty(String value, this.originalPassword)
      : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == RepeatPasswordError.empty) return 'El campo es requerido';
    if (displayError == RepeatPasswordError.mismatch) return 'Las contraseñas no coinciden';
    return null;
  }

  @override
  RepeatPasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return RepeatPasswordError.empty;
    if (value != originalPassword) return RepeatPasswordError.mismatch;
    return null;
  }
}
