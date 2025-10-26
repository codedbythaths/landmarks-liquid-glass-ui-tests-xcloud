/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that shows a group of landmarks in a grid.
*/

import SwiftUI

/// A view that shows a group of landmarks in a grid.
struct LandmarksGrid: View {
    @Binding var landmarks: [Landmark]
    let forEditing: Bool

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: Constants.landmarkGridSpacing) {
                ForEach(landmarks, id: \.id) { landmark in
                    if forEditing {
                        LandmarkGridItemView(landmark: landmark)
                            .accessibilityIdentifier("LandmarksGrid.item.editing.\(landmark.id)")
                    } else {
                        NavigationLink(destination: LandmarkDetailView(landmark: landmark)) {
                            LandmarkGridItemView(landmark: landmark)
                                .accessibilityIdentifier("LandmarksGrid.item.content.\(landmark.id)")
                        }
                        .buttonStyle(.plain)
                        .accessibilityIdentifier("LandmarksGrid.item.link.\(landmark.id)")
                    }
                }
            }
            .accessibilityIdentifier("LandmarksGrid.grid")
        }
        .accessibilityIdentifier("LandmarksGrid.scrollView")
    }
    
    private var columns: [GridItem] {
        if forEditing {
            return [ GridItem(.adaptive(minimum: Constants.landmarkGridItemEditingMinSize,
                                        maximum: Constants.landmarkGridItemEditingMaxSize),
                              spacing: Constants.landmarkGridSpacing) ]
        }
        return [ GridItem(.adaptive(minimum: Constants.landmarkGridItemMinSize,
                                    maximum: Constants.landmarkGridItemMaxSize),
                          spacing: Constants.landmarkGridSpacing) ]
    }
}

#Preview {
    let modelData = ModelData()
    let previewCollection = modelData.userCollections[2]

    LandmarksGrid(landmarks: .constant(previewCollection.landmarks), forEditing: true)
}
