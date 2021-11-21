// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';
import '../routing.dart';
import '../widgets/book_list.dart';
import '../widgets/library_scope.dart';

class BooksScreen extends StatefulWidget {
  final ParsedRoute currentRoute;

  const BooksScreen({
    Key? key,
    required this.currentRoute,
  }) : super(key: key);

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(_handleTabIndexChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newPath = routeState.route.pathTemplate;
    if (newPath.startsWith('/books/popular')) {
      _tabController.index = 0;
    } else if (newPath.startsWith('/books/new')) {
      _tabController.index = 1;
    } else if (newPath == '/books/all') {
      _tabController.index = 2;
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndexChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final library = LibraryScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Popular',
              icon: Icon(Icons.people),
            ),
            Tab(
              text: 'New',
              icon: Icon(Icons.new_releases),
            ),
            Tab(
              text: 'All',
              icon: Icon(Icons.list),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BookList(
            books: library.popularBooks,
            onTap: _handleBookTapped,
          ),
          BookList(
            books: library.newBooks,
            onTap: _handleBookTapped,
          ),
          BookList(
            books: library.allBooks,
            onTap: _handleBookTapped,
          ),
        ],
      ),
    );
  }

  String get title {
    switch (_tabController.index) {
      case 1:
        return 'New';
      case 2:
        return 'All';
      case 0:
      default:
        return 'Popular';
    }
  }

  RouteState get routeState => RouteStateScope.of(context)!;

  void _handleBookTapped(Book book) {
    routeState.go('/book/${book.id}');
  }

  void _handleTabIndexChanged() {
    switch (_tabController.index) {
      case 1:
        routeState.go('/books/new');
        break;
      case 2:
        routeState.go('/books/all');
        break;
      case 0:
      default:
        routeState.go('/books/popular');
        break;
    }
  }
}
