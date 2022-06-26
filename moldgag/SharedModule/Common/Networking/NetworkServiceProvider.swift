//
//  NetworkServiceProvider.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import Foundation

let posts = [
    VideoPostUIModel(type: PostType.adBanner, url: URL(string: "https://img1.10bestmedia.com/Images/Photos/379865/Alaska---Forget-me-not_54_990x660.jpg")!),
    VideoPostUIModel(type: PostType.image, url: URL(string: "https://photovideocreative.com/wordpress/wp-content/uploads/2017/11/Paysage-en-orientation-portrait.jpg")!),
    VideoPostUIModel(type: PostType.video, url: URL(string: "https://i.imgur.com/LdP8WkB.mp4")!),
    VideoPostUIModel(type: PostType.video, url: URL(string: "http://www.exit109.com/~dnn/clips/RW20seconds_2.mp4")!),
    VideoPostUIModel(type: PostType.video, url: URL(string: "https://i.imgur.com/9R6zXD1.mp4")!),
    VideoPostUIModel(type: PostType.video, url: URL(string: "https://i.imgur.com/veyJFra.mp4")!),
    VideoPostUIModel(type: PostType.video, url: URL(string: "https://i.imgur.com/5iSFBPS.mp4")!),
    VideoPostUIModel(type: PostType.image, url: URL(string: "https://i.imgur.com/QdTIU1Z.jpeg")!),
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
            let data = posts
                .map({ PostRemoteDataModel(id: $0.id, type: $0.type.rawValue, url: $0.url.absoluteString) })
                .shuffled()
            
            return Just(PostsRemoteDataModel(posts: data) as! T)
                .delay(for: 2, scheduler: RunLoop.current)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else if T.self is PostRemoteDataModel.Type {
            return Just(PostRemoteDataModel(id: "-1", type: "image", url: "url-mock") as! T)
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
    
}
