class Validators {
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "Digite $fieldName";
    }
    return null;
  }

  static String? validateInt(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "Digite $fieldName";
    }
    if (int.tryParse(value) == null) {
      return "$fieldName deve ser um número";
    }
    return null;
  }

  static String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Digite a data de nascimento";
    }

    final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!regex.hasMatch(value)) {
      return "Use o formato dd/mm/aaaa";
    }

    try {
      final parts = value.split('/');
      final day = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);

      if (day == null || month == null || year == null) {
        return "Data inválida.";
      }

      final birthDate = DateTime(year, month, day);
      final now = DateTime.now();

      final minAgeDate = DateTime(now.year - 16, now.month, now.day);

      if (birthDate.isAfter(minAgeDate)) {
        return "A idade mínima é de 16 anos.";
      }
    } catch (e) {
      return "Data inválida.";
    }

    return null;
  }
}
