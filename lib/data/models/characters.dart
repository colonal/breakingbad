class Character {
  late int charId;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String statusIfDeladorAlive;
  late List<dynamic> appearanceOfSeasons;
  late String acotrName;
  late String categoryForTwoseries;
  late List<dynamic> betterCallSaulAppearance;
  Character.fromJson(Map<String, dynamic> json) {
    charId = json["char_id"];
    name = json["name"];
    nickName = json["nickname"];
    image = json["img"];
    jobs = json["occupation"];
    statusIfDeladorAlive = json["status"];
    appearanceOfSeasons = json["appearance"];
    acotrName = json["portrayed"];
    categoryForTwoseries = json["category"];
    betterCallSaulAppearance = json["better_call_saul_appearance"];
  }
}
