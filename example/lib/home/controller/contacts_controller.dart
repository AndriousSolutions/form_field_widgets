//

import '/src/controller.dart';

import '/src/model.dart';

import '/src/view.dart';

///
class ContactsController extends AppStateXController {
  ///
  factory ContactsController([StateX? state]) =>
      _this ??= ContactsController._(state);

  ContactsController._([StateX? state])
      : model = ContactsDB(),
        super(state);

  ///
  final ContactsDB model;
  static ContactsController? _this;

  @override
  Future<bool> initAsync() async {
    _sortedAlpha = Prefs.getBool(sortKEY, false);
    final init = await model.initState();
    if (init) {
      await getContacts();
    }
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: initState in $appState');
    }
    return init;
  }

  /// Indicate if the records are sorted
  bool get sortedAlpha => _sortedAlpha;
  late bool _sortedAlpha;

  ///
  static const String sortKEY = 'sort_by_alpha';

  @override
  bool onAsyncError(FlutterErrorDetails details) {
    /// Supply an 'error handler' routine if something goes wrong
    /// in the corresponding initAsync() routine.
    /// Returns true if the error was properly handled.
    return false;
  }

  /// The framework calls this method when the [StateX] object removed from widget tree.
  /// i.e. The screen is closed.
  @override
  void deactivate() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: deactivate in $appState');
    }
  }

  /// Called when this State object was removed from widget tree for some reason
  /// Undo what was done when [deactivate] was called.
  @override
  void activate() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: activate in $appState');
    }
  }

  @override
  void dispose() {
    model.dispose();
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ now disposed for $state.');
    }
    super.dispose();
  }

  ///
  Future<List<Contact>> getContacts() async {
    _contacts = await model.getContacts();
    if (_sortedAlpha) {
      _contacts!.sort();
    }
    return _contacts!;
  }

  /// Retrieve any new contacts or display any changes made.
  Future<void> refresh() async {
    await getContacts();
    super.setState(() {});
  }

  /// Called by menu option
  Future<List<Contact>> sort() async {
    _sortedAlpha = !_sortedAlpha;
    await Prefs.setBool(sortKEY, _sortedAlpha);
    await refresh();
    return _contacts!;
  }

  ///
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ///
  List<Contact>? get items => _contacts;
  List<Contact>? _contacts;

  ///
  Contact? itemAt(int index) => items?.elementAt(index);

  ///
  Future<bool> deleteItem(int index) async {
    final Contact? contact = items?.elementAt(index);
    var delete = contact != null;
    if (delete) {
      delete = await contact.delete();
    }
    await refresh();
    return delete;
  }

  /// The application is not currently visible to the user, not responding to
  /// user input, and running in the background.
  @override
  void pausedAppLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: pausedLifecycleState in $appState');
    }
  }

  /// Called when app returns from the background
  @override
  void resumedAppLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: resumedLifecycleState in $appState');
    }
  }

  /// The application is in an inactive state and is not receiving user input.
  @override
  void inactiveAppLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: inactiveLifecycleState in $appState');
    }
  }

  /// Either be in the progress of attaching when the engine is first initializing
  /// or after the view being destroyed due to a Navigator pop.
  @override
  void detachedAppLifecycleState() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: detachedLifecycleState in $appState');
    }
  }

  /// Override this method to respond when the [StatefulWidget] is recreated.
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didUpdateWidget in $appState');
    }
  }

  /// Called when this [StateX] object is first created immediately after [initState].
  /// Otherwise called only if this [State] object's Widget
  /// is a dependency of [InheritedWidget].
  @override
  void didChangeDependencies() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeDependencies in $appState');
    }
  }

  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  void reassemble() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: reassemble in $appState');
    }
  }

  /// Called when the system tells the app to pop the current route.
  /// For example, on Android, this is called when the user presses
  /// the back button.
  @override
  Future<bool> didPopRoute() async {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPopRoute in $appState');
    }
    return super.didPopRoute();
  }

  /// Called when the host tells the application to push a new
  /// [RouteInformation] and a restoration state onto the router.
  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPushRouteInformation in $appState');
    }
    return super.didPushRouteInformation(routeInformation);
  }

  /// The top route has been popped off, and this route shows up.
  @override
  void didPopNext() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPopNext in $appState');
    }
  }

  /// Called when this route has been pushed.
  @override
  void didPush() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPush in $appState');
    }
  }

  /// Called when this route has been popped off.
  @override
  void didPop() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPop in $appState');
    }
  }

  /// New route has been pushed, and this route is no longer visible.
  @override
  void didPushNext() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didPushNext in $appState');
    }
  }

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeMetrics in $appState');
    }
  }

  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeTextScaleFactor in $appState');
    }
  }

  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangePlatformBrightness in $appState');
    }
  }

  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeLocale in $appState');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Passing these possible values:
    /// AppLifecycleState.inactive (may be paused at any time)
    /// AppLifecycleState.paused (may enter the suspending state at any time)
    /// AppLifecycleState.detach
    /// AppLifecycleState.resume
    if (inDebugMode) {
      //ignore: avoid_print
      print(
          '############ Event: didChangeAppLifecycleState in ${this.state} for $this');
    }
  }

  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didHaveMemoryPressure in $appState');
    }
  }

  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: didChangeAccessibilityFeatures in $appState');
    }
  }
}
