//
//  MatchesItemView.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/23/26.
//

import SwiftUI

struct MatchesItemView: View {
    var matchItem: MatchItem
    
    var body: some View {
        HStack(alignment: .top) {
            Image(matchItem.imageUrl)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(matchItem.name)
                Text(matchItem.location)
            }
            // Setting maxWidth: .infinity is like setting the width to flex
            //  'infinity' means to take up as much space as possible
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    let item = MatchItem(name: "Scott Nicholes", location: "Claremont, CA, USA", imageUrl: "sample_profile_picture")
    MatchesItemView(matchItem: item)
        .frame(maxHeight: 100)
}
