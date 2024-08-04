//
//  UIViewController+Ext.swift
//  RickAndMortyUIKit
//
//  Created by Valeh Amirov on 27.02.24.
//

import UIKit

extension UIViewController {
    func setNavigationItem(title: String) {
        self.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}
