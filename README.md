# Face Recog iOS 15 App
 	            
## Overview:
A native iOS face recognition app that demonstrates the application of face recognition 
like emotion Recognition, Categorising similar faces and safe payments. All through a 
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

## Installation process
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
 - SwiftUI
 
## APIs used:
 - Microsoft Azure Face API
 - Apple Music API
 - Vision API 
 
## Frameworks used:
 - VisionKit 
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
- I have created a ML Model from createML tool. This model has labels of happy, sad, angry, fear, neutral and disgust with it. 
  50 images of each emotions are fed into the create ml tool for training the model. Testing images from each emotion is also added
  to make a ML Model. This ml model is then added into the project. I could have used an API for recognising emotions but an API was
  taking a lot of time to load up my first tab screen. Thus increasing the execution time. Hence I adopted an approach of creatin my own 
  ML Model and integrating into my project.
- Dashboard View uses SwiftUI framework extensively and make use of property wrappers like @AppStorage for updating the percentage of 
  emotions after the emotion recognition. The percentage will change each time after a face recognition. Hence, to make changes into the screen,
  property wrappers are used. @AppStorage is only used and not other here because it 

## Challenges faced:

## Accomplishments:

## What I learned:

## What's next for FaceRecog App:
