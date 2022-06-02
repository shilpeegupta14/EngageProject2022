# Face Recog iOS 15 App

## Synopsis
An iOS app that recognises emotions from the face and recommends songs based on the emotion 
detected. It gives the users a dashboard view of the emotion analysis from their face. It categorises similar 
faces with help of Microsoft Azure's Face API and the end users can search the photos by the 
face of people. This face verified protected account also provides a platform for safe 
transaction by auto-filling the card details.  
 	            
## Overview:
A native iOS face recognition app that demonstrates the application of face recognition 
like emotion Recognition, Categorising similar faces and safe transactions. All through a 
face verified protected account that is by Face ID integration. 

The app provides users to login through Face ID, touch ID and regular Firebase authentication.
It also enables users to signup by entering the username, email id and password. The users can
also add a profile photo during sign up. 

After login or sign up, the user is redirected to the Home Screen where there are 
total 4 tabs present on the screen. Home Screen, dashboard view, categorise and card scanner. 

The Home Screen allows user to recognise their emotions from their face either by 
clicking their picture or by selecting photo from the library. 
After recognising emotions, they are recommended songs according to their mood.
So if you are happy, you will be recommended happy songs. 
If you are angry, you will be recommended calm songs.
The users are provided with a player view as well where they can play the recommended songs.
Apple Music api is used to recommend songs from a particular mood playlist.
Ml models are developed from create ml tool for recognising emotions. 

In the dashboard tab, Users are shown the emotion analysis from their face 
like the percentage of happy, sad, angry, fear, surprise, neutral and disgust
found from their face.

In the third tab that is categorise tab, we have a recognised data set of images 
present near the navigation bar of the screen and a bunch of images as training data.
Microsoft azure face api is used to find similar faces and provides the end users an 
ability to search photos by faces of people. This is one of the most practical 
application of facial recognition that was also introduced by Google with their 
photos app back in 2015. 

This face verified protected account can also be used for making safe transactions.
A lot of times it happens that we add wrong card details and might end up 
transferring money to the wrong account. To avoid this, we can scan the card
details and auto fill the text fields. You might notice that the card screen 
on the user interface is changed after scanning. 
This is implemented by state management of the text fields by the use of SwiftUI. 
Thus ensuring a smooth User experience while making a safe transaction from a face verified account. 

Note: The app doesnt do any actual payment. It is purely based on an idea and is shown as a prototype.

## Installation process and other Prerequistes to know
  - Open Xcode and click on "Clone an existing project"
  ![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot%202022-05-31%20at%207.03.38%20PM.png?raw=true)
  - Enter command: git clone https://github.com/shilpeegupta14/FaceAuth.git and choose master branch for checkout.Then press Clone button.
  ![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot%202022-05-31%20at%207.02.22%20PM.png?raw=true)
  - You will be redirected to the project. 
  - Please make sure that the project completes its build time. Dont press the run button when the project is still building. The interface of building a project looks like this. 
  ![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot%202022-05-29%20at%202.17.46%20PM.png?raw=true)
  - When the project completes its build time. The interface looks like this. You can press the run button now.
  ![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot%202022-05-31%20at%207.09.31%20PM.png?raw=true)
  - It is advised to choose iPhone 13 as simulator for the best user experience.
  - To access any feature that requires camera access, you will need a physical device to run the app.
   Or else the app will crash. Please make sure that you connect physical iphone device to the MacBook from a 
   USB type C to lightening cable.
  - You can view the SwiftUI screens without running the app by clicking on the resume button. There are 2 SwiftUI previews available
   in the codebase - CardFormView and Dashboard View.
   ![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot%202022-05-31%20at%208.09.18%20PM.png?raw=true)
    
## Languages used
 - Swift
 
## APIs used:
 - Microsoft Azure Face API
 - Apple Music API
 - Vision API 
 
## Frameworks used:
 - VisionKit 
 - SwiftUI
 - LocalAuthentication
 - StoreKit
 - MediaPlayer
 - CoreML
 - Combine
 - PhotosUI
 
## Tools used:
 - Firebase 
 - CreateML

## Dependancies of the project:
- FirebaseAuth - for logging and signup.
- SDWebImageSwiftUI - for image loading

## Features 
- Face-ID authentication for iphones like iphone X etc.
- Touch-ID authentication for older iPhones.
- Firebase authentication for regular login/signup.
- Profile Image Setup while Signing up for the account. 
- Emotion Recongnition from the face and recommending songs from Apple Music. 
  For example- if the emotion detected is sad, happy songs from
  a happy playlist will be recommended to cheer you up. 
- User can play songs according to his/her mood recognised from
  the face.
- Emotion analysis from the face and shows the percent of happy, 
  sad, disgust, fear, neutral, surprised, angry in the Dashboard tab.
- Categorise similar faces using Microsoft Azure Face API. 
- Credit Card scanner that autofills the card details to ensure
  safe transaction through a face verified protected account.
- The app adapts to the light and dark mode depending upon the night or day. 

