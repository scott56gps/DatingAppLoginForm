//
//  MatchesView.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/23/26.
//

import SwiftUI

struct MatchesView: View {
    @ObservedObject var viewModel = MatchesViewModel(client: MatchesClient())
    
    var body: some View {
        VStack {
            List(viewModel.matches, id: \.name) { match in
                MatchesItemView(matchItem: match)
                    .frame(maxHeight: 75)
            }
        }
    }
}

#Preview {
    MatchesView()
}
