//
//  BaseCollectionCell.swift
//  RickAndMortyUIKit
//
//  Created by Valeh Amirov on 27.02.24.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {}
}

