import Firebase
import SwiftUI

class FirebaseAuthStateObserver: ObservableObject {
    @Published var isSignin: Bool = false
    @AppStorage("uid") var uid: String?
    private var listener: AuthStateDidChangeListenerHandle!

    init() {
        listener = Auth.auth().addStateDidChangeListener { [self] (auth, user) in
            if let _ = user {
                uid = user?.uid
                isSignin = true
            } else {
                isSignin = false
            }
        }
    }

    deinit {
        Auth.auth().removeStateDidChangeListener(listener)
    }

}
