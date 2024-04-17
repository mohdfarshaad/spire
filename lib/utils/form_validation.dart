class FormValidate{

  final String? value;

  const FormValidate({this.value});

  String? validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'cant be empty';
    }
    return null;
  }
}