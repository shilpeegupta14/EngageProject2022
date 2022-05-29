//
//  TabScreen1.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 28/05/22.
//

import UIKit
import SwiftUI
import MediaPlayer

class HomeScreen: UIHostingController<EmotionView> {
    required init?(coder aDecoder: NSCoder) {
        
        @State var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
        let binding = Binding<MPMusicPlayerController>(projectedValue: $musicPlayer)
        let musicController = EmotionView(musicPlayer: binding)
        super.init(coder: aDecoder, rootView: musicController)
    }
}
