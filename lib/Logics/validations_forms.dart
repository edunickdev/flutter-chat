class FormValidations {
  Object SignInSignupValidations(String value){
    String? value;

    if(value!.isEmpty || !value.contains('@')){
      return 'Please insert correct information';
    }
    return Future.delayed(const Duration(seconds: 5));
  }
}
