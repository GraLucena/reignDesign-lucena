//
//  HitsViewController.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit
import RxSwift
import CellRegistrable
import SVProgressHUD

class HitsViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Properties
    fileprivate let disposeBag = DisposeBag()
    fileprivate var hits = [Hit]()
    var viewModel: HitsViewModel
    private let refreshControl = UIRefreshControl()

    // MARK: - Init
    init(viewModel: HitsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: HitsViewController.self), bundle: nil)
        viewModel.viewDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hits"
        SVProgressHUD.show()
        configureTable()
        setupRefreshController()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - UI
    private func configureTable() {
        tableView.registerCell(HitsTableViewCell.self)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        viewModel.getHits()
    }
    
    private func setupRefreshController() {
        refreshControl.tintColor = UIColor(red:0.17, green:0.69, blue:0.62, alpha:1.0)
        refreshControl.addTarget(self, action: #selector(refreshHits), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.alwaysBounceVertical = true
    }
    
    func refreshHits() {
        viewModel.getHits()
        self.refreshControl.endRefreshing()
    }
}

// MARK: - HitsViewModelViewDelegate
extension HitsViewController: HitsViewModelViewDelegate{
    func hitsDidChange(viewModel: HitsViewModel) {
        tableView.reloadData()
        SVProgressHUD.dismiss()
    }
    
    func showAlertError(viewModel: HitsViewModel, error: ApiError) {
        SVProgressHUD.dismiss()
        let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: LocalizableString.ok.localizedString, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDelegate
extension HitsViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectHitAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            viewModel.hits?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//MARK: - UITableViewDataSource
extension HitsViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfHits()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HitsTableViewCell.reuseIdentifier, for: indexPath as IndexPath)
        
        if let hitCell = cell as? HitsTableViewCell{
            let hit = viewModel.hitAt(indexPath.row)
            
            if hit.title != nil {
                hitCell.title.text = title
            }else{
                hitCell.title.text = hit.storyTitle
            }

            let date : String = viewModel.getDaysFrom(hit: hit)
            hitCell.hitInfo.text = hit.author + " - " + date
        }
        return cell
    }
}

