//
//  FactViewModel.swift
//  UITableViewNoStoryboard
//
//  Created by mac on 27/03/20.
//  Copyright © 2020 JournalDev.com. All rights reserved.
//
import Foundation
import Alamofire
/* Created protocal for update view  when data changes*/
protocol FactViewModelProtocol {
    func didUpdateList()
}

class FactViewModel: NSObject {
    var delegate: FactViewModelProtocol?
    
    fileprivate(set) var factData: [RowsData] = []
    fileprivate(set) var strTitle: String = ""
    private var apiService = ApiService()

    func updateFacts() {
        /* Calling api for fetch data */
          apiService.fetchFacts(with: "", completion: { (FactsResults, error) in
            if let error = error {
                print(error)
            } else {
                if let factsResults = FactsResults {
                    self.factData = factsResults.rows!
                   self.strTitle = FactsResults?.title ?? ""
                     self.delegate?.didUpdateList()
                }
            }
        })
    }
}

