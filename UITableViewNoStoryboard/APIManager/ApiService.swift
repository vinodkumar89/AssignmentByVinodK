import Foundation

import SwiftyJSON
struct ApiService {
  

    /* fetch data from server */
       func fetchFacts(with string: String, completion: @escaping (FactsResults?, Error?) -> ()) {
 
      let url = URL(string: kAPI_SERVERBASEURL)!

       let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
           guard let data = data else { return }
                  do{
                     let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
                    if let jsonData = try JSONSerialization.jsonObject(with: utf8Data!, options: .allowFragments) as? [String:AnyObject] {

                                 let title = jsonData["title"] as! String
                                  let rowsArr = jsonData["rows"] as! [[String:Any]]
                                   var arrRow = [RowsData]()
                                 for item in rowsArr {
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
                        // }
                     }catch {
                         print(error.localizedDescription)
                         completion(nil,error)
                     }
       }

       task.resume()
    }
}

