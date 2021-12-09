//
//  CoinListViewController.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import UIKit
import SnapKit

typealias CoinListDataSource =  UITableViewDiffableDataSource<Int, CoinListTVCViewModel>
typealias CoinListSnapshot =  NSDiffableDataSourceSnapshot<Int, CoinListTVCViewModel>

final class CoinListViewController: UIViewController {
    
    private lazy var dataSource: CoinListDataSource = {
        let source = CoinListDataSource(tableView: self.tableView) { tableView, indexPath, viewModel in
            let cell: CoinListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(viewModel)
            return cell
        }
        return source
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.register(cellType: CoinListTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.rowHeight = 90
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        return tableView
    }()
    
    private var didSetupConstraints = false
    
    // ViewModel
    var viewModel: CoinListViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        view.backgroundColor = UIColor.Theme.backgroundColor
        navigationItem.title = "Ranking List"
        setupTableView()
        setupSortingMenu()
        view.setNeedsUpdateConstraints()
        
        viewModel.viewDidLoad()
    }
    
    private func bindViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.applySnapshot(animatingDifferences: false)
            if let sortButton = self?.navigationItem.rightBarButtonItem?.customView as? UIButton {
                sortButton.setTitle(self?.viewModel.sortType.localizedTitle, for: .normal)
                sortButton.sizeToFit()
            }
        }
    }
    
    private func setupSortingMenu() {
        
        let sortButton = UIButton(configuration: .tinted())
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sortButton)
        sortButton.snp.makeConstraints { $0.height.equalTo(30) }
        
        let actionHandler: (UIAction)->Void = { [unowned self] action in
            
            guard let sortType = CoinSortType(rawValue: action.identifier.rawValue) else {
                return
            }
            
            self.viewModel.applySort(sortType)
        }
        
        let actions = CoinSortType.allCases.map { sortType in
            UIAction(title: sortType.localizedTitle, identifier: .init(rawValue: sortType.rawValue), handler: actionHandler)
        }
        
        let menu = UIMenu(children: actions)
        sortButton.showsMenuAsPrimaryAction = true
        sortButton.menu = menu
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = CoinListSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.coinViewModels)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            tableView.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
}

extension CoinListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailScene = SceneFactory.makeCoinDetailScene(CoinDetailViewModel(coin: viewModel.coin(at: indexPath)))
        navigationController?.pushViewController(detailScene, animated: true)
    }
}
