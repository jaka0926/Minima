//
//  ProductDetailViewController.swift
//  Minima
//
//  Created by Jaka on 2024-06-17.
//

import UIKit
import WebKit
import SnapKit

class ProductDetailViewController: UIViewController {

    let webView = WKWebView()
    var webUrl = ""
    //var saved = false
    var indexRow = 0
    var savedList: [Int: Bool] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()

        print(savedList)
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(navBackButtonClicked))
        backButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backButton
        configureRightBarButton()
        
        view.backgroundColor = .white
        
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let url = URL(string: webUrl)!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    func configureRightBarButton() {
        print(savedList[indexRow]!)
        let likeButton = UIBarButtonItem(image: UIImage(named: savedList[indexRow]! ? "like_selected" : "like_unselected"), style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = likeButton
    }
    
    @objc func navBackButtonClicked() {

        navigationController?.popViewController(animated: true)
    }
    @objc func saveButtonClicked() {
        savedList[indexRow]!.toggle()
        configureRightBarButton()
    }
}
