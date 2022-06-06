//
//  ResolverService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import UIKit
import Resolver
import Foundation

class ResolverService: NSObject, ApplicationService {
    
    override init() {
        super.init()
        debugPrint("\(String(describing: ResolverService.self)) has started!")
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        Resolver.register { NetworkServiceProvider<PostNetworkService>() }
        
        
        Resolver.register { try! RealmStorageContext() as StorageContext }

        
        Resolver.register { RealPostRepository() as PostRepository }
        Resolver.register { RealPostLocalDataSource() as PostLocalDataSource }
        Resolver.register { RealPostRemoteDataSource() as PostRemoteDataSource }

        
        Resolver.register { RealPostModelToPostUIModelMapper() as PostModelToPostUIModelMapper }
        Resolver.register { RealPostLocalDataModelToPostMapper() as PostLocalDataModelToPostMapper }
        Resolver.register { RealPostRemoteDataModelToPostModelMapper() as PostRemoteDataModelToPostModelMapper }
        Resolver.register { RealPostUIModelToUIViewControllerMapper() as PostUIModelToUIViewControllerMapper }
        
        Resolver.register { RealGetPostsUseCase() as GetPostsUseCase }
        Resolver.register { RealVideoCacheService() as VideoCacheService }


        Resolver.register { RealFilenameToLocalPathMapper() as FilenameToLocalPathMapper }
        Resolver.register { RealGetVideoPostUseCase() as GetVideoPostUseCase }
        Resolver.register { RealImageCacheService() as ImageCacheService }
        
        
        
        Resolver.register { RealUserSignInStatusUseCase() as UserSignInStatusUseCase }
        
        let window = (UIApplication.shared.delegate as! PluggableApplicationDelegate).window
        Resolver.register { RealSignInWithAppleUseCase(window: window) as SignInWithAppleUseCase? }

   
        Resolver.register { NetworkServiceProvider<AuthorizationNetworkService>() }
        
        
        
        
        Resolver.register { RealUserAuthorizationLocalDataModelToUserAuthorizationMapper() as UserAuthorizationLocalDataModelToUserAuthorizationMapper }
        
        Resolver.register { RealASAuthorizationAppleIDCredentialToUserAuthorizationMapper() as ASAuthorizationAppleIDCredentialToUserAuthorizationMapper }
        Resolver.register { RealUserAuthorizationToUserAuthorizationRemoteDataModelMapper() as UserAuthorizationToUserAuthorizationRemoteDataModelMapper }
        Resolver.register { RealUserAuthorizationToUserAuthorizationLocalDataModelMapper() as UserAuthorizationToUserAuthorizationLocalDataModelMapper }

        Resolver.register { RealUserAuthoriationRemoteDataSource() as UserAuthoriationRemoteDataSource }
        Resolver.register { RealUserAuthoriationLocalDataSource() as UserAuthoriationLocalDataSource }
        Resolver.register { RealUserAuthorizationRepository() as UserAuthorizationRepository }
        Resolver.register { SignInViewModel() }
        
        
        Resolver.register { RealUserAuthorizationToUserMapper() as UserAuthorizationToUserMapper }
        Resolver.register { RealUserRepository() as UserRepository }
        Resolver.register { RealGetUserUseCase() as GetUserUseCase }

        
  
        Resolver.register { NetworkServiceProvider<UploadContentNetworkService>() }
        Resolver.register { RealUploadContentRemoteDataSource() as UploadContentRemoteDataSource }
        Resolver.register { RealUploadContentUseCase() as UploadContentUseCase }

        
        
        Resolver.register { VerticalScrollablePageViewModel(verticalScrollablePageUIModel: .init()) }
        
        return true
    }
}
