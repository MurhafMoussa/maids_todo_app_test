import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioCacheInterceptorModule {
  @lazySingleton
  DioCacheInterceptor get dioCacheInterceptor {
    final CacheOptions options = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.refreshForceCache,
      maxStale: const Duration(
        days: 1,
      ),
    );
    return DioCacheInterceptor(options: options);
  }
}
