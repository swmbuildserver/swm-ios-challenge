# M-Login App

## Brief
The M-Login App is a native implemented App for iOS and Android. One of its main purpose is to provide an 100% native login experience, without any webviews. This includes also to act as 'login-app', e. g. when the user runs the first time an app like Handyparken. The the user will be forwarded to the native M-Login App, when she logs into the app.

The project itself starts as a minimal viable product (MVP) with the initial feature set of the website http://login.muenchen.de

It provides a native login by implementing the O-Auth 2.0 Resource Owner Password Credentials Grant Flow. The feature set itself consists of managing user-profile data, managing service access rights and service based user optins. Last but not least the user is able to manage payment method related data in a comfortable way, i. e. scanning credit cards on device with the camera.

***ClientSecret als Angriffsvektor***



The App will be designed for usage on Phone Devices. Tablet specific optimization are not planned yet.

## Architecture
The app itself will be built natively for both Platforms (Android/iOS) in a ***symmetric component based approach***. 

Symetric means in this case, that it is strongly enforced to keep Class-Design (i. e. naming of Classes, properties and method signatures) as equal as possible between the native implementation in Swift and Kotlin. Since both languages have a lot in common, this will result in components which can easiely maintained by developers, who have only expert level skills on one plattform. In past projects, a lesson learned was also, that copy & paste between kotlin and swift code worked very well. Of course some compiler errors had to be fixed, but this was a very painless approach in most cases, since both languages are very similiar.

The App will be built in two components.

The M-Login **Frontend Component** is the the App, which the users and also third party apps can interacts with. It contains all view elements and handles user input by incorporating the M-Login **Core Component**.
The **Core Component** will handle all business logic, backend interaction and provides interfaces to access user data of the currently logged in M-Login user (CRUD)

The frontend component uses the core component, i. e. the core component will never call functions from the frontend component and only provide functionality.

The core component is responsible for the model data, i. e. changes on the model data will only be done via the core component, where as the frontend component can only read the data provided by core component.

### Platform specific details

#### iOS
Since we want to reduce external dependencies as much as possible, the minimum deployment target is **iOS 13.0**. This allows us to make use of technologies like **Combine** or the Swift Package Manager for the Core Component.

The Frontend Component will use **Storyboards**. Every ViewController will have its own Storyboard. The Storyboard will be named as the ViewControllers Base Name, e.g. SomeViewController -> Some.storyboard. Only for context based Navigation Flows, it will be feasible to use one Storyboard for multiple ViewControllers, i. e. a registration streak context.

Also it is strongly encouraged to set all accessability labels where possible. This does not only benefit in clearer error messages when the app crashes unexpectedly, it also enables future use cases for impaired people.

#### Android
TBD

## M-Login Frontend

The M-Login Frontend is basically the app, which user can interact with. It provides on Root-Level a Login-Screen, where the M-Login User is able to perform a login, or create a new account.

Additionally a Login-Screen can also be triggered for external native Apps from the SWM, to provide a native login-experience rather than a web based flow, provided the M-Login App is allready installed on the users device.

After the user logged in, she can access her profile data, change her optins on app-level or subscribe herself to new services which support the M-Login. Additionally payment methods can be managed.

One of the main reasons for the MVP is to provide the best possible user experience. Therefore technologies like scanning credit cards with the camera, faceId or touchId shall be used where possible.

The App itself will use the Core Component to access the user data read only, via model objects provided by the core component. All altering operation will be triggered via the core component

### iOS

The Basic Architecture of the Frontend App will be MVVM-C. As typical in MVVM, the goal is to move model related taks (e. g. fetching data via the core component, observing for changes and transform it for display) out of the viewController into its related viewModel. E. g. a LoginViewController holds a loginViewModel. The ViewController will only implement UIKit Lifecycle events like viewDidLoad etc. where as the viewModel is responsible to interact with core and provide updates of the display data to the viewController.

ViewBindings will be realized using Combine.

Additionaly we use a Coordinator with MVVM. Its main purpose is to handle the presentation of other viewControllers and manage the viewController hierarchy. As a result we have viewControllers, which only react to lifecycle events and handle the model related tasks via viewModels and the navigation related tasks via coordinators.

