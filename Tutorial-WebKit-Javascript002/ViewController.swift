//
//  ViewController.swift
//  Tutorial-WebKit-Javascript002
//
//  Created by Kevin Quinn on 2/8/16.
//  Copyright © 2016 Kevin Quinn. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate{
    
    //TODO document
    // DOM events:  www.w3schools.com/jsref/dom_obj_event.asp
    
    //--------------------------------------------------
    // MARK: Properties
    //--------------------------------------------------
    
    var webView: WKWebView?
    let jsMessageHandler = "jsEventHandler"
    
    //--------------------------------------------------
    // MARK: Functions
    //--------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate the javascript to be injected on initial load
        let webViewConfiguration = WKWebViewConfiguration()
        do {
            let jsFile = NSBundle.mainBundle().pathForResource("example002", ofType: "js")
            let jsFromFile = try String(contentsOfFile: jsFile!, encoding: NSUTF8StringEncoding)
            let jsScript = WKUserScript(source: jsFromFile, injectionTime: .AtDocumentEnd, forMainFrameOnly: false)
            
            webViewConfiguration.userContentController.addUserScript(jsScript)
            webViewConfiguration.userContentController.addScriptMessageHandler(self, name: jsMessageHandler)
        } catch {
            print("ViewController.viewDidLoad():  Error, unable to parse javascript from file")
        }
        
        // Add the WKWebView to the screen + assign viewcontroller as the delegate
        webView = WKWebView(frame: self.view.bounds, configuration: webViewConfiguration)
        self.view.addSubview(webView!)
        webView!.navigationDelegate = self
        
        // Launch the webpage and trigger the injection
        
        //  load via url for https://  no special permission required
        //let url = NSURL(string: "https://www.google.com")
        //
        //  load via url for http:// requires special App Transport Security permission in info.plist
        //let url = NSURL(string: "http://www.darknessdescending.com")
        //
        //let request = NSURLRequest(URL: url!)
        //self.webView!.loadRequest(request)
        
        //  load via file - used for testing purposes, for production, load via url.
        let fileUrl = NSBundle.mainBundle().pathForResource("example002", ofType: "html")!
        let url = NSURL(fileURLWithPath: fileUrl)
        webView!.loadFileURL(url, allowingReadAccessToURL: url)
    }
    
    //--------------------------------------------------
    // MARK: Protocols
    //--------------------------------------------------

    //WKScriptMessageHandler
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        print("Event Registered")
    }

}

