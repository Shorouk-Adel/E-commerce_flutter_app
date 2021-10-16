class CartModel {
  String _image;
  String _name;
  String _title;
  int _price;
  int _count;

  CartModel(this._image, this._name, this._title, this._price, this._count);

  void updateCount(int newCount){
    _count = newCount;
  }

  int get count => _count;

  set count(int value) {
    _count = value;
  }

  int get price => _price;

  set price(int value) {
    _price = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }
}