import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/contacts/screens/contacts_screen.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatApp',
      debugShowCheckedModeBanner: false,
      home: const ContactsScreen(),
    );
  }
}