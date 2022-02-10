import 'dart:convert';
import 'dart:developer';

class Json {
  dynamic data;
  late bool _isJunk = false;

  Json(this.data) {
    if (isString) data = decode();
  }

  Type get type {
    if (isMap) {
      return Map<String, dynamic>;
    } else {
      return data.runtimeType;
    }
  }

  bool get isNull => data == null;

  bool get isString => (data is String);

  set isJunk(val) {
    _isJunk = val;
  }

  bool get isJunk => _isJunk;

  bool get isList => (data is List);

  bool get isMap => (data is Map<String, dynamic>);

  bool get isEmpty {
    late bool _isEmpty;

    if (isNull) {
      _isEmpty = true;
    } else if (isJunk) {
      if (length == 0) {
        _isEmpty = true;
      } else {
        _isEmpty = false;
      }
    } else if (isList) {
      if ((data as List).isEmpty) {
        _isEmpty = true;
      } else {
        _isEmpty = false;
      }
    } else if (isMap) {
      if ((data as Map<String, dynamic>).isEmpty) {
        _isEmpty = true;
      } else {
        _isEmpty = false;
      }
    } else {
      _isEmpty = true;
    }

    return _isEmpty;
  }

  bool get isNotEmpty => !isEmpty;

  bool get isBlank {
    return toString().isEmpty;
  }

  int get length {
    late int _length;

    if (isNull) {
      _length = 0;
    } else if (isJunk) {
      _length = data.toString().length;
    } else if (isList) {
      if ((data as List).isEmpty) {
        _length = 0;
      } else {
        _length = (data as List).length;
      }
    } else if (isMap) {
      if ((data as Map<String, dynamic>).isEmpty) {
        _length = 0;
      } else {
        _length = map.length;
      }
    } else {
      _length = 0;
    }

    return _length;
  }

  List get list => isList ? (data as List) : [];

  Map<String, dynamic> get map => isMap ? (data as Map<String, dynamic>) : {};

  String encode() => json.encode(data);

  dynamic decode() {
    var _data = data;
    try {
      _data = json.decode(data);
      isJunk = false;
    } on FormatException catch (e) {
      log('{FormatException: ${e.message}, data: $data}');
      isJunk = true;
    }
    return _data;
  }

  @override
  String toString() => data.toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Json && runtimeType == other.runtimeType && data == other.data;

  @override
  int get hashCode => data.hashCode;
}
