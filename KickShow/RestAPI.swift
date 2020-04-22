//
//  RestAPI.swift
//  KickShow
//
//  Created by Christopher Tufaro on 4/21/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import Alamofire

class RestAPI{
    static func UploadVideo(){
        guard let fileURL = Bundle.main.url(forResource: "spin.MP4", withExtension: nil)
            else {
                fatalError("Couldn't find spin.mp4 in main bundle.")
        }

        AF.upload(fileURL, to: "https://httpbin.org/post").responseDecodable(of: HTTPBinResponse.self) { response in
            debugPrint(response)
        }
    }
}

struct HTTPBinResponse: Decodable { let url: String }
