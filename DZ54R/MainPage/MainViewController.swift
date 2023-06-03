//
//  MainViewController.swift
//  DZ54R
//
//  Created by merim kasenova on 27/5/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 300
        view.layer.cornerRadius = 30
        view.dataSource = self
        view.register(
            CustomTableViewCell.self,
            forCellReuseIdentifier: CustomTableViewCell.reusedId
        )
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Find store by name"
        view.backgroundColor = .white
        view.borderStyle = .line
        view.addTarget(
            self,
            action: #selector(editingChanged),
            for: .editingChanged)
        view.layer.cornerRadius = 5
        return view
    }()
    
    private func fetchProducts() {
    Task {
        await viewModel.fetchProducts()
        tableView.reloadData()
        }
    }
    
    private var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        fetchProducts()
    }
    
    @objc func editingChanged() { }
    
    private func setupView() {
        
        view.addSubview(searchTextField)
        view.addSubview(tableView)
        
        searchTextField.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(60)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(Constants.Sizes.size46)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.products.count
    }
    
    func tableView(
        _ tableView: UITableView,
         cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.reusedId,
            for: indexPath
        ) as! CustomTableViewCell
        let model = viewModel.products[indexPath.row]
        cell.diplay(item: model)
        return cell
           }
       }



