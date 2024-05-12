import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omwaytech/constants/color_constant.dart';
import 'package:omwaytech/home/model/news_model.dart';
import 'package:omwaytech/utils/api.dart';

import '../../constants/image_constant.dart';
import '../../utils/size.dart';

class NewsDetailsScreen extends StatelessWidget {
  NewsDetailsScreen({super.key, this.newsModel});

  final NewsModel? newsModel;

  final dateFormat = DateFormat('MMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(newsModel!.createdAt.toString());
    final date = dateFormat.format(dateTime);
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            SizeConfig.padding! * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                newsModel!.title.toString(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: primaryLightColor,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.01),
              Text(
                date,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black.withOpacity(0.8),
                    ),
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.01),
              newsModel!.image != null
                  ? CachedNetworkImage(
                      imageUrl: "${Api.imageApi}/${newsModel!.image!}",
                      fit: BoxFit.cover,
                      placeholder: (context, string) {
                        return Icon(
                          Icons.image,
                          size: SizeConfig.screenHeight! * 0.1,
                        );
                      },
                      errorWidget: (context, string, _) {
                        return Image.asset(
                          ImageConstant.logoImage,
                        );
                      },
                    )
                  : Image.asset(
                      ImageConstant.logoImage,
                    ),
              SizedBox(height: SizeConfig.screenHeight! * 0.02),
              Text(
                newsModel!.description.toString(),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: textLightColor,
                    ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
