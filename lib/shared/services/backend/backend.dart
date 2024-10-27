import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

class Backend {
  final _client = Supabase.instance.client;

  /// AUTHENTICATION SECTION
  bool get isLogged => _client.auth.currentSession?.accessToken != null;
  String? get userId => _client.auth.currentSession?.user.id;
  // Get current user
  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get onAuthStateChanges => _client.auth.onAuthStateChange;

  // Sign up a new user with email and password
  Future<AuthResponse?> signUp(String email, String password) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (error) {
      print('Sign Up Error: $error');
      return null;
    }
  }

  // Sign in with email and password
  Future<AuthResponse?> signIn(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (error) {
      print('Sign In Error: $error');
      return null;
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (error) {
      print('Sign Out Error: $error');
    }
  }

  /// DATABASE SECTION

  // Fetch data from a specific table with optional filtering
  Future<List<Map<String, dynamic>>?> fetchData(
    String table, {
    Map<String, dynamic>? filters,
  }) async {
    try {
      var query = _client.from(table).select();

      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      final response = await query;
      return response as List<Map<String, dynamic>>?;
    } catch (error) {
      print('Fetch Data Error: $error');
      return null;
    }
  }

  // Insert data into a specific table
  Future<void> insertData(String table, Map<String, dynamic> data) async {
    try {
      await _client.from(table).insert(data);
    } catch (error) {
      print('Insert Data Error: $error');
    }
  }

  // Update data in a specific table
  Future<void> updateData({
    required String table,
    required Map<String, dynamic> data,
    required String column,
    required dynamic value,
  }) async {
    try {
      await _client.from(table).update(data).eq(column, value);
    } catch (error) {
      print('Update Data Error: $error');
    }
  }

  // Delete data from a specific table
  Future<void> deleteData(String table, String column, dynamic value) async {
    try {
      await _client.from(table).delete().eq(column, value);
    } catch (error) {
      print('Delete Data Error: $error');
    }
  }

  /// STORAGE SECTION

  // Upload a file to a specific bucket
  Future<void> uploadFile({
    required String bucket,
    required String path,
    required dynamic file,
  }) async {
    try {
      await _client.storage.from(bucket).upload(path, file);
    } catch (error) {
      print('File Upload Error: $error');
    }
  }

  // Download a file from a specific bucket
  Future<String?> downloadFile(String bucket, String path) async {
    try {
      final response = await _client.storage
          .from(bucket)
          .createSignedUrl(path, 60); // expires in 60 seconds
      return response;
    } catch (error) {
      print('File Download Error: $error');
      return null;
    }
  }

  /// REAL-TIME SECTION

  // Subscribe to a table for real-time updates
  Stream<List<Map<String, dynamic>>> subscribe(String table) {
    return _client
        .from(table)
        .stream(primaryKey: ['*']).asyncMap((event) => event);
  }

  /// Subscribe with a callback for easier handling of incoming data
  StreamSubscription<List<Map<String, dynamic>?>>? subscribeWithCallback(
    String table, {
    required void Function(List<Map<String, dynamic>>? data) onData,
  }) {
    final subscription = subscribe(table).listen(onData);
    return subscription;
  }

// Unsubscribe from a table
  void unsubscribe(String table) {
    // The `stream()` method returns a `StreamSubscription` in Dart
    // So to unsubscribe, simply cancel the subscription.

    final subscription =
        _client.from(table).stream(primaryKey: ['*']).listen((_) {});
    subscription.cancel();
  }
}
