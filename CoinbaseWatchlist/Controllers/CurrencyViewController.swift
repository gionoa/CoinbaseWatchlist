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

    init(currency: String) {
        super.init(nibName: nil, bundle: nil)
        
        title = currency
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(doneButtonTapped(_:)))
        
        //view.backgroundColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
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
        self.dismiss(animated: true)
    }
}
