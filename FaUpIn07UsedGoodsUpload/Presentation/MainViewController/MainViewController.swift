//
//  MainViewController.swift
//  FaUpIn07UsedGoodsUpload
//
//  Created by joe on 6/4/24.
//

import RxSwift
import RxCocoa
import SnapKit

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    let submitButton = UIBarButtonItem()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MainViewModel) {}
    
    private func attribute() {
        title = "Used Goods Posting"
        view.backgroundColor = .white
        
        submitButton.title = "Submit"
        submitButton.style = .done
        
        navigationItem.setRightBarButton(submitButton, animated: true)
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: "TitleTextFieldCell") // index row 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategorySelectCell") // index row 1
        tableView.register(PriceTextFieldCell.self, forCellReuseIdentifier: "PriceTextFieldCell") // index row 2
        tableView.register(DetailWriteFormCell.self, forCellReuseIdentifier: "DetailWriteFormCell") // index row 3
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

typealias Alert = (title: String, message: String?)
extension Reactive where Base: MainViewController {
    var setAlert: Binder<Alert> {
        return Binder(base) { base, data in
            let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(action)
            base.present(alertController, animated: true)
        }
    }
}
