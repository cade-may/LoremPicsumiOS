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

    func getImage(url: String, completion: @escaping (AFDataResponse<Image>) -> Void) {
        AF.request(url).responseImage { response in
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

class ImageRepository {
    
    let network = NetworkService()

    func getRandomImage(completion: @escaping (AFDataResponse<Image>) -> Void) {
        let randomImageRequestUrl = "https://picsum.photos/400/500"
        network.getImage(url: randomImageRequestUrl, completion: completion)
    }
    
    func getImageDetails<T: PicsumImageDetails>(for imageId: Int, completion: @escaping (Result<T, Error>) -> Void) {
        let url = "https://picsum.photos/id/\(imageId)/info"
        network.get(url: url, completion: completion)
    }
}


