//
//  WebViewController.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit
import SVProgressHUD

class WebViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet var webView: UIWebView!
    
    // MARK: - Properties
    var viewModel: WebViewModel

    // MARK: - Init
    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: WebViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        webView.delegate = self
        loadURL()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }

    // MARK: - UI
    private func loadURL(){
        
        if let url = viewModel.hit?.storyURL {
            let nsurl = NSURL(string: url)
            let request = NSURLRequest(url: nsurl! as URL)
            webView.loadRequest(request as URLRequest)
        }
    }
}

//MARK: - UIWebViewDelegate
extension WebViewController: UIWebViewDelegate{
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
