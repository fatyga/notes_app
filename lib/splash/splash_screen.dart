import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/authentication/domain/models/app_user.dart';
import 'package:notes_app/authentication/services/authentication_repository.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/route/app_router.dart';
import 'package:notes_app/route/app_router.gr.dart';
import 'package:notes_app/service_locator.dart';
import 'package:rxdart/rxdart.dart';



enum AuthenticationStatus { initial, userAuthenticated, userNotAuthenticated }

class NotesAppData {
  const NotesAppData(
      {required this.authenticationStatus,
        this.notesFromFirstFetch = const []});

  final AuthenticationStatus authenticationStatus;
  final List<Note> notesFromFirstFetch;
}

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthenticationRepository authentication =
  serviceLocator<AuthenticationRepository>();
  final NotesRepository notes = serviceLocator<NotesRepository>();

  late Stream<NotesAppData> authenticationChanges;

  @override
  void initState() {
    authenticationChanges = authentication.authenticationChanges.map<
        AuthenticationStatus>((AppUser? user) {
      if (user == null) {
        return AuthenticationStatus.userNotAuthenticated;
      } else {
        return AuthenticationStatus.userAuthenticated;
      }
    }).asyncMap<NotesAppData>((authStatus) async {
      if (authStatus == AuthenticationStatus.userAuthenticated) {
        final notesFromFirstFetch = await notes.notesChanges.take(1).last;
        print(notesFromFirstFetch);
        return NotesAppData(
            authenticationStatus: authStatus,
            notesFromFirstFetch: notesFromFirstFetch);
      } else {
        return NotesAppData(authenticationStatus: authStatus);
      }
    }).startWith(
        const NotesAppData(authenticationStatus: AuthenticationStatus.initial));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NotesAppData>(
      stream: authenticationChanges,
      builder: (context, AsyncSnapshot<NotesAppData> snapshot) =>


            AutoRouter.declarative(
                routes: (_) => [
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData ||
                      snapshot.data?.authenticationStatus ==
                          AuthenticationStatus.initial)
                    const SplashRoute()
                  else if (snapshot.data?.authenticationStatus ==
                      AuthenticationStatus.userAuthenticated)
                    HomeRouter(children: [
                      NotesRouter(children: [
                        NoteListRoute(
                            notesFromInitialFetch:
                            snapshot.data!.notesFromFirstFetch)
                      ])
                    ])
                  else
                    const AuthenticationRoute()
                ]),

          );

  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Center(
  //     child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
  //       Text('Notes App', style: Theme.of(context).textTheme.titleLarge),
  //       const SizedBox(height: 16),
  //       const CircularProgressIndicator()
  //     ]),
  //   ));
  // }
}

