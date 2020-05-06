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
    static func UploadVideo(fileURL:URL, prevImage:UIImage!){
//        guard let fileURL = Bundle.main.url(forResource: "spin.MP4", withExtension: nil)
//            else {
//                fatalError("Couldn't find spin.mp4 in main bundle.")
//        }

//        AF.upload(fileURL, to: "https://192.168.1.45:45455/api/spin").responseDecodable(of: HTTPBinResponse.self) { response in
//            debugPrint(response)
//        }
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data("1".utf8), withName: "UserId")
            multipartFormData.append(Data("KickShow Test Upload".utf8), withName: "Title")
            multipartFormData.append(fileURL, withName: "Motion")
            multipartFormData.append(prevImage!.jpegData(compressionQuality: 0.5)!, withName: "preview_image", fileName:"file.jpeg",mimeType: "image/jpeg")
        } , to: "https://kickshowapi.azurewebsites.net/api/spin")
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
