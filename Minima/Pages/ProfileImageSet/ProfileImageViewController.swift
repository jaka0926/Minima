//
//  ProfileImageViewController.swift
//  Minima
//
//  Created by Jaka on 2024-06-15.
//

import UIKit
import SnapKit

class ProfileImageViewController: UIViewController {
    
    var imageList: [String] = []
    
    let profileImage = UIButton()
    let cameraIcon = UIButton()
    var currentProfileImage = UIImage()
    lazy var profileCollection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    var selectedIndexPath: IndexPath?
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 50
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        return layout
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
        view.addSubview(profileCollection)
        
        profileCollection.delegate = self
        profileCollection.dataSource = self
        profileCollection.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
        for num in 0...11 {
            imageList.append("profile_\(num)")
        }
        
        profileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(140)
        }
        cameraIcon.snp.makeConstraints { make in
            make.right.bottom.equalTo(profileImage)
            make.size.equalTo(40)
        }
        profileCollection.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(40)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        defaultProfileImage(profileImage, cameraIcon)
        profileImage.setImage(currentProfileImage, for: .normal)
    }
    
    @objc func navBackButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}

extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = profileCollection.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as! ProfileImageCollectionViewCell
        
        cell.profileImage.image = UIImage(named: imageList[indexPath.row])
        
        // Set the alpha based on selection
        if indexPath == selectedIndexPath {
            cell.contentView.alpha = 1
            cell.contentView.layer.borderColor = Color.orange.cgColor
            cell.contentView.layer.borderWidth = 3
        } else {
            cell.contentView.alpha = 0.5
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        selectedIndexPath = indexPath
        currentProfileImage = UIImage(named: "profile_\(indexPath.row)")!
        UserDefaults.standard.set("profile_\(indexPath.row)", forKey: "savedProfileImage")
        profileImage.setImage(currentProfileImage, for: .normal)
        collectionView.reloadData()
    }
}
