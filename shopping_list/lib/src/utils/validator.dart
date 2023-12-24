class Validator {
  final String text;

  Validator(this.text);

  static String? isRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório!';
    }
    return null; // Retornar null indica que a validação foi bem-sucedida
  }
}
