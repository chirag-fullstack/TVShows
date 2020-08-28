## Overview
This is a TV show manager application with with 2 screens. The first screen displays a list of all the TV shows added by the user with swipe to delete functionality and the Other screen allows the user to add a TV show. 

The app is utilising:
- `Parse` cloud service as a backend
- `MVP design pattern` to assure testability of the code
- `Protocols` for services like `CloudStoreService` for better scalability
- `Switflint` to enforce the standards of coding
- `UITableView` to display a list of all the TV shows

## Code Structure
```
├── TVShows
│ ├── Assets.xcassets
│ │ ├── AppIcon.appiconset
│ │ └── empty.imageset
│ ├── Base
│ │ ├── Protocols
│ │ ├──── ViewService
│ │ ├──── ReusableView
│ │ ├── UIClasses
│ │ ├──── BaseTableView
│ ├── Models
│ │ └── TVShowModel
│ │ └── ClientSecret
│ │ └── SlideInfo
│ │ └── ClientCredentials
│ ├── Resources
│ ├── Screens
│ │ └── AddTVShow
│ │ └──── AddTVShowVC
│ │ └──── AddTVShowPresenter
│ │ └──── AddTVShow.storyboard
│ │ └── Home
│ │ └──── HomePresenter
│ │ └──── HomeVC
│ │ └──── Home.storyboard
│ ├── Services
│ ├──── CloudStore
│ ├────── Service
│ ├──────── CloudService
│ ├──────── ParseCloudService
│ ├────── CloudStoreManager
│ └── Utils
│ └──── CustomUIComponents
│ ├────── RoundedView
│ ├────── RoundedButton
│ ├────── BorderedTextField
│ ├────── BorderedButton
│ ├────── ShadowView
│ └──── Extensions
│ ├────── UIViewController+Extension
│ ├────── UIView+Extension
│ ├────── UITableView+Extension
│ ├────── UICollectionView+Extension
│ ├────── String+Extension
│ ├────── Decodable+Extension
│ ├────── Date+Extension
│ └──── Constants
```

#### Structure details
The app is structured as per the `MVP` design pattern to make sure that the business logic resides in a class (`presenter` in our case) detached from view code and hence is unit testable.
We can also follow `MVVM`, `Clean Swift`, or other patterns depending on the project's requirement.

###### CustomUIComponents
A directory to hold all the `reusable` or `customized` components.

###### Models
This directory is responsible for keeping all the `Models` and related `Enums` for the app

###### Resources
This directory will hold all the required resources like JSON files, SVGs, fonts, HTML files, etc. For now, this just holds Parse  Credentials in a `parseCredentials.json` file.

###### Screens
This directory is to keep directories for each screen of the app. Each directory has 3 files in general, a `view` file must be and XIB or Storyboard, a controller file, and a `presenter` file.

###### Services
This is to keep all the services of the app. Currently it has `CloudStore` service.

###### Utils
This is to keep all the code that will be used as a utility for the app. It also includes all the extensions for any Foundation or UIKit component.

## Notes
- The current project has storyboards for creating the views, but we can also use SwiftUI which is newer
- The new combine framework can also be used for cleaner code
- TableView is used as the main component for `Home` to make it scalable
- Carousel for shows and swipe to delete has been added as the additional functionalities
- `parseCredentials.json` has been committed to make the compile. Client secrets should not be committed and shared via source control management 

## Build Info
- iOS 13.0+
- Xcode 11.6
- Swift 5

## Project Setup
> CocoaPods is our dependency manager. If it is not installed on the machine please visit: https://guides.cocoapods.org/using/getting-started.html
- Go to the project's root directory on the mac's terminal
- Run `pod install`
- Make sure to open `TVShows.xcworkspace` and then run the app

## Project Dependencies
- [Parse SDK](https://github.com/parse-community/Parse-SDK-iOS-OSX)
- [Material Buttons](https://material.io/develop/ios/components/buttons)
- [Nuke](https://github.com/kean/Nuke)
- [SwiftLint](https://github.com/realm/SwiftLint)
- [ProgressHUD](https://github.com/relatedcode/ProgressHUD)

# Demo
![Demo](https://github.com/chirag-fullstack/TVShows/blob/master/demo.gif)
