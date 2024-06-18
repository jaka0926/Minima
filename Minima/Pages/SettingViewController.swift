//
//  SettingViewController.swift
//  Minima
//
//  Created by Jaka on 2024-06-18.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {

    let profileView = UIButton()
    let profileImage = UIButton()
    let border = UIView()
    let menuStack = UIStackView()
    let savedListLabel = UIButton()
    let menu1 = UIButton()
    let menu2 = UIButton()
    let menu3 = UIButton()
    let menu4 = UIButton()
    let menu5 = UIButton()
    let menuTextContents = ["나의 장바구니 목록", "자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴"]
    lazy var menuList = [menu1, menu2, menu3, menu4, menu5]
    var userName = UserDefaults.standard.string(forKey: "userName")
    lazy var currentProfileImage = UIImage()
    
    override func viewIsAppearing(_ animated: Bool) {
        let savedProfileImage = UserDefaults.standard.string(forKey: "savedProfileImage")
        let savedUsername = UserDefaults.standard.string(forKey: "userName")
        currentProfileImage = UIImage(named: savedProfileImage!)!
        userName = savedUsername
        profileImage.setImage(currentProfileImage, for: .normal)
        profileView.configuration = .profileStyle(userName!)
        let savedItemsCount = UserDefaults.standard.integer(forKey: "savedItemsCount")
        savedListLabel.setTitle("\(savedItemsCount)개의 상품", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Setting"
        view.backgroundColor = .white
        
        view.addSubview(border)
        view.addSubview(profileView)
        view.addSubview(profileImage)
        view.addSubview(menuStack)
        for item in menuList {
            menuStack.addArrangedSubview(item)
        }
        view.addSubview(savedListLabel)
        
        profileView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(140)
        }
        profileImage.snp.makeConstraints { make in
            make.centerY.equalTo(profileView)
            make.left.equalTo(profileView).offset(20)
            make.size.equalTo(100)
        }
        menuStack.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(profileView.snp.bottom)
            make.height.equalTo(300)

        }
        border.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(-20)
            make.right.equalToSuperview().offset(20)
        }
        savedListLabel.snp.makeConstraints { make in
            make.centerY.equalTo(menu1)
            make.right.equalTo(menu1)
        }
        
        savedListLabel.titleLabel?.font = Font.bold14
        savedListLabel.setTitleColor(.black, for: .normal)
        savedListLabel.setImage(UIImage(named: "like_selected"), for: .normal)
        
        menuStack.axis = .vertical
        menuStack.distribution = .fillEqually
        menuStack.spacing = -1
        
        for (index, item) in menuTextContents.enumerated() {
            
            let filter = menuList[index]
            filter.contentHorizontalAlignment = .leading
            filter.setTitle(item, for: .normal)
            filter.setTitleColor(.black, for: .normal)
            filter.layer.borderWidth = 1
            filter.layer.borderColor = UIColor.black.cgColor
            filter.titleLabel?.font = Font.bold14
            filter.addTarget(self, action: #selector(menuItemClicked), for: .touchUpInside)
            filter.tag = index
        }
        
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = 50
        profileImage.layer.borderColor = Color.orange.cgColor
        profileImage.layer.borderWidth = 3
        profileImage.clipsToBounds = true
        
        border.layer.borderWidth = 1
        border.layer.borderColor = Color.lightGray.cgColor
        
        profileView.addTarget(self, action: #selector(profileButtonClicked), for: .touchUpInside)
    }
    @objc func profileButtonClicked() {
        print(#function)
        let vc = ProfileEditViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func menuItemClicked() {
        
    }
}
