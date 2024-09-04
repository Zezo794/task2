import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/shared/MainCubit/cubit.dart';
import 'package:task2/shared/MainCubit/states.dart';

import '../../shared/component/componanets.dart';
import '../../shared/component/constans.dart';
import '../pdfScreen/pdfScreen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   var cubit=AppCubit.get(context);

    return BlocConsumer<AppCubit,AppState>(
      listener: (BuildContext context, AppState state) {  },
      builder: (BuildContext context, AppState state) {
        return Scaffold(
            backgroundColor: const Color(0xFFE0E4C9),
            appBar: AppBar(
              leading: const SizedBox.shrink(),
              backgroundColor: Colors.black54,
              title: const Text('القصائد المفضلة'),
              actions: [
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_forward)
                )
              ],
            ),
            body: cubit.allFavoritesTitles.isNotEmpty?ListView.separated(

              itemBuilder: (context, index) {
                final title = cubit.allFavoritesTitles[index];
                return ListTile(
                  title:  Text(title),
                  trailing:const Icon(Icons.arrow_back_ios_new_outlined),
                  onTap: (){
                    cubit.changeSelectedItem(title);
                    int pageIndex = titles
                        .firstWhere((element) => element.containsKey(title), orElse: () => {})
                        .values
                        .first;
                    cubit.onPdfPageChanged(pageIndex);
                    NavigateTo(context, const PdfViewerPage());
                  },

                );

              },
              separatorBuilder: (context, index) {

                return Column(
                  children: [
                    const SizedBox(height: 3,),
                    Container(height: 1,color: Colors.black54,),
                    const SizedBox(height: 3,),
                  ],
                );

              },
              itemCount: cubit.allFavoritesTitles.length,
            ):
          const Center(child:Text('لا يوجد قصائد مفضلة',style: TextStyle(color: Colors.black54,fontSize: 24),) ,)
        );
      },


    );
  }
}