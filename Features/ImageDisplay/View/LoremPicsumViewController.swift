//
//  LoremPicsumViewController.swift
//  LoremPicsum
//
//  Created by Cade May on 11/20/21.
//

import UIKit
import RxSwift
import RxCocoa

class LoremPicsumViewController: UIViewController {
    
    let viewModel  = LoremPicsumViewModel()
    let disposeBag = DisposeBag()
    
    let mainPicsumView: MainPicsumView = {
        let view = MainPicsumView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}

// MARK: - overrides
extension LoremPicsumViewController {
    override func loadView() {
        self.view = self.mainPicsumView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initObservers()
        self.fetchData()
        self.initGestures()
        self.view.backgroundColor = .white
    }
}

// MARK: - init
extension LoremPicsumViewController {
    
    private func initObservers() {
        self.observeDate()
        self.observeImage()
        self.observeLoadTime()
        self.observeImageDetails()
    }
    
    private func initGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.fetchDataAction))
        self.mainPicsumView.mainImageView.addGestureRecognizer(tapGesture)
    }
}

// MARK: - rx observers
extension LoremPicsumViewController {
    
    private func observeDate() {
        self.viewModel.dateStringRx.subscribe { [weak self] dateString in
            guard let self = self else {return}
            guard let dateString = dateString else {return}
            DispatchQueue.main.async {
                self.mainPicsumView.dateLabel.text = dateString
            }
        } onError: { err in
            print(err.localizedDescription)
        }.disposed(by: self.disposeBag)
    }
    
    private func observeLoadTime() {
        self.viewModel.loadTimeRx.subscribe { [weak self] timeString in
            guard let self = self else {return}
            guard let timeString = timeString else {return}
            DispatchQueue.main.async {
                self.mainPicsumView.loadTimeView.label2.text = timeString
            }
        } onError: { err in
            print(err.localizedDescription)
        }.disposed(by: self.disposeBag)
    }
    
    private func observeImageDetails() {
        self.viewModel.imageDetailsRx.subscribe { [weak self] imageDetails in
            guard let self = self else {return}
            if let imageDetails = imageDetails {
                DispatchQueue.main.async {
                    self.mainPicsumView.setup(with: imageDetails)
                }
            }
        } onError: { err in
            print(err.localizedDescription)
        }.disposed(by: self.disposeBag)
    }
    
    private func observeImage() {
        self.viewModel.imageRx.subscribe { [weak self] image in
            guard let self = self else {return}
            if let image = image {
                DispatchQueue.main.async {
                    self.mainPicsumView.mainImageView.image = image
                }
            }
        } onError: { err in
            print(err.localizedDescription)
        }.disposed(by: self.disposeBag)
    }
    
}

// MARK: - actions
extension LoremPicsumViewController {
    
    @objc func fetchDataAction(_ gesture: UILongPressGestureRecognizer) {
        self.fetchData()
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        self.animateImageView()
    }
    
    private func fetchData() {
        self.viewModel.fetchRandomImage()
    }
    
    private func animateImageView() {
        UIView.animate(withDuration: 0.222, delay: 0, options: []) {
            // animate shrink
            self.mainPicsumView.mainImageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            // animate back to regular size
            UIView.animate(withDuration: 0.444, delay: 0.025, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [.curveEaseInOut], animations: {
                self.mainPicsumView.mainImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }

}