import 'package:flutter/material.dart';
import 'package:whatsappchatapp/features/contacts/widgets/%20contact_tile.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/chat_data.dart';
import '../widgets/contact_tile.dart';
import '../widgets/story_avatar.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSearching = false;
  String _searchQuery = '';
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark   = Theme.of(context).brightness == Brightness.dark;
    final contacts = _searchQuery.isEmpty
        ? ChatData.contacts
        : ChatData.contacts
            .where((c) => c.name.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.bgDark : const Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor:
            isDark ? AppTheme.appBarDark : AppTheme.appBarLight,
        title: _isSearching
            ? TextField(
                controller: _searchCtrl,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white60),
                  border: InputBorder.none,
                ),
                onChanged: (v) => setState(() => _searchQuery = v),
              )
            : const Text(
                'ChatApp',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search,
                color: Colors.white),
            onPressed: () => setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) {
                _searchQuery = '';
                _searchCtrl.clear();
              }
            }),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (_) {},
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'new_group',  child: Text('New group')),
              PopupMenuItem(value: 'starred',    child: Text('Starred messages')),
              PopupMenuItem(value: 'settings',   child: Text('Settings')),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: isDark ? AppTheme.primaryGreen : Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ── CHATS TAB ──────────────────────────────────
          CustomScrollView(
            slivers: [
              // Story row
              if (_searchQuery.isEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    color: isDark ? AppTheme.surfaceDark : Colors.white,
                    height: 106,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      children: [
                        StoryAvatar(
                          name: 'My Status',
                          initials: 'ME',
                          colorIndex: 8,
                          isMe: true,
                        ),
                        ...ChatData.contacts.take(5).map((c) => StoryAvatar(
                              name: c.name.split(' ').first,
                              initials: c.avatarInitials,
                              colorIndex: c.avatarColorIndex,
                              isOnline: c.isOnline,
                            )),
                      ],
                    ),
                  ),
                ),
              // Divider
              if (_searchQuery.isEmpty)
                SliverToBoxAdapter(
                  child: Divider(
                    height: 1,
                    color: isDark
                        ? Colors.white12
                        : Colors.black.withOpacity(0.08),
                  ),
                ),
              // Contact list
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => ContactTile(contact: contacts[i]),
                  childCount: contacts.length,
                ),
              ),
            ],
          ),
          // ── STATUS TAB ─────────────────────────────────
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle_outlined, size: 64,
                    color: isDark ? Colors.white24 : Colors.black26),
                const SizedBox(height: 16),
                Text('No status updates',
                    style: TextStyle(
                        color: isDark ? Colors.white38 : Colors.black38)),
              ],
            ),
          ),
          // ── CALLS TAB ──────────────────────────────────
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.call_outlined, size: 64,
                    color: isDark ? Colors.white24 : Colors.black26),
                const SizedBox(height: 16),
                Text('No recent calls',
                    style: TextStyle(
                        color: isDark ? Colors.white38 : Colors.black38)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.primaryGreen,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}