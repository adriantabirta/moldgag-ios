//
//  VolumeObserverService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 29.03.2022.
//

import UIKit
import AVFoundation

/// GlobalAudioService - service to observe volume up&down to react with animation on whole app
class GlobalAudioService: NSObject, ApplicationService {
    
    private var progressBar: ProgressBar
    
    var sessionObservation: NSKeyValueObservation?
    
    init(progressBar: ProgressBar = .init()) {
        self.progressBar = progressBar
        super.init()
        
        print("GlobalAudioService has started!")
                
        addVolumeObserver()
        
        addVolumeBarView()
    }
    
    deinit {
        sessionObservation?.invalidate()
        sessionObservation = nil
    }
}

private extension GlobalAudioService {
    
    func addVolumeObserver() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setActive(true, options: [])
            
            sessionObservation = audioSession.observe(\.outputVolume, options: [.old, .new],
                                                       changeHandler: { [weak self] (session, change) in
                self?.handleVolumeChange(change)
            })

        } catch {
            print("Error")
        }
    }
    
    func handleVolumeChange(_ change: NSKeyValueObservedChange<Float>) {
        let oldVolume = change.oldValue ?? 0
        let newVolume = change.newValue ?? 0
    
        let difference = fabsf(newVolume - oldVolume)
        print("Old vol: \(oldVolume), new vol: \(newVolume), diff: \(difference)")
        
        self.progressBar.updateProgress(CGFloat(newVolume), withFadeOutAnimation: true)
    }
    
    func addVolumeBarView() {
        guard let vc = UIApplication.shared.windows.first?.rootViewController else { return }
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(progressBar)
        
        progressBar.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 10).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -10).isActive = true
        progressBar.bottomAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.bottomAnchor, constant: -3).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        progressBar.color = .blue
        
        progressBar.updateProgress(CGFloat.zero, withFadeOutAnimation: true)
    }
}
