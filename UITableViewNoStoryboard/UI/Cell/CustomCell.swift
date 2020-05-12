//
//  CustomCell.swift
//  UITableViewNoStoryboard
//
//  Created by mac on 27/03/20.
//  Copyright © 2020 JournalDev.com. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
 //  custom  tableview cell
        let minValue = 0
        
        var rData : RowsData? {
            didSet {
              /* setting value to imageview, title and description */
                imgView.setImages(url:rData?.image ?? "")
                  lblName.text = rData?.title
                lblDescription.text = rData?.description
            }
        }
        
        /* Setup label for title */
        private let lblName : UILabel = {
            let lbl = UILabel()
            lbl.textColor = .black
            lbl.font = UIFont.boldSystemFont(ofSize: 16)
            lbl.textAlignment = .left
            return lbl
        }()
     
         /* Setup label for description */
        private let lblDescription : UILabel = {
            let lbl = UILabel()
            lbl.textColor = .black
            lbl.font = UIFont.systemFont(ofSize: 16)
            lbl.textAlignment = .left
            lbl.numberOfLines = 0
            return lbl
        }()
        
  /* Setup imageview for picture */
        private let imgView : UIImageView = {
            let imgV = UIImageView(image: #imageLiteral(resourceName: "default"))
            imgV.contentMode = .scaleAspectFit
            imgV.clipsToBounds = true
            return imgV
        }()
       
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
          /* Added imageview , tile and description  label to view*/
            addSubview(imgView)
            addSubview(lblName)
            addSubview(lblDescription)
            /* Added constaints to imageView,lblName,lblDescription for managing cell ui. */
           imgView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 5, paddingBottom: 2, paddingRight: 0, width: 90, height: 65, enableInsets: true)
            lblName.anchor(top: topAnchor, left: imgView.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: frame.size.width - 100 , height: 0, enableInsets: true)
            lblDescription.anchor(top: lblName.bottomAnchor, left: imgView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 20, paddingRight: 5, width: frame.size.width - 100, height: 0, enableInsets: true)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }

  
