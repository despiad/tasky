String? validateTaskName(String? name) {
  if (name == null || name.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}
