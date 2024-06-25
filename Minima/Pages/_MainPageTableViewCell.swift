//
//  _MainPageTableViewCell.swift
//  Minima
//
//  Created by Jaka on 2024-06-18.
//

import UIKit
import SnapKit

class MainPageTableViewCell: UITableViewCell {
    
    let clockIcon = UIImageView()
    var textContent = UILabel()
    let xButton = UIButton()
    
    static let id = "MainPageTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(clockIcon)
        contentView.addSubview(textContent)
        contentView.addSubview(xButton)
        
        clockIcon.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        textContent.snp.makeConstraints { make in
            make.left.equalTo(clockIcon.snp.right).offset(20)
            make.centerY.equalToSuperview()
        }
        xButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(xButton.snp.height)
        }
        
        clockIcon.image = UIImage(systemName: "clock")
        clockIcon.tintColor = .black
        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.tintColor = .black
        
        textContent.font = Font.bold14
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
