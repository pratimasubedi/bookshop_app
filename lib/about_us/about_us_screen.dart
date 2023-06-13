import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookshop_app/about_us/cubit/about_us_cubit.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AboutUsBody();
  }
}

class AboutUsBody extends StatelessWidget {
  const AboutUsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 80,
          ),
          child: BlocBuilder<AboutUsCubit, AboutUsState>(
            builder: (context, state) {
              if (state is AboutUsFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AboutUsFetchFailure) {
                return const Center(
                  child: Text(
                    'अहिले उपलब्ध हुन सकेन',
                  ),
                );
              } else if (state is AboutUsFetchSuccess) {
                var aboutList = state.aboutList;
                return aboutList.isEmpty
                    ? Center(
                        child: Text(
                          'डाटा खाली छ।',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      )
                    : Column(
                        children: [
                          for (var aboutItem in aboutList)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  aboutItem.title,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Html(
                                  data: aboutItem.description,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            )
                        ],
                      );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
