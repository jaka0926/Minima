//
//  ViewController.swift
//  Minima
//
//  Created by Jaka on 2024-06-15.
//

import UIKit
import SnapKit

class OnBoardingViewController: UIViewController {

    let appTitle = UILabel()
    let mainPoster = UIImageView()
    let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.backButtonTitle = ""
        
        view.addSubview(appTitle)
        view.addSubview(mainPoster)
        view.addSubview(startButton)
        
        appTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(55)
            make.centerX.equalToSuperview()
        }
        mainPoster.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        view.backgroundColor = .white
        appTitle.text = "Minima"
        appTitle.font = UIFont(name: "Optima-ExtraBlack", size: 40)
        appTitle.textColor = Color.orange
        mainPoster.image = UIImage(named: "launch")
        
        startButton.backgroundColor = Color.orange
        startButton.setTitle("시작하기", for: .normal)
        startButton.titleLabel?.font = Font.bold16
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 20
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        let vc = ProfileNameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
