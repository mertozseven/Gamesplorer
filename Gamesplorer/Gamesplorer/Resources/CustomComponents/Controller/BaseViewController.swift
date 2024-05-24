//
//  BaseViewController.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 24.05.2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
        view.backgroundColor = .systemBackground
    }
    
    private func addViews() {
    }
    
    private func configureLayout() {

    }

}
