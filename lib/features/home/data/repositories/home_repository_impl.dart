import 'package:sqflite/sqflite.dart';

import '../../domain/entities/home_models.dart';
import '../../domain/repositories/home_repository.dart';
import '../services/sqlite/home_dao.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._db) : _dao = HomeDao(_db);

  final Database _db;
  final HomeDao _dao;

  @override
  Future<List<HomeCategory>> loadCategories() async {
    final rows = await _dao.getActiveCategories();
    return rows.map((r) {
      return HomeCategory(
        id: (r['id'] as String?) ?? '',
        name: (r['name'] as String?) ?? '',
        iconKey: (r['iconKey'] as String?) ?? '',
        quizCount: (r['quizCount'] as int?) ?? 0,
      );
    }).toList();
  }

  @override
  Future<List<FeaturedQuiz>> loadFeaturedQuizzes() async {
    final rows = await _dao.getFeaturedPublicQuizzes();
    return rows.map((r) {
      return FeaturedQuiz(
        id: (r['id'] as String?) ?? '',
        title: (r['title'] as String?) ?? '',
        subtitle: (r['subtitle'] as String?) ?? '',
      );
    }).toList();
  }
}
