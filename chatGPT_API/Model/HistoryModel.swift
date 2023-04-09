//
//  HistoryModel.swift
//  chatGPT_API
//
//  Created by Ai Hawok on 27/03/2023.
//
// HistoryModel > Shared class consist of user's choices and context

import Foundation

class HistoryModel{
    struct History{
        let title: String
        let option: String
    }
    static let shared = HistoryModel()
    
    
    
    var data: [History] = []
    private init(){}
    
    
    func addData(title: String, option: String){
        data.append(History(title: title, option: option))
    }
    
    func getData() -> [History]{
        return data
    }
    
}
