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
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var noView: UIView!
    @IBOutlet weak var noArrow: UIImageView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameArrowImage: UIImageView!
    @IBOutlet weak var percentChangeView: UIView!
    @IBOutlet weak var percentChangeArrowImage: UIImageView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceArrowImage: UIImageView!
    
    var count: Int?
    var listData: [CoinResponse] = []
    var slugToIDMap = [String : Int]()
    var headerViewInitHeight = CGFloat()
    var isSelectSort: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 10
        self.setupViewHeader()
        self.tableView.registerCellNib(AllCoinTableViewCell.self)
        tableView.delegate = self
        //        tableView.delegate = self
        // add a top edge inset for table view.
        //        tableView.contentInset = UIEdgeInsets(top: headerView.frame.height, left: 0, bottom: 0, right: 0)
        headerViewInitHeight = headerView.frame.height
        
        // update table view content height
        tableView.layoutIfNeeded()
        
        // adjust scroll view content height using rootContainer height anchor
        //        rootViewHeightConstraint.constant = tableView.contentSize.height + headerViewInitHeight
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
    
    private func setupViewHeader() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.clickAction (_:)))
        self.noView.addGestureRecognizer(gesture)
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector (self.clickAction2 (_:)))
        self.nameView.addGestureRecognizer(gesture2)
        let gesture3 = UITapGestureRecognizer(target: self, action:  #selector (self.clickAction3 (_:)))
        self.percentChangeView.addGestureRecognizer(gesture3)
        let gesture4 = UITapGestureRecognizer(target: self, action:  #selector (self.clickAction4 (_:)))
        self.priceView.addGestureRecognizer(gesture4)
    }
    
    // or for Swift 4
    @objc func clickAction(_ sender:UITapGestureRecognizer){
        // do other task
        self.noArrow.isHidden = false
        if(isSelectSort){
            self.noArrow.transform = CGAffineTransform(rotationAngle: .pi)
        }
        else {
            self.noArrow.transform = CGAffineTransform(rotationAngle: .pi*2)
        }
        self.nameArrowImage.isHidden = true
        self.percentChangeArrowImage.isHidden = true
        self.priceArrowImage.isHidden = true
        isSelectSort = !isSelectSort
    }
    
    @objc func clickAction2(_ sender:UITapGestureRecognizer){
        // do other task
        self.nameArrowImage.isHidden = false
        if(isSelectSort){
            self.nameArrowImage.transform = CGAffineTransform(rotationAngle: .pi)
        }
        else {
            self.nameArrowImage.transform = CGAffineTransform(rotationAngle: .pi*2)
        }
        self.noArrow.isHidden = true
        self.percentChangeArrowImage.isHidden = true
        self.priceArrowImage.isHidden = true
        isSelectSort = !isSelectSort
    }
    
    @objc func clickAction3(_ sender:UITapGestureRecognizer){
        // do other task
        self.percentChangeArrowImage.isHidden = false
        if(isSelectSort){
            self.percentChangeArrowImage.transform = CGAffineTransform(rotationAngle: .pi)
        }
        else {
            self.percentChangeArrowImage.transform = CGAffineTransform(rotationAngle: .pi*2)
        }
        self.nameArrowImage.isHidden = true
        self.noArrow.isHidden = true
        self.priceArrowImage.isHidden = true
        isSelectSort = !isSelectSort
    }
    
    @objc func clickAction4(_ sender:UITapGestureRecognizer){
        // do other task
        self.priceArrowImage.isHidden = false
        if(isSelectSort){
            self.priceArrowImage.transform = CGAffineTransform(rotationAngle: .pi)
        }
        else {
            self.priceArrowImage.transform = CGAffineTransform(rotationAngle: .pi*2)
        }
        self.nameArrowImage.isHidden = true
        self.percentChangeArrowImage.isHidden = true
        self.noArrow.isHidden = true
        isSelectSort = !isSelectSort
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

extension HomeViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let y = scrollView.contentOffset.y
        //            - tableView.contentOffset.y
        self.headerTopConstraint.constant =  -y
        if headerTopConstraint.constant > 0 || headerTopConstraint.constant == -headerViewInitHeight {
            headerTopConstraint.constant = 0
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
}
