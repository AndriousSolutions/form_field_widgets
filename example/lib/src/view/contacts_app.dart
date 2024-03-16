//
// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//

import 'package:example/src/controller.dart';

import 'package:example/src/view.dart';

/// App
class FormFieldsExampleApp extends AppStatefulWidget {
  FormFieldsExampleApp({super.key});
  // This is the 'App State object' of the application.
  @override
  AppState createAppState() => _ExampleAppState();
}

/// This is the 'View' of the application.
/// The 'look and behavior' of the app.
///
class _ExampleAppState extends AppState {
  _ExampleAppState()
      : super(
          controller: ContactsController(),
          inTitle: () => 'Demo App',
          inDebugShowCheckedModeBanner: () => false,
          switchUI: Prefs.getBool('switchUI'),
          useRouterConfig: false,
          inSupportedLocales: () {
            return L10n.supportedLocales;
          },
          localizationsDelegates: [
            L10n.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          allowChangeLocale: true, // Allow the app to change locale
          allowChangeUI: true, // Allow the app to change its design interface
          inInitAsync: () => Future.value(true), // Merely a test.
          inInitState: () {/* Optional inInitState() function */},
          home: const ContactsList(),
        );
}
