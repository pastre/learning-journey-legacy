import SwiftUI
import UIKit

// FIXME: Replace this for a SwiftUI component when Apple releases it
struct SearchBar: UIViewRepresentable {
    
    // MARK: - Inner types
    final class Coordinator: NSObject, UISearchBarDelegate {
        let text: Binding<String>
        
        init(text: Binding<String>) {
            self.text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text.wrappedValue = searchText
        }
        
        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.setShowsCancelButton(true, animated: true)
            return true
        }
        
        func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.setShowsCancelButton(false, animated: true)
            return true
        }
 
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
            searchBar.text = ""
            text.wrappedValue = ""
        }
    }
    
    
    // MARK: - Properties
    @Binding var text: String
    
    // MARK: - UIViewRepresentable
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let bar = UISearchBar(frame: .zero)
        bar.delegate = context.coordinator
        return bar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
}
