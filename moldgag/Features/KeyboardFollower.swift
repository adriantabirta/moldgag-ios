//
//  KeyboardFollower.swift
//  moldgag
//
//  Created by Adrian Tabirta on 07.06.2022.
//

import Combine
import Foundation
import UIKit

final class KeyboardFollower: ObservableObject {
    
    @Published var keyboardHeight: CGFloat = 12.0
    
    @Published var isKeyboardVisible: Bool = false
    
//    @Published var info: (duration: Double, curve: UInt, keyboardHeight: CGFloat)!
    
    private var subscriptions = Set<AnyCancellable>()
    
    var keyboardChangeFrames: AnyPublisher<(begin: CGRect, end: CGRect), Never> {
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { notification in
                guard
                    let userInfo = notification.userInfo,
                    let beginFrame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect,
                    let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                else { return nil }
                
                return (begin: beginFrame, end: endFrame)
            }
            .eraseToAnyPublisher()
    }
    
//    let duration = aNotification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as Double
//    let curve = aNotification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as UInt
//
//    self.view.setNeedsLayout()
//    //baseConstraint.constant = 211
//    self.view.setNeedsUpdateConstraints()
//
//    UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions(curve), animations: { _ in
//        //self.view.layoutIfNeeded()
//    }, completion: { aaa in
//        //(value: Bool) in println()
//    })
    
    
    init() {
        keyboardChangeFrames
            .receive(on: RunLoop.main)
            .map { frames in
                frames.begin.minY > frames.end.minY
            }
            .assign(to: \.isKeyboardVisible, on: self)
            .store(in: &subscriptions)
        
        
        keyboardChangeFrames
            .receive(on: RunLoop.main)
            .map { frames in
                self.isKeyboardVisible ? frames.end.height : 0.0
            }
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &subscriptions)
    }
}
