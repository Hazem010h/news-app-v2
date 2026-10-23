import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_news_app/reusable_function.dart';

import 'AppStates.dart';
import 'NewsCubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){

        NewsCubit cubit = NewsCubit();
        TextEditingController searchController=TextEditingController();

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              ReusableTextFormField(
                  label: Text('Search'),
                  onTap: (){},
                  onChange: (String value){

                  },
                borderColor: Colors.deepOrange,
                  controller: searchController,
                  prefixIcon: Icon(Icons.search_rounded),
              ),
            ],
          ),
        );
      },
    );
  }
}
