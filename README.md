## By Example
I’m using the repo., contacts_service, as an example. I arbitrarily picked it. I’m not picking on those particular developers or anything. As it happens, it itself demonstrates the use of the contacts_service plugin, but my version is not much about the ‘plugin’ but more about the ‘look and feel’. More about organization really. More about the MVC design pattern specifically.

So, do you like it? What do you see? I see clean. I can readily see the ‘data’ is coming from static references in a class called, Contacts. It’s coming from the Contact class’ ‘edit reference’ specifically. This is the app’s edit screen after all, and so we can see that the class, Contact, is in edit mode! Below is a closer look.

You can see, for example, the AppBar.title property below is getting its data from Contact’s displayName reference. You know that the AppBar’s title property accepts a Widget, and so you’ll guess correctly that the item ‘Contacts.edit.displayName.text’ therefore returns a Text Widget. Clean.

## MVC is in play
Of all my articles, the most popular has been Flutter + MVC at Last! so far. It talks about implementing the MVC design pattern in Flutter, and you’ll quickly see that MVC is in play here as well. Let’s look at the Contacts class.

Contacts.dart
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>

If you’re familiar with my MVC implementation in Flutter, you’ll realize that the class, Contacts, is a Controller in the MVC design as it extends the class, ControllerMVC. You can also see it implements a static factory: Item 1 in Joshua Bloch’s now renowned 2001 original publication, Effective Java. You see it imports the class, ContactsService — the Model part of this app.

Finally, you may have guessed that possibly everything referenced in this class is static (in keeping with Item 22 of Joshua Bloch’s Effective Java 2nd ed.), and again, you’d be right.


Contacts.dart
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>

## MVC Inside and Out
Even the directory structure of the app reflects the MVC approach taken when this app was developed. Following a design pattern (any design pattern) provides a guideline, a structure, on how you organize your logic, how you organize your code — even how you organize your files and folders.

Remaining consistent and studious to that structure, for example, allows a ‘turn over’ of developers to ‘hit the ground running’ when going from one project to another. For example, at a glance, they can see below where and what makes up ‘the View’, ‘the Controller’, and ‘the Model’ for this particular project.

I’ve taken the original repo. and organized it in this chosen fashion. I suspect a developer not even familiar with MVC could come to understand ‘where everything lives’ in a reasonably short time. Good design patterns allow for that.

A follow-up article detailing this directory structure is on my ‘to do’ list.



This project’s directory structure and its contents
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>

## Get it? Got it. Good!
Now, go back up and look at that last getter in the class, Contacts. It’s called, edit, and it references a ‘library private’ variable that, in turn, references the instantiated class, ContactEdit. Remember that getter? You’ve seen it before. It’s Contact in edit mode! There are two more classes: ContactList and ContactAdd. See where I’m going with this?

You may have guessed there are three things here; three ‘modes’ to this app. If you’ve guessed there’s three screens in this app: One for adding Contacts, one for editing Contacts and one for listing Contacts. Again, you’d be right.

## One From Another
Let’s start at the end. Let’s look at the class, ContactAdd. Note, however, you’ll discover it extends from the class, ContactEdit. We’ll then look at that class which, as it happens, extends the class, ContactList. We’ll then look at that, which extends yet another class called ContactFields. We’ll get to them all soon enough, but first, the class that helps ‘add’ a Contact in the app.


Class ContactAdd
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>

## It Adds Up.
Looking at the class above, you see that indeed this class, ContactAdd, extends the class, ContactEdit. You can see it’s not a very big class but does a lot of interesting things. Firstly, it optionally takes in a ‘Contact’ object in its first method called init(). It then assigns values to two properties called phone and email. Since they’re not defined here in this class, we can assume they‘re defined in its parent class or in another inherited class up the hierarchy. You can see that the init() method calls its parent’s init() method passing in that Contact object…if any.

There’s a ‘library private’ variable assigned a class called PostalAddress. There’s a GlobalKey being provided by a getter called formKey, and there’s a method called onPressed.

Now there are some details I’ve missed, but what I really want you to look at now is how this class is then utilized in the ‘Add Contact’ screen for this app.


Look for the ‘Contacts.add’ getter in all the code below. I’ll wait here. (There are little red arrows below to help you out. It’s not a test after all.) See how the properties and methods found in the class, ContactAdd, will now make sense when you see when are where they’re applied below.


AddContactPage.dart
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>

## It Does Add Up!
The ‘Add Contact’ screen needs a ‘form key’ for its form. Well, where does it get that form key from? Take a look back at the ContactAdd class, and you’ll readily see where that form key is to come from. Clean.

