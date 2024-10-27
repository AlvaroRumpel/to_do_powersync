import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_data_source.dart';

class HomeRepositoryImpl implements HomeRepository{
  final HomeDataSource _dataSource;

  HomeRepositoryImpl({required HomeDataSource dataSource}) : _dataSource = dataSource;
}