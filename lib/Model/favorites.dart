class Favorites {
  int _id;
  String _imageUrl;
  String _avmName;
  String _brandName;
  String _info;
  String _stars;
  String _title;

  int get id => _id;

  set id(int value) => _id = value;

  String get imageUrl => _imageUrl;

  set imageUrl(String value) => _imageUrl = value;

  String get avmName => _avmName;

  set avmName(String value) => _avmName = value;

  String get brandName => _brandName;

  set brandName(String value) => _brandName = value;

  String get info => _info;

  set info(String value) => _info = value;

  String get stars => _stars;

  set stars(String value) => _stars = value;

  String get title => _title;

  set title(String value) => _title = value;

  Favorites(this._imageUrl, this._avmName, this._brandName, this._info,
      this._stars, this._title);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = _id;
    map["image_url"] = _imageUrl;
    map["avm_name"] = _avmName;
    map["brand_name"] = _brandName;
    map["info"] = _info;
    map["stars"] = _stars;
    map["title"] = _title;

    return map;
  }

  Favorites.fromMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._imageUrl = map["image_url"];
    this._avmName = map["avm_name"];
    this._brandName = map["brand_name"];
    this._info = map["info"];
    this._stars = map["stars"];
    this._title = map["title"];
  }

  @override
  String toString() {
    return "Favorites(_id: $_id\n, _imageUrl $_imageUrl\n )";
  }
}
