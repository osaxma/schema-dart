import 'dart:convert';

class Users {
  const Users({
    this.emailChangeTokenCurrent,
    this.reauthenticationToken,
    this.aud,
    this.role,
    this.email,
    this.encryptedPassword,
    this.confirmationToken,
    this.recoveryToken,
    this.emailChangeTokenNew,
    this.emailChange,
    this.lastSignInAt,
    this.rawAppMetaData,
    this.isSuperAdmin,
    this.rawUserMetaData,
    this.createdAt,
    this.updatedAt,
    this.phoneConfirmedAt,
    this.phoneChangeSentAt,
    this.confirmedAt,
    this.emailChangeConfirmStatus,
    this.bannedUntil,
    this.reauthenticationSentAt,
    required this.isSsoUser,
    this.deletedAt,
    this.emailChangeSentAt,
    this.recoverySentAt,
    this.confirmationSentAt,
    this.invitedAt,
    this.emailConfirmedAt,
    required this.id,
    this.instanceId,
    this.phone,
    this.phoneChange,
    this.phoneChangeToken,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      emailChangeTokenCurrent: map['email_change_token_current'],
      reauthenticationToken: map['reauthentication_token'],
      aud: map['aud'],
      role: map['role'],
      email: map['email'],
      encryptedPassword: map['encrypted_password'],
      confirmationToken: map['confirmation_token'],
      recoveryToken: map['recovery_token'],
      emailChangeTokenNew: map['email_change_token_new'],
      emailChange: map['email_change'],
      lastSignInAt: DateTime.tryParse(map['last_sign_in_at'] ?? ""),
      rawAppMetaData: map['raw_app_meta_data'],
      isSuperAdmin: map['is_super_admin'],
      rawUserMetaData: map['raw_user_meta_data'],
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
      phoneConfirmedAt: DateTime.tryParse(map['phone_confirmed_at'] ?? ""),
      phoneChangeSentAt: DateTime.tryParse(map['phone_change_sent_at'] ?? ""),
      confirmedAt: DateTime.tryParse(map['confirmed_at'] ?? ""),
      emailChangeConfirmStatus: int.tryParse(map['email_change_confirm_status'] ?? ""),
      bannedUntil: DateTime.tryParse(map['banned_until'] ?? ""),
      reauthenticationSentAt: DateTime.tryParse(map['reauthentication_sent_at'] ?? ""),
      isSsoUser: map['is_sso_user'],
      deletedAt: DateTime.tryParse(map['deleted_at'] ?? ""),
      emailChangeSentAt: DateTime.tryParse(map['email_change_sent_at'] ?? ""),
      recoverySentAt: DateTime.tryParse(map['recovery_sent_at'] ?? ""),
      confirmationSentAt: DateTime.tryParse(map['confirmation_sent_at'] ?? ""),
      invitedAt: DateTime.tryParse(map['invited_at'] ?? ""),
      emailConfirmedAt: DateTime.tryParse(map['email_confirmed_at'] ?? ""),
      id: map['id'],
      instanceId: map['instance_id'],
      phone: map['phone'],
      phoneChange: map['phone_change'],
      phoneChangeToken: map['phone_change_token'],
    );
  }

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  final String? emailChangeTokenCurrent;

  final String? reauthenticationToken;

  final String? aud;

  final String? role;

  final String? email;

  final String? encryptedPassword;

  final String? confirmationToken;

  final String? recoveryToken;

  final String? emailChangeTokenNew;

  final String? emailChange;

  final DateTime? lastSignInAt;

  final Object? rawAppMetaData;

  final bool? isSuperAdmin;

  final Object? rawUserMetaData;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final DateTime? phoneConfirmedAt;

  final DateTime? phoneChangeSentAt;

  final DateTime? confirmedAt;

  final int? emailChangeConfirmStatus;

  final DateTime? bannedUntil;

  final DateTime? reauthenticationSentAt;

  final bool isSsoUser;

  final DateTime? deletedAt;

  final DateTime? emailChangeSentAt;

  final DateTime? recoverySentAt;

  final DateTime? confirmationSentAt;

  final DateTime? invitedAt;

  final DateTime? emailConfirmedAt;

  final String id;

  final String? instanceId;

  final String? phone;

  final String? phoneChange;

  final String? phoneChangeToken;

