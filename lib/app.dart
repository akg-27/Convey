import 'package:convey/features/auth/data/firebase_auth_repo.dart';
import 'package:convey/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:convey/features/auth/presentation/cubits/auth_states.dart';
import 'package:convey/features/auth/presentation/pages/auth_page.dart';
import 'package:convey/features/home/presentation/pages/home_page.dart';
import 'package:convey/features/post/data/firebase_post_repo.dart';
import 'package:convey/features/post/presentation/cubits/post_cubit.dart';
import 'package:convey/features/profile/data/firebase_profile_repo.dart';
import 'package:convey/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:convey/features/search/data/firebase_search_repo.dart';
import 'package:convey/features/search/presentation/cubits/search_cubit.dart';
import 'package:convey/features/storage/data/supabase_storage_repo.dart';
import 'package:convey/themes/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*

  APP - ROOT LEVEL


  Repositories: for the  databse
    -firebase

  Bloc Providers for state management
    -auth
    -profile
    -search
    -theme

  Check Authentication
    - unauthenticated -> auth page (login/register)
    - authenticated -> home page 
*/
class MyApp extends StatelessWidget {
  // auth repo
  final firebaseAuthRepo = FirebaseAuthRepo();

  // profile repo
  final firebaseProfileRepo = FirebaseProfileRepo();

  // storage repo
  final supabaseStorageRepo = SupabaseStorageRepo();

  // post repo
  final firebasePostRepo = FirebasePostRepo();

  // search repo
  final firebaseSearchRepo = FirebaseSearchRepo();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // provide cubit to app
    return MultiBlocProvider(
      providers: [
        // Auth Cubit
        BlocProvider<AuthCubit>(
          create:
              (context) => AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),
        ),

        // Profile Cubit
        BlocProvider<ProfileCubit>(
          create:
              (context) => ProfileCubit(
                profileRepo: firebaseProfileRepo,
                storageRepo: supabaseStorageRepo,
              ),
        ),

        // Post Cubit
        BlocProvider<PostCubit>(
          create:
              (context) => PostCubit(
                postRepo: firebasePostRepo,
                storageRepo: supabaseStorageRepo,
              ),
        ),

        // Search Cubit
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(searchRepo: firebaseSearchRepo),
        ),

        // Theme Cubit
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
      ],

      // bloc builder : themes
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder:
            (context, currentTheme) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: currentTheme,

              // bloc builder check current auth state
              home: BlocConsumer<AuthCubit, AuthState>(
                builder: (context, authState) {

                  // unauthenticated -> AuthPage(login/register)
                  if (authState is Unauthenticated) {
                    return const AuthPage();
                  }
                  // authenticated -> HomePage
                  if (authState is Authenticated) {
                    return const HomePage();
                  }
                  // loading..
                  else {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
                listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
              ),
            ),
      ),
    );
  }
}
