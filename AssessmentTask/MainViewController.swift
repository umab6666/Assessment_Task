//
//  MainViewController.swift
//  AssessmentTask
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class MainViewController: UIViewController{

    lazy var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    let mainViewModel: MainViewModalProtocol = MainViewModal()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupTableView()
        self.getCategorys()
    }
    func getCategorys(){
        
        self.mainViewModel.getImageDataFromServer { (success, errMsg) in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                if success{
                        self.title = self.mainViewModel.title
                        self.tableView.reloadData()
                }else{
                    Alert.showApiErrorAlert(message: errMsg ?? "error")
                }
            }
        }
    }
    func setupTableView(){
        self.view.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(MainTableCell.self, forCellReuseIdentifier: "MainTableCell")
        self.tableView.estimatedRowHeight = 100
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        //Adding Pull To Refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        self.getCategorys()
    }
}
extension MainViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.contentArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableCell") as! MainTableCell
        cell.loadCategoryCell(detail:mainViewModel.contentArray![indexPath.row])
        cell.imgView.kf.indicatorType = .activity
        return cell
    }
}
extension MainViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let imgcell = cell as? MainTableCell{
            let url = mainViewModel.contentArray![indexPath.row].imageurl
            
            imgcell.imgView.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"),options: [.transition(.fade(1))],
                                        progressBlock: { receivedSize, totalSize in
            }, completionHandler: { result in
                
            }
            )
        }
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let imgcell = cell as? MainTableCell{
            imgcell.imgView.kf.cancelDownloadTask()
        }
    }
}



