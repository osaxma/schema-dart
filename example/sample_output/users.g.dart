import 'dart:convert';

class Users {
  const Users({
    this.lastSignInAt,
    this.role,
    this.phoneConfirmedAt,
    this.instanceId,
    this.phone,
    this.recoveryToken,
    this.rawAppMetaData,
    this.confirmationSentAt,
    this.recoverySentAt,
    this.rawUserMetaData,
    required this.id,
    this.createdAt,
    this.phoneChangeToken,
    this.phoneChangeSentAt,
    this.confirmedAt,
    this.isSuperAdmin,
    this.phoneChange,
    this.emailChangeSentAt,
    this.emailChangeTokenNew,
    this.updatedAt,
    this.email,
    this.emailChangeConfirmStatus,
    this.encryptedPassword,
    this.invitedAt,
    this.emailChangeTokenCurrent,
    this.aud,
    this.emailChange,
    this.confirmationToken,
    this.emailConfirmedAt,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      lastSignInAt: DateTime.tryParse(map['last_sign_in_at'] ?? ""),
      role: map['role'],
      phoneConfirmedAt: DateTime.tryParse(map['phone_confirmed_at'] ?? ""),
      instanceId: map['instance_id'],
      phone: map['phone'],
      recoveryToken: map['recovery_token'],
      rawAppMetaData: map['raw_app_meta_data'],
      confirmationSentAt: DateTime.tryParse(map['confirmation_sent_at'] ?? ""),
      recoverySentAt: DateTime.tryParse(map['recovery_sent_at'] ?? ""),
      rawUserMetaData: map['raw_user_meta_data'],
      id: map['id'],
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      phoneChangeToken: map['phone_change_token'],
      phoneChangeSentAt: DateTime.tryParse(map['phone_change_sent_at'] ?? ""),
      confirmedAt: DateTime.tryParse(map['confirmed_at'] ?? ""),
      isSuperAdmin: map['is_super_admin'],
      phoneChange: map['phone_change'],
      emailChangeSentAt: DateTime.tryParse(map['email_change_sent_at'] ?? ""),
      emailChangeTokenNew: map['email_change_token_new'],
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
      email: map['email'],
      emailChangeConfirmStatus: int.tryParse(map['email_change_confirm_status'] ?? ""),
      encryptedPassword: map['encrypted_password'],
      invitedAt: DateTime.tryParse(map['invited_at'] ?? ""),
      emailChangeTokenCurrent: map['email_change_token_current'],
      aud: map['aud'],
      emailChange: map['email_change'],
      confirmationToken: map['confirmation_token'],
      emailConfirmedAt: DateTime.tryParse(map['email_confirmed_at'] ?? ""),
    );
  }

  factory Users.fromJson(String source) => Users.fromMap(jsonDecode(source));

  final DateTime? lastSignInAt;

  final String? role;

  final DateTime? phoneConfirmedAt;

  final String? instanceId;

  final String? phone;

  final String? recoveryToken;

  final Object? rawAppMetaData;

  final DateTime? confirmationSentAt;

  final DateTime? recoverySentAt;

  final Object? rawUserMetaData;

  final String id;

  final DateTime? createdAt;

  final String? phoneChangeToken;

  final DateTime? phoneChangeSentAt;

  final DateTime? confirmedAt;

  final bool? isSuperAdmin;

  final String? phoneChange;

  final DateTime? emailChangeSentAt;

  final String? emailChangeTokenNew;

  final DateTime? updatedAt;

  final String? email;

  final int? emailChangeConfirmStatus;

  final String? encryptedPassword;

  final DateTime? invitedAt;

  final String? emailChangeTokenCurrent;

  final String? aud;

  final String? emailChange;

  final String? confirmationToken;

  final DateTime? emailConfirmedAt;

