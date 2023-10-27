extension EmailToId on String {
  String toId() {
    if (isEmpty) {
      return "";
    }

    var s = "";
    var i = 0;
    while (this[i] != '@') {
      if (this[i].toLowerCase() == this[i] &&
          this[i].contains(RegExp(r'[a-z0-9]'))) {
        s += this[i];
      }
      i++;
    }
    return s;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
            caseSensitive: false)
        .hasMatch(this);
  }
}
