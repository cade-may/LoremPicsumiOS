//
//  NetworkService.swift
//  LoremPicsum
//
//  Created by Cade May on 11/20/21.
//

import Foundation
import Alamofire
import AlamofireImage

class NetworkService {

    /** Fetch image via AlamofireImage */
    func getImage(url: String, completion: @escaping (AFDataResponse<Image>) -> Void) {
        AF.request(url).responseImage { response in
            completion(response)
        }
    }
    
    /** HTTP - GET */
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
