# simple-stack

## Overview 
* A simple iOS app to display top 20 users on stack overflow
* Built with SwiftUI & UIKit using MVVM+C in an modular architecture using platfom agnostic components

## Priority notices: 
* There are many ways to build an iOS app, this way. Others are possible. 
* Deciding an approach depends on the company and team needs. This one was chosen for reasons discussed in the Architecture section.
* This approach chosen iss *not* indicative of hard preference or style: it’s just one approach. Many others are possible and viable. 

FAQ: Architecture and use of Swift Packages: 
* “could it be simpler and all live in one Xcode project without packages? ”: Yes
* “why did you do it this way?”: to make the code modular, re-usable, more testable (in isolation) and speed up build times - it’s all about speed 
* “is this the only way of doing this”: No others are viable and possible with more or less abstraction and separation of concerns  
* “does this approach scale?”: Yes - I have used on projects at companies at varying levels of scale (small, to large)
* “where did these packages come from?”: core packages are from my own personal projects, the rest are custom for this project
* “why is the “UserFeedFeature” not a package?”:  not necessary for a simple project like this
* “so many protocols everywhere, why?”: applying SOLID Principles for re-usability, extensibility and testability 

FAQ: Models
* “why do you have a `RemoteUserModel` and `UserModel`” to stop large bloated models i.e. if CoreData, or mode Codable methods were to be added/ `UserModel` is the one pure model to be used in the app,

FAQ: Async Await
* “why did you not use async await”: This is a simple UIKit project, so I used the old networking stack I have

FAQ: Testing 
* “why do you write `Specs`”: to cover acceptance criteria when doing TDD + they are useful for refactoring + new implementations 
* “why did you not write UITests”: not necessary right now
* “why did you not test `ImageFetcher`”: in the real world I would use a third party for this i.e. Kingfisher as its pretty good for this 
* “could you have written more tests in the app layer”: yes, in many places, chose only to cover necessary bases as a demonstration

 ## Architecture 
* App is built on top of multiple platform-agnostic frameworks that exist inside their own Swift Packages split into layers. Reasoning and design are discussed in the sections below
* Each layer package can be built and be tested on its own including the Presentation Layer Application targets.
* There are five layers: Core Foundational, Core Components, Core Stack Exchange, Core UI Components and the Presentation layer (Which contains the application targets)
* Layers dependencies are used vertically: each module can import only from layers below or on the same level
* The core design pattern used in the Feature layer is MVVM+C. This is then used in the presentation. 
* MVVM+C was chosen because it allows us to easily separate responsibilities.

### Platform Agnostic Components (Reasoning)
Every layer that exists below the presentation layer is built with platform-agnostic components for the following reasons.
* Easily use in Mac, iOS, iPadOS, Watch OS apps using either UIKit, WatchKit or SwiftUI
* Highly *reusable* components that can easily be used to support other feature layer components and Presentation Layer Application targets
* Faster *build times* for tests, testing suites and projects locally and on pipelines. 
* Easier *collaboration* between teams (everything does not happen in one place)
* Easily use new technologies i.e. SwiftUI or Combine
* Applied Engineering business organisation considerations for *open-sourcing* capability, *hiring* and *demo apps* as layer components are independently relying on abstractions rather than concrete implementation. It is also very easy to bring on new technologies such as SwiftUI.

### Design and Development (Discussion) 
* Built applying SOLID principles with a relatively extensive Unit and Integration testing suite. The Snapshot & UITests will come.
* App Built in a TDD way, ensuring that functionality works as expected and also providing protection from regressions 
* A simple UI with Accessibility features in place including Dynamic type, Bold Text, Voice Over amongst others and also Dark Mode as a bonus
* Business and engineering organisations' considerations were made when constructing this project as discussed in the previous section.

## Architectural decisions 

### Layers (overview)
* As seen in the overview, the app has four layers: Core Shared Utilities, Core Shared Components, Shared Features and the Application Target layer
* Each module lives in its own independent project with as few dependencies as possible, contains its own tests, this way each feature can be
  *  Built-in isolation without building the entire Presentation Layer Target 
  *  Be highly reusable, open sourceable and able to be used in demo apps
  *  Be platform agnostic usable in any presentation application target platform
* Vertical dependencies: each layer contains modules used as dependencies by higher-level modules. Modules can import only from the layers below. 
* Each layer has its own readme

## What was not done
* Pagination
* Localisation 
* Pretty UI
* UI and Snapshot tests 

## What could be improved
* More tests
* The tasks not done as mentioned earlier
* Move `User Feed Feature` to its own package
