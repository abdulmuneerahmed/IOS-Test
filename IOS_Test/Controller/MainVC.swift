//
//  ViewController.swift
//  IOS_Test
//
//  Created by admin on 29/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController {

    fileprivate let reuseCell = "CellId"
    fileprivate let dataService = CellDataService.service
    
    fileprivate var pageNumber = 1
    
    override func loadView() {
        super.loadView()
        setup()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        tableViewSetup()
        spinner.startAnimating()
        loadData()
    }

    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.separatorInset.left = 0
        tableView.separatorInset.right = 0
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    fileprivate lazy var spinner:UIActivityIndicatorView = {
        let spinner  = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.style = .whiteLarge
        spinner.color = .orange
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    fileprivate func setup(){
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont(name: "Avenirnext-Heavy", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.orange]
        
        view.addSubview(tableView)
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 40),
            spinner.widthAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func tableViewSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DataTableViewCell.self, forCellReuseIdentifier: reuseCell)
    }
    
    private func loadData(){
        retrieveData(url: getApi()) {[weak self] finish in
            guard let self = self else{return}
            if finish{
                self.spinner.stopAnimating()
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.navigationItem.title = "\(self.dataService.getCellItems().count)"
            }
        }
    }
}

extension MainVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.getCellItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? DataTableViewCell else{return UITableViewCell()}
        cell.updateCell(cellDetails: dataService.getCellItems()[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        loadMore(indexPath: indexPath)
    }
    
    
    func loadMore(indexPath:IndexPath){
        if dataService.getCellItems().count - 1 == indexPath.row{
            if pageNumber < dataService.getCellItems()[indexPath.row].numberofPages{
                pageNumber += 1
                retrieveData(url: getApi(pageNumber: pageNumber)) {[weak self] finish in
                     guard let self = self else{return}
                    if finish{
                        self.tableView.reloadData()
                        self.navigationItem.title = "\(self.dataService.getCellItems().count)"
                    }
                }
            }
        }
    }
}

extension MainVC{
    func retrieveData(url:String,completion: @escaping (_ status:Bool)->()){
        Alamofire.request(url).responseJSON { (response) in
            //print(response)
            guard let json = response.result.value as? Dictionary<String,AnyObject> else{return}
            
            let hits = json["hits"] as! [Dictionary<String,AnyObject>]
            let pages = json["nbPages"] as! Int
            for hit in hits{
                let title = hit["title"] as! String
                let date = hit["created_at"] as! String
                self.dataService.cellData.append(CellData(title: title, date: date, numberofPages: pages))
            }
            
            completion(true)
        }
    }
}
