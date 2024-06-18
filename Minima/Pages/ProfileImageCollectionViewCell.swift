//
//  ProfileImageCollectionViewCell.swift
//  Minima
//
//  Created by Jaka on 2024-06-15.
//

import UIKit
import SnapKit

class ProfileImageCollectionViewCell: UICollectionViewCell {

    static let id = "ProfileImageCollectionViewCell"
    let profileImage = UIImageView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(profileImage)
        
        profileImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImage.contentMode = .scaleAspectFill
        contentView.layer.cornerRadius = 85.75/2
        contentView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
