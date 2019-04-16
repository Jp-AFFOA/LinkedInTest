//
//  OAuth2Wrapper.swift
//  LinkedInTest
//
//  Created by JP LaFond on 4/16/19.
//  Copyright © 2019 Jp LaFond. All rights reserved.
//

import Foundation
import p2_OAuth2

class OAuth2Wrapper {
    let oauth2: OAuth2CodeGrantLinkedIn

    static let shared = OAuth2Wrapper()

    private init() {
        oauth2 = OAuth2CodeGrantLinkedIn(settings: [
            "client_id": "86wgy3rfgw3d32",
            "client_secret": "eRd5yh4ynpOSw0Kg",
            "authorize_uri": "https://www.linkedin.com/oauth/v2/authorization",
            "token_uri": "https://www.linkedin.com/oauth/v2/accessToken",   // code grant only
            "redirect_uris": ["https://www.jp4mobile.com/redirect/test-page"],
//            "scope": "r_liteprofile r_emailaddress w_member_social",
            "scope": "r_fullprofile r_emailaddress w_member_social",
            "keychain": false,         // if you DON'T want keychain integration
            ] as OAuth2JSON)
        oauth2.logger = OAuth2DebugLogger(.trace)
    }
}
