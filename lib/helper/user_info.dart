import 'package:shared_preferences/shared_preferences.dart'; // Import package SharedPreferences untuk menyimpan data lokal

// variable konstan untuk menyimpan data dalam SharedPreferences
const String TOKEN = "token";
const String USER_ID = 'userID';
const String USERNAME = 'username';

// Class untuk mengelola informasi pengguna yang disimpan di SharedPreferences
class UserInfo {
  // Method untuk menyimpan token
  Future setToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(TOKEN, value); // Menyimpan token dengan kunci TOKEN
  }

  // Method untuk mendapatkan token
  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(TOKEN); // Mengambil token dengan kunci TOKEN
  }

  // Method untuk menyimpan userID
  Future setUserID(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(USER_ID, value); // Menyimpan userID dengan kunci USER_ID
  }

  // Method untuk mendapatkan userID
  Future<String?> getUserID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(USER_ID); // Mengambil userID dengan kunci USER_ID
  }

  // Method untuk menyimpan username
  Future setUsername(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(USERNAME, value); // Menyimpan username dengan kunci USERNAME
  }

  // Method untuk mendapatkan username
  Future<String?> getUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(USERNAME); // Mengambil username dengan kunci USERNAME
  }

  // Method untuk menghapus semua data yang tersimpan (logout)
  Future<void> logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear(); // Menghapus semua data yang tersimpan
  }
}
