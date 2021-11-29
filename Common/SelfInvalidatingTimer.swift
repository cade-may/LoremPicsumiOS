//
//  SelfInvalidatingTimer.swift
//  LoremPicsum
//
//  Created by Cade May on 11/28/21.
//

import Foundation

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
