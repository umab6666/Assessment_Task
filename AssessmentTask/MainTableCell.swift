//
//  MainTableCell.swift
//  AssessmentTask
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//

import UIKit
import SnapKit

class MainTableCell: UITableViewCell {

    var imgView = UIImageView()
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIElements(){
        self.selectionStyle = .none
        
        //Adding ImageView
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_leftMargin).offset(10)
            make.height.width.equalTo(60)
            make.top.equalTo(self.contentView.snp_topMargin).offset(20)
        }
        
        //Adding Title Label
        self.contentView.addSubview(titleLabel)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.contentMode = .center
        self.titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.imgView.snp_trailingMargin).offset(15)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(20)
            make.top.equalTo(self.imgView)
        }
        
        //Adding Description Label
        self.contentView.addSubview(descriptionLabel)
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textColor = .gray
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.titleLabel)
            make.height.greaterThanOrEqualTo(30)
            make.top.equalTo(self.titleLabel.snp_bottomMargin).offset(10)
            make.bottom.right.equalTo(self.contentView).offset(-10)
        }
    }
    
    func loadCategoryCell(detail:Category){
        self.titleLabel.text = detail.titleString
        self.descriptionLabel.text = detail.descriptionString
    }
}
