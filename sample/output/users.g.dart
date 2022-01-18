import 'dart:convert';

class Users {
  const Users({
    this.phone,
    this.phoneChange,
    this.phoneChangeToken,
    this.emailChangeTokenCurrent,
    this.emailChangeTokenNew,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.phoneConfirmedAt,
    this.phoneChangeSentAt,
    this.confirmedAt,
    this.emailChangeConfirmStatus,
    this.instanceId,
    required this.id,
    this.emailConfirmedAt,
    this.invitedAt,
    this.confirmationSentAt,
    this.recoverySentAt,
    this.emailChangeSentAt,
    this.lastSignInAt,
    this.rawAppMetaData,
    this.aud,
    this.role,
    this.email,
    this.encryptedPassword,
    this.confirmationToken,
    this.recoveryToken,
    this.rawUserMetaData,
    this.emailChange,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      phone: map['phone'],
      phoneChange: map['phone_change'],
      phoneChangeToken: map['phone_change_token'],
      emailChangeTokenCurrent: map['email_change_token_current'],
      emailChangeTokenNew: map['email_change_token_new'],
      isSuperAdmin: map['is_super_admin'],
      createdAt: DateTime.tryParse(map['created_at']),
      updatedAt: DateTime.tryParse(map['updated_at']),
      phoneConfirmedAt: DateTime.tryParse(map['phone_confirmed_at']),
      phoneChangeSentAt: DateTime.tryParse(map['phone_change_sent_at']),
      confirmedAt: DateTime.tryParse(map['confirmed_at']),
      emailChangeConfirmStatus: int.tryParse(map['email_change_confirm_status']),
      instanceId: map['instance_id'],
      id: map['id'],
      emailConfirmedAt: DateTime.tryParse(map['email_confirmed_at']),
      invitedAt: DateTime.tryParse(map['invited_at']),
      confirmationSentAt: DateTime.tryParse(map['confirmation_sent_at']),
      recoverySentAt: DateTime.tryParse(map['recovery_sent_at']),
      emailChangeSentAt: DateTime.tryParse(map['email_change_sent_at']),
      lastSignInAt: DateTime.tryParse(map['last_sign_in_at']),
      rawAppMetaData: map['raw_app_meta_data'],
      aud: map['aud'],
      role: map['role'],
      email: map['email'],
      encryptedPassword: map['encrypted_password'],
      confirmationToken: map['confirmation_token'],
      recoveryToken: map['recovery_token'],
      rawUserMetaData: map['raw_user_meta_data'],
      emailChange: map['email_change'],
    );
  }

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  final String? phone;

  final String? phoneChange;

  final String? phoneChangeToken;

  final String? emailChangeTokenCurrent;

  final String? emailChangeTokenNew;

  final bool? isSuperAdmin;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final DateTime? phoneConfirmedAt;

  final DateTime? phoneChangeSentAt;

  final DateTime? confirmedAt;

  final int? emailChangeConfirmStatus;

  final String? instanceId;

  final String id;

  final DateTime? emailConfirmedAt;

  final DateTime? invitedAt;

  final DateTime? confirmationSentAt;

  final DateTime? recoverySentAt;

  final DateTime? emailChangeSentAt;

  final DateTime? lastSignInAt;

  final Object? rawAppMetaData;

  final String? aud;

  final String? role;

  final String? email;

  final String? encryptedPassword;

  final String? confirmationToken;

  final String? recoveryToken;

  final Object? rawUserMetaData;

  final String? emailChange;

  Users copyWith({
    String? phone,
    String? phoneChange,
    String? phoneChangeToken,
    String? emailChangeTokenCurrent,
    String? emailChangeTokenNew,
    bool? isSuperAdmin,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? phoneConfirmedAt,
    DateTime? phoneChangeSentAt,
    DateTime? confirmedAt,
    int? emailChangeConfirmStatus,
    String? instanceId,
    String? id,
    DateTime? emailConfirmedAt,
    DateTime? invitedAt,
    DateTime? confirmationSentAt,
    DateTime? recoverySentAt,
    DateTime? emailChangeSentAt,
    DateTime? lastSignInAt,
    Object? rawAppMetaData,
    String? aud,
    String? role,
    String? email,
    String? encryptedPassword,
    String? confirmationToken,
    String? recoveryToken,
    Object? rawUserMetaData,
    String? emailChange,
  }) {
    return Users(
      phone: phone ?? this.phone,
      phoneChange: phoneChange ?? this.phoneChange,
      phoneChangeToken: phoneChangeToken ?? this.phoneChangeToken,
      emailChangeTokenCurrent: emailChangeTokenCurrent ?? this.emailChangeTokenCurrent,
      emailChangeTokenNew: emailChangeTokenNew ?? this.emailChangeTokenNew,
      isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      phoneConfirmedAt: phoneConfirmedAt ?? this.phoneConfirmedAt,
      phoneChangeSentAt: phoneChangeSentAt ?? this.phoneChangeSentAt,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      emailChangeConfirmStatus: emailChangeConfirmStatus ?? this.emailChangeConfirmStatus,
      instanceId: instanceId ?? this.instanceId,
      id: id ?? this.id,
      emailConfirmedAt: emailConfirmedAt ?? this.emailConfirmedAt,
      invitedAt: invitedAt ?? this.invitedAt,
      confirmationSentAt: confirmationSentAt ?? this.confirmationSentAt,
      recoverySentAt: recoverySentAt ?? this.recoverySentAt,
      emailChangeSentAt: emailChangeSentAt ?? this.emailChangeSentAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      rawAppMetaData: rawAppMetaData ?? this.rawAppMetaData,
      aud: aud ?? this.aud,
      role: role ?? this.role,
      email: email ?? this.email,
      encryptedPassword: encryptedPassword ?? this.encryptedPassword,
      confirmationToken: confirmationToken ?? this.confirmationToken,
      recoveryToken: recoveryToken ?? this.recoveryToken,
      rawUserMetaData: rawUserMetaData ?? this.rawUserMetaData,
      emailChange: emailChange ?? this.emailChange,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'phone_change': phoneChange,
      'phone_change_token': phoneChangeToken,
      'email_change_token_current': emailChangeTokenCurrent,
      'email_change_token_new': emailChangeTokenNew,
      'is_super_admin': isSuperAdmin,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'phone_confirmed_at': phoneConfirmedAt,
      'phone_change_sent_at': phoneChangeSentAt,
      'confirmed_at': confirmedAt,
      'email_change_confirm_status': emailChangeConfirmStatus,
      'instance_id': instanceId,
      'id': id,
      'email_confirmed_at': emailConfirmedAt,
      'invited_at': invitedAt,
      'confirmation_sent_at': confirmationSentAt,
      'recovery_sent_at': recoverySentAt,
      'email_change_sent_at': emailChangeSentAt,
      'last_sign_in_at': lastSignInAt,
      'raw_app_meta_data': rawAppMetaData,
      'aud': aud,
      'role': role,
      'email': email,
      'encrypted_password': encryptedPassword,
      'confirmation_token': confirmationToken,
      'recovery_token': recoveryToken,
      'raw_user_meta_data': rawUserMetaData,
      'email_change': emailChange,
    };
  }

