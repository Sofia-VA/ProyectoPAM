import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:viajes/home/home_page.dart';

// import 'calendarPages/bloc/calendar_bloc.dart';
import 'custom_widgets/comments/bloc/comment_bloc.dart';
// import 'experience/bloc/experiences_bloc.dart';
import 'home/bloc/home_bloc.dart';
import 'location/bloc/location_bloc.dart';
import 'location/experiences/experience_page.dart';
import 'location/experiences/experience_provider.dart';
import 'location/location_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  return runApp(
    MultiBlocProvider(
      providers: [
        //BlocProvider(create: (context) => GoogleAuthBloc()..add(VerifyGoogleAuthEvent()),),
        BlocProvider(create: (context) => CommentBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        // BlocProvider(
        //   create: (context) => ExperiencesBloc(),
        // ),
        // BlocProvider(
        //   create: (context) => CalendarBloc(),
        // ),
      ],
      child: MultiProvider(providers: [
        Provider<ExperienceProvider>(create: (_) => ExperienceProvider()),
      ], child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
          // General colors
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              secondary: Color.fromARGB(255, 2, 114, 60)),
          primaryColor: Colors.teal[300],

          // Specific colors
          iconTheme: IconThemeData(color: Colors.teal[700]),
          listTileTheme: ListTileThemeData(iconColor: Colors.deepPurple[700]),
          scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.all(Colors.teal[700])),
          // Text Themes
          fontFamily: 'Lato',
          textTheme: TextTheme(bodyText2: TextStyle(height: 1.4))),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/LocationPage': (context) => LocationPage(
              locationID: null,
            ),
        '/ExperiencePage': (context) => ExperiencePage(
              experience: {},
            ),
      },
    );
  }
}
