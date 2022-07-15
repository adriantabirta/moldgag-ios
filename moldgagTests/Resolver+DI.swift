//
//  Resolver+DI.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import Resolver
@testable import moldgag

extension Resolver {
    
    static let test: Resolver = Resolver(child: .main)

    static func registerForUnitTests() {
        Resolver.root = .test
        test.register { FilenameToLocalPathMapperMock() as FilenameToLocalPathMapper }.scope(.cached)
        test.register { RealLocalStorageService() as LocalStorageService }.scope(.cached)

        registerLocalDataSources()
        registerRemoteDataSources()
        registerUseCases()
        registerMappers()
        registerRepositories()
    }
    

    
    static func registerLocalDataSources() {
        
    }
    
    static func registerRemoteDataSources() {
        test.register { PostRemoteDataSourceMock() as PostRemoteDataSource }.scope(.cached)
            
    }
    
    static func registerRepositories() {
        test.register { PostRepositoryMock() as PostRepository }.scope(.cached)
        test.register { VideoRepositoryMock() as VideoRepository }.scope(.cached)
    }
    
    static func registerUseCases() {
        test.register { UploadContentUseCaseMock() as UploadContentUseCase }.scope(.cached)
        test.register { DeleteAllPostsUseCaseMock() as DeleteAllPostsUseCase }.scope(.cached)
        test.register { LoadPostsForPageUseCaseMock() as LoadPostsForPageUseCase }.scope(.cached)
    }
    
    static func registerMappers() {
        test.register { PostRemoteDataModelToPostModelMapperMock() as PostRemoteDataModelToPostModelMapper }.scope(.cached)

    }

    static func resetForUnitTests() {
        Resolver.root = .main
        ResolverScope.cached.reset()
    }

    /*
     We use this function to resolve a type to a mock objects as Resolver knows to register by type.

     */
    static func resolveMock<Service, Mock>(_ type: Service.Type = Service.self) -> Mock? {
        let service: Service = Resolver.test.resolve()
        return service as? Mock
    }
}
