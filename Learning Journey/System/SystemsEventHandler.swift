import Foundation
import UIKit
import SwiftUI
import Combine

struct SystemEventHandler {
    // MARK: - Dependencies
    let container: DIContainer
    
    // MARK: - Properties
    private var cancelBag = CancelBag()
    
    // MARK: - Initialization
    init(container: DIContainer) {
        self.container = container
        
        installKeyboardHeightObserver()
    }
    
    // MARK: - Helpers
    private func installKeyboardHeightObserver() {
        let appStore = container.appStore
        NotificationCenter.default.keyboardHeightPublisher
            .sink { [appStore] height in
                appStore[\.system.keyboardHeight] = height
        }
        .store(in: cancelBag)
    }
}


private extension NotificationCenter {
    var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        let willShow = publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        let willHide = publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        return Publishers.Merge(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

private extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
            .cgRectValue.height ?? 0
    }
}
