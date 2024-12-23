import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pots_app/presentation/bloc/post/posts_blok.dart';
import 'package:pots_app/presentation/bloc/post/posts_events.dart';
import 'package:pots_app/presentation/bloc/post_add_delete_update_bloc/post_add_delete_update_bloc.dart';
import 'package:pots_app/src/core/routes/app_routes.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(DevicePreview(builder: (context) => MyApp(
    appRouter: AppRouter(),
  )));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({
    super.key,
    required this.appRouter,
  });

  @override
  Widget build (BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())
        ),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: DevicePreview.appBuilder,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}

    