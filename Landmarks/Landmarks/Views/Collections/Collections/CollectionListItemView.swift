/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that represents a single landmark collection in a grid.
*/

import SwiftUI

/// A view that represents a single landmark collection in a grid.
struct CollectionListItemView: View {
    let collection: LandmarkCollection

    var body: some View {
        VStack {
            collection.imageForListItem()
                .cornerRadius(Constants.cornerRadius)
                .accessibilityIdentifier("collectionListItem.image.\(collection.id)")
            Text(collection.name)
                .accessibilityIdentifier("collectionListItem.name.\(collection.id)")
            Text("\(collection.landmarks.count) items")
                .font(.callout)
                .foregroundStyle(.secondary)
                .accessibilityIdentifier("collectionListItem.count.\(collection.id)")
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("collectionListItem.container.\(collection.id)")
    }
}

#Preview {
    let modelData = ModelData()
    let previewCollection = modelData.userCollections.first!

    CollectionListItemView(collection: previewCollection)
}
