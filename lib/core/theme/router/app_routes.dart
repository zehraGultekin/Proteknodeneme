enum AppRoute {
  login(name: 'login', path: '/login'),
  home(name: 'home', path: '/home');

  final String name;
  final String path;

  const AppRoute({required this.name, required this.path});
}
