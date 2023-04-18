
import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text : String
    @Binding var keyboardHeight: CGFloat
    var placeholder: String
    
    class Cordinator : NSObject, UISearchBarDelegate {
        
        @Binding var text : String
        @Binding var searchBarHeight: CGFloat
        
        var searchDebouncer: Debouncer!
        
        init(text : Binding<String>, searchBarHeight: Binding<CGFloat>) {
            _text = text
            _searchBarHeight = searchBarHeight
            
            super.init()
            
            searchDebouncer = Debouncer(delay: 0.5) {
                // Perform search here
                print("Search for: \(self.text)")
            }
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillHide),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            searchDebouncer.call()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            searchBar.resignFirstResponder()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
        
        @objc func keyboardWillShow(_ notification: Notification) {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                UIView.animate(withDuration: 0.3) {
                    self.searchBarHeight = keyboardRectangle.height
                }
            }
        }
        
        @objc func keyboardWillHide(_ notification: Notification) {
            UIView.animate(withDuration: 0.3) {
                self.searchBarHeight = 0
            }
        }
    }
    
    func makeCoordinator() -> SearchBar.Cordinator {
        return Cordinator(text: $text, searchBarHeight: $keyboardHeight)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = placeholder
        searchBar.delegate = context.coordinator
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = true
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.spellCheckingType = .no

        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

class Debouncer {
    let delay: TimeInterval
    var timer: Timer?
    
    init(delay: TimeInterval, handler: @escaping () -> Void) {
        self.delay = delay
        self.handler = handler
    }
    
    func call() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            self.handler()
        }
    }
    
    var handler: (() -> Void)
}

