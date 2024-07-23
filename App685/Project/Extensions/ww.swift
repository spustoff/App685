//
//  ww.swift
//  App685
//
//  Created by Вячеслав on 7/23/24.
//

import SwiftUI
import ApphudSDK
import WebKit

struct WebSystem: View {
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
            
            WControllerRepresentable()
        }
        .ignoresSafeArea()
    }
}

class WController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @AppStorage("first_open") var firstOpen: Bool = true
    @AppStorage("silka") var silka: String = ""
    
    @Published var url_link: URL = URL(string: "https://google.com")!
    @Published var isAllChangeURL: Bool = false
    
    var webView = WKWebView()
    var loadCheckTimer: Timer?
    var isPageLoadedSuccessfully = false

    override func viewDidLoad() {
        super.viewDidLoad()
        getRequest()
    }
    
    private func getRequest() {
        
        fetchData { server1_0, isAllChangeURL, isDead, lastDate, error in
            
            if let error = error {
                
                print("Ошибка: \(error.localizedDescription)")
                
            } else {
                
                self.isAllChangeURL = isAllChangeURL ?? false
                guard let url = URL(string: "\(server1_0 ?? "google.com")") else { return }

                self.url_link = url
                self.getInfo()
            }
        }
    }
    
    private func getInfo() {
        
        var request: URLRequest?
        
        if isAllChangeURL {
            
            request = URLRequest(url: self.url_link)
            silka = url_link.absoluteString
            
        } else {
            
            if silka == "about:blank" || silka.isEmpty {
                
                request = URLRequest(url: self.url_link)
                
            } else {
                
                if let currentURL = URL(string: silka) {
                    
                    request = URLRequest(url: currentURL)
                }
            }
        }
        
        let cookies = HTTPCookieStorage.shared.cookies ?? []
        let headers = HTTPCookie.requestHeaderFields(with: cookies)
        request?.allHTTPHeaderFields = headers
        
        DispatchQueue.main.async {
            
            self.setupWebView()
        }
    }
    
    private func setupWebView() {
        
        let urlString = silka.isEmpty ? url_link.absoluteString : silka
        
        guard let url = URL(string: urlString) else { return }
        
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        webView.customUserAgent = "Mozilla/5.0 (Linux; Android 11; AOSP on x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/89.0.4389.105 Mobile Safari/537.36"
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        webView.load(URLRequest(url: url))
        
        loadCookie()
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        isPageLoadedSuccessfully = false
        loadCheckTimer?.invalidate()
        loadCheckTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            
            if let strongSelf = self, !strongSelf.isPageLoadedSuccessfully {
                
                print("Страница не загрузилась в течение 5 секунд.")
            }
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        isPageLoadedSuccessfully = true
        loadCheckTimer?.invalidate()
        
        if let currentURL = webView.url?.absoluteString, currentURL != url_link.absoluteString {
            
            silka = currentURL
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        isPageLoadedSuccessfully = false
        loadCheckTimer?.invalidate()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        isPageLoadedSuccessfully = false
        loadCheckTimer?.invalidate()
    }

    func saveCookie() {
        
        let cookieJar = HTTPCookieStorage.shared
        
        if let cookies = cookieJar.cookies {
            
            let data = NSKeyedArchiver.archivedData(withRootObject: cookies)
            
            UserDefaults.standard.set(data, forKey: "cookie")
        }
    }
    
    func loadCookie() {
        
        let ud = UserDefaults.standard
        
        if let data = ud.object(forKey: "cookie") as? Data, let cookies = NSKeyedUnarchiver.unarchiveObject(with: data) as? [HTTPCookie] {
            
            for cookie in cookies {
                
                HTTPCookieStorage.shared.setCookie(cookie)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
    }
}

struct WControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = WController
    
    func makeUIViewController(context: Context) -> WController {
        
        return WController()
    }
    
    func updateUIViewController(_ uiViewController: WController, context: Context) {}
}
