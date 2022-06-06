//
//  UploadResponseRemoteDataModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 02.06.2022.
//

import Foundation

//{
//  "status": 200,
//  "success": true,
//  "data": {
//    "id": "QuXZO4b",
//    "deletehash": "0ywnisel026qGnJ",
//    "account_id": 76634007,
//    "account_url": "AdrianTab",
//    "ad_type": null,
//    "ad_url": null,
//    "title": null,
//    "description": null,
//    "name": "",
//    "type": "image/png",
//    "width": 750,
//    "height": 1334,
//    "size": 1664937,
//    "views": 0,
//    "section": null,
//    "vote": null,
//    "bandwidth": 0,
//    "animated": false,
//    "favorite": false,
//    "in_gallery": false,
//    "in_most_viral": false,
//    "has_sound": false,
//    "is_ad": false,
//    "nsfw": null,
//    "link": "https://i.imgur.com/QuXZO4b.png",
//    "tags": [],
//    "datetime": 1654435446,
//    "mp4": "",
//    "hls": ""
//  }
//}

struct UploadResponseRemoteDataModel: Decodable {
    
    struct UploadData: Decodable {
        
        let id: String
        
        let link: String
    }
    
    let status: Int
    
    let success: Bool
    
    let data: UploadData
  
}
