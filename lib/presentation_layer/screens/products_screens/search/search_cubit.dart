import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/data_layer/network/end_points.dart';
import 'package:shop_app/data_layer/network/remote/dio_helper.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/presentation_layer/widgets/SharedWidgets.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  SearchModel model;
  void search({String text}){
    emit(SearchLoading());
    DioHelper.postData(url: SEARCH, data: {'text':text},token: token).then((value){
      model = SearchModel.fromJson(value.data);
      printFullText(model.data.data.length.toString());
      emit(SearchSuccess());
    }).catchError((err){
      print('err search is ${err.toString()}');
      emit(SearchError(err.toString()));
    });
  }

}
