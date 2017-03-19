IceGig
===============

![App Icon](https://s3.eu-west-2.amazonaws.com/hilmarbirgir/app_icon-256.png)

[IceGig](https://itunes.apple.com/us/app/icegig/id1216327579?ls=1&mt=8) is an iOS app that shows you upcoming concerts in Iceland and lets you listen to the artist playing those shows on your Spotify account.

Installing
----------
This project uses [CocoaPods](http://cocoapods.org/) 

    gem install cocoapods
    pod repo update
    pod install

Once you installed the cocoapods you open IceGig.workspace and simply run.

Application
----------
The application is written in Objective-C and uses a ViewController + ViewModel paradigm (MVVM). Reactive cocoa is used for the ViewModel + View glue. The app uses simple dependency injection for singletons which are called services. ViewControllers only have outlets to UI elements, button callbacks and bindings to its ViewModel. The ViewModels use dependency injection to use the Services to do things like network requests and navigating. This makes mock writing valuable mock tests easy.

Important Classes
----------
**Application**: Is owned and created by the AppDelegate. It creates the services, sets them up and handles the interaction between them.

**LoginService:** A singleton wrapper around the SPTAuth class from Spotify. Handles logging the user in to his Spotify account.

**NetworkingService:**  A singleton wrapper around AFNetworking with a reactive API.

**PlaybackService:** A singleton wrapper around the SPTAudioStreamingController class from Spotify. Handles the audio playback.

**RoutingService:** A navigation singleton. Owns and creates the window and the navigationcontroller and handles all navigation.

**Constants**: A file that has the spotify app client info. If you want to create your own you update this file.

**TableViewController**: All the view controllers that have a table view are an instance of TableViewController. Their ViewModels adhere to the TableViewModel protocol. It handles user interaction with the table view and displaying a list of CellViewModels that are specified in its ViewModel.

**TableViewModel**: A protocol that all table ViewController ViewModels must adhere to. It has to specify an array of CellViewModels for the tableview to display and it has some other utility functions.

**CellViewModel**: A protocol that all table view cell ViewModels must adhere to. It must specify the height and reuseIdentifier of the cell.


Testing
----------
The tests are written using XCTest and OCMock.  To run the tests:

    CMD + U

Releasing
----------
Releasing is done with fastlane. There is only one lane currently, release. It submits a build to apple and sends it to testflight as well. To use fastlane with the project start by [installing fastlane](https://docs.fastlane.tools/getting-started/ios/setup/). Then you have to create an Appfile and Deliverfile (see [fastlane documentation](https://docs.fastlane.tools/)). Then you can run: 

    fastlane release


3rd Party libraries
----------
* [AFNetworking](https://github.com/AFNetworking/AFNetworking): A nice wrapper around making network requests.
* [Reactive Cocoa](https://github.com/ReactiveCocoa/ReactiveObjC) : Provides a nice functional API to Objective-C. Also provides a really nice way of gluing UI and logic together.
* [SDWebImage](https://github.com/rs/SDWebImage): Provides a nice API for image downloading with a built in cache.
* [libextobjc](https://github.com/jspahrsummers/libextobjc): Objective-C extension library. The weakify/strongify makes not retaining self when writing Reactive Cocoa code easy.
* [OCMock](http://ocmock.org/): A mocking library used for testing.

UI
----------
![Login](https://s3.eu-west-2.amazonaws.com/hilmarbirgir/login-screen.png)

LoginViewController with the LoginViewModel

![Upcoming](https://s3.eu-west-2.amazonaws.com/hilmarbirgir/upcoming-screen.png)

TableViewController with ConcertViewModel and ConcertCells

![Listen](https://s3.eu-west-2.amazonaws.com/hilmarbirgir/artist-screen.png)

TableViewController with SongCellViewModel and SongCells

![Song](https://s3.eu-west-2.amazonaws.com/hilmarbirgir/play-screen.png)

A PlayerViewController with PlayerViewModel


Possible improvements
----------
* The playback experience can be a lot better. Would be nice to have a scrubber and the capability to pause. Also it would be nice to be able to minimise the app while playing.
* Threading, currently networking code and cell view model allocation is run on the main thread. Would be more optimized to move that onto an offthread.
* The titles of

Credits
----------
* [apis.is](http://apis.is) for the upcoming concerts data.
* [Spotify](http://spotify.com/) for their iOS SDK.