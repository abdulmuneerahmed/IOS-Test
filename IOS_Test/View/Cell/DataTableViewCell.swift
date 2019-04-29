//
//  DataTableViewCell.swift
//  IOS_Test
//
//  Created by admin on 29/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenirnext-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var timeLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenirnext-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func setup(){
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10)
            ])
       addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
            timeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
    }
    func updateCell(cellDetails:CellData){
        titleLabel.text = cellDetails.title
        //let delimiter = "T"
        //let date = cellDetails.date.components(separatedBy: delimiter)
        //timeLabel.text = date.first
        timeLabel.text = cellDetails.date
    }
}
