//
//  CoinDetailViewController.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import Foundation
import UIKit
import SnapKit
import DSFSparkline

typealias CoinDetailDataSource =  UITableViewDiffableDataSource<Int, CoinDetailTVCViewModel>
typealias CoinDetailSnapshot =  NSDiffableDataSourceSnapshot<Int, CoinDetailTVCViewModel>

final class CoinDetailViewController: UIViewController {
    
    private lazy var dataSource: CoinDetailDataSource = {
        let source = CoinDetailDataSource(tableView: self.tableView) { tableView, indexPath, viewModel in
            let cell: CoinDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(viewModel)
            return cell
        }
        return source
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.register(cellType: CoinDetailTableViewCell.self)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var didSetupConstraints = false
    
    // ViewModel
    var viewModel: CoinDetailViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        view.backgroundColor = UIColor.Theme.backgroundColor
        navigationItem.title = "\(viewModel.name) - \(viewModel.symbol)"
        
        setupTableView()
        view.setNeedsUpdateConstraints()
        
        viewModel.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupSparkLineView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.Theme.darkTextColor.withAlphaComponent(0.1)
        headerView.frame = CGRect(x: 0, y: 0, width: 0, height: 100)
        tableView.tableHeaderView = headerView
    }
    
    private var sparkLineDataSource: DSFSparkline.DataSource!
    private func setupSparkLineView() {
        
        let footerView = DSFSparklineLineGraphView()
        footerView.frame = CGRect(x: 0, y: 0, width: 0, height: 100)
        footerView.shadowed = false
        footerView.lineWidth = 1
        footerView.graphColor = UIColor.Theme.darkTextColor
        footerView.interpolated = true
                
        let values = viewModel.sparkLines.map { CGFloat($0) }
        let range: ClosedRange<CGFloat> = (values.min() ?? 0) ... (values.max() ?? 0)
        
        sparkLineDataSource = DSFSparkline.DataSource(values: values, range: range)
        footerView.dataSource = sparkLineDataSource
        tableView.tableHeaderView = footerView
    }
    
    private func bindViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.applySnapshot(animatingDifferences: false)
        }
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = CoinDetailSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.cellViewModels)
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
