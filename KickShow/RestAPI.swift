//
//  RestAPI.swift
//  KickShow
//
//  Created by Christopher Tufaro on 4/21/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class RestAPI{
    static func UploadVideo(fileURL:URL, imageUrl:URL){
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data("1".utf8), withName: "UserId")
            multipartFormData.append(Data("KickShow Test Upload".utf8), withName: "Title")
            multipartFormData.append(fileURL, withName: "Motion")
            multipartFormData.append(imageUrl, withName: "Image")
        } , to: "https://kickshowapi.azurewebsites.net/api/userpost")
        .uploadProgress { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }
        .downloadProgress { progress in
            print("Download Progress: \(progress.fractionCompleted)")
        }
        .responseDecodable(of: HTTPBinResponse.self) { response in
            debugPrint(response)
        }
    }
}

struct HTTPBinResponse: Decodable { let url: String }
