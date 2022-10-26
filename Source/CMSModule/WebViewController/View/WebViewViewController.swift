//
//  WebViewViewController.swift
//  Manipal
//
//  Created by DB-MBP-008 on 07/10/22.
//

import UIKit
import WebKit

class WebViewViewController: BaseViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var urlString : String?
    var documentType : String?
    var viewModel = WebViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }

    
    private func initialSetup(){
        lblTitle.text = documentType
        webView.navigationDelegate = self
        switch(documentType) {
        case WebViewType.aboutUs.rawValue:
            apiCalForAboutUs()
        case WebViewType.termsConditions.rawValue:
            apiCalForTermsConditions()
        case WebViewType.privacy.rawValue:
            apiCalForPrivacy()
        default:
            break
        }
    }
    
    func apiCalForAboutUs(){
        self.viewModel.apicallForAboutUs() { status, data in
            if status == .Success{
                self.loadWebView(urlString: data?.webPageLink ?? "")
            }else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
    
    func apiCalForTermsConditions(){
        self.viewModel.apicallForTermsConditions() { status, data in
            if status == .Success{
                self.loadHTMLTag(htmlString: data?.cmsContent?.description ?? "")
            }else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
    
    func apiCalForPrivacy(){
        self.viewModel.apicallForPrivacy() { status, data in
            if status == .Success{
                self.loadHTMLTag(htmlString: data?.cmsContent?.description ?? "")
            }else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrint("currentWebUrl::::::", webView.url ?? "")
    }
    
    func loadWebView(urlString: String) {
        if urlString.isEmpty != true {
            if  let url = URL(string: urlString) {
                debugPrint("urlString=\(url)")
                let request = URLRequest(url: url)
                webView.load(request)
            }else{
                guard let urlEncodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                        let url = URL(string: urlEncodedString)
                else { return  }
                debugPrint("query urlString=\(url)")
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }else{
            showToast(message: "No preview available")
        }
    }
    
    func loadHTMLTag(htmlString: String) {
        let header = """
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
                    <style>
                        body {
                            font-family: "Helvetica Neue";
                            font-size: 12px;
                        }
                    </style>
                </head>
                <body>
                """
        webView.loadHTMLString(header + htmlString + "</body>", baseURL: nil)
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