## Screenshots:
![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot%202022-05-29%20at%208.51.12%20PM.png?raw=true)

![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot%202022-05-29%20at%208.51.02%20PM.png?raw=true)

![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot%202022-05-29%20at%205.12.46%20PM.png?raw=true)

![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot%202022-05-29%20at%208.38.44%20PM.png?raw=true)

![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot%202022-05-29%20at%208.41.28%20PM.png?raw=true)

![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot%202022-05-29%20at%208.42.24%20PM.png?raw=true)

![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot%202022-05-29%20at%208.59.27%20PM.png?raw=true)


## Technical Aspect of the project 💪
- For FaceID and TouchID integration, LocalAuthentication Framework is used.
- Firebase Authentication is used for signup/login.
- SDWebImageSwiftUI framework is used for image loading instead of Firebase becasue SDWebImageSwiftUI provides me 
 with the async image loading and comes with additional performance benefits. 
- Apple Music API is used to play songs from the emotion recongised playlist.
- For emotion recognition, I have created a ML Model from createML tool. This model has labels of happy, sad, angry, fear, neutral and disgust with it. 
  50 images of each emotions are fed into the create ml tool for training the model. Testing images from each emotion is also added
  to make a ML Model. This ml model is then added into the project. I could have used an API for recognising emotions but an API was
  taking a lot of time to load up my first tab screen. Thus increasing the execution time. Hence I adopted an approach of creating my own 
  ML Model and integrating into my project.
- Dashboard View uses SwiftUI framework extensively and make use of property wrappers like @AppStorage for updating the percentage of 
  emotions after the emotion recognition. The percentage will change each time after a face recognition. Hence, to make changes into the screen,
  property wrappers are used. @AppStorage is only used and not others here because we want our data to exist in multiple views. It helps us 
  persists our data and points to the same UserDefaults store. It helps us read and write values from and to the UserDefaults and if anything changes
  SwiftUI will invalidate the relevant views for us. So if another face is added to detect emotion, the dashboard tab will be notified and 
  invalidate the older view and retrieves the new percentage of data. 
- For categorising emotions, Microsoft Azure's face API is used as it is easily integrable and yields good accuracy in finding similar faces. 
- For card scanner, I have used Vision API to recognize card details. To autofill the text fields and to change the text present on the 
  card image, I have used state manangement with use of SwiftUI. 

## Challenges faced:
- One major application of face recognition is face authentication. At the beginning, my approach was to store facial features, along with email id
and password. So when a user tries to login through face authentication, the encoding from the input face will be checked with all the faces stored 
in the database. But, the latency will be higher for finding the results from 1: K matching problems. There will be approximately a O(N) time 
complexity for finding the right match. To improvise on the performance, I thought to add a tensorflow backend by doing interoperabilty with 
Objective C headers. But this process was being code heavy and complex for me. I looked for more simpler alternatives and come to an approach of 
finding similar faces of the input face from the database of stored credentials. But again, this was taking time to load the screen, sometimes 
black out and freezes the UI. To make things more simpler and faster, I resorted to FaceID integration into my app by using LocalAuthentication framework 
in Swift.  

## Accomplishments that I am proud of:
- Linking SwiftUI screens with UIKit and using both the frameworks by the use of Hosting View Controllers.  
- Applied State Management for updating the SwiftUI screens after scanning the card. 
- Applied refactoring into code because a deeply nested body of swiftUI was generating compiler error. This was the most common error that 
  is "The compiler is unable to type-check this expression in reasonable time; try breaking up the expression into distinct sub-expressions".
  ![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot_2022-05-28_at_1.32.41_PM.png?raw=true)
  As a solution to this error, I broke down my code into many structs and refactored the complete code in SwiftUI. Though the compiler error
  was not descriptive enough of why the body was taking a lot amount of time to run the code, it helped me as a beginner to write neat code, debug
  and refactor my code. During debug, I found that the ForEach loop was taking a lot of time complexity. Hence I broke down the flow of code into 
  multiple structs, linked some structs and called them inside my body. 
  This was the final refactored code: 
  ![alt text](https://github.com/shilpeegupta14/images/blob/main/Screenshot%202022-06-01%20at%2012.34.43%20AM.png?raw=true)
  To view the complete refactored code, you can visit   https://github.com/shilpeegupta14/FaceAuth/blob/master/FaceRecogDeviceSecurity/Views/DashboardView.swift
  
## What I learned:
- learnt SwiftUI framework and Vision Kit.
- Used Azure's face API for the first time.
- Used Apple Music API for the first time. 
- Refactoring my code.
- Debugging 
- How to use SwiftUI and Uikit both
- Got to know about SDWebImageSwiftUI framework and worked with it for the first time. 
- Property Wrappers in SwiftUI.
- Collection Views.

## What's next for FaceRecog App:
- To maintain a responsive player view.
- To use a microsoft azure's face sdk and to compare the performance and speed of API vs SDK. Depending upon who's faster will be integrated 
  into the project. 🚀 
- To add a payment gateway by using any payment services api. 
- Add cloud storage for uploading private documents.
