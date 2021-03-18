import Firebase

class FirebaseAuthStateObserver: ObservableObject {
    @Published var isSignin: Bool = false
    private var listener: AuthStateDidChangeListenerHandle!

    init() {
        listener = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let _ = user {
                print("sign-in")
                self.isSignin = true
            } else {
                print("sign-out")
                self.isSignin = false
            }
        }
    }

    deinit {
        Auth.auth().removeStateDidChangeListener(listener)
    }

}
