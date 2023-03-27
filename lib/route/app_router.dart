import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/', page: SplashRoute.page),
    AutoRoute(
        path: '/authentication',
        page: AuthenticationRouter.page,
        children: [
          AutoRoute(path: '', page: SignInRoute.page),
          AutoRoute(path: 'register', page: RegisterRoute.page),
        ]),
    AutoRoute(path: '/home', page: HomeRouter.page, children: [
      AutoRoute(path: '', page: NotesRouter.page, children: [
        AutoRoute(path: '', page: NoteListRoute.page),
        AutoRoute(page: NotePreviewRoute.page),
        AutoRoute(page: NewNoteRoute.page),
        AutoRoute(page: UpdateNoteRoute.page),
        AutoRoute(page: TagsManageRoute.page),
      ]),
      AutoRoute(path: 'userAccount', page: AccountRouter.page, children: [
        AutoRoute(path: '', page: UserAccountPreviewRoute.page),
        AutoRoute(page: UserAccountUpdateRoute.page),
      ]),
    ]),
  ];
}
