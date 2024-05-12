part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsSuccessState extends NewsState {
  final List<NewsModel>? news;

  NewsSuccessState({this.news});
}

final class NewErrorState extends NewsState {}

final class NewsLoadingState extends NewsState {}
