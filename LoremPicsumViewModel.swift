//
//  LoremPicsumViewModel.swift
//  LoremPicsum
//
//  Created by LUM on 11/20/21.
//

import RxSwift
import RxCocoa
import Alamofire
import AlamofireImage

// todo: display hstack subclasses for metadata, spinners, better ui/ux, date display
class LoremPicsumViewModel {

    let network = NetworkService()
    
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

        network.getRandomImage { response in
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
    
    private func initDateTimeDisplayTimer() {
        self.dateTimeDisplayTimer = SelfInvalidatingTimer(seconds: 1, repeats: true, closure: { [weak self] in
            guard let _self = self else {return}
            let dateTime = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
            _self.dateStringRx.accept(dateTime)
        })
    }
    
    private func parseIdAndFetchDetails(_ response: AFDataResponse<Image>) {
        // parse image id from http header
        let PICSUM_ID_KEY = "picsum-id"
        guard let headerDict = response.response?.headers.dictionary else {return}
        guard let imageIdString = headerDict[PICSUM_ID_KEY], let imageId = Int(imageIdString) else {return}
        self.getInfo(for: imageId)
    }
    
    
    private func getInfo(for imageId: Int) {
        let url = "https://picsum.photos/id/\(imageId)/info"
        
        network.get(url: url) { (result: Result<PicsumImageDetails, Error>) in
            switch result {
            case .success(let imageDetails):
                self.imageDetailsRx.accept(imageDetails)
            case .failure(let error):
                print("we have an error! \(error)")
            }
        }
    }
    
    private func updateLoadTime(relativeTo startDate: Date) {
        let imageFetchDuration = Date().timeIntervalSince(startDate)
        let roundedDuration = round(imageFetchDuration * 1000) / 1000.0
        self.loadTimeRx.accept("\(roundedDuration) seconds")
    }
}

class SelfInvalidatingTimer {
    let timer: Timer
    
    init(seconds: TimeInterval, repeats: Bool, closure: @escaping () -> ()) {
        timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: repeats, block: { _ in
            closure();
        })
    }
    
    deinit {
        timer.invalidate()
    }
}
