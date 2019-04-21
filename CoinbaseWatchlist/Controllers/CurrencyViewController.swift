//
//  CurrencyViewController.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/16/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import UIKit

protocol CurrencyDelegate: class {
    func didSelectCurrency(currency: String)
}

class CurrencyViewController: UIViewController {
    
    weak var delegate: CurrencyDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight =  UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private let modelController = CurrenciesModelController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func setupUI() {
        title = NSLocalizedString("Currencies", comment: "")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancelButtonTapped(_:)))
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        modelController.fetchCurrencies { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}

extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.reuseIdentifier, for: indexPath) as! CurrencyTableViewCell
        cell.configure(modelController.dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectCurrency(currency: modelController.dataSource[indexPath.row].symbol)
        dismiss(animated: true)
    }
}
