import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:omwaytech/constants/color_constant.dart';
import 'package:omwaytech/constants/image_constant.dart';
import 'package:omwaytech/home/bloc/news_bloc/news_bloc.dart';
import 'package:omwaytech/home/ui/fetch_data.dart';
import 'package:omwaytech/home/ui/news_details_screen.dart';
import 'package:omwaytech/utils/api.dart';
import 'package:omwaytech/utils/custom_storage.dart';

import '../../auth/ui/login_screen.dart';
import '../../utils/size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.id});

  final String? id;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(LoadingNewsEvent());
    super.initState();
  }

  String? authId;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Omway News"),
            IconButton(
              onPressed: () {
                deleteTokenAccess();
                deleteID();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewErrorState) {
            return const Center(
              child: Text("Error to Load news data"),
            );
          } else if (state is NewsLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is NewsSuccessState) {
            return state.news!.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<NewsBloc>(context)
                          .add(LoadingNewsEvent());
                    },
                    backgroundColor: primaryLightColor,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.news!.length,
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.padding! * 0.01,
                              vertical: SizeConfig.padding! * 0.01,
                            ),
                            itemBuilder: (c, i) {
                              DateTime dateTime = DateTime.parse(
                                  state.news![i].createdAt.toString());
                              final data = dateFormat.format(dateTime);
                              authId = state.news![i].authorId.toString();
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewsDetailsScreen(
                                                newsModel: state.news![i],
                                              )));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                    SizeConfig.padding! * 0.02,
                                  )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              SizeConfig.padding! * 0.02),
                                          bottomLeft: Radius.circular(
                                              SizeConfig.padding! * 0.02),
                                        ),
                                        child: state.news![i].image != null
                                            ? CachedNetworkImage(
                                                imageUrl:
                                                    "${Api.imageApi}/${state.news![i].image}",
                                                //height: SizeConfig.screenHeight! * 0.1,
                                                width: SizeConfig.screenWidth! *
                                                    0.3,
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, string, _) {
                                                  return Image.asset(
                                                    ImageConstant.logoImage,
                                                    height: SizeConfig
                                                            .screenHeight! *
                                                        0.1,
                                                    width: SizeConfig
                                                            .screenWidth! *
                                                        0.3,
                                                  );
                                                },
                                                placeholder: (context, string) {
                                                  return Icon(
                                                    Icons.image,
                                                    size: SizeConfig
                                                            .screenHeight! *
                                                        0.1,
                                                  );
                                                },
                                                // width: SizeConfig.screenWidth! * 0.2,
                                              )
                                            : Image.asset(
                                                ImageConstant.logoImage,
                                                height:
                                                    SizeConfig.screenHeight! *
                                                        0.1,
                                                width: SizeConfig.screenWidth! *
                                                    0.3,
                                              ),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.screenWidth! * 0.015,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.news![i].title!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    color: primaryLightColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                            SizedBox(
                                              height: SizeConfig.screenHeight! *
                                                  0.01,
                                            ),
                                            Text(
                                              state.news![i].description!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: textLightColor,
                                                  ),
                                            ),
                                            SizedBox(
                                              height: SizeConfig.screenHeight! *
                                                  0.01,
                                            ),
                                            Text(
                                              data,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FetchOwnDatScreen(
                                  userID: widget.id,
                                  authorID: state.news![0].authorId.toString(),
                                ),
                              ),
                            );
                          },
                          child: const Text("Fetch Own Data"),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Text(
                      "There is no any news",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: textLightColor),
                    ),
                  );
          } else {
            return Center(
              child: Text(
                "There is no any news",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: textLightColor),
              ),
            );
          }
        },
      ),
    );
  }
}
