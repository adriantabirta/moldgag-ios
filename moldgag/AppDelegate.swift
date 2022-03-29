//
//  AppDelegate.swift
//  moldgag
//
//  Created by Adrian Tabirta on 19.02.2022.
//

import UIKit
import MediaPlayer
import AVFoundation

@main
class AppDelegate: PluggableApplicationDelegate {
    
    override var services: [ApplicationService] {
        return [GlobalAudioService(),
                GlobalNavigationService()]
    }
}
