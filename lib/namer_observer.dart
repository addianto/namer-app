import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

class NamerObserver extends BlocObserver {
  const NamerObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    Logger().d('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    Logger().e('${bloc.runtimeType} $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
