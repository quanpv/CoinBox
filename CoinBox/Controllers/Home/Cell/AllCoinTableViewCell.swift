//
//  AllCoinTableViewCell.swift
//  CoinBox
//
//  Created by Pham Van Quan on 11/20/18.
//  Copyright © 2018 Pham Van Quan. All rights reserved.
//

import UIKit

class AllCoinTableViewCell: UITableViewCell {
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var imageThumb: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPercentChange: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpView(data: CoinResponse) {
        lblNo.text = data.rank
        lblName.text = data.name
        lblPercentChange.text = data.percent_change_24h! + "%"
        lblPrice.text = String(format: "$%@", data.price_usd!)
        imageThumb.cacheImage(urlString: String(format: Production.IMAGE_URL_FORMAT, data.idThumb!))
    }
}
