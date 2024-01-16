import 'package:collection/collection.dart';
import 'dart:convert';

class SerializationOutput {
  const SerializationOutput({
    this.bl,
    this.ta,
    this.n,
    this.ba,
    this.va,
    this.ia,
    this.boola,
    this.bia,
    required this.s,
    this.jj,
    this.dt,
    this.tsz,
    this.v,
    this.ts,
    this.i,
    this.da,
    required this.bs,
    this.ja,
    this.u,
    this.t,
    this.d,
    this.j,
    this.bi,
    this.f,
    this.si,
  });

  factory SerializationOutput.fromMap(Map<String, dynamic> map) {
    return SerializationOutput(
      bl: map['bl'],
      ta: map['ta'] == null ? null : List<String>.from(map['ta']),
      n: map['n'],
      ba: map['ba'] == null ? null : List<int>.from(map['ba']),
      va: map['va'] == null ? null : List<String>.from(map['va']),
      ia: map['ia'] == null ? null : List<int>.from(map['ia']),
      boola: map['boola'] == null ? null : List<bool>.from(map['boola']),
      bia: map['bia'] == null ? null : List<int>.from(map['bia']),
      s: map['s'].toInt(),
      jj: map['jj'],
      dt: DateTime.tryParse(map['dt'] ?? ""),
      tsz: DateTime.tryParse(map['tsz'] ?? ""),
      v: map['v'],
      ts: DateTime.tryParse(map['ts'] ?? ""),
      i: map['i']?.toInt(),
      da: map['da'] == null ? null : List<double>.from(map['da']),
      bs: map['bs'].toInt(),
      ja: map['ja'] == null ? null : List<Object>.from(map['ja']),
      u: map['u'],
      t: map['t'],
      d: map['d']?.toDouble(),
      j: map['j'],
      bi: map['bi']?.toInt(),
      f: map['f']?.toDouble(),
      si: map['si']?.toInt(),
    );
  }

  factory SerializationOutput.fromJson(String source) => SerializationOutput.fromMap(json.decode(source));

  final bool? bl;

  final List<String>? ta;

  final String? n;

  final List<int>? ba;

  final List<String>? va;

  final List<int>? ia;

  final List<bool>? boola;

  final List<int>? bia;

  final int s;

  final Object? jj;

  final DateTime? dt;

  final DateTime? tsz;

  final String? v;

  final DateTime? ts;

  final int? i;

  final List<double>? da;

  final int bs;

  final List<Object>? ja;

  final String? u;

  final String? t;

  final double? d;

  final Object? j;

  final int? bi;

  final double? f;

  final int? si;

  SerializationOutput copyWith({
    bool? bl,
    List<String>? ta,
    String? n,
    List<int>? ba,
    List<String>? va,
    List<int>? ia,
    List<bool>? boola,
    List<int>? bia,
    int? s,
    Object? jj,
    DateTime? dt,
    DateTime? tsz,
    String? v,
    DateTime? ts,
    int? i,
    List<double>? da,
    int? bs,
    List<Object>? ja,
    String? u,
    String? t,
    double? d,
    Object? j,
    int? bi,
    double? f,
    int? si,
  }) {
    return SerializationOutput(
      bl: bl ?? this.bl,
      ta: ta ?? this.ta,
      n: n ?? this.n,
      ba: ba ?? this.ba,
      va: va ?? this.va,
      ia: ia ?? this.ia,
      boola: boola ?? this.boola,
      bia: bia ?? this.bia,
      s: s ?? this.s,
      jj: jj ?? this.jj,
      dt: dt ?? this.dt,
      tsz: tsz ?? this.tsz,
      v: v ?? this.v,
      ts: ts ?? this.ts,
      i: i ?? this.i,
      da: da ?? this.da,
      bs: bs ?? this.bs,
      ja: ja ?? this.ja,
      u: u ?? this.u,
      t: t ?? this.t,
      d: d ?? this.d,
      j: j ?? this.j,
      bi: bi ?? this.bi,
      f: f ?? this.f,
      si: si ?? this.si,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bl': bl,
      'ta': ta,
      'n': n,
      'ba': ba,
      'va': va,
      'ia': ia,
      'boola': boola,
      'bia': bia,
      's': s,
      'jj': jj,
      'dt': dt?.toIso8601String(),
      'tsz': tsz?.toIso8601String(),
      'v': v,
      'ts': ts?.toIso8601String(),
      'i': i,
      'da': da,
      'bs': bs,
      'ja': ja,
      'u': u,
      't': t,
      'd': d,
      'j': j,
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

    return other is SerializationOutput &&
        other.bl == bl &&
        collectionEquals(other.ta, ta) &&
        other.n == n &&
        collectionEquals(other.ba, ba) &&
        collectionEquals(other.va, va) &&
        collectionEquals(other.ia, ia) &&
        collectionEquals(other.boola, boola) &&
        collectionEquals(other.bia, bia) &&
        other.s == s &&
        other.jj == jj &&
        other.dt == dt &&
        other.tsz == tsz &&
        other.v == v &&
        other.ts == ts &&
        other.i == i &&
        collectionEquals(other.da, da) &&
        other.bs == bs &&
        collectionEquals(other.ja, ja) &&
        other.u == u &&
        other.t == t &&
        other.d == d &&
        other.j == j &&
        other.bi == bi &&
        other.f == f &&
        other.si == si;
  }

  @override
  int get hashCode {
    return bl.hashCode ^
        ta.hashCode ^
        n.hashCode ^
        ba.hashCode ^
        va.hashCode ^
        ia.hashCode ^
        boola.hashCode ^
        bia.hashCode ^
        s.hashCode ^
        jj.hashCode ^
        dt.hashCode ^
        tsz.hashCode ^
        v.hashCode ^
        ts.hashCode ^
        i.hashCode ^
        da.hashCode ^
        bs.hashCode ^
        ja.hashCode ^
        u.hashCode ^
        t.hashCode ^
        d.hashCode ^
        j.hashCode ^
        bi.hashCode ^
        f.hashCode ^
        si.hashCode;
  }

  @override
  String toString() {
    return 'SerializationOutput(bl: $bl, ta: $ta, n: $n, ba: $ba, va: $va, ia: $ia, boola: $boola, bia: $bia, s: $s, jj: $jj, dt: $dt, tsz: $tsz, v: $v, ts: $ts, i: $i, da: $da, bs: $bs, ja: $ja, u: $u, t: $t, d: $d, j: $j, bi: $bi, f: $f, si: $si)';
  }
}