  String toJson() => json.encode(toMap());
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.phone == phone &&
        other.phoneChange == phoneChange &&
        other.phoneChangeToken == phoneChangeToken &&
        other.emailChangeTokenCurrent == emailChangeTokenCurrent &&
        other.emailChangeTokenNew == emailChangeTokenNew &&
        other.isSuperAdmin == isSuperAdmin &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.phoneConfirmedAt == phoneConfirmedAt &&
        other.phoneChangeSentAt == phoneChangeSentAt &&
        other.confirmedAt == confirmedAt &&
        other.emailChangeConfirmStatus == emailChangeConfirmStatus &&
        other.instanceId == instanceId &&
        other.id == id &&
        other.emailConfirmedAt == emailConfirmedAt &&
        other.invitedAt == invitedAt &&
        other.confirmationSentAt == confirmationSentAt &&
        other.recoverySentAt == recoverySentAt &&
        other.emailChangeSentAt == emailChangeSentAt &&
        other.lastSignInAt == lastSignInAt &&
        other.rawAppMetaData == rawAppMetaData &&
        other.aud == aud &&
        other.role == role &&
        other.email == email &&
        other.encryptedPassword == encryptedPassword &&
        other.confirmationToken == confirmationToken &&
        other.recoveryToken == recoveryToken &&
        other.rawUserMetaData == rawUserMetaData &&
        other.emailChange == emailChange;
  }

  @override
  int get hashCode {
    return phone.hashCode ^
        phoneChange.hashCode ^
        phoneChangeToken.hashCode ^
        emailChangeTokenCurrent.hashCode ^
        emailChangeTokenNew.hashCode ^
        isSuperAdmin.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        phoneConfirmedAt.hashCode ^
        phoneChangeSentAt.hashCode ^
        confirmedAt.hashCode ^
        emailChangeConfirmStatus.hashCode ^
        instanceId.hashCode ^
        id.hashCode ^
        emailConfirmedAt.hashCode ^
        invitedAt.hashCode ^
        confirmationSentAt.hashCode ^
        recoverySentAt.hashCode ^
        emailChangeSentAt.hashCode ^
        lastSignInAt.hashCode ^
        rawAppMetaData.hashCode ^
        aud.hashCode ^
        role.hashCode ^
        email.hashCode ^
        encryptedPassword.hashCode ^
        confirmationToken.hashCode ^
        recoveryToken.hashCode ^
        rawUserMetaData.hashCode ^
        emailChange.hashCode;
  }

  @override
  String toString() {
    return 'Users(phone: $phone, phoneChange: $phoneChange, phoneChangeToken: $phoneChangeToken, emailChangeTokenCurrent: $emailChangeTokenCurrent, emailChangeTokenNew: $emailChangeTokenNew, isSuperAdmin: $isSuperAdmin, createdAt: $createdAt, updatedAt: $updatedAt, phoneConfirmedAt: $phoneConfirmedAt, phoneChangeSentAt: $phoneChangeSentAt, confirmedAt: $confirmedAt, emailChangeConfirmStatus: $emailChangeConfirmStatus, instanceId: $instanceId, id: $id, emailConfirmedAt: $emailConfirmedAt, invitedAt: $invitedAt, confirmationSentAt: $confirmationSentAt, recoverySentAt: $recoverySentAt, emailChangeSentAt: $emailChangeSentAt, lastSignInAt: $lastSignInAt, rawAppMetaData: $rawAppMetaData, aud: $aud, role: $role, email: $email, encryptedPassword: $encryptedPassword, confirmationToken: $confirmationToken, recoveryToken: $recoveryToken, rawUserMetaData: $rawUserMetaData, emailChange: $emailChange)';
  }
}
