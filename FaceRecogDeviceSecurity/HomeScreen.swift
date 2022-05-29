//
//  TabScreen1.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 28/05/22.
//

import UIKit
import SwiftUI
import MediaPlayer

class HomeScreen: UIHostingController<EmotionView>{
    //@Binding var musicPlayer: MPMusicPlayerController
    //let musicController: Binding<MPMusicPlayerController>
    //let binding=Binding(projectedValue: EmotionView.init(musicPlayer: musicController))
    
    required init?(coder aDecoder: NSCoder){
        let musicController: Binding<MPMusicPlayerController>
        musicController=EmotionView.init(musicPlayer: musicController)
        let binding=Binding(projectedValue: musicController)
//        EmotionView.init(musicPlayer: musicController){
//            self.musicController=musicController()
//        }
        //self.musicPlayer=EmotionView.init(musicPlayer: $musicPlayer)
        //let binding=EmotionView.init(musicPlayer: musicController)
        //musicController=EmotionView.init(musicPlayer: musicController)
//        let musicController=EmotionView.init(
        //self.musicPlayer=musicPlayer
        super.init(coder: aDecoder, rootView: EmotionView(musicPlayer: binding))
    }

}
