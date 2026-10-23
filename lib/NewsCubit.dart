import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'AppStates.dart';
import 'BusinessScreen.dart';
import 'ScienceScreen.dart';
import 'SportsScreen.dart';
import 'cache_helper.dart';
import 'constants.dart';
import 'dio_helper.dart';
import 'news_model.dart';

class NewsCubit extends Cubit<AppStates>{
  NewsCubit():super(InitState());

  static NewsCubit get(context)=>BlocProvider.of(context);

  bool darkTheme=false;
  int currentScreen=0;
  List<BottomNavigationBarItem> bottomBar=[
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];
  List<Widget>screens=[
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];
  List<NewsModel> articales=[];

  void changeTheme({bool? fromShared}){
    if(fromShared != null){
      darkTheme= fromShared;
    }else{
      darkTheme= !darkTheme;
    }
    CacheHelper.putData(key: darkModeKey, value: darkTheme).then((value) {
      emit(ChangeAppTheme());
      emit(GetDataSuccessState());
    });
  }

  void changeScreen(int index){
    if(index==0){
      getData(category: 'business');
    }
    else if(index==1){
      getData(category: 'sports');
    }
    else{
      getData(category: 'science');
    }
    currentScreen=index;
    emit(ChangeScreenState());
  }

  void getData({
    required String category
}){
    emit(GetDataLoadingState());
    articales=[];
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':category,
        'apiKey':apiKey,
      },
    ).then((value){
      articales=NewsModel.fromJsonList(value.data['articles']);
      if(articales.isNotEmpty) print(articales[0].title);
      emit(GetDataSuccessState());
    }
    ).catchError((e){
      print(e.toString());
      emit(GetDataErrorState());
    }
    );
  }


}