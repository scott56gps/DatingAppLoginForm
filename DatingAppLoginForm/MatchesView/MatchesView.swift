//
//  MatchesView.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/23/26.
//

import SwiftUI

struct MatchesView: View {
    @ObservedObject var viewModel = MatchesViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.matchItems, id: \.name) { match in
                MatchesItemView(matchItem: match)
                    .frame(maxHeight: 75)
            }
            TextField("New Match Name", text: $viewModel.customMatchName)
            Button("Add Match") {
                viewModel.addMatch()
            }
        }
    }
}

#Preview {
    MatchesView()
}
