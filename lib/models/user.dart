class User {
  String _id;
  String _name;
  String _email;
  String _url;

  String get id => _id;

  String get name => _name;

  String get email => _email;

  String get url => _url;

  User(this._id, this._name, this._email, this._url);

  User.map(var data) {
    this._id = data['id'];
    this._name = data['name'];
    this._email = data['email'];
    this._url = data['picture']['data']['url'];
  }

  @override
  String toString() {
    return 'User{_id: $_id, _name: $_name, _email: $_email, _url: $_url}';
  }
}
