//
//  WSManager2.swift
//  EvaluationApp
//
//  Created by mac on 20/07/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
struct ApiService {
  
// API Manager
  
  /* fetch data from server */
    func fetchFacts(with string: String, completion: @escaping (FactsResults?, Error?) -> ()) {
    
        AF.request(kAPI_SERVERBASEURL)
        .responseString { response in
       switch response.result {
       case .success:
        /* converted response string to json object and parse it with validating null value */
           let str = String(describing: response.value!)
                    do{
                        if let json = str.data(using: String.Encoding.utf8){
                            if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{

                                let title = jsonData["title"] as! String
                                 let rowsArr = jsonData["rows"] as! [[String:Any]]
                                  var arrRow = [RowsData]()
                                for item in rowsArr{
                                 var  r = RowsData ()
                                     var strTitle = ""
                                     var strDesc = ""
                                     var strImageUrl = ""
                               
                                  if   ((item as Dictionary)[kTitle]!) is NSNull {
                                        } else {
                                   strTitle  = (item as Dictionary)[kTitle]! as! String
                                    }

                                  if ((item as Dictionary)[kImageHref]!) is NSNull {
                                       } else {

                                     strImageUrl  = (item as Dictionary)[kImageHref]! as! String
                                    }

                                   if ((item as Dictionary)[kDescription]!) is NSNull {

                                           } else {

                                     strDesc  = (item as Dictionary)[kDescription]! as! String
                                    }
                                r.title = strTitle
                                r.description = strDesc
                                r.image = strImageUrl
                                    arrRow.append(r)
                                }
                                 let fdata = FactsResults.init(title: title, rows:arrRow )
                                completion(fdata,nil)
                             }
                        }
                    }catch {
                        print(error.localizedDescription)
                        completion(nil,error)
                    }
                
        break
         case .failure(let error):
           print(error)
         completion(nil,error)
       }
         
            
            
        }
      
         
        
    }

}
