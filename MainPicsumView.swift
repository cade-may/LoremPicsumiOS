//
//  MainPicsumView.swift
//  LoremPicsum
//
//  Created by LUM on 11/20/21.
//

import UIKit

class MainPicsumView: UIView {
    
    private var padding: CGFloat = 16
    
    lazy var mainVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dateLabel, imageIdView, imageWidthView, imageHeightView, loadTimeView, mainImageView, authorNameView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis          = .vertical
        stack.spacing       = 8
        stack.alignment     = .fill
        stack.distribution  = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: padding, left: padding, bottom: padding, right: padding)
        return stack
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.numberOfLines = 1
        return label
    }()
    let imageIdView: MetadataLabelsView = {
        let view = MetadataLabelsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label1.text = "Image id:"
        return view
    }()
    let imageWidthView: MetadataLabelsView = {
        let view = MetadataLabelsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label1.text = "Width:"
        return view
    }()
    let imageHeightView: MetadataLabelsView = {
        let view = MetadataLabelsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label1.text = "Height:"
        return view
    }()
    let loadTimeView: MetadataLabelsView = {
        let view = MetadataLabelsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label1.text = "Load time:"
        return view
    }()
    let mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleAspectFill
        iv.setContentHuggingPriority(.defaultLow, for: .vertical) // fill height
        iv.roundCorners(.allCorners, radius: 12)
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.borderWidth = 4
        return iv
    }()
    let authorNameView: MetadataLabelsView = {
        let view = MetadataLabelsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label1.text = "Author name:"
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initLayout()
    }
    
    func setup(with imageDetails: PicsumImageDetails) {
        self.imageHeightView.label2.text = "\(imageDetails.height)"
        self.imageWidthView.label2.text = "\(imageDetails.width)"

        if let imageId = imageDetails.id {
            self.imageIdView.label2.text = "\(imageId)"
        }
        
        if let authorName = imageDetails.author {
            self.authorNameView.label2.text = "\(authorName)"
        }
    }
    
    private func initLayout() {
        self.addSubview(mainVStack)
        mainVStack.constrainToFillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


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
