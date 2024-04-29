extension StringExtension on String {
  bool isValidEmail() => RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(this);

  bool isValidPhoneNumber() => RegExp(r'^[0-9]{10}$').hasMatch(this);

  // Password must be at least 8 characters long and contain at least one lowercase letter
  bool isPasswordValid() => RegExp(r'^(?=.*[a-z]).{8,}$').hasMatch(this);

  // English text validation
  bool containEnglish() => RegExp(r'[a-zA-Z]').hasMatch(this);

  // Arabic text validation
  bool containArabic() => RegExp(r'[\u0600-\u06FF]').hasMatch(this);

  //Capitalize first letter
  String get capitalizeFirstLetter {
    if(length ==1) {
      return toUpperCase();
    } else if(length < 1) {
      return '';
    }else {
      return this[0].toUpperCase() + substring(1);
    }
  }
}
