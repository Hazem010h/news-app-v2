import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_news_app/reusable_function.dart';
import 'AppStates.dart';
import 'NewsCubit.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,AppStates>(
        listener:(context,state){},
        builder:(context,state){

          NewsCubit cubit=NewsCubit.get(context);
          List articales=cubit.articales;

          return ConditionalBuilder(
            condition: articales.isNotEmpty ,
            builder: (context)=> ListView.separated(
              itemBuilder: (context,index)=>buildArticaleItem(articales[index],context),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: articales.length,
            ),
            fallback: (context)=>const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
    );
  }
}
