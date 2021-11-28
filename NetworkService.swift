//
//  NetworkService.swift
//  LoremPicsum
//
//  Created by LUM on 11/20/21.
//

import Foundation
import Alamofire
import AlamofireImage

class NetworkService {

    func getRandomImage(completion: @escaping (AFDataResponse<Image>) -> Void) {
        let randomImageRequestUrl = "https://picsum.photos/400/500"
        AF.request(randomImageRequestUrl).responseImage { response in
            completion(response)
        }
    }
    
    func get<T: Codable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of: T.self) { (response) in
            switch response.result {
            case .success(let decodedModel):
                completion(.success(decodedModel))
            case .failure(let afError):
                completion(.failure(afError))
            }
        }
    }
    
}

extension NetworkService {
    
    func get3<T: Codable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        let session = URLSession.shared
        let url = URL(string: url)!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            print(response)
            
            // handle errors
            if let error = error {
                completion(.failure(error))
                return
            }

            // unwrap data
            guard let data = data else {
                completion(.failure(CustomError.networkError("Data not found")))
                return
            }
            
            // decode model
            do {
                let decodedModel = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedModel))
                print("json.decoded \(decodedModel)")
            } catch {
                completion(.failure(error))
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
            
        })
        
        // execute task
        task.resume()
    }

    func get2(url: String) {
        let session = URLSession.shared
        let url = URL(string: url)!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            print(error)
            print(response)
        })
        
        task.resume()
    }
    
    private func getImageId() {
        let url = "https://picsum.photos/200/300"

        guard let imageSource = CGImageSourceCreateWithURL(NSURL(string: url)!, nil) else {return}
        guard let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? else {return}
        guard let exifDict = imageProperties[kCGImagePropertyExifDictionary] as? NSDictionary else {return}
        print("exifDict")

        print(exifDict)
        if let userCommentIdData = exifDict["UserComment"] {
            print("exifDict[], \(userCommentIdData)")
        }

//        print(imageProperties)
    }
    
}

class PicsumImageDetails: Codable {
    var id: String?
    var author: String?
    var width: Int
    var height: Int
//    var url: String
//    var download_url: String
}

enum CustomError: Error {
    case runtimeError(String)
    case networkError(String)
    
    var errorDescription: String {
        switch self {
        case .runtimeError(let errorMessage):
            return errorMessage
        case .networkError(let errorMessage):
            return errorMessage
        }
    }
}

extension Error {
    func errorMessage() -> String {
        let defaultError = "Oops! We are having a moment. Please try again later."
        guard let error = self as? CustomError else {return defaultError}
        return error.errorDescription
    }
}
