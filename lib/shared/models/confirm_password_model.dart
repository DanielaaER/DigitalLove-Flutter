import 'package:formz/formz.dart';

enum ConfirmPasswordError { empty, invalid }

class ConfirmPassword extends FormzInput<String, ConfirmPasswordError> {
  final String password;

  const ConfirmPassword.pure(this.password) : super.pure('');
  const ConfirmPassword.dirty(this.password,String value) : super.dirty(value);

  @override
  ConfirmPasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return ConfirmPasswordError.empty;
    if (value != password) return ConfirmPasswordError.invalid;
    return null;
  }

  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == ConfirmPasswordError.empty ) return 'Ingrese su confirmacion de contraseña';
    if ( displayError == ConfirmPasswordError.invalid ) return 'Las contraseñas no coinciden';

    return null;
  }
}

