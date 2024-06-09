//
//  MainModel.swift
//  FaUpIn07UsedGoodsUpload
//
//  Created by joe on 6/10/24.
//

import Foundation

struct MainModel {
    func setAlert(errorMessage: [String]) -> Alert {
        let title = errorMessage.isEmpty ? "Successful" : "Unsuccessful"
        let message = errorMessage.isEmpty ? nil : errorMessage.joined(separator: "\n")
        return (title: title, message: message)
    }
}
