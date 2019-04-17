//
//  MainViewController.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/11/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 81
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.reuseID)
        return tableView
    }()

    private let modelController = ModelController()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  currencyView.delegate = self
        
        setupNavBar()
        setupUI()
        
        modelController.fetchData() { error in
            if let error = error {
                print(error)
                // alert
            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Setup
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Coinbase Markets"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "USD", style: .plain, target: self, action: #selector(barButtonTapped(_:)))
      //  navigationItem.rightBarButtonItem = UIBarButtonItem(customView: currencyView)
        // navigationItem.rightBarButtonItem?.setTitlePositionAdjustment(.init(horizontal: 0, vertical: 25),
        //                                                                for: UIBarMetrics.default)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let safeArea = view.safeAreaLayoutGuide
        view.addConstraints([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            ])
    }
    
    @objc private func barButtonTapped(_ sender: UIBarButtonItem) {
        let vc = UINavigationController(rootViewController: CurrencyViewController(currency: modelController.currency))
        
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    //MARK: - TableView Delegate / DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reuseID, for: indexPath) as! CoinTableViewCell
        
        let coin = modelController.coin(at: indexPath.row)
        cell.configure(coin)
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let coin = modelController.coin(at: indexPath.row)
        let detailVC = CoinDetailViewController(coin)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
