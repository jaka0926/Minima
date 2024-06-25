//
//  _SearchResultCollectionViewCell.swift
//  Minima
//
//  Created by Jaka on 2024-06-16.
//

import UIKit
import SnapKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    static let id = "SearchResultCollectionViewCell"
    let posterImage = UIImageView()
    let mallName = UILabel()
    let productName = UILabel()
    let productPrice = UILabel()
    let saveButton = UIButton()
    var saved: Bool = false {
            didSet {
                configureSaveButtonUI()
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.addSubview(posterImage)
        contentView.addSubview(mallName)
        contentView.addSubview(productName)
        contentView.addSubview(productPrice)
        contentView.addSubview(saveButton)
        
        posterImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
        mallName.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview()
        }
        productName.snp.makeConstraints { make in
            make.top.equalTo(mallName.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview()
        }
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview()
        }
        saveButton.snp.makeConstraints { make in
            make.bottom.right.equalTo(posterImage).offset(-15)
            make.size.equalTo(30)
        }
        
        posterImage.layer.cornerRadius = 10
        posterImage.clipsToBounds = true
        posterImage.contentMode = .scaleAspectFill

        mallName.textColor = Color.lightGray
        mallName.font = Font.system13

        productName.numberOfLines = 2
        productName.font = Font.bold14

        productPrice.font = Font.bold16
        
        configureSaveButtonUI()
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        
    }
    
    func configureSaveButtonUI() {
        saveButton.layer.cornerRadius = 5
        saveButton.setImage(UIImage(named: saved ? "like_selected" : "like_unselected"), for: .normal)
        saveButton.backgroundColor = saved ? .white : Color.gray.withAlphaComponent(0.5)
        
    }
    @objc func saveButtonClicked() {
        saved.toggle()
        configureSaveButtonUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
