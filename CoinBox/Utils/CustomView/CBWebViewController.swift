//
//  CBWebViewController.swift
//  CoinBox
//
//  Created by Pham Van Quan on 1/14/19.
//  Copyright © 2019 Pham Van Quan. All rights reserved.
//

import UIKit
import WebKit

class CBWebViewController: UIViewController , WKUIDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var urlWeb:String!
    var myContext = 0
    var navItem = UINavigationItem(title: "News");
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let myURL = URL(string:urlWeb)
        let myRequest = URLRequest(url: myURL!)
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-50), configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        // navigation bar
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45))
        self.view.addSubview(navBar)
//        let navItem = UINavigationItem(title: "News");
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(doneWK));
        navItem.rightBarButtonItem = doneItem;
        navBar.setItems([navItem], animated: false);
        
        // progress
        progressView = UIProgressView(frame: CGRect(x: 0, y: 45, width: UIScreen.main.bounds.width, height: 5))
        progressView.progress = 0.0
        progressView.tintColor = UIColor.cyan
         self.view.addSubview(progressView)
        self.view.addSubview(webView)
        webView.load(myRequest)
        webView.allowsBackForwardNavigationGestures = true
        // // add observer for key path
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }

//    override func loadView() {
//
////        view = webView
//    }
    
    //deinit
    deinit {
        //remove all observers
        webView.removeObserver(self, forKeyPath: "title")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        //remove progress bar from navigation bar
        progressView.removeFromSuperview()
    }
    
  @objc func doneWK () {
    print("========>done webview")
    self.dismiss(animated: true, completion: {
         print("========>dismiss")
    })
    }
    
    //observer
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let change = change else { return }
//        if context != &myContext {
//            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
//            return
//        }
        
        if keyPath == "title" {
            if let title = change[NSKeyValueChangeKey.newKey] as? String {
                self.navItem.title = title
            }
            return
        }
        if keyPath == "estimatedProgress" {
            if let progress = (change[NSKeyValueChangeKey.newKey] as AnyObject).floatValue {
                progressView.progress = progress;
                if(progress >= 1.0)        {
                     progressView.isHidden = true
                }
                 print("========>progress \(progress)")
            }
            return
        }
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

}

extension CBWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
    }
}
