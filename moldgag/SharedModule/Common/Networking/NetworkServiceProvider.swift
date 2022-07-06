//
//  NetworkServiceProvider.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import Foundation

let imageUrls = [
    "https://img1.10bestmedia.com/Images/Photos/379865/Alaska---Forget-me-not_54_990x660.jpg",
    "https://photovideocreative.com/wordpress/wp-content/uploads/2017/11/Paysage-en-orientation-portrait.jpg",
    "https://i.imgur.com/QdTIU1Z.jpeg",
    "https://i.imgur.com/GKPFZBy.jpeg",
    "https://i.imgur.com/gYOWB4l.jpeg",
    "https://i.imgur.com/5p0H5Aw.jpeg",
    "https://i.imgur.com/1W5N7i3.jpeg",
    "https://i.imgur.com/TXt4BCJ.jpeg",
    "https://i.imgur.com/qqGe1B8.jpeg"
]

let videoUrls = [
    "https://i.imgur.com/LdP8WkB.mp4",
    "http://www.exit109.com/~dnn/clips/RW20seconds_2.mp4",
    "https://i.imgur.com/9R6zXD1.mp4",
    "https://i.imgur.com/veyJFra.mp4",
    "https://i.imgur.com/5iSFBPS.mp4",
    "https://i.imgur.com/hEylmuu.mp4",
    "https://i.imgur.com/vyHREFY.mp4",
    "https://i.imgur.com/zGaSqqg.mp4",
    "https://i.imgur.com/gr4QcLA.mp4",
    "https://i.imgur.com/KNqJAdt.mp4"
]

class NetworkServiceProvider<N: NetworkService> {
    
    private var urlSession: URLSession
    
    private var decoder: JSONDecoder
    
    init(urlSession: URLSession =  URLSession.shared, decoder: JSONDecoder = .init()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func requestMock<T: Decodable>(enpoint: N) -> AnyPublisher<T, NetworkError> {
        
        if T.self is PostsRemoteDataModel.Type {
            
            let images = (0...4).compactMap { _ in imageUrls.randomElement() }.map { PostRemoteDataModel(type: "image", url: $0) }
            let videos = (0...4).compactMap { _ in videoUrls.randomElement() }.map { PostRemoteDataModel(type: "video", url: $0) }
            let result = (images + videos).shuffled()
            
            return Just(PostsRemoteDataModel(posts: result) as! T)
                .delay(for: 2, scheduler: RunLoop.current)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            
        } else if T.self is PostRemoteDataModel.Type {
            return Just(PostRemoteDataModel(type: "image", url: "url-mock") as! T)
                .delay(for: 1, scheduler: RunLoop.current)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else if T.self is UploadResponseRemoteDataModel.Type {
            let uploadData = UploadResponseRemoteDataModel.UploadData(id: "1", link: "https://content.com/image.jpg")
            return Just(UploadResponseRemoteDataModel(status: 200, success: true, data: uploadData) as! T)
                .delay(for: 1, scheduler: RunLoop.current)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            
        } else {
            let result = try! T(from: decoder as! Decoder)
            return Just(result)
                .delay(for: 2, scheduler: RunLoop.current)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
    }
    
    func request<T: Decodable>(enpoint: N) -> AnyPublisher<T, NetworkError> {
        guard let urlRequest = enpoint.urlRequest else { return Fail(error: NetworkError.unableToBuildRequest).eraseToAnyPublisher() }
        return urlSession.dataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                print(element.response.description)
                print(String(data: element.data, encoding: .utf8))
                
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: T.self, decoder: self.decoder)
            .handleEvents(receiveOutput: { decodable in
                print(decodable)
            }, receiveCompletion: { completion in
                
                switch completion {
                case .failure(let error): print("Error \(error)")
                case .finished: print("Publisher is finished")
                }
            })
            .mapError({ NetworkError($0) })
            .eraseToAnyPublisher()
    }
    
    func dataRequest(_ url: URL) -> AnyPublisher<Optional<Data>, NetworkError> {
        urlSession.dataTaskPublisher(for: url)
            .map({ (data, response) -> Optional<Data> in
                guard ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300 else { return nil }
                return data
            })
            .mapError { NetworkError($0) }
            .eraseToAnyPublisher()
    }
    
}
