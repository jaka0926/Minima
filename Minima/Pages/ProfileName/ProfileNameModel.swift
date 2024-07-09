//
//  ProfileNameModel.swift
//  Minima
//
//  Created by Jaka on 2024-07-09.
//

import Foundation

class ProfileNameModel {
    let blackList = ["@", "#", "$", "%"]
    let numbers = CharacterSet.decimalDigits
    let completeButtonEnabled = false
    
    var inputValue = "" {
        didSet {
            print("Value did Change", inputValue)
            validation(inputValue)
            print(outputValue, outputValid)
        }
    }
    var outputValue = ""
    var outputValid = false
    
    private func validation( _ inputValue: String?) {
        guard let text = inputValue, !text.isEmpty else {
            outputValue = "2글자 이상 10글자 미만으로 입력해주세요"
            outputValid = false
            return
        }
        if text.count < 2 || text.count > 10 {
            outputValue =  "2글자 이상 10글자 미만으로 입력해주세요"
            outputValid = false
        }
        else if blackList.contains(where: text.contains) {
            outputValue = "닉네임에 @,#,$,% 는 포함할 수 없어요"
            outputValid = false
        }
        else if text.rangeOfCharacter(from: numbers) != nil {
            outputValue =  "닉네임에 숫자는 포함할 수 없어요"
            outputValid = false
        }
        else if text.range(of: "\\s{2,}", options: .regularExpression) != nil {
            outputValue = "연속된 공백을 포함할 수 없어요"
            outputValid = false
        }
        else {
            outputValue = "사용할 수 있는 닉네임이에요"
            outputValid = true
        }
    }
}
