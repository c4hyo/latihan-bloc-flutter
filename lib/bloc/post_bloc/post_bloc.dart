import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial/model/post.dart';
import 'package:bloc_tutorial/network/api_provider.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  @override
  PostState get initialState => PostInitial();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if(event is GetListPost){
      yield* _getListPost();
    }
  }
}

Stream<PostState> _getListPost() async*{
  ApiProvider _apiProvider = ApiProvider();
  yield PostWaiting();
  try{
  List<Post> data = await _apiProvider.getListPost();
    yield PostLoaded(listPost: data);
  }catch(e){
    yield PostError(errorMessage: e.toString());
  }
}
