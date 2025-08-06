import '../../../../../core/api/api_endpoints.dart';
import '../../../../../core/api/api_service.dart';
import '../../../../../core/functions/cache_random_fact.dart';
import '../../../domain/entities/fact_entity.dart';
import '../../models/fact_model.dart';
import 'main_remote_data_source.dart';

class MainRemoteDataSourceImpl implements MainRemoteDataSource {
  MainRemoteDataSourceImpl(this._apiService);

  final ApiService _apiService;

  @override
  Future<FactEntity> fetchRandomFact() async {
    final data = await _apiService.get(endpoint: ApiEndpoints.getRandomFact);
    final model = FactModel.fromJson(data);
    final entity = model.toEntity();
    await cacheRandomFact(entity);
    return entity;
  }
}
