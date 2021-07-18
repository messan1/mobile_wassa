class AuthState {
  String acsessToken;
  String tokenType;
  String id;
  String username;
  String email;
  String role;
  bool isActive;
  bool isDeleted;
  AuthState(
      {
      this.acsessToken,
      this.tokenType,
      this.id,
      this.username,
      this.email,
      this.role,
      this.isActive,
      this.isDeleted
    }) {}
}
