import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/sarsh/cubit/states.dart';
import 'package:shop_app/shared/network/end_poient.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  static String token = CacheHelper.getData(key: 'token');

  SearchModel model;

  void serch(String text) {
    emit(SearchLoadingState());
    DioHelper.pastData(
      url: SEARCH,
      token:token,
      data:
      {
      'text': text,
    },
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