  Users copyWith({
    DateTime? lastSignInAt,
    String? role,
    DateTime? phoneConfirmedAt,
    String? instanceId,
    String? phone,
    String? recoveryToken,
    Object? rawAppMetaData,
    DateTime? confirmationSentAt,
    DateTime? recoverySentAt,
    Object? rawUserMetaData,
    String? id,
    DateTime? createdAt,
    String? phoneChangeToken,
    DateTime? phoneChangeSentAt,
    DateTime? confirmedAt,
    bool? isSuperAdmin,
    String? phoneChange,
    DateTime? emailChangeSentAt,
    String? emailChangeTokenNew,
    DateTime? updatedAt,
    String? email,
    int? emailChangeConfirmStatus,
    String? encryptedPassword,
    DateTime? invitedAt,
    String? emailChangeTokenCurrent,
    String? aud,
    String? emailChange,
    String? confirmationToken,
    DateTime? emailConfirmedAt,
  }) {
    return Users(
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      role: role ?? this.role,
      phoneConfirmedAt: phoneConfirmedAt ?? this.phoneConfirmedAt,
      instanceId: instanceId ?? this.instanceId,
      phone: phone ?? this.phone,
      recoveryToken: recoveryToken ?? this.recoveryToken,
      rawAppMetaData: rawAppMetaData ?? this.rawAppMetaData,
      confirmationSentAt: confirmationSentAt ?? this.confirmationSentAt,
      recoverySentAt: recoverySentAt ?? this.recoverySentAt,
      rawUserMetaData: rawUserMetaData ?? this.rawUserMetaData,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      phoneChangeToken: phoneChangeToken ?? this.phoneChangeToken,
      phoneChangeSentAt: phoneChangeSentAt ?? this.phoneChangeSentAt,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
      phoneChange: phoneChange ?? this.phoneChange,
      emailChangeSentAt: emailChangeSentAt ?? this.emailChangeSentAt,
      emailChangeTokenNew: emailChangeTokenNew ?? this.emailChangeTokenNew,
      updatedAt: updatedAt ?? this.updatedAt,
      email: email ?? this.email,
      emailChangeConfirmStatus: emailChangeConfirmStatus ?? this.emailChangeConfirmStatus,
      encryptedPassword: encryptedPassword ?? this.encryptedPassword,
      invitedAt: invitedAt ?? this.invitedAt,
      emailChangeTokenCurrent: emailChangeTokenCurrent ?? this.emailChangeTokenCurrent,
      aud: aud ?? this.aud,
      emailChange: emailChange ?? this.emailChange,
      confirmationToken: confirmationToken ?? this.confirmationToken,
      emailConfirmedAt: emailConfirmedAt ?? this.emailConfirmedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'last_sign_in_at': lastSignInAt,
      'role': role,
      'phone_confirmed_at': phoneConfirmedAt,
      'instance_id': instanceId,
      'phone': phone,
      'recovery_token': recoveryToken,
      'raw_app_meta_data': rawAppMetaData,
      'confirmation_sent_at': confirmationSentAt,
      'recovery_sent_at': recoverySentAt,
      'raw_user_meta_data': rawUserMetaData,
      'id': id,
      'created_at': createdAt,
      'phone_change_token': phoneChangeToken,
      'phone_change_sent_at': phoneChangeSentAt,
      'confirmed_at': confirmedAt,
      'is_super_admin': isSuperAdmin,
      'phone_change': phoneChange,
      'email_change_sent_at': emailChangeSentAt,
      'email_change_token_new': emailChangeTokenNew,
      'updated_at': updatedAt,
      'email': email,
      'email_change_confirm_status': emailChangeConfirmStatus,
      'encrypted_password': encryptedPassword,
      'invited_at': invitedAt,
      'email_change_token_current': emailChangeTokenCurrent,
      'aud': aud,
      'email_change': emailChange,
      'confirmation_token': confirmationToken,
      'email_confirmed_at': emailConfirmedAt,
    };
  }

  String toJson() => jsonEncode(toMap());
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.lastSignInAt == lastSignInAt &&
        other.role == role &&
        other.phoneConfirmedAt == phoneConfirmedAt &&
        other.instanceId == instanceId &&
        other.phone == phone &&
        other.recoveryToken == recoveryToken &&
        other.rawAppMetaData == rawAppMetaData &&
        other.confirmationSentAt == confirmationSentAt &&
        other.recoverySentAt == recoverySentAt &&
        other.rawUserMetaData == rawUserMetaData &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.phoneChangeToken == phoneChangeToken &&
        other.phoneChangeSentAt == phoneChangeSentAt &&
        other.confirmedAt == confirmedAt &&
        other.isSuperAdmin == isSuperAdmin &&
        other.phoneChange == phoneChange &&
        other.emailChangeSentAt == emailChangeSentAt &&
        other.emailChangeTokenNew == emailChangeTokenNew &&
        other.updatedAt == updatedAt &&
        other.email == email &&
        other.emailChangeConfirmStatus == emailChangeConfirmStatus &&
        other.encryptedPassword == encryptedPassword &&
        other.invitedAt == invitedAt &&
        other.emailChangeTokenCurrent == emailChangeTokenCurrent &&
        other.aud == aud &&
        other.emailChange == emailChange &&
        other.confirmationToken == confirmationToken &&
        other.emailConfirmedAt == emailConfirmedAt;
  }

  @override
  int get hashCode {
    return lastSignInAt.hashCode ^
        role.hashCode ^
        phoneConfirmedAt.hashCode ^
        instanceId.hashCode ^
        phone.hashCode ^
        recoveryToken.hashCode ^
        rawAppMetaData.hashCode ^
        confirmationSentAt.hashCode ^
        recoverySentAt.hashCode ^
        rawUserMetaData.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        phoneChangeToken.hashCode ^
        phoneChangeSentAt.hashCode ^
        confirmedAt.hashCode ^
        isSuperAdmin.hashCode ^
        phoneChange.hashCode ^
        emailChangeSentAt.hashCode ^
        emailChangeTokenNew.hashCode ^
        updatedAt.hashCode ^
        email.hashCode ^
        emailChangeConfirmStatus.hashCode ^
        encryptedPassword.hashCode ^
        invitedAt.hashCode ^
        emailChangeTokenCurrent.hashCode ^
        aud.hashCode ^
        emailChange.hashCode ^
        confirmationToken.hashCode ^
        emailConfirmedAt.hashCode;
  }

  @override
  String toString() {
    return 'Users(lastSignInAt: $lastSignInAt, role: $role, phoneConfirmedAt: $phoneConfirmedAt, instanceId: $instanceId, phone: $phone, recoveryToken: $recoveryToken, rawAppMetaData: $rawAppMetaData, confirmationSentAt: $confirmationSentAt, recoverySentAt: $recoverySentAt, rawUserMetaData: $rawUserMetaData, id: $id, createdAt: $createdAt, phoneChangeToken: $phoneChangeToken, phoneChangeSentAt: $phoneChangeSentAt, confirmedAt: $confirmedAt, isSuperAdmin: $isSuperAdmin, phoneChange: $phoneChange, emailChangeSentAt: $emailChangeSentAt, emailChangeTokenNew: $emailChangeTokenNew, updatedAt: $updatedAt, email: $email, emailChangeConfirmStatus: $emailChangeConfirmStatus, encryptedPassword: $encryptedPassword, invitedAt: $invitedAt, emailChangeTokenCurrent: $emailChangeTokenCurrent, aud: $aud, emailChange: $emailChange, confirmationToken: $confirmationToken, emailConfirmedAt: $emailConfirmedAt)';
  }
}
