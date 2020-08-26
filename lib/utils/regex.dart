final RegExp emailRegExp = RegExp(
  r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
);

final RegExp phoneRegExp = RegExp(r'^\d{10,}$');

final RegExp numberRegExp = RegExp(r'^[0-9]*$');
