//
//  MainViewController.swift
//  RickAndMortyUIKit
//
//  Created by Valeh Amirov on 27.02.24.
//
//

import AnchorKit

class MainViewController: UIViewController {

    lazy var viewModel: MainViewModel = {
        let vModel = MainViewModel(http: HTTPClient())
        vModel.delegate = self
        return vModel
    }()
    
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ada görə axtarış"
        textField.layer.cornerRadius = 12
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(MainCell.self, forCellWithReuseIdentifier: MainCell.description())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationItem(title: "Rick & Morty")
        
        setupUIConstraints()
        viewModel.fetchData()
    }
    
    private func setupUIConstraints() {
        
        view.anchor(view: searchButton) { kit in
            kit.trailing(10)
            kit.width(80)
            kit.height(50)
            kit.top(safe: true)
        }

        view.anchor(view: searchTextField) { kit in
            kit.leading(10)
            kit.trailing(searchButton.leadingAnchor, 5)
            kit.top(safe: true)
            kit.height(50)
        }
        
        view.anchor(view: collectionView) { kit in
            kit.leading(23)
            kit.trailing(23)
            kit.top(searchTextField.bottomAnchor, 20)
            kit.bottom(safe: true)
        }
    }
    
    @objc private func didTapSearch() {
        guard let text = searchTextField.text else { return }
        viewModel.search(nameText: text)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.description(), for: indexPath) as? MainCell {
            cell.item = viewModel.filteredData[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = viewModel.filteredData[indexPath.row].id
        guard let id else { return }
        show(id: id)
    }
    
    func show(id: Int) {
        let vc = DetailViewController()
        vc.viewModel.update(id: id)
        show(vc, sender: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.1, height: collectionView.frame.height / 2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MainViewController: MainViewModelDelegate {
    func didSuccess() {
        collectionView.reloadData()
    }
}
