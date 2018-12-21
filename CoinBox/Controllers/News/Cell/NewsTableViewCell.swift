//
//  NewsTableViewCell.swift
//  CoinBox
//
//  Created by Pham Van Quan on 12/21/18.
//  Copyright © 2018 Pham Van Quan. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbNewsImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSourceName: UILabel!
    @IBOutlet weak var lblUpvote: UILabel!
    @IBOutlet weak var lblDownvote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func  setUpView(data: NewsResponse) {
        thumbNewsImage.layer.cornerRadius = 5
        thumbNewsImage.clipsToBounds = true
        thumbNewsImage.cacheImage(urlString: (data.sourceInfo?.img)!)
        lblTitle.text = data.title
        lblSourceName.text = data.sourceInfo?.name
        lblUpvote.text = data.upvotes
        lblDownvote.text = data.downvotes
    }
    
}
