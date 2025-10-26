/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that shows a person's favorite landmarks and custom landmark collections.
*/

import SwiftUI

/// A view that shows a person's favorite landmarks and custom landmark collections.
struct CollectionsView: View {
    @Environment(ModelData.self) var modelData

    var body: some View {
        @Bindable var modelData = modelData

        ScrollView(.vertical) {
            LazyVStack {
                HStack {
                    CollectionTitleView(title: "Favorites", comment: "Section title above favorite collections.")
                        .accessibilityIdentifier("collectionsView.sectionHeader.favorites")
                    Spacer()
                }
                .padding(.leading, Constants.leadingContentInset)
                
                LandmarkHorizontalListView(landmarkList: modelData.favoritesCollection.landmarks)
                    .accessibilityIdentifier("collectionsView.favorites.horizontalList")
                    .containerRelativeFrame(.vertical) { height, axis in
                        let proposedHeight = height * Constants.landmarkListPercentOfHeight
                        if proposedHeight > Constants.landmarkListMinimumHeight {
                            return proposedHeight
                        }
                        return Constants.landmarkListMinimumHeight
                    }

                HStack {
                    CollectionTitleView(title: "My Collections", comment: "Section title above the person's collections.")
                        .accessibilityIdentifier("collectionsView.sectionHeader.myCollections")
                    Spacer()
                }
                .padding(.leading, Constants.leadingContentInset)
                
                CollectionsGrid()
                    .accessibilityIdentifier("collectionsView.collectionsGrid.container")
                    .padding(.leading, Constants.leadingContentInset)
            }
            .accessibilityIdentifier("collectionsView.stack")
        }
        .ignoresSafeArea(.keyboard, edges: [.bottom])
        .navigationTitle("Collections")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    let newCollection = modelData.addUserCollection()
                    modelData.path.append(newCollection)
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityIdentifier("collectionsView.toolbar.addCollectionButton")
            }
        }
        .navigationDestination(for: Landmark.self) { landmark in
            LandmarkDetailView(landmark: landmark)
        }
        .navigationDestination(for: LandmarkCollection.self) { collection in
            CollectionDetailView(collection: collection)
        }
        .accessibilityIdentifier("collectionsView.scrollView")
    }
}

private struct CollectionTitleView: View {
    let title: LocalizedStringKey
    let comment: StaticString
    
    var body: some View {
        Text(title, comment: comment)
            .font(.title2)
            .bold()
            .padding(.top, Constants.titleTopPadding)
    }
}

#Preview {
    CollectionsView()
        .environment(ModelData())
}
