//
//  HomeViewController.swift
//  CoinBox
//
//  Created by Pham Van Quan on 11/19/18.
//  Copyright © 2018 Pham Van Quan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var count: Int?
    var listData: [CoinResponse] = []
    var slugToIDMap = [String : Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 10
        self.tableView.registerCellNib(AllCoinTableViewCell.self)
//        tableView.delegate = self
//        tableView.delegate = self
        // Do any additional setup after loading the view.
        
        MGConnection.requestArray(APIRouter.coinInfo(limit: 200), CoinResponse.self, completion: { (result, err) in
            guard err == nil else {
                print("False with code: \(err?.mErrorCode) and message: \(err?.mErrorMessage)")
                return
            }
            print("Count:\(String(describing: result?.count))")
            if let result = result {
                   self.listData = result
                self.getCMCQuickSearch()
                for data in result {
//                    self.listData.append(data)
                    print("name: "+data.name!)
                    print(data.percent_change_24h ?? "-")
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
   private func getCMCQuickSearch() {
    MGConnection.requestArray(APIRouter.quickSearch, CMCQuickSearch.self, completion: { (result, err) in
        guard err == nil else {
            print("False with code: \(err?.mErrorCode) and message: \(err?.mErrorMessage)")
            return
        }
        
        if let dataResponse = result {
            for data in dataResponse {
                self.slugToIDMap[data.slug!] = data.id
                print(data.slug ?? "-")
                print(data.id ?? "-")
            }
            for data in self.listData {
                data.idThumb = self.slugToIDMap[data.id!]
            }
            self.tableView.reloadData()
        }
    })
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("======> 0")
            count = 10
          break
        case 1:
               print("======> 1")
               count = 3
           break
        default:
            break
        }
//        tableView.reloadData()
    }
}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (listData.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:AllCoinTableViewCell? = tableView.dequeueReusableCell(withIdentifier: AllCoinTableViewCell.className, for: indexPath) as? AllCoinTableViewCell
        if (cell == nil) {
//            cell = tableView.dequeueReusableCell(withIdentifier: AllCoinTableViewCell.className) as? AllCoinTableViewCell
            cell = AllCoinTableViewCell(style: .default, reuseIdentifier: AllCoinTableViewCell.className)
        }
        cell?.setUpView(data: listData[indexPath.row])
//        cell?.lblNo.text = String(indexPath.row+1)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
