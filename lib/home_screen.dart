import 'package:descope/descope.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DescopeSession? session = Descope.sessionManager.session;

  Future<void> _logout() async {
    final refreshJwt = Descope.sessionManager.session?.refreshJwt;
    if (refreshJwt != null) {
      await Descope.auth.logout(refreshJwt);
      Descope.sessionManager.clearSession();
    }

    if (!mounted) return;
    context.pushReplacementNamed('welcome');
  }

  @override
  Widget build(BuildContext context) {
    if (session == null) {
      return const Scaffold(
        body: Center(
          child: Text('No user data available'),
        ),
      );
    }
    DescopeUser userInfo = session!.user;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hi, ${userInfo.name}!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Log out'),
            )
          ],
        ),
      ),
    );
  }
}
