

// Paso 1 - crear el estado (state del provider)

import 'package:teslo_shop/features/shared/shared.dart';

class LoginFormState{

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false, 
    this.isFormPosted = false, 
    this.isValid = false, 
    this.email = const Email.pure(), 
    this.password = const Password.pure()
  });
}


// Paso 2 - Cómo implementamos un notifier

// Paso 3 - Cómo vamos a construir ese provider (StateNotifierProvider -> Esto se cosnume afuera)