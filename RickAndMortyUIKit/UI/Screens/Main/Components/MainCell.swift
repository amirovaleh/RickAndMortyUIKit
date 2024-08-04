//
//  MainCell.swift
//  RickAndMortyUIKit
//
//  Created by Valeh Amirov on 27.02.24.
//

import AnchorKit

final class MainCell: BaseCollectionCell {
    
    var item: Results? {
        didSet {
            guard let item else { return }
            
            profileImage.downloadImage(withUrl: item.image ?? "")
            nameLabel.text = item.name
            speciesLabel.text = item.species
            genderCase(gender: item.gender ?? "")
        }
    }

    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let genderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemRed
        return view
    }()
    
    override func setupView() {
        super.setupView()
        setConstraint()
    }
    
    private func setConstraint() {
        
        contentView.anchor(view: profileImage) { kit in
            kit.leading()
            kit.trailing()
            kit.top()
            kit.height(154.87)
            kit.width(160)
        }
        
        contentView.anchor(view: nameLabel) { kit in
            kit.centerX(profileImage.centerXAnchor)
            kit.top(profileImage.bottomAnchor, 5)
            kit.height(26)
        }
        
        contentView.anchor(view: speciesLabel) { kit in
            kit.centerX(nameLabel.centerXAnchor)
            kit.top(nameLabel.bottomAnchor, 5)
            kit.height(18)
        }
        
        profileImage.anchor(view: genderView) { kit in
            kit.trailing(11)
            kit.top(13)
            kit.height(30)
            kit.width(30)
        }
    }
    
    private func genderCase(gender: String) {

        switch gender {
        case "Male":
            genderView.backgroundColor = .systemBlue
        case "Female":
            genderView.backgroundColor = .systemRed
        case "Genderless":
            genderView.backgroundColor = .systemBrown
        case "unknown":
            genderView.backgroundColor = .systemGray
        default:
            break
        }
    }
}

