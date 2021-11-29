//
//  ImageRepository.swift
//  LoremPicsum
//
//  Created by Cade May on 11/28/21.
//

import Foundation
import Alamofire
import AlamofireImage

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


