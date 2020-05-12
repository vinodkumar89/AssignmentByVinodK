//
//  Facts.swift
//  UITableViewNoStoryboard
//
//  Created by mac on 27/03/20.
//  Copyright © 2020 JournalDev.com. All rights reserved.
//

import Foundation
import Alamofire


/* data model */
struct FactsResults : Codable{
    var title:String?
    var rows:[RowsData]?
    enum  CodingKeys:String,CodingKey {
          case title = "title"
          case rows = "rows"
           }
}


struct RowsData : Codable{
    var title:String?
    var description:String?
    var image:String?

    enum  CodingKeys:String,CodingKey {
          case title = "title"
          case description = "description"
          case image = "imageHref"
         }

}
