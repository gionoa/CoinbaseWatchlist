//
//  CurrencyViewController.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/16/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        title = "Currencies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(doneButtonTapped(_:)))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped(_:)))
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        let safeArea = view.safeAreaLayoutGuide
        view.addConstraints([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
    }
    
    @objc private func doneButtonTapped(_ sender: UIBarButtonItem) {
        // change currency and reload
        self.dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}
