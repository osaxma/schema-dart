import 'package:collection/collection.dart';
import 'dart:convert';

class ReadTablesTest {
  const ReadTablesTest({
    this.bl,
    this.ja,
    this.j,
    this.v,
    this.ta,
    this.da,
    required this.s,
    this.bia,
    this.dt,
    this.tsz,
    this.ia,
    this.ts,
    this.i,
    this.va,
    required this.bs,
    this.ba,
    this.jj,
    this.t,
    this.d,
    this.u,
    this.bi,
    this.f,
    this.si,
  });

  factory ReadTablesTest.fromMap(Map<String, dynamic> map) {
    return ReadTablesTest(
      bl: map['bl'],
      ja: map['ja'] == null ? null : List<Object>.from(map['ja']),
      j: map['j'],
      v: map['v'],
      ta: map['ta'] == null ? null : List<String>.from(map['ta']),
      da: map['da'] == null ? null : List<double>.from(map['da']),
      s: map['s'].toInt(),
      bia: map['bia'] == null ? null : List<int>.from(map['bia']),
      dt: DateTime.tryParse(map['dt'] ?? ""),
      tsz: DateTime.tryParse(map['tsz'] ?? ""),
      ia: map['ia'] == null ? null : List<int>.from(map['ia']),
      ts: DateTime.tryParse(map['ts'] ?? ""),
      i: map['i']?.toInt(),
      va: map['va'] == null ? null : List<String>.from(map['va']),
      bs: map['bs'].toInt(),
      ba: map['ba'] == null ? null : List<bool>.from(map['ba']),
      jj: map['jj'],
      t: map['t'],
      d: map['d']?.toDouble(),
      u: map['u'],
      bi: map['bi']?.toInt(),
      f: map['f']?.toDouble(),
      si: map['si']?.toInt(),
    );
  }

  factory ReadTablesTest.fromJson(String source) => ReadTablesTest.fromMap(json.decode(source));

  final bool? bl;

  final List<Object>? ja;

  final Object? j;

  final String? v;

  final List<String>? ta;

  final List<double>? da;

  final int s;

  final List<int>? bia;

  final DateTime? dt;

  final DateTime? tsz;

  final List<int>? ia;

  final DateTime? ts;

  final int? i;

  final List<String>? va;

  final int bs;

  final List<bool>? ba;

  final Object? jj;

  final String? t;

  final double? d;

  final String? u;

  final int? bi;

  final double? f;

  final int? si;

  ReadTablesTest copyWith({
    bool? bl,
    List<Object>? ja,
    Object? j,
    String? v,
    List<String>? ta,
    List<double>? da,
    int? s,
    List<int>? bia,
    DateTime? dt,
    DateTime? tsz,
    List<int>? ia,
    DateTime? ts,
    int? i,
    List<String>? va,
    int? bs,
    List<bool>? ba,
    Object? jj,
    String? t,
    double? d,
    String? u,
    int? bi,
    double? f,
    int? si,
  }) {
    return ReadTablesTest(
      bl: bl ?? this.bl,
      ja: ja ?? this.ja,
      j: j ?? this.j,
      v: v ?? this.v,
      ta: ta ?? this.ta,
      da: da ?? this.da,
      s: s ?? this.s,
      bia: bia ?? this.bia,
      dt: dt ?? this.dt,
      tsz: tsz ?? this.tsz,
      ia: ia ?? this.ia,
      ts: ts ?? this.ts,
      i: i ?? this.i,
      va: va ?? this.va,
      bs: bs ?? this.bs,
      ba: ba ?? this.ba,
      jj: jj ?? this.jj,
      t: t ?? this.t,
      d: d ?? this.d,
      u: u ?? this.u,
      bi: bi ?? this.bi,
      f: f ?? this.f,
      si: si ?? this.si,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bl': bl,
      'ja': ja,
      'j': j,
      'v': v,
      'ta': ta,
      'da': da,
      's': s,
      'bia': bia,
      'dt': dt?.toIso8601String(),
      'tsz': tsz?.toIso8601String(),
      'ia': ia,
      'ts': ts?.toIso8601String(),
      'i': i,
      'va': va,
      'bs': bs,
      'ba': ba,
      'jj': jj,
      't': t,
      'd': d,
      'u': u,
      'bi': bi,
      'f': f,
      'si': si,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final collectionEquals = const DeepCollectionEquality().equals;

    return other is ReadTablesTest &&
        other.bl == bl &&
        collectionEquals(other.ja, ja) &&
        other.j == j &&
        other.v == v &&
        collectionEquals(other.ta, ta) &&
        collectionEquals(other.da, da) &&
        other.s == s &&
        collectionEquals(other.bia, bia) &&
        other.dt == dt &&
        other.tsz == tsz &&
        collectionEquals(other.ia, ia) &&
        other.ts == ts &&
        other.i == i &&
        collectionEquals(other.va, va) &&
        other.bs == bs &&
        collectionEquals(other.ba, ba) &&
        other.jj == jj &&
        other.t == t &&
        other.d == d &&
        other.u == u &&
        other.bi == bi &&
        other.f == f &&
        other.si == si;
  }

  @override
  int get hashCode {
    return bl.hashCode ^
        ja.hashCode ^
        j.hashCode ^
        v.hashCode ^
        ta.hashCode ^
        da.hashCode ^
        s.hashCode ^
        bia.hashCode ^
        dt.hashCode ^
        tsz.hashCode ^
        ia.hashCode ^
        ts.hashCode ^
        i.hashCode ^
        va.hashCode ^
        bs.hashCode ^
        ba.hashCode ^
        jj.hashCode ^
        t.hashCode ^
        d.hashCode ^
        u.hashCode ^
        bi.hashCode ^
        f.hashCode ^
        si.hashCode;
  }

  @override
  String toString() {
    return 'ReadTablesTest(bl: $bl, ja: $ja, j: $j, v: $v, ta: $ta, da: $da, s: $s, bia: $bia, dt: $dt, tsz: $tsz, ia: $ia, ts: $ts, i: $i, va: $va, bs: $bs, ba: $ba, jj: $jj, t: $t, d: $d, u: $u, bi: $bi, f: $f, si: $si)';
  }
}
