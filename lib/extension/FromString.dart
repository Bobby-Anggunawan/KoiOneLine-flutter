extension FromString on String{

  /// Kalau misalnya isi string "IkanAsinGoreng", fungsi ini akan mereturn "Ikan Asin Goreng"
  String get koiAddSpaceBetweenEachCapital{

    String value = this;

    String ret = "";
    value.split('').forEach((ch){
      if(ch == ch.toUpperCase()){
        ret = ret+" ";
      }
      ret = ret+ch;
    });

    return ret;
  }

  /// apa string ini mengandung character lain selain whitespace (spaces, tabs atau line breaks)
  bool get koiIsOnlyWhitespace{
    if(this.trim().isEmpty){
      return true;
    }
    else{
      return false;
    }
  }

  /// buat semua awal kata jadi kapital. "ikan asin" jadi "Ikan Asin"
  String get koiCapitalEachWord{
    String ret = "";
    this.split(" ").forEach((element) {
      var elementPros = element.toLowerCase();
      if(elementPros.length > 0){

        elementPros = elementPros.replaceFirst(elementPros[0], elementPros[0].toUpperCase());
      }

      if(ret == ""){
        ret = elementPros;
      }
      else{
        ret += " ${elementPros}";
      }
    });

    return ret;
  }
}