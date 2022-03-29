//
//  MoldgagVideoServiceImpl.swift
//  moldgag
//
//  Created by Adrian Tabirta on 22.03.2022.
//

import Foundation
import GRPC
import NIO

/// MoldgagVideoServiceImpl - service to work with content.
class MoldgagVideoServiceImpl {
    
    private let client: Helloworld_GreeterClient
    
    init(connectionTarget: ConnectionTarget = .host("api.moldgag.ml"),
         eventLoopGroup: MultiThreadedEventLoopGroup = .init(numberOfThreads: 1)) throws {
        
        let tls = GRPCTLSConfiguration.makeClientDefault(compatibleWith: eventLoopGroup)
        let transportSecurity = GRPCChannelPool.Configuration.TransportSecurity.tls(tls)
        
        let channel = try GRPCChannelPool.with(target: connectionTarget, transportSecurity: transportSecurity, eventLoopGroup: eventLoopGroup)
        
        self.client = Helloworld_GreeterClient(channel: channel)
        
    }
    
}

extension MoldgagVideoServiceImpl: MoldgagVideoService {
    
    func sayHello(for name: String) -> String {
        var req = Helloworld_HelloRequest()
        req.name = UUID().uuidString
        
        let call = client.sayHello(req, callOptions: nil)
        do {
            let response = try call.response.wait()
            return response.message
        } catch {
            return "Fail"
        }
    }
    
    func items(for page: Int) -> [Item] {
        [
            .init(type: .adBanner, url: "https://img1.10bestmedia.com/Images/Photos/379865/Alaska---Forget-me-not_54_990x660.jpg"),
            .init(type: .image, url: "https://img1.10bestmedia.com/Images/Photos/379865/Alaska---Forget-me-not_54_990x660.jpg"),
            .init(type: .video, url: "https://moldgag.fra1.digitaloceanspaces.com/staging/067bac88093348ff99b62a6b85282329.mp4"),
            .init(type: .video, url: "https://moldgag.fra1.digitaloceanspaces.com/staging/dance.mp4"),
            .init(type: .video, url: "https://moldgag.fra1.digitaloceanspaces.com/staging/china.mp4")
        ]
    }
}