A custom URL Scheme will be defined, which other Apps can use to redirect directly on a native Login-Screen. Then the Login will be performed within the M-Login App. A successfull login attempt will then redirect to the origin App, returning the tokens, it would normally receive via the web flow. **TODO**: check if this assumption is correct 

### Android

TODO



## M-Login Core API

- MLoginCore.shared
  - setup
  - *teardown*
  
  - ProfileRepository
    - read
    - update
  - PaymentMethodsRepository
    - read
    - update
  - OptInsRepository
    - read
    - update
  - UserServicesRepository
    - read
    - remove
  - ServiceRepository
    - read
    - update
  
- ***Update auf Rx and Repositories***


### General
The M-Login Core API provides classes and methods for consuming apps, encapsulating the business logic, data layer, models, networking tasks and persistence.
The main purpose is to provide a native login experience and interfaces to implement the current portal web application  usecases in native apps.

- Login via Resource Owner Password Credentials Flow
- Login via another app, including gathering additonal required data
- Register new users
- Register new users via another app, including gathering additonal required data
- Secure storage of refresh token
- Reactive interfaces for subscribing and altering Data insde
  - Profile
  - Optins
  - Services (in use)
  - Payment
- Services-Overview (i. e. apps and websites) which use M-Login, to enable users to setup their account and the required profile information before using another app the first time.

### Architecture

The basic pattern used to access the existing M-Login Backend System will be the **Repository** Pattern. In General there will be Repository for every domain/model object which provides interfaces for the general CRUD operations. 

The Repositories will make use of Combine (iOS) and LiveData (Android), and return Publishers for the Model Objects. So it will be possible for consumers to subscribe to the Model and implement an efficient view binding from within the outer App.

-->> Reactive Klasse ist hier  eigentlich der Manager

The Repositories will not be accessed directly, therefore Manager Classes will be implemented, which expose the required functionality to the consuming app.

Depency Injection must be possible within the Core Component, to provide not just a good code coverage of unit tests, but also provide an easy way of stubbing/mocking repositories, which enables developers to work from outside the SWM against testdata.

The MLoginCore itself shall be implemented as Singleton, and provide a central setup method containing a configuration of which backend environment to use (K, I, P). Details for those parameteres can be taken from the allready existing m-login and payment SDKs.

### User Handling
The M-Login App provides native functions for users to perform a registration for a new account or a login with an existing account

##### Login
To perform a login pass the user credentials to
```signInWithEmail:email:password:completion:```

#### iOS
```swift
UserService.shared().signIn(withEmail: email, password: password) { [weak self] authResult, error in
  guard let self = self else { return }
  // ...

}
```

##### Android
```Kotlin

```

#### Create User
To create a new M-Login User use the function
```createUserWithEmail:email:password:completion:```
##### iOS
```swift
UserService.shared().createUser(withEmail: email, password: password) { [weak self] authResult, error in
  guard let self = self else { return }
  // ...

}
```

##### Android
```Kotlin

```

### Profile
The Profile Service lets you access the profile data of the currently logged-in User. It contains Login Data like usercredentials, personal data and contact data.

#### LoginData
To receive the user related Login Data use ```loginData:completion```

##### iOS
```swift
tbd
```

#### Android
```Kotlin
tbd
```

To update the user related Login Data use ```updateUsername:username:password:completion```

##### iOS
```swift
tbd
```

##### Android
```Kotlin
tbd
```


To delete the currently logged in User use ```deleteCurrentUser:completion```

##### iOS
```swift
tbd
```

##### Android
```Kotlin
tbd
```



To receive the profile data of the current User use```userProfile:completion```
It will return the full Userprofile.

##### iOS
```swift
tbd
```

##### Android
```Kotlin
tbd
```
To update the profile data of the current User use```updateUserProfile:userprofile:completion```
It will return the new Userprofile.

##### iOS
```swift
tbd
```

##### Android
```Kotlin
tbd
```

### Payment

### UserServices

### OptIns

#### Open Issues
- Modelklassen spezifizieren, e.g. UserProfile?
- Nacherfassungstrecken für Scopes und Interests
- z.B. createUser aus Handyparken heraus, oder Nacherfassungstrecke weil AppXY zusätzliche Daten benötigt.
