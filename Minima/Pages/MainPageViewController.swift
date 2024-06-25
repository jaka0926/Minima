//
//  MainPageViewController.swift
//  Minima
//
//  Created by Jaka on 2024-06-16.
//

import UIKit
import SnapKit

class MainPageViewController: UIViewController {

    let searchField = UISearchTextField()
    let bgImage = UIImageView()
    let bgText = UILabel()
    let border = UIView()
    let recentSearchLabel = UILabel()
    let deleteAllButton = UIButton()
    let tableView = UITableView()
    var list: Array = UserDefaults.standard.array(forKey: "recentSearchList") ?? []
    
    override func viewIsAppearing(_ animated: Bool) {
        print(#function)
        if list.isEmpty {
            tableView.isHidden = true
            recentSearchLabel.isHidden = true
            deleteAllButton.isHidden = true
            tableView.reloadData()
        }
        else {
            tableView.isHidden = false
            recentSearchLabel.isHidden = false
            deleteAllButton.isHidden = false
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let navTitle = "\(UserDefaults.standard.string(forKey: "userName")!)'s Minima"
        navigationItem.title = navTitle
        view.backgroundColor = .white
        
        view.addSubview(searchField)
        view.addSubview(bgImage)
        view.addSubview(bgText)
        view.addSubview(border)
        view.addSubview(tableView)
        view.addSubview(recentSearchLabel)
        view.addSubview(deleteAllButton)
        
        configureSnap()
        configureUI()
        
    }
    
    func configureSnap() {
        
        recentSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(border)
            make.horizontalEdges.equalTo(searchField)
            make.height.equalTo(45)
        }
        deleteAllButton.snp.makeConstraints { make in
            make.top.equalTo(border)
            make.right.equalTo(recentSearchLabel)
            make.height.equalTo(recentSearchLabel)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom)
            make.horizontalEdges.equalTo(recentSearchLabel)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-1)
        }
        searchField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        border.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(-20)
            make.right.equalToSuperview().offset(20)
        }
        bgImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        bgText.snp.makeConstraints { make in
            make.top.equalTo(bgImage.snp.bottom).offset(15)
            make.centerX.equalTo(bgImage)
        }
    }

    func configureUI() {
        
        border.layer.borderWidth = 1
        border.layer.borderColor = Color.lightGray.cgColor
        
        searchField.placeholder = "브랜드, 상품 등을 입혁하세요"
        searchField.enablesReturnKeyAutomatically = true
        searchField.returnKeyType = .search
        searchField.autocorrectionType = .no
        searchField.addTarget(self, action: #selector(SearchFieldReturnClicked), for: .editingDidEndOnExit)
        
        bgImage.image = UIImage(named: "empty")
        bgText.text = "최근 검색어가 없어요"
        bgText.font = Font.bold16
        
        recentSearchLabel.text = "최근 검색"
        recentSearchLabel.font = Font.bold16
        
        deleteAllButton.setTitle("전체 삭제", for: .normal)
        deleteAllButton.titleLabel?.font = Font.bold16
        deleteAllButton.setTitleColor(Color.orange, for: .normal)
        deleteAllButton.addTarget(self, action: #selector(deleteAll), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainPageTableViewCell.self, forCellReuseIdentifier: MainPageTableViewCell.id)
        tableView.rowHeight = 45
    }
    
    @objc func SearchFieldReturnClicked() {
        list.append(searchField.text!)
        UserDefaults.standard.set(list, forKey: "recentSearchList")
        let vc = SearchResultViewController()
        vc.navigationItem.title = searchField.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func deleteAll() {
        list.removeAll()
        tableView.isHidden = true
        recentSearchLabel.isHidden = true
        deleteAllButton.isHidden = true
        tableView.reloadData()
        UserDefaults.standard.set(list, forKey: "recentSearchList")
    }
    
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainPageTableViewCell.id, for: indexPath) as! MainPageTableViewCell
        let data = list[indexPath.row]
        cell.textContent.text = "\(data)"
        cell.xButton.tag = indexPath.row
        cell.xButton.addTarget(self, action: #selector(deleteRow), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SearchResultViewController()
        print(list[indexPath.row])
        vc.navigationItem.title = list[indexPath.row] as? String
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func deleteRow(_ sender: UIButton) {
    
        list.remove(at: sender.tag)
        if list.isEmpty {
            tableView.isHidden = true
            recentSearchLabel.isHidden = true
            deleteAllButton.isHidden = true
        }
        tableView.reloadData()
        UserDefaults.standard.set(list, forKey: "recentSearchList")
        print(list)
    }
}
