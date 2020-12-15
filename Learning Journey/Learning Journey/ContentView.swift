//
//  ContentView.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 04/12/20.
//

import SwiftUI

struct ContentView: View {
    private let container: DIContainer
    init(container: DIContainer) {
        self.container = container
    }
    var body: some View {
        LeariningJourneyView()
            .inject(container)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: .preview)
    }
}
#endif
