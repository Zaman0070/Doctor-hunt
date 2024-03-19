var regEx = RegExp(
    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
RegExp numReg = RegExp(r'.*[0-9].*');
RegExp phoneNumReg =
    RegExp(r'^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');
RegExp letterReg = RegExp(r'.*[A-Za-z].*');

String? emailValidator(String? value) {
  if (!regEx.hasMatch(value!)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? isValidInstagramHandle(String? handle) {
  RegExp regex = RegExp(r'^[a-zA-Z0-9._]{1,30}$');
  if (!regex.hasMatch(handle!)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? uNameValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter your user name';
  }
  if (value.length > 25) {
    return 'Exceeded 25 characters';
  }
  return null;
}

String? dSpecialValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter your speciality';
  }
  if (value.length > 25) {
    return 'Exceeded 15 characters';
  }
  return null;
}

String? dTotalExpValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter your total experience';
  }
  if (value.length > 25) {
    return 'Exceeded 15 characters';
  }
  return null;
}

String? dDetailValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter your total experience';
  }
  if (value.length > 1000) {
    return 'Exceeded 1000 characters';
  }
  return null;
}

String? countryValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter your country';
  }
  return null;
}

String? sectionValidator(String? value) {
  if (value!.isEmpty) {
    return 'Can\'t be empty';
  }
  return null;
}

String? cityValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter your City';
  }
  return null;
}

String? addressValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter a Valid Address';
  }
  return null;
}

String? passValidator(String? value) {
  if (value!.length < 6) {
    return 'Can not have less than 6 characters';
  }
  return null;
}

String? phoneValidator(String? value) {
  // Use this regex to validate phone numbers without a country code
  final RegExp phoneRegex = RegExp(r'^\d{3}-\d{3}-\d{4}$');

  if (value == null || !phoneRegex.hasMatch(value)) {
    return 'Enter a valid phone number';
  }

  return null;
}