When the FlatButton widget’s onPressed method is called (when a user presses the screen’s ‘save’ button) what method are you to call? Again, looking back at the ContactAdd class, I’d say you’re to call its very own ‘onPressed’ method. This approach has a ‘bigger purpose.’ You can see the build() function actually dictates the api to be used by the Controller, no?

Another article detailing this is also on my ‘to do’ list. That list is getting long.

Look at the data to be displayed when adding a new Contact. Can you readily guess what data is to be entered? Bet you can! (Hint: givenName, middleName, familyName, etc.) You can also readily see that the data is to be entered in a list of TextFormField widgets as well. Let’s look at the original screen below. See how the ‘data’ and ‘interface’ are not separated as much?


AddContactPage.dart
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>

Now, scroll down and look at my version again.


AddContactPage.dart
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>
What do you think?

## Edit A Contact
What have we got next? Next, we’ve got editing a Contact. We can readily see that the class, ContactEdit, extends the class ContactList. What does one usually do with a Contact in a Contact list? We usually add, edit and delete a Contact, don’t we. We may even ‘undelete’ a Contact if we change our minds. Look below. What do you see?


## Class ContactEdit
You can see the class, ContactEdit, calls static methods from the class, ContactService, (the Modal aspect of the app) to add a contact, to delete a contact, and to ‘undelete’ a contact. You can see that the contact object passed to these methods is first changed into a ‘map’ object. You also see the contact object parameter is optional, and if null, assigns the ‘library private’ variable, _contact. Note, that variable is from the parent class, ContactList.

## Contact!
The Contact class has the getter, toMap. As you see below, it also has a named constructor called Contact.fromMap. You can guess what that does. You don’t see them here, but that constructor assigns the map entries to a list of setters named after the Contact’s field names. However, you do see the list of ‘library private’ variables being assigned by those setters. Finally, you see the getter, toMap, that converts the Contact’s properties back into a Map. You’ll guess correctly that the ‘backend’ deals directly with Map objects. Clean.


Contact.dart
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>

## List them Contacts
The next class is the parent class of the previous two. It has one lone method called init(). You can see a mess of ‘library private’ variables being assigned a variety of ‘Field’ classes. All those variables are obviously defined from the parent class, ContactFields. A ‘new’ Contact object is created if no Contact object is passed to the init() method. Note, the object is assigned to that variable, _contact, we saw in the previous class, ContactEdit.


Class ContactList
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>

## What’s Your Field?
Let’s take a quick peek at one of those ‘Field’ classes. The first one listed above is the class, DisplayName. This one is very much like the others, but like the others, it has to be specific and provide its particular field name, displayName. Note, the variable, value, is from the parent class, Field.


## Class DisplayName
Note, onSave() is called when you save a Contact, for example, in the AddContactPage under the method, _formKey.currentState.save(). While the circleAvatar is, of course, found in the main screen, ContactListPage.

## A Field of Contacts
The first class in this hierarchy is the last class we’ll look at, ContactFields. You have seen how each class ‘builds upon the previous one’ in one degree or another. Now, what does this class provide? It provides the ‘field’ variables of the type, Field, along with their associated getters and setters. See below.


Class ContactFields
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>

## List Your Contacts
Below is the build function for the first or ‘main’ screen of this app. Those familiar with my implementation of MVC in Flutter, know I consider the build() function of the Widget for the ‘main’ screen of an app (the build() function of any Widget actually) to be ‘the View’ in the MVC implementation. Remember?

For this app, any data displayed in ‘The View’ is accessed through the Controller. So in this case, Contacts is the controller for this app. Below, anywhere you see the word ‘contacts’, you know its value(s) are being drawn out of the Controller. You can’t see it here, for example, but the ‘private’ variable, _contacts, gets its values from a method found in the Controller: Contacts.getContacts()


ContactListPage Build() function is the app’s View
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>

I’d put up its original version, but you’ll get lost in the code. Go look at its original Github if you want to make a comparison. Note, I did put in a Dissmissible widget (red arrow) in my version so to easily delete contacts. The original doesn’t have the means to delete contacts, and in my version, you can see at a glance, what field is displayed and ‘deleted’ with a swipe!

## Where‘s this Dismissible Discerned?
I may be getting ahead of myself a bit here, but that red arrow is introducing you to a very important approach applied here: The Controller is not only determining ‘what’ is displayed, but ‘what’ you can do with it. To a degree, this approach has the Controller take up what would be the View’s job and presents the data in a certain fashion (i.e. in a TextFormField, in a Text, and or in a Dismissible.)

As you saw in the class, ContactFields, there is a mess of ‘Field’ classes being defined. It is in this class, Field, where you will find the method, onDissmissible().


onDissmissible()
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>

## The Getter Gets It
The method above actually calls the getter, dismissible. It is the getter that returns the desired Widget (in this case, a Dismissible) to the variable, newWidget listed above.


