//
//  SearchCell.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-04.
//

import SwiftUI

struct SearchCell: View {
    var tag = ""
    var numberOfTweets = "100"

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Test")
                .fontWeight(.heavy)
            Text("\(numberOfTweets) Tweets")
                .fontWeight(.light)
            
        }
    }
}

struct SearchCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell()
    }
}
