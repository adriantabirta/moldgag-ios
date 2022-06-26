//
//  VideoPostView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 19.02.2022.
//

import UIKit
import AVFoundation

class VideoPostView: GenericPostView {
    
    private let viewModel: VideoPostViewModel
    
    private let swipebleVideoPlayerView: SwipebleVideoPlayerView
    
    init(_ viewModel: VideoPostViewModel, index: Int) {
        self.viewModel = viewModel
        self.swipebleVideoPlayerView = SwipebleVideoPlayerView(viewModel: .init(asset: viewModel.asset))
        super.init(genericPostViewModel: .init(postId: viewModel.postUIModel.id, index: index))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VideoPostView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple // UIColor.random()
        
        swipebleVideoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(swipebleVideoPlayerView)
        
        swipebleVideoPlayerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        swipebleVideoPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        swipebleVideoPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        swipebleVideoPlayerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        /*
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)
        
        let image = UIImage(systemName: "arrow.up", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        let imageView = UIImageView(image: image)
        imageView.center = view.center
        view.addSubview(imageView)
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        swipebleVideoPlayerView.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        swipebleVideoPlayerView.pause()
    }
}

extension VideoPostView {
    
    override func onTap(_ sender: UITapGestureRecognizer) {
        print("tap")
        swipebleVideoPlayerView.toggle()
    }
    
    override func onLongTap(_ sender: UITapGestureRecognizer) {
        print("long tap")
        swipebleVideoPlayerView.pause()
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.view.tintColor = .darkGray
        //        alert.view.backgroundColor = .white
        //        let backView = alert.view.subviews.last?.subviews.last
        //        backView?.layer.cornerRadius = 10.0
        //        backView?.backgroundColor = UIColor.yellow
        
        let customView = UIView()
        
        customView.backgroundColor = .green
        // 2
        let blurEffect = UIBlurEffect(style: .light)
        // 3
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 4
        customView.insertSubview(blurView, at: 0)
        
        alert.view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 10).isActive = true
        customView.rightAnchor.constraint(equalTo: alert.view.rightAnchor, constant: -10).isActive = true
        customView.leftAnchor.constraint(equalTo: alert.view.leftAnchor, constant: 10).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        customView.layer.cornerRadius = 12
        customView.layer.masksToBounds = true
        
        
        
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        alert.view.heightAnchor.constraint(equalToConstant: 530).isActive = true
        
        
        let inset = -(UIScreen.main.bounds.width * 0.8)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular, scale: .medium)
        
        
        
        
        let shareAction = UIAlertAction(title: "Share", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
        })
        
        
        let shareIcon = UIImage(systemName: "square.and.arrow.up", withConfiguration: symbolConfiguration)?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0))
            .withTintColor(.darkGray)
            .withRenderingMode(.alwaysOriginal)
        shareAction.setValue(shareIcon, forKey: "image")
        alert.addAction(shareAction)
        
        
        let createAction = UIAlertAction(title: "Create new post", style: .default , handler:{ (UIAlertAction) in
            print("create post")
            alert.dismiss(animated: true) {
                
                DispatchQueue.main.async {
                    
                   let vc = CreatePostPartOneView()
                    (self.view.window?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)

                    
//                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreatePostViewController")
//                    //                    self.navigationController?.pushViewController(vc, animated: true)
//                    (self.view.window?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
                }
            }
        })
        
        
        let createPostIcon = UIImage(systemName: "plus", withConfiguration: symbolConfiguration)?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0))
            .withTintColor(.darkGray)
            .withRenderingMode(.alwaysOriginal)
        createAction.setValue(createPostIcon, forKey: "image")
        alert.addAction(createAction)
        
        
        let userProfileAction = UIAlertAction(title: "User profile", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit button")
        })
        
        
        
        let userProfileIcon = UIImage(systemName: "person.circle", withConfiguration: symbolConfiguration)?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0))
            .withTintColor(.darkGray)
            .withRenderingMode(.alwaysOriginal)
        userProfileAction.setValue(userProfileIcon, forKey: "image")
        alert.addAction(userProfileAction)
        
        
        
        let editAction = UIAlertAction(title: "Edit post", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit button")
        })
        
        let editIcon = UIImage(systemName: "pencil.circle", withConfiguration: symbolConfiguration)?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0))
            .withTintColor(.darkGray)
            .withRenderingMode(.alwaysOriginal)
        editAction.setValue(editIcon, forKey: "image")
        alert.addAction(editAction)
        
        
        //
        
        let reportAction = UIAlertAction(title: "Report", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit button")
        })
        
        let reportIcon = UIImage(systemName: "exclamationmark.shield", withConfiguration: symbolConfiguration)?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0))
            .withTintColor(.darkGray)
            .withRenderingMode(.alwaysOriginal)
        reportAction.setValue(reportIcon, forKey: "image")
        alert.addAction(reportAction)
        
        
        
        let deleteAction = UIAlertAction(title: "Delete post", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete button")
        })
        
        let deleteIcon = UIImage(systemName: "trash.circle", withConfiguration: symbolConfiguration)?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0))
            .withTintColor(.red)
            .withRenderingMode(.alwaysOriginal)
        
        deleteAction.setValue(deleteIcon, forKey: "image")
        alert.addAction(deleteAction)
        
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        
        self.view.window?.rootViewController?.present(alert, animated: true, completion: {
            print("completion block for alert")
        })
    }
}
