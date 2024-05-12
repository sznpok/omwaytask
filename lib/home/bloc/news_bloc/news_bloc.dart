import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:omwaytech/home/repo/news_repo.dart';

import '../../model/news_model.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<LoadingNewsEvent>(loadingNewsEvent);
  }

  FutureOr<void> loadingNewsEvent(
      LoadingNewsEvent event, Emitter<NewsState> emit) async {
    NewsRepo newsRepo = NewsRepo();
    emit(NewsLoadingState());
    final result = await newsRepo.getNews();
    if (result.isNotEmpty) {
      emit(NewsSuccessState(news: result));
    } else {
      emit(NewErrorState());
    }
  }
}
