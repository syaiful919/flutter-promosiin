extension ExtendedString on String {
  String getExtension() => this.split('.').last.toLowerCase();

  String capitalizeSingleWord() =>
      this[0].toUpperCase() + this.substring(1).toLowerCase();

  String capitalize() {
    var split = this.trim().split(' ');
    String res = '';
    for (var i = 0; i < split.length; i++)
      res += split[i].capitalizeSingleWord() + ' ';
    return res;
  }

  String getFirstWord() => this.split(" ")[0];
}
