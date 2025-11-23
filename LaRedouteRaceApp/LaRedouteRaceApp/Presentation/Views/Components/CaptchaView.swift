//
//  CaptchaView.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import SwiftUI
import WebKit

struct CaptchaView: View {
    let url: URL
    let onComplete: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(spacing: 10) {
                    Text("Security Check")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Please complete the CAPTCHA to continue")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color.black)
                
                CaptchaWebView(url: url, onComplete: onComplete)
            }
        }
    }
}

struct CaptchaWebView: UIViewRepresentable {
    let url: URL
    let onComplete: () -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onComplete: onComplete)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let onComplete: () -> Void
        private var hasCompleted = false
        
        init(onComplete: @escaping () -> Void) {
            self.onComplete = onComplete
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            //MARK: We don't get the https://www.google.com/recaptcha/api2/userverify at all. This breaks the return logic!
            if let url = navigationAction.request.url,
               url.absoluteString.contains("recaptcha/api2/demo"),
               !hasCompleted {
                
                hasCompleted = true
                
                Task {
                    do {
                        let (_, response) = try await URLSession.shared.data(from: url)
                        if let httpResponse = response as? HTTPURLResponse,
                           httpResponse.statusCode == 200 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.onComplete()
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.hasCompleted = false
                            }
                        }
                    } catch {
                        print("Error checking userverify: \(error)")
                        DispatchQueue.main.async {
                            self.hasCompleted = false
                        }
                    }
                }
            }
            
            decisionHandler(.allow)
        }
    }
}
