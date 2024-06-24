//
//  ProfileNameViewController.swift
//  Minima
//
//  Created by Jaka on 2024-06-15.
//

import UIKit
import SnapKit

class ProfileNameViewController: UIViewController {

    let profileImage = UIButton()
    let cameraIcon = UIButton()
    let nicknameTextField = UITextField()
    let nicknameGuideline = UILabel()
    let completeButton = UIButton()
    let profileImageString = "profile_\(Int.random(in: 0...11))"
    lazy var currentProfileImage = UIImage(named: profileImageString)
    let blackList = ["@", "#", "$", "%"]
    let numbers = CharacterSet.decimalDigits
    
    override func viewIsAppearing(_ animated: Bool) {
        let savedProfileImage = UserDefaults.standard.string(forKey: "savedProfileImage")
        if (savedProfileImage != nil) {
            currentProfileImage = UIImage(named: savedProfileImage!)
        }
        else {
            currentProfileImage = UIImage(named: profileImageString)
            UserDefaults.standard.set(profileImageString, forKey: "savedProfileImage")
        }
        profileImage.setImage(currentProfileImage, for: .normal)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "PROFILE SETTING"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(navBackButtonClicked))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        
        view.backgroundColor = .white
        
        view.addSubview(profileImage)
        view.addSubview(cameraIcon)
        view.addSubview(nicknameTextField)
        view.addSubview(nicknameGuideline)
        view.addSubview(completeButton)
        
        configureSnap()
        configureUI()
        
    }
    @objc func navBackButtonClicked() {
        UserDefaults.standard.removeObject(forKey: "savedProfileImage")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func profileImageClicked() {
        let vc = ProfileImageViewController()
        vc.currentProfileImage = currentProfileImage!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func returnKeyClicked() {
        view.endEditing(true)
    }
    
    @objc func editingChange() {
        guard let text = nicknameTextField.text, !text.isEmpty else { return }

        if text.count < 2 || text.count > 10 {
            nicknameGuideline.text = "2글자 이상 10글자 미만으로 입력해주세요"
        }
        else if blackList.contains(where: text.contains) {
            nicknameGuideline.text = "닉네임에 @,#,$,% 는 포함할 수 없어요"
        }
        else if text.rangeOfCharacter(from: numbers) != nil {
            nicknameGuideline.text = "닉네임에 숫자는 포함할 수 없어요"
        }
        else if text.range(of: "\\s{2,}", options: .regularExpression) != nil {
            nicknameGuideline.text = "연속된 공백을 포함할 수 없어요"
        }
        else {
            nicknameGuideline.text = "사용할 수 있는 닉네임이에요"
            completeButton.isEnabled = true
            completeButton.backgroundColor = UIColor.orange
            return
        }
        completeButton.isEnabled = false
        completeButton.backgroundColor = UIColor.lightGray
    }
    
    @objc func completeButtonClicked() {
        
        UserDefaults.standard.set(nicknameTextField.text!, forKey: "userName")
        let vc = MainTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func configureSnap() {
        profileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(140)
        }
        cameraIcon.snp.makeConstraints { make in
            make.right.bottom.equalTo(profileImage)
            make.size.equalTo(40)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(30)
        }
        nicknameGuideline.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(30)
        }
        completeButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(nicknameGuideline.snp.bottom).offset(30)
            make.height.equalTo(40)
        }
    }
    func configureUI() {
        defaultProfileImage(profileImage, cameraIcon)
        profileImage.setImage(currentProfileImage, for: .normal)
        profileImage.addTarget(self, action: #selector(profileImageClicked), for: .touchUpInside)
        
        cameraIcon.addTarget(self, action: #selector(profileImageClicked), for: .touchUpInside)
        
        nicknameTextField.placeholder = "닉네임을 입혁해주세요 :)"
        nicknameTextField.font = Font.bold14
        nicknameTextField.returnKeyType = .done
        nicknameTextField.autocorrectionType = .no
        nicknameTextField.addTarget(self, action: #selector(editingChange), for: .editingChanged)
        nicknameTextField.addTarget(self, action: #selector(returnKeyClicked), for: .editingDidEndOnExit)
        
        nicknameGuideline.textColor = Color.orange
        nicknameGuideline.font = Font.bold14
        
        completeButton.isEnabled = false
        completeButton.backgroundColor = Color.lightGray
        completeButton.titleLabel?.font = Font.bold16
        completeButton.setTitle("완료", for: .normal)
        completeButton.layer.cornerRadius = 20
        completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
    }
    
}
