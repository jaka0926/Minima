//
//  _SettingTableViewCell.swift
//  Minima
//
//  Created by Jaka on 2024-06-24.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {

    static let id = "SettingTableViewCell"
    let textContent = UILabel()
    let savedItemLabel = UILabel()
    let savedItemIcon = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(textContent)
        contentView.addSubview(savedItemLabel)
        contentView.addSubview(savedItemIcon)
        
        textContent.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        savedItemIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(savedItemLabel.snp.left)
        }
        savedItemLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
        
        textContent.font = Font.bold14
        textContent.textColor = .black
        
        savedItemLabel.font = Font.bold14
        savedItemLabel.textColor = .black
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
