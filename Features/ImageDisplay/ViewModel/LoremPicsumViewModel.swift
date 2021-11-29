//
//  LoremPicsumViewModel.swift
//  LoremPicsum
//
//  Created by Cade May on 11/20/21.
//

import RxSwift
import RxCocoa
import Alamofire
import AlamofireImage

class LoremPicsumViewModel {

    let repository = ImageRepository()
    
    // MARK: - observables
    let dateStringRx = BehaviorRelay<String?>(value: " ")
    let imageRx = BehaviorRelay<UIImage?>(value: nil)
    let imageDetailsRx = BehaviorRelay<PicsumImageDetails?>(value: nil)
    let loadTimeRx = BehaviorRelay<String?>(value: " ")

    private var dateTimeDisplayTimer: SelfInvalidatingTimer?
    
    init () {
        self.initDateTimeDisplayTimer()
    }

    func fetchRandomImage() {
        // for load duration calculation
        let imageFetchStartDate = Date()

        repository.getRandomImage { response in
            // fetch metadata
            self.parseIdAndFetchDetails(response)
 
            // display image
            switch response.result {
                case .success(let image):
                    self.imageRx.accept(image)
                self.updateLoadTime(relativeTo: imageFetchStartDate)
                case .failure(let afError):
                    print("failed")
            }
        }

    }
    
}

// MARK: - image details
extension LoremPicsumViewModel {
    
    /** Pull image id from response header and fetch metadata */
    private func parseIdAndFetchDetails(_ response: AFDataResponse<Image>) {
        // parse image id from http header
        let PICSUM_ID_KEY = "picsum-id"
        guard let headerDict = response.response?.headers.dictionary else {return}
        guard let imageIdString = headerDict[PICSUM_ID_KEY], let imageId = Int(imageIdString) else {return}
        self.getImageDetails(for: imageId)
    }
    
    
    /** Fetch metadata for imageId */
    private func getImageDetails(for imageId: Int) {
        repository.getImageDetails(for: imageId) { result in
            switch result {
            case .success(let imageDetails):
                self.imageDetailsRx.accept(imageDetails)
            case .failure(let error):
                print("we have an error! \(error)")
            }
        }
    }
    
}

// MARK: - time displays
extension LoremPicsumViewModel {
    
    /** Derive current timestamp and update observable once per second */
    private func initDateTimeDisplayTimer() {
        self.dateTimeDisplayTimer = SelfInvalidatingTimer(seconds: 1, repeats: true, closure: { [weak self] in
            guard let _self = self else {return}
            let dateTime = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
            _self.dateStringRx.accept(dateTime)
        })
    }
    
    /** Compute time difference and update observable */
    private func updateLoadTime(relativeTo startDate: Date) {
        let imageFetchDuration = Date().timeIntervalSince(startDate)
        let roundedDuration = round(imageFetchDuration * 1000) / 1000.0
        self.loadTimeRx.accept("\(roundedDuration) seconds")
    }
    
}
