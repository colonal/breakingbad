class Quoste {
  late String quote;

  Quoste.fromJason(Map<String, dynamic> json) {
    quote = json["quote"];
  }
}
