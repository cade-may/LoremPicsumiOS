//
//  MainPicsumView.swift
//  LoremPicsum
//
//  Created by Cade May on 11/20/21.
//

import UIKit

class MainPicsumView: UIView {
    
    private var padding: CGFloat = 16
    
    lazy var mainVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dateLabel, imageIdView, imageWidthView, imageHeightView, loadTimeView, mainImageView, authorNameView, errorLabel])
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
        label.setContentHuggingPriority(.required, for: .vertical)
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
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = ""
        label.textAlignment = .left
        label.textColor = .red
        label.numberOfLines = 2
        label.isHidden = true
        return label
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
