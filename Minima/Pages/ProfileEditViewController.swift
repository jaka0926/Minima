//
//  ProfileEditViewController.swift
//  Minima
//
//  Created by Jaka on 2024-06-18.
//

import UIKit

class ProfileEditViewController: UIViewController {

    let nicknameTextField = UITextField()
    let nicknameGuideline = UILabel()
    let profileImage = UIButton()
    let cameraIcon = UIButton()
    let blackList = ["@", "#", "$", "%"]
    let numbers = CharacterSet.decimalDigits
    var saveButton = UIBarButtonItem()
    lazy var currentProfileImage = UIImage()
    
    override func viewIsAppearing(_ animated: Bool) {
        let savedProfileImage = UserDefaults.standard.string(forKey: "savedProfileImage")
        
        currentProfileImage = UIImage(named: savedProfileImage!)!
        profileImage.setImage(currentProfileImage, for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "EDIT PROFILE"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(navBackButtonClicked))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
        saveButton.tintColor = .lightGray
        
        view.backgroundColor = .white
        view.addSubview(profileImage)
        view.addSubview(cameraIcon)
        view.addSubview(nicknameTextField)
        view.addSubview(nicknameGuideline)
        
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
        
        defaultProfileImage(profileImage, cameraIcon)
        
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
    }
    @objc func navBackButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func profileImageClicked() {
        let vc = ProfileImageEditViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func returnKeyClicked() {
        view.endEditing(true)
    }
    
    @objc func editingChange() {
        guard nicknameTextField.text != "" else {return}
        
        if nicknameTextField.text!.count < 2 || nicknameTextField.text!.count > 10 {
            nicknameGuideline.text = "2글자 이상 10글자 미만으로 입력해주세요"
            
        }
        else if blackList.contains(where: nicknameTextField.text!.contains) {
            nicknameGuideline.text = "닉네임에 @,#,$,% 는 포함할 수 없어요"
        }
        else if nicknameTextField.text!.rangeOfCharacter(from: numbers) != nil {
            nicknameGuideline.text = "닉네임에 숫자는 포함할 수 없어요"
        }
        else {
            nicknameGuideline.text = "사용할 수 있는 닉네임이에요"
            saveButton.isEnabled = true
            saveButton.tintColor = .black
            return
        }
        saveButton.isEnabled = false
        saveButton.tintColor = .lightGray
    }
    @objc func saveButtonClicked() {
        
        UserDefaults.standard.set(nicknameTextField.text!, forKey: "userName")
        navigationController?.popViewController(animated: true)
    }
}
