import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dummy_state.dart';

class DummyCubit extends Cubit<DummyState> {
  DummyCubit() : super(DummyInitial());
}
