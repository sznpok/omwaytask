import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omwaytech/home/bloc/news_bloc/news_bloc.dart';

class FetchOwnDatScreen extends StatefulWidget {
  const FetchOwnDatScreen({super.key, this.userID, this.authorID});

  final String? userID;

  final String? authorID;

  @override
  State<FetchOwnDatScreen> createState() => _FetchOwnDatScreenState();
}

class _FetchOwnDatScreenState extends State<FetchOwnDatScreen> {
  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(LoadingNewsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsSuccessState) {
            return widget.userID == widget.authorID
                ? ListView.builder(
                    itemBuilder: (c, i) {
                      return ListTile(
                        title: Text(state.news![i].title!),
                        subtitle: Text(state.news![i].description!),
                      );
                    },
                    itemCount: 1,
                  )
                : const Center(child: Text("no data found"));
          } else if (state is NewsLoadingState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is NewErrorState) {
            const Center(
              child: Text("Error Text"),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
