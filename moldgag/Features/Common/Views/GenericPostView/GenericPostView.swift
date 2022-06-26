//
//  GenericViewController.swift
//  moldgag
//
//  Created by Adrian Tabirta on 19.02.2022.
//

import UIKit
import Combine
import Resolver
import CoreMedia

/// GenericViewController -
class GenericPostView: UIViewController {

    // MARK: - Dependencies
    
    @Injected private var refreshPostsUseCase: RefreshPostsUseCase
    
    // MARK: - Propreties

    let genericPostViewModel: GenericPostViewModel
    
    private var bag = Set<AnyCancellable>()
    
    init(genericPostViewModel: GenericPostViewModel) {
        self.genericPostViewModel = genericPostViewModel
        super.init(nibName: nil, bundle: nil)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.onDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:)))
        view.addGestureRecognizer(tap)
        tap.require(toFail: doubleTap)

    
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(self.onLongTap(_:)))
        longTap.minimumPressDuration = 0.5

        view.addGestureRecognizer(longTap)
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GenericPostView {
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        // todo: navigate
    }
    
    @objc func onDoubleTap(_ sender: UITapGestureRecognizer) {
        print("double tap")
        
        genericPostViewModel.toggleFavorite()
        
        // todo: animate heart
    }
    
    @objc func onLongTap(_ sender: UITapGestureRecognizer) {
        print("long tap")
        //
        
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
        alert.view.heightAnchor.constraint(equalToConstant: 590).isActive = true
    
        
        let inset = -(UIScreen.main.bounds.width * 0.8)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular, scale: .medium)

        
        let refreshAction = UIAlertAction(title: "Refresh", style: .default , handler:{ (UIAlertAction)in
            self.refreshPostsUseCase.execute().sink(receiveValue: {}).store(in: &self.bag)
        })
    
        alert.addAction(refreshAction)

        
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
//                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreatePostViewController")
//                    self.navigationController?.pushViewController(vc, animated: true)
                    (self.view.window?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
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
