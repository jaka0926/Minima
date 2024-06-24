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
    let menuTable = UITableView()
    let menuTextContents = ["나의 장바구니 목록", "자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    var userName = UserDefaults.standard.string(forKey: "userName")
    var savedItemsCount = 0
    lazy var currentProfileImage = UIImage()
    
    override func viewIsAppearing(_ animated: Bool) {
        let savedProfileImage = UserDefaults.standard.string(forKey: "savedProfileImage")
        let savedUsername = UserDefaults.standard.string(forKey: "userName")
        currentProfileImage = UIImage(named: savedProfileImage!)!
        userName = savedUsername
        profileImage.setImage(currentProfileImage, for: .normal)
        profileView.configuration = .profileStyle(userName!)
        savedItemsCount = UserDefaults.standard.integer(forKey: "savedItemsCount")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Setting"
        view.backgroundColor = .white
        
        view.addSubview(border)
        view.addSubview(profileView)
        view.addSubview(profileImage)
        view.addSubview(menuTable)
        
        menuTable.dataSource = self
        menuTable.delegate = self
        menuTable.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
        
        profileView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(140)
        }
        profileImage.snp.makeConstraints { make in
            make.centerY.equalTo(profileView)
            make.left.equalTo(profileView).offset(20)
            make.size.equalTo(100)
        }
        menuTable.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-1)
            make.top.equalTo(profileView.snp.bottom)
        }
        border.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(-20)
            make.right.equalToSuperview().offset(20)
        }
        
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = 50
        profileImage.layer.borderColor = Color.orange.cgColor
        profileImage.layer.borderWidth = 3
        profileImage.clipsToBounds = true
        
        border.layer.borderWidth = 1
        border.layer.borderColor = Color.lightGray.cgColor
        
        profileView.addTarget(self, action: #selector(profileButtonClicked), for: .touchUpInside)
        
        menuTable.isScrollEnabled = false
        menuTable.rowHeight = 50
        
    }
    @objc func profileButtonClicked() {
        print(#function)
        let vc = ProfileEditViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func menuItemClicked() {
        
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTextContents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as! SettingTableViewCell
        
        cell.textContent.text = menuTextContents[indexPath.row]
        print(menuTextContents[indexPath.row])
        
        if indexPath.row == 0 {
            cell.savedItemLabel.text = "\(savedItemsCount)개의 상품"
            cell.savedItemIcon.image = UIImage(named: "like_selected")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?") {
                
                UserDefaults.standard.removeObject(forKey: "savedProfileImage")
                
                let vc = ViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                
                self.present(nav, animated: true)
            }
        }
    }
}
