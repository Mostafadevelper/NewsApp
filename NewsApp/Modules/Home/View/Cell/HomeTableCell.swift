//
//  HomeTableCell.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//

import UIKit

class HomeTableCell: UITableViewCell {

    //MARK:- Layout:-
    @IBOutlet weak var newTitleLB: UILabel!
    @IBOutlet weak var newIMG: UIImageView!
    
    //MARK:- variable:=
    var listCellViewModel: HomeCellViewModel? {
        didSet {
            self.newIMG.loadImage(urlName: listCellViewModel?.image)
            self.newTitleLB.text = listCellViewModel?.title
        }
    }
    
    
}
