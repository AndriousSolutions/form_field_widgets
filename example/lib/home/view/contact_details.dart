//
import '/src/model.dart';

import '/src/view.dart';

///
enum AppBarBehavior {
  ///
  normal,

  ///
  pinned,

  ///
  floating,

  ///
  snapping,
}

///
class ContactDetails extends StatefulWidget {
  ///
  const ContactDetails({required this.contact, Key? key}) : super(key: key);

  ///
  final Contact contact;
  @override
  State createState() => _ContactDetailsState();
}

class _ContactDetailsState extends StateX<ContactDetails> {
  @override
  void initState() {
    super.initState();
    contact = widget.contact;
  }

  late Contact contact;

  @override
  Widget buildAndroid(BuildContext context) => _BuildAndroid(state: this);

  @override
  Widget buildiOS(BuildContext context) => _BuildiOS(state: this);

  // Provide a means to 'edit' the details
  Future<void> editContact(Contact? contact, BuildContext context) async {
    final widget = AddContact(contact: contact, title: 'Edit a contact'.tr);
    PageRoute<void> route;
    if (App.useMaterial) {
      route =
          MaterialPageRoute<void>(builder: (BuildContext context) => widget);
    } else {
      route =
          CupertinoPageRoute<void>(builder: (BuildContext context) => widget);
    }
    await Navigator.of(context).push(route);
    final contacts = await contact!.model.getContacts();
    this.contact = contacts
        .firstWhere((contact) => contact.id.value == this.contact.id.value);
    setState(() {});
  }
}

// Android interface
class _BuildAndroid extends StatelessWidget {
  const _BuildAndroid({Key? key, required this.state}) : super(key: key);
  final _ContactDetailsState state;

  @override
  Widget build(BuildContext context) {
    final contact = state.contact;
    // Dart allows for local function declarations
    void onTap() {
      if (!contact.inForm) {
        state.editContact(contact, context);
      }
    }

    return Scaffold(
      appBar: AppBar(title: contact.displayName.text, actions: [
        TextButton(
          onPressed: () async {
            // Confirm the deletion
            final delete = await showBox(
                button01: OKOption(),
                button02: CancelOption(),
                text: 'Delete this contact?'.tr,
                context: context,
                useMaterial: App.useMaterial);

            if (delete) {
              //
              await contact.delete();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            }
          },
          child: const Icon(Icons.delete, color: Colors.white),
        ),
      ]),
      bottomNavigationBar: SimpleBottomAppBar(
        button01: HomeBarButton(onPressed: () {
          Navigator.of(context).pop();
        }),
        button03: EditBarButton(onPressed: onTap),
      ),
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            contact.givenName.onListTile(tap: onTap),
            contact.middleName.onListTile(tap: onTap),
            contact.familyName.onListTile(tap: onTap),
            contact.phone.onListItems(onTap: onTap),
            contact.email.onListItems(onTap: onTap),
            contact.company.onListTile(tap: onTap),
            contact.jobTitle.onListTile(tap: onTap),
          ]),
        )
      ]),
    );
  }
}

// iOS interface
class _BuildiOS extends StatelessWidget {
  const _BuildiOS({Key? key, required this.state}) : super(key: key);
  final _ContactDetailsState state;

  @override
  Widget build(BuildContext context) {
    final contact = state.contact;
    // Dart allows for local function declarations
    void onTap() => state.editContact(contact, context);
    return CupertinoPageScaffold(
      child: CustomScrollView(slivers: <Widget>[
        CupertinoSliverNavigationBar(
          leading: CupertinoNavigationBarBackButton(
            previousPageTitle: 'Home',
            onPressed: () {
              Navigator.of(context).maybePop();
            },
          ),
          largeTitle: Text(
              '${contact.givenName.value ?? ''}  ${contact.familyName.value ?? ''}'),
          trailing: Material(
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showBox(
                  text: 'Delete this contact?'.tr,
                  context: context,
                  useMaterial: App.useMaterial,
                ).then((bool delete) {
                  if (delete) {
                    contact.delete().then((_) {
                      Navigator.of(context).maybePop();
                    });
                  }
                });
              },
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            contact.givenName.onListTile(tap: onTap),
            contact.middleName.onListTile(tap: onTap),
            contact.familyName.onListTile(tap: onTap),
            contact.phone.onListItems(onTap: onTap),
            contact.email.onListItems(onTap: onTap),
            contact.company.onListTile(tap: onTap),
            contact.jobTitle.onListTile(tap: onTap),
          ]),
        ),
      ]),
    );
  }
}