  Users copyWith({
    String? emailChangeTokenCurrent,
    String? reauthenticationToken,
    String? aud,
    String? role,
    String? email,
    String? encryptedPassword,
    String? confirmationToken,
    String? recoveryToken,
    String? emailChangeTokenNew,
    String? emailChange,
    DateTime? lastSignInAt,
    Object? rawAppMetaData,
    bool? isSuperAdmin,
    Object? rawUserMetaData,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? phoneConfirmedAt,
    DateTime? phoneChangeSentAt,
    DateTime? confirmedAt,
    int? emailChangeConfirmStatus,
    DateTime? bannedUntil,
    DateTime? reauthenticationSentAt,
    bool? isSsoUser,
    DateTime? deletedAt,
    DateTime? emailChangeSentAt,
    DateTime? recoverySentAt,
    DateTime? confirmationSentAt,
    DateTime? invitedAt,
    DateTime? emailConfirmedAt,
    String? id,
    String? instanceId,
    String? phone,
    String? phoneChange,
    String? phoneChangeToken,
  }) {
    return Users(
      emailChangeTokenCurrent: emailChangeTokenCurrent ?? this.emailChangeTokenCurrent,
      reauthenticationToken: reauthenticationToken ?? this.reauthenticationToken,
      aud: aud ?? this.aud,
      role: role ?? this.role,
      email: email ?? this.email,
      encryptedPassword: encryptedPassword ?? this.encryptedPassword,
      confirmationToken: confirmationToken ?? this.confirmationToken,
      recoveryToken: recoveryToken ?? this.recoveryToken,
      emailChangeTokenNew: emailChangeTokenNew ?? this.emailChangeTokenNew,
      emailChange: emailChange ?? this.emailChange,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      rawAppMetaData: rawAppMetaData ?? this.rawAppMetaData,
      isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
      rawUserMetaData: rawUserMetaData ?? this.rawUserMetaData,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      phoneConfirmedAt: phoneConfirmedAt ?? this.phoneConfirmedAt,
      phoneChangeSentAt: phoneChangeSentAt ?? this.phoneChangeSentAt,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      emailChangeConfirmStatus: emailChangeConfirmStatus ?? this.emailChangeConfirmStatus,
      bannedUntil: bannedUntil ?? this.bannedUntil,
      reauthenticationSentAt: reauthenticationSentAt ?? this.reauthenticationSentAt,
      isSsoUser: isSsoUser ?? this.isSsoUser,
      deletedAt: deletedAt ?? this.deletedAt,
      emailChangeSentAt: emailChangeSentAt ?? this.emailChangeSentAt,
      recoverySentAt: recoverySentAt ?? this.recoverySentAt,
      confirmationSentAt: confirmationSentAt ?? this.confirmationSentAt,
      invitedAt: invitedAt ?? this.invitedAt,
      emailConfirmedAt: emailConfirmedAt ?? this.emailConfirmedAt,
      id: id ?? this.id,
      instanceId: instanceId ?? this.instanceId,
      phone: phone ?? this.phone,
      phoneChange: phoneChange ?? this.phoneChange,
      phoneChangeToken: phoneChangeToken ?? this.phoneChangeToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email_change_token_current': emailChangeTokenCurrent,
      'reauthentication_token': reauthenticationToken,
      'aud': aud,
      'role': role,
      'email': email,
      'encrypted_password': encryptedPassword,
      'confirmation_token': confirmationToken,
      'recovery_token': recoveryToken,
      'email_change_token_new': emailChangeTokenNew,
      'email_change': emailChange,
      'last_sign_in_at': lastSignInAt,
      'raw_app_meta_data': rawAppMetaData,
      'is_super_admin': isSuperAdmin,
      'raw_user_meta_data': rawUserMetaData,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'phone_confirmed_at': phoneConfirmedAt,
      'phone_change_sent_at': phoneChangeSentAt,
      'confirmed_at': confirmedAt,
      'email_change_confirm_status': emailChangeConfirmStatus,
      'banned_until': bannedUntil,
      'reauthentication_sent_at': reauthenticationSentAt,
      'is_sso_user': isSsoUser,
      'deleted_at': deletedAt,
      'email_change_sent_at': emailChangeSentAt,
      'recovery_sent_at': recoverySentAt,
      'confirmation_sent_at': confirmationSentAt,
      'invited_at': invitedAt,
      'email_confirmed_at': emailConfirmedAt,
      'id': id,
      'instance_id': instanceId,
      'phone': phone,
      'phone_change': phoneChange,
      'phone_change_token': phoneChangeToken,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.emailChangeTokenCurrent == emailChangeTokenCurrent &&
        other.reauthenticationToken == reauthenticationToken &&
        other.aud == aud &&
        other.role == role &&
        other.email == email &&
        other.encryptedPassword == encryptedPassword &&
        other.confirmationToken == confirmationToken &&
        other.recoveryToken == recoveryToken &&
        other.emailChangeTokenNew == emailChangeTokenNew &&
        other.emailChange == emailChange &&
        other.lastSignInAt == lastSignInAt &&
        other.rawAppMetaData == rawAppMetaData &&
        other.isSuperAdmin == isSuperAdmin &&
        other.rawUserMetaData == rawUserMetaData &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.phoneConfirmedAt == phoneConfirmedAt &&
        other.phoneChangeSentAt == phoneChangeSentAt &&
        other.confirmedAt == confirmedAt &&
        other.emailChangeConfirmStatus == emailChangeConfirmStatus &&
        other.bannedUntil == bannedUntil &&
        other.reauthenticationSentAt == reauthenticationSentAt &&
        other.isSsoUser == isSsoUser &&
        other.deletedAt == deletedAt &&
        other.emailChangeSentAt == emailChangeSentAt &&
        other.recoverySentAt == recoverySentAt &&
        other.confirmationSentAt == confirmationSentAt &&
        other.invitedAt == invitedAt &&
        other.emailConfirmedAt == emailConfirmedAt &&
        other.id == id &&
        other.instanceId == instanceId &&
        other.phone == phone &&
        other.phoneChange == phoneChange &&
        other.phoneChangeToken == phoneChangeToken;
  }

  @override
  int get hashCode {
    return emailChangeTokenCurrent.hashCode ^
        reauthenticationToken.hashCode ^
        aud.hashCode ^
        role.hashCode ^
        email.hashCode ^
        encryptedPassword.hashCode ^
        confirmationToken.hashCode ^
        recoveryToken.hashCode ^
        emailChangeTokenNew.hashCode ^
        emailChange.hashCode ^
        lastSignInAt.hashCode ^
        rawAppMetaData.hashCode ^
        isSuperAdmin.hashCode ^
        rawUserMetaData.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        phoneConfirmedAt.hashCode ^
        phoneChangeSentAt.hashCode ^
        confirmedAt.hashCode ^
        emailChangeConfirmStatus.hashCode ^
        bannedUntil.hashCode ^
        reauthenticationSentAt.hashCode ^
        isSsoUser.hashCode ^
        deletedAt.hashCode ^
        emailChangeSentAt.hashCode ^
        recoverySentAt.hashCode ^
        confirmationSentAt.hashCode ^
        invitedAt.hashCode ^
        emailConfirmedAt.hashCode ^
        id.hashCode ^
        instanceId.hashCode ^
        phone.hashCode ^
        phoneChange.hashCode ^
        phoneChangeToken.hashCode;
  }

  @override
  String toString() {
    return 'Users(emailChangeTokenCurrent: $emailChangeTokenCurrent, reauthenticationToken: $reauthenticationToken, aud: $aud, role: $role, email: $email, encryptedPassword: $encryptedPassword, confirmationToken: $confirmationToken, recoveryToken: $recoveryToken, emailChangeTokenNew: $emailChangeTokenNew, emailChange: $emailChange, lastSignInAt: $lastSignInAt, rawAppMetaData: $rawAppMetaData, isSuperAdmin: $isSuperAdmin, rawUserMetaData: $rawUserMetaData, createdAt: $createdAt, updatedAt: $updatedAt, phoneConfirmedAt: $phoneConfirmedAt, phoneChangeSentAt: $phoneChangeSentAt, confirmedAt: $confirmedAt, emailChangeConfirmStatus: $emailChangeConfirmStatus, bannedUntil: $bannedUntil, reauthenticationSentAt: $reauthenticationSentAt, isSsoUser: $isSsoUser, deletedAt: $deletedAt, emailChangeSentAt: $emailChangeSentAt, recoverySentAt: $recoverySentAt, confirmationSentAt: $confirmationSentAt, invitedAt: $invitedAt, emailConfirmedAt: $emailConfirmedAt, id: $id, instanceId: $instanceId, phone: $phone, phoneChange: $phoneChange, phoneChangeToken: $phoneChangeToken)';
  }
}
