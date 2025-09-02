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

  static String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Digite a data";
    }
    final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$'); // dd/mm/aaaa
    if (!regex.hasMatch(value)) {
      return "Use o formato dd/mm/aaaa";
    }
    return null;
  }
}
