//
//  MetadataLabelsView.swift
//  LoremPicsum
//
//  Created by Cade May on 11/28/21.
//

import UIKit

class MetadataLabelsView: UIView {
        
    lazy var mainHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label1, label2])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis          = .horizontal
        stack.spacing       = 4
        stack.alignment     = .fill
        stack.distribution  = .fill
        return stack
    }()
    let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    let label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .left
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initLayout()
        self.setContentHuggingPriority(.required, for: .vertical)
    }
    
    private func initLayout() {
        self.addSubview(mainHStack)
        mainHStack.constrainToFillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

