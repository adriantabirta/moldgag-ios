//
//  AppDelegate.swift
//  moldgag
//
//  Created by Adrian Tabirta on 19.02.2022.
//

import UIKit
import MediaPlayer
import AVFoundation
import DHT

@main class AppDelegate: PluggableApplicationDelegate {
    
    override var services: [ApplicationService] {
        [
            ResolverService(),
            GlobalNavigationService(),
          //  GlobalAudioService(),
        ]
    }
}

/*
struct Resolver: DHTNetworkAddressResolver {
    
    func resolve(hostname: String, port: Int) throws -> DHTNetworkAddress? {
        return DHTNetworkAddress.hostPort(host: DHTNetworkAddress.Host.ipv4(DHTIPv4Address.init(Data())!),
                                          port: DHTNetworkAddress.Port.init("4200")!)
    }
}


func test() {
    

    let config = DHT.Config.init(ipv4NodeID: .init(value: "")!, ipv6NodeID: .init(value: "")!, clientVersion: Data())
    
 
    
    let dht = DHT.init(config: config,
             addressResolver: Resolver(),
             queue: DispatchQueue.main,
             remoteQueryMessageHandlers: [])
    
    
    let message = KRPCMessage.init(transactionID: "ss".data(using: .utf8)!, errorCode: 0, errorMessage: "", clientVersion: Data())
    
  
    let remoteAddress = DHTRemoteNode.Identifier.init(address: DHTNetworkAddress.hostPort(host: DHTNetworkAddress.Host.ipv4(DHTIPv4Address.init(Data())!), port: DHTNetworkAddress.Port.init(integerLiteral: 4200)), nodeID: nil)
    
    dht.channel = DHTChannel
    dht.send(message: message, to: remoteAddress, queryTimeout: .seconds(5)) { result in
        switch result {
        case .success(let message):
            print(message.debugDescription)
        case .failure(let error):
            print(error)
        }
    } completionHandler: { completion in
        
    }

}
 */
