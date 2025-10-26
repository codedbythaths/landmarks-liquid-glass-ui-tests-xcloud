/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that shows a single landmark, with an image and description.
*/

import SwiftUI
import MapKit

/// A view that shows a single landmark, with an image and description.
struct LandmarkDetailView: View {
    @Environment(ModelData.self) private var modelData
    let landmark: Landmark

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: Constants.landmarkImagePadding) {
                Image(landmark.backgroundImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .backgroundExtensionEffect()
                    .flexibleHeaderContent()
                    .accessibilityIdentifier("LandmarkDetail.headerImage.\(landmark.id)")

                VStack(alignment: .leading) {
                    Text(landmark.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .accessibilityIdentifier("LandmarkDetail.title.\(landmark.id)")

                    Text(landmark.description)
                        .textSelection(.enabled)
                        .accessibilityIdentifier("LandmarkDetail.description.\(landmark.id)")
                }
                .padding(.leading, Constants.leadingContentInset)
                .padding(.trailing, Constants.leadingContentInset * 2)
                .accessibilityIdentifier("LandmarkDetail.textContainer.\(landmark.id)")
            }
            .accessibilityIdentifier("LandmarkDetail.contentStack.\(landmark.id)")
        }
        .flexibleHeaderScrollView()
        .toolbar {
            ToolbarSpacer(.flexible)

            ToolbarItem {
                ShareLink(item: landmark, preview: landmark.sharePreview)
                    .accessibilityIdentifier("LandmarkDetail.toolbar.share.\(landmark.id)")
            }

            ToolbarSpacer(.fixed)
            
            ToolbarItemGroup {
                LandmarkFavoriteButton(landmark: landmark)
                    .accessibilityIdentifier("LandmarkDetail.toolbar.favorite.\(landmark.id)")

                LandmarkCollectionsMenu(landmark: landmark)
                    .accessibilityIdentifier("LandmarkDetail.toolbar.collectionsMenu.\(landmark.id)")
            }
            
            ToolbarSpacer(.fixed)
        
            ToolbarItem {
                Button("Info", systemImage: "info") {
                    modelData.selectedLandmark = landmark
                    modelData.isLandmarkInspectorPresented.toggle()
                }
                .accessibilityIdentifier("LandmarkDetail.toolbar.info.\(landmark.id)")
            }
        }
        .toolbar(removing: .title)
        .ignoresSafeArea(edges: .top)
        .accessibilityIdentifier("LandmarkDetail.scrollView.\(landmark.id)")
    }
}

private struct FavoriteButtonLabel: View {
    var isFavorite: Bool
    var body: some View {
        Label(isFavorite ? "Unfavorite" : "Favorite", systemImage: "heart")
            .symbolVariant(isFavorite ? .fill : .none)
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    let previewLandmark = modelData.landmarksById[1016] ?? modelData.landmarks.first!

    NavigationSplitView {
        List {
            Section {
                ForEach(NavigationOptions.mainPages) { page in
                    NavigationLink(value: page) {
                        Label(page.name, systemImage: page.symbolName)
                    }
                }
            }
        }
    } detail: {
        LandmarkDetailView(landmark: previewLandmark)
    }
    .inspector(isPresented: $modelData.isLandmarkInspectorPresented) {
        if let landmark = modelData.selectedLandmark {
            LandmarkDetailInspectorView(landmark: landmark, inspectorIsPresented: $modelData.isLandmarkInspectorPresented)
        } else {
            EmptyView()
        }
    }
    .environment(modelData)
    .onGeometryChange(for: CGSize.self) { geometry in
        geometry.size
    } action: {
        modelData.windowSize = $0
    }
}
