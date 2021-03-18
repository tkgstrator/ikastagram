//
//  LoginView.swift
//  ikastagram
//
//  Created by Devonly on 3/17/21.
//

import SwiftUI
import BetterSafariView
import CryptoKit

struct LoginView: View {
    
    @State var isPresented: Bool = false
    @State var oauthURL: URL? = nil
    
    @AppStorage("isFirstLaunch") var isFirstLaunch = true
    @AppStorage("userId") var userId: String?
    var body: some View {
        Button(action: { isPresented.toggle() }, label: { Text("BTN_SIGN_IN") })
            .webAuthenticationSession(isPresented: $isPresented) {
                WebAuthenticationSession(
                    url: URL(string: "https://ikastagram.herokuapp.com/")!,
                    callbackURLScheme: "ikastagram") { callbackURL, Error in
                    guard let value: String = callbackURL?.absoluteString else { return }
                    if let id: String = value.capture(pattern: "user_id=([0-9]*)", group: 1) {
                        userId = id
                        print(userId)
                        isFirstLaunch.toggle()
                    }
                }
            }
    }
}

extension String {
    static var randomString: String {
        let letters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<128).map{ _ in letters.randomElement()! })
    }
    
    var base64EncodedString: String {
        return self.data(using: .utf8)!.base64EncodedString()
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
    }
    
    func capture(pattern: String, group: Int) -> String? {
        let result = capture(pattern: pattern, group: [group])
        return result.isEmpty ? nil : result[0]
    }
    
    private func capture(pattern: String, group: [Int]) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        guard let matched = regex.firstMatch(in: self, range: NSRange(location: 0, length: self.count)) else { return [] }
        return group.map { group -> String in
            return (self as NSString).substring(with: matched.range(at: group))
        }
    }
    
    var rawurlencode: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
     
    var urlencode: String {
        let charset = NSCharacterSet(charactersIn:"&:=\"#%/<>?@\\^`{|}+,! ").inverted
        return self.addingPercentEncoding(withAllowedCharacters: charset)!
    }
    
    func hmacsha1(key: String) -> String {
        let hash = HMAC<Insecure.SHA1>.authenticationCode(for: Data(self.data(using: .utf8)!), using: SymmetricKey(data: Data(key.data(using: .utf8)!)))
        let hashArray: [UInt8] = Array(hash.map{ String(format: "%02x", $0) }).map{ UInt8($0, radix: 16)! }
        let data: Data = Data(bytes: hashArray, count: hashArray.count)
        return data.base64EncodedString()
    }
}

extension Dictionary where Key == String, Value == String {
    var queryString: String {
        return self.sorted(by: { $0.0 < $1.0} ).map{ "\($0.0)=\($0.1)" }.joined(separator: "&")
    }
    
    var paramString: String {
        return self.sorted(by: { $0.0 < $1.0} ).map{ "\($0.0)=\($0.1.urlencode)" }.joined(separator: "&")
    }
    
    var query: String {
        return self.sorted(by: { $0.0 < $1.0} ).map{ "\($0.0)=\($0.1.urlencode)" }.joined(separator: ",")
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
