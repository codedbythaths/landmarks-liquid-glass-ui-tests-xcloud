/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that shows a collection's title, description, and list of landmarks.
*/

import SwiftUI

/// A view that shows a collection's title, description, and list of landmarks.
struct CollectionDetailDisplayView: View {
    @Bindable var collection: LandmarkCollection
    
    var body: some View {
        VStack() {
            HStack {
                Text(collection.name)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding([.top])
                    .accessibilityIdentifier("CollectionDetail.title.\(collection.id)")
                Spacer()
            }
            .accessibilityIdentifier("CollectionDetail.titleRow")
            HStack {
                Text(collection.description)
                    .font(.title2)
                    .padding([.top, .bottom])
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibilityIdentifier("CollectionDetail.description.\(collection.id)")
                Spacer()
            }
            .accessibilityIdentifier("CollectionDetail.descriptionRow")
            LandmarksGrid(landmarks: $collection.landmarks, forEditing: false)
                .accessibilityIdentifier("CollectionDetail.landmarksGrid.\(collection.id)")
        }
        .padding([.leading, .trailing], Constants.leadingContentInset)
        .accessibilityIdentifier("CollectionDetail.root.\(collection.id)")
    }
}

#Preview {
    let modelData = ModelData()
    let previewCollection = modelData.userCollections.last!

    CollectionDetailDisplayView(collection: previewCollection)
}