get dissmissible
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>

## Talk About Flutter Clutter
As you see above, there’s a lot going on. Libraries are designed to make the lives of developers that much easier, but as a consequence, they tend to get messy themselves (having a lot going on in the background.) In this case, all the parameters associated with the Widget, Dissimissible, are made available to the user to use… or not. If not, the library supplies other values or functions. Doing so allows for options, and developers love options.

For example, doing so allows us to ‘clean up’ the code a little bit in the example above (beside the big red arrow.) Note, that example has two anonymous functions being passed to the function, onDismissible. One for the named parameter, child, and another the named parameter, dismissed.

I mean, this whole exercise was to reduce the practice of passing anonymous functions as parameters, remember? Well, …let’s do that. Boom!


ContactListPage build() function
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>

## Where’d Everybody Go??
Pictured above is the same build() function first displayed with the method, onDismissible. It was used with its named parameters: child and dismissed, but now they’re all gone?! Replaced now with the item, ‘Contacts.list.displayName.dissmissible’. Where did they go? Take a guess. If you guessed they’re now in the class, DisplayName, accessed by the getter, displayName, you’d be right.


## Class DisplayName
The class, DisplayName, first introduced to you now has two newly implemented methods. Each overriding methods from the parent class, Field: onDismissed() and onChild(). That particular ‘logic’ is now embedded on the ‘Controller side.’

## MVC Means Manageability
It results in the ‘separation of work.’ Picture a team of developers was working on this app, and one developer was assigned the ‘Contact Data’ aspect of the app. He’s not even given access to the build() functions! He does his work in the Controller as it’s the Controller’s responsibility to provide the data to the View (i.e. the View can ‘talk to’ the Controller). Thus, he’s only to provide the API (the public properties and functions) to the ‘UI’ team needed to access the ‘Contact Data.’ No problem. In this particular case, for example, he gives them this: ‘Contacts.list.displayName.dissmissible’.

Done.

It took a little more coding, but there you are. As it is, I prefer the former implementation over this one. It’s just a small little app, and I feel the separation of logic need not be that pronounced. Regardless, the point is you’ve got options, and we developers love options. Right?

## The Field Class
So let’s take a further look at this class, Field. As you may have guessed by now. It’s a library I’ve created to make my life as a developer that much easier. It makes my code (code in my build() functions) that much cleaner. When the Controller is to provide a specific data field, it can do so with a Widget most appropriate for the situation. It can be a TextFormField, a Text, a ListTile, a CheckBox, and a few others. The list of Widgets is finite but is growing. Like any good library file, it does a lot of the grunt work for you.

## The Irony
Look at me. I started this article by maybe complaining a little bit about the list of parameters found in Flutter, and I end up making a class library accepting some 77 parameters. And there’s likely going to be more to come! Hilarious!


fields.dart
<div>
<a target="_blank" rel="noopener noreferrer" href=""><img src="" width="48%" height="60%"></a>
</div>
## The Point To All This
Anyway, do you see why I did that? On your next project, you’ll have a data field from a database, and you are to display that data field in a TextFormField, a ListTile, a CircleAvatar, and maybe even in a CheckBox. On top of all that a Dismissible is to be implemented so that the data field can be deleted with a swipe of a finger on some other screen down the line.

The point is, define one Field object passing all the necessary parameters for all those Widgets, and you’re done. Get it? You now have a Field object you can apply to a number of screens throughout your app. What do you think?

## Widgets? How Many Widgets?
As of this writing, the Field class accommodates the following Widgets. Again, more are likely to be added.

TextFormField
Text
RichText
ListTile
CheckBoxListTile
CircleAvatar
Dismissible
CheckBox

## So What’s The Real Point To All This?
So, you can deduce that the Field class is still a work in progress. It’s in a file under the directory, Utils , but you can see it’s not alone. You see, the Field class is merely in a utility file called Fields.dart inside an even bigger repository. One that holds my next package release, mvc_application.

## The Bigger Picture
In my development, I’ve slowly but surely been making my own little ‘application framework’ so to make my life easier with each subsequent project. Developers tend to do that of course — build up their toolkit.

## With MVC_Pattern comes MVC_Application
I was pleasantly surprised with the release of the package, mvc_pattern. This package applied the 40-year old MVC design pattern to your Flutter app, and it received a receptive response when released. I saw a need, and as it’s my chosen design pattern for most of my apps, it was nice to see many still appreciate the ‘grandfather of design patterns.’

As time went on, me working away, my ‘toolkit’ has grown. Now the intent is to release my current framework, mvc_application, as a package. It won’t be tomorrow, but soon. As it is, it simply works on top of the mvc_pattern package.