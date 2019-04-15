//
//  ViewController.swift
//  LinkedInTest
//
//  Created by JP LaFond on 4/11/19.
//  Copyright © 2019 Jp LaFond. All rights reserved.
//

import p2_OAuth2
import SafariServices
import UIKit

class ViewController: UIViewController {

    let dateFormatter = DateFormatter()

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    @IBAction func loginPressed(sender: UIButton) {
        log("\(#function)")
        triggerOAuth()
    }

    var loader: OAuth2DataLoader?

    private var errorText = String()

    private func log(_ comment: String = "", at now: Date = Date()) {
        let nowString = dateFormatter.string(from: now)
        errorText = "<\(comment)>[\(nowString)]\n" + errorText
        errorLabel.text = errorText
    }

    private func triggerOAuth() {
        let oauth2 = OAuth2CodeGrant(settings: [
            "client_id": "86wgy3rfgw3d32",
            "client_secret": "C7447242",
            "authorize_uri": "https://www.linkedin.com/oauth/v2/authorization",
            "token_uri": "https://www.linkedin.com/oauth/v2/accessToken",   // code grant only
//            "redirect_uris": ["Jp4Mobile://redirect/test-page"],
            "redirect_uris": ["https://www.jp4mobile.com/redirect/test-page"],
            "scope": "r_liteprofile%20r_emailaddress%20w_members_social",
            "secret_in_body": false,
            "keychain": false,         // if you DON'T want keychain integration
            ] as OAuth2JSON)
//        oauth2.authConfig.authorizeEmbedded = true
//        oauth2.authConfig.authorizeContext = self
        oauth2.authConfig.authorizeEmbedded = true
        oauth2.authConfig.authorizeContext = self
        oauth2.logger = OAuth2DebugLogger(.trace)
        let base = URL(string: "https://api.linkedin.com")!
        let url = base.appendingPathComponent("v2/me")

        // https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id={your_client_id}&redirect_uri=https%3A%2F%2Fdev.example.com%2Fauth%2Flinkedin%2Fcallback&state=fooobar&scope=r_liteprofile%20r_emailaddress%20w_member_social

        var req = oauth2.request(forURL: url)
        req.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")

        self.loader = OAuth2DataLoader(oauth2: oauth2)
        loader?.perform(request: req) { response in
            do {
                let dict = try response.responseJSON()
                DispatchQueue.main.async {
                    // you have received `dict` JSON data!
                    self.log("<\(dict)>")
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    // an error occurred
                    self.log("[\(error)]")
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        log("\(#function)")
    }
}

extension ViewController {
    func SafariViewControllerDidFinish(_ controller: SFSafariViewController) {
        print("*Jp* \(#function)")
        dismiss(animated: true, completion: nil)
    }
}
