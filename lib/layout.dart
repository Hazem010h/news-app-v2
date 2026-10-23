import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'AppStates.dart';
import 'NewsCubit.dart';
import 'SearchScreen.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){

        var cubit=NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'News App',
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                    },
                  icon: const Icon(Icons.search,),
              ),
              IconButton(onPressed: (){cubit.changeTheme();}, icon: Icon(Icons.dark_mode_outlined)),
            ],
          ),
          body: cubit.screens[cubit.currentScreen],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeScreen(index);
            },
            currentIndex: cubit.currentScreen,
            items: cubit.bottomBar,
          ),
        );
      },
    );
  }
}
