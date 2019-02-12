//
//  MainViewController.swift
//  AssessmentTask
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController{

    lazy var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    let mainViewModel: MainViewModalProtocol = MainViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupTableView()
    }
    func getCategorys(){
        self.mainViewModel.getImageDataFromServer { (success, errMsg) in
            if success{
                self.tableView.reloadData()
            }else{
                
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
        return cell
    }
}

extension MainViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
