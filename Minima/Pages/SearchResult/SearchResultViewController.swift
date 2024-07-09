//
//  SearchResultViewController.swift
//  Minima
//
//  Created by Jaka on 2024-06-16.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class SearchResultViewController: UIViewController {

    let border = UIView()
    let totalResult = UILabel()
    let filterStack = UIStackView()
    lazy var gridView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    let filter1 = UIButton()
    let filter2 = UIButton()
    let filter3 = UIButton()
    let filter4 = UIButton()
    lazy var filterItems = [filter1, filter2, filter3, filter4]
    var filterText = ["정확도", "날짜순", "가격높은순", "가격낮은순"]
    var list = Shopping(total: 0, items: [])
    var start = 1
    var sort = "sim"
    // Track saved state of items
    var savedItems: [Int: Bool] = [:]
    
    func collectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 30
        layout.itemSize = CGSize(width: width/2, height: width/2*1.7)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let plistSavedList = UserDefaults.standard.dictionary(forKey: "savedList") {
            // Convert plistSavedList back to [Int: Bool]
            savedItems = plistSavedList as! [Int: Bool]
        }
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(navBackButtonClicked))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        
        view.backgroundColor = .white
        
        view.addSubview(border)
        border.addSubview(totalResult)
        border.addSubview(filterStack)
        for item in filterItems {
            filterStack.addArrangedSubview(item)
        }
        border.addSubview(gridView)
        
        gridView.dataSource = self
        gridView.delegate = self
        gridView.prefetchDataSource = self
        gridView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
        gridView.isPagingEnabled = true
        
        
        configureSnap()
        configureUI()
        filterClicked(filter1)
        callRequest(sort, 1)
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("View Will Disappear!!!!", #function)
        UserDefaults.standard.set(savedItems.count, forKey: "savedItemsCount")
    }
    
    func callRequest(_ sort: String, _ start: Int) {
        
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(navigationItem.title!)&display=30&start=\(start)&sort=\(sort)"
        let header: HTTPHeaders = ["X-Naver-Client-Secret": APIKey.naverShoppingSecret, "X-Naver-Client-Id": APIKey.naverShoppingID]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Shopping.self) { response in
            
            switch response.result {
            case .success(let value):
                if value.total == 0 { return }
                
                else if self.start == 1 {
                    self.list = value
                }
                else {
                    //self.list.total = value.total
                    self.list.items.append(contentsOf: value.items)
                }
                self.updateTotalResult()
                self.gridView.reloadData()
                
                if self.start == 1 {
                    self.gridView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
                
            case .failure(let error):
                print("FAILURE", error)
            }
        }
    }
    
    func configureSnap() {
        border.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(-20)
            make.right.equalToSuperview().offset(20)
        }
        totalResult.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        filterStack.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(totalResult)
            make.top.equalTo(totalResult.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        gridView.snp.makeConstraints { make in
            make.top.equalTo(filterStack.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureUI() {
        border.layer.borderWidth = 1
        border.layer.borderColor = Color.lightGray.cgColor
        
        updateTotalResult()
        totalResult.textColor = Color.orange
        totalResult.font = Font.bold14
        
        filterStack.axis = .horizontal
        filterStack.distribution = .fillEqually
        filterStack.spacing = 10
        
        for (index, item) in filterText.enumerated() {
            
            let filter = filterItems[index]
            filter.setTitle(item, for: .normal)
            filter.setTitleColor(.black, for: .normal)
            filter.layer.borderWidth = 1
            filter.layer.borderColor = Color.lightGray.cgColor
            filter.layer.cornerRadius = 15
            filter.titleLabel?.font = Font.bold14
            filter.addTarget(self, action: #selector(filterClicked), for: .touchUpInside)
            filter.tag = index
        }
        
    }
    func updateTotalResult() {
        totalResult.text = "\(list.total.formatted())개의 검색 결과"
    }
    
    @objc func navBackButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    @objc func filterClicked(_ sender: UIButton) {
        
        for num in 0...3 {
            if num == sender.tag {
                sender.setTitleColor(.white, for: .normal)
                sender.backgroundColor = Color.darkGray
            }
            else {
                let otherFilter = filterStack.arrangedSubviews[num] as! UIButton
                otherFilter.setTitleColor(.black, for: .normal)
                otherFilter.backgroundColor = .none
            }
        }
        
        print(sender.tag)
        switch sender.tag {
        case 0: sort = "sim";
        case 1: sort = "date";
        case 2: sort = "dsc";
        case 3: sort = "asc";
        default: print("Error")
        }
        start = 1
        callRequest(sort, start)
        
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gridView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as! SearchResultCollectionViewCell
        
        let data = list.items[indexPath.row]
        let productName = data.title
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
        
        let url = URL(string: data.image)
        cell.posterImage.kf.setImage(with: url)
        cell.mallName.text = data.mallName
        cell.productName.text = productName
        cell.productPrice.text = Double(data.lprice)!.formatted() + "원"
        
//        cell.saveButton.tag = indexPath.row
//        cell.saveButton.addTarget(self, action: #selector(saveButtonClicked(_:)), for: .touchUpInside)
        
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(indexPath.row)
        
        let data = list.items[indexPath.row]
        let productName = data.title
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
        let vc = ProductDetailViewController()
        
        if savedItems[indexPath.row] == nil {
            savedItems[indexPath.row] = false
        }
        //vc.saved = savedItems[indexPath.row]!
        print("Before sending: ", savedItems)
        print("Before sending: ", indexPath.row)
        vc.indexRow = indexPath.row
        vc.savedList = savedItems
        
        vc.webUrl = data.link
        vc.navigationItem.title = productName
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func saveButtonClicked(_ sender: UIButton) {
            let index = sender.tag
        if savedItems[index] == nil {
            savedItems[index] = true
        }
        else {
            savedItems[index]!.toggle()
        }
            print(savedItems)
        }
}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if list.items.count - 4 == item.row {
                start += 30
                callRequest(sort, start)
                print("start: ", start)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("-------Cancel Prefetch \(indexPaths)")
    }
}
