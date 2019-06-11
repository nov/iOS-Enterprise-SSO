//
//  ViewController.swift
//  sso
//
//  Created by nov on 2019/06/11.
//  Copyright © 2019 YAuth.jp. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginButtonPushed(_ sender: Any) {
        let issuer = URL(fileURLWithPath: "https://connect-op.herokuapp.com")
        let ssoProvider = ASAuthorizationSingleSignOnProvider(identityProvider: issuer)
        let request = ssoProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.authorizationOptions = [
            URLQueryItem(name: "client_id", value: "client_id"),
            URLQueryItem(name: "response_type", value: "code")
        ]
        let authzController = ASAuthorizationController(authorizationRequests: [request])
        authzController.delegate = self
        authzController.presentationContextProvider = self
        authzController.performRequests()
    }
    
}

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
