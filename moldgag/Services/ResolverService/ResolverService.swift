//
//  ResolverService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import UIKit
import Resolver
import Foundation

class ResolverService: NSObject {
    
    override init() {
        super.init()
        debugPrint("\(String(describing: ResolverService.self)) has started!")
    }
}

extension ResolverService: ApplicationService {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        registerAllDependencies()
        return true
    }
}

private extension ResolverService {
    
    private func registerAllDependencies() {
        registerLocalDataSources()
        registerRemoteDataSources()
        registerRepositories()
        registerUseCases()
        registerMappers()
        registerViewModels()
        registerNetworkServices()
        registerServices()
    }
    
    func registerLocalDataSources() {
        Resolver.register { RealPostLocalDataSource() as PostLocalDataSource }
        Resolver.register { RealUserAuthoriationLocalDataSource() as UserAuthoriationLocalDataSource }
        Resolver.register { RealVideoLocalDataSource() as VideoLocalDataSource }
        Resolver.register { RealImageLocalDataSource() as ImageLocalDataSource }
    }
    
    func registerRemoteDataSources() {
        Resolver.register { RealPostRemoteDataSource() as PostRemoteDataSource }
        Resolver.register { RealUserAuthoriationRemoteDataSource() as UserAuthoriationRemoteDataSource }
        Resolver.register { RealUploadContentRemoteDataSource() as UploadContentRemoteDataSource }
        Resolver.register { RealPostRemoteDataSource() as PostRemoteDataSource }
        Resolver.register { RealImageRemoteDataSource() as ImageRemoteDataSource }
    }
    
    func registerRepositories() {
        Resolver.register { RealPostRepository() as PostRepository }
        Resolver.register { RealUserAuthorizationRepository() as UserAuthorizationRepository }
        Resolver.register { RealUserRepository() as UserRepository }
        Resolver.register { RealVideoRepository() as VideoRepository }
        Resolver.register { RealImageRepository() as ImageRepository }.scope(.application)
    }
    
    func registerUseCases() {
        Resolver.register { RealLoadPostsForPageUseCase() as LoadPostsForPageUseCase }
        Resolver.register { RealGetVideoAssetUseCase() as GetVideoAssetUseCase }
        Resolver.register { RealGetPostsStreamUseCase() as GetPostsStreamUseCase }
        Resolver.register { RealRefreshPostsUseCase() as RefreshPostsUseCase }
        Resolver.register { RealDeleteAllPostsUseCase() as DeleteAllPostsUseCase }
        Resolver.register { RealRefreshPostsUseCase() as RefreshPostsUseCase }
        Resolver.register { RealCreatePostUseCase() as CreatePostUseCase }
        Resolver.register { RealIsUserLoggedInUseCase() as IsUserLoggedInUseCase }
        Resolver.register { RealGetUserUseCase() as GetUserUseCase }
        Resolver.register { RealUploadContentUseCase() as UploadContentUseCase }

        let window = (UIApplication.shared.delegate as! PluggableApplicationDelegate).window
        Resolver.register { RealSignInWithAppleUseCase(window: window) as SignInWithAppleUseCase? }
        Resolver.register { RealGetImageUseCase() as GetImageUseCase }
    }
    
    
    func registerMappers() {
        Resolver.register { RealPostModelToPostUIModelMapper() as PostModelToPostUIModelMapper }
        Resolver.register { RealPostLocalDataModelToPostMapper() as PostLocalDataModelToPostMapper }
        Resolver.register { RealPostRemoteDataModelToPostModelMapper() as PostRemoteDataModelToPostModelMapper }
        Resolver.register { RealPostUIModelToUIViewControllerMapper() as PostUIModelToUIViewControllerMapper }
        
        Resolver.register { RealUserAuthorizationLocalDataModelToUserAuthorizationMapper() as UserAuthorizationLocalDataModelToUserAuthorizationMapper }
        
        Resolver.register { RealASAuthorizationAppleIDCredentialToUserAuthorizationMapper() as ASAuthorizationAppleIDCredentialToUserAuthorizationMapper }
        Resolver.register { RealUserAuthorizationToUserAuthorizationRemoteDataModelMapper() as UserAuthorizationToUserAuthorizationRemoteDataModelMapper }
        Resolver.register { RealUserAuthorizationToUserAuthorizationLocalDataModelMapper() as UserAuthorizationToUserAuthorizationLocalDataModelMapper }
        Resolver.register { RealFilenameToLocalPathMapper() as FilenameToLocalPathMapper }
        Resolver.register { RealUserAuthorizationToUserMapper() as UserAuthorizationToUserMapper }

        Resolver.register { RealPostRemoteDataModelToPostModelMapper() as PostRemoteDataModelToPostModelMapper }
        Resolver.register { RealPostRemoteDataModelToPostLocalDataModelMapper() as PostRemoteDataModelToPostLocalDataModelMapper }

        Resolver.register { RealContentPickedDictionaryToVideoUrlMapper() as ContentPickedDictionaryToVideoUrlMapper  }
        Resolver.register { RealContentPickedDictionaryToImageUrlMapper() as ContentPickedDictionaryToImageUrlMapper }

    }
    
    func registerViewModels() {
        Resolver.register { AuthenticationViewModel() }
        Resolver.register { LoadingScreenViewModel() }
        Resolver.register { VerticalScrollablePageViewModel(verticalScrollablePageUIModel: .init()) }
        Resolver.register { CreateVideoPostViewModel() }
    }
    
    func registerNetworkServices() {
        Resolver.register { NetworkServiceProvider<PostNetworkService>() }
        Resolver.register { NetworkServiceProvider<AuthorizationNetworkService>() }
        Resolver.register { NetworkServiceProvider<UploadContentNetworkService>() }
    }
    
    func registerServices() {
        Resolver.register { RealLocalStorageService() as LocalStorageService }
    }
}
