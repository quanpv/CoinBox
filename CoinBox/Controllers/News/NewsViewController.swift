//
//  NewsViewController.swift
//  CoinBox
//
//  Created by Pham Van Quan on 12/21/18.
//  Copyright © 2018 Pham Van Quan. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
     var listData: [NewsResponse] = []
    override func viewDidLoad() {
        super.viewDidLoad()
          self.tableView.registerCellNib(NewsTableViewCell.self)
        getNews()
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func getNews() {
        MGConnection.requestArray(APIRouter.news, NewsResponse.self, completion: { (result, err) in
            guard err == nil else {
                print("False with code: \(err?.mErrorCode) and message: \(err?.mErrorMessage)")
                return
            }
            
            if let dataResponse = result {
                self.listData = dataResponse
                for data in dataResponse {
                    print(data.imageurl ?? "-")
                    print(data.title ?? "-")
                    print(data.sourceInfo?.img ?? "-")
                }
                self.tableView.reloadData()
            }
        })
    }
    
}

extension NewsViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (listData.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:NewsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.className, for: indexPath) as? NewsTableViewCell
        if (cell == nil) {
            //            cell = tableView.dequeueReusableCell(withIdentifier: AllCoinTableViewCell.className) as? AllCoinTableViewCell
            cell = NewsTableViewCell(style: .default, reuseIdentifier: NewsTableViewCell.className)
        }
        cell?.setUpView(data: listData[indexPath.row])
        //        cell?.lblNo.text = String(indexPath.row+1)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
