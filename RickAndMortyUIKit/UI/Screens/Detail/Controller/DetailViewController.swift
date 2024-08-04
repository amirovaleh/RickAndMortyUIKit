//
//  DetailController.swift
//  RickAndMortyUIKit
//
//  Created by Valeh Amirov on 27.02.24.
//
//

import AnchorKit

final class DetailViewController: UIViewController {

    lazy var viewModel: DetailViewModel = {
        let vModel = DetailViewModel(http: HTTPClient())
        vModel.delegate = self
        return vModel
    }()
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .regular)
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let originLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        
        view.anchor(view: nameLabel) { kit in
            kit.top(safe: true)
            kit.centerX()
        }
        
        view.anchor(view: profileImage) { kit in
            kit.leading(16)
            kit.trailing(16)
            kit.top(nameLabel.bottomAnchor,23)
            kit.height(329)
            kit.width(361)
        }
        
        let components = VStack(views: genderLabel,
                                statusLabel,
                                speciesLabel,
                                typeLabel,
                                originLabel, spacing: 7,
                                alignment: .fill,
                                distribution: .equalSpacing)
        
        view.anchor(view: components) { kit in
            kit.leading(16)
            kit.top(profileImage.bottomAnchor, 51)
            kit.height(130)
        }
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func didSuccess() {
        guard let data = viewModel.userData else { return }
        
        genderLabel.text = "Gender:\(data.gender ?? "None")"
        profileImage.downloadImage(withUrl: data.image ?? "")
        nameLabel.text = data.name
        statusLabel.text = "Status:\(data.status ?? "Yoxdur")"
        speciesLabel.text = "Species: \(data.species ?? "None")"
        typeLabel.text = "Type:\(data.type ?? "None")"
        originLabel.text = "Origin: \(data.origin?.name ?? "")"
        print("\(data.type ?? "yoxdur")")
    }
}
