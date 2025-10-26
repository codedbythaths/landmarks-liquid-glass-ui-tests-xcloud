/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that establishes split view navigation for the app.
*/

import SwiftUI

/// A view that establishes split view navigation for the app.
struct LandmarksSplitView: View {
    @Environment(ModelData.self) var modelData
    @State private var preferredColumn: NavigationSplitViewColumn = .detail

    var body: some View {
        @Bindable var modelData = modelData
        
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            List {
                Section {
                    ForEach(NavigationOptions.mainPages) { page in
                        NavigationLink(value: page) {
                            Label(page.name, systemImage: page.symbolName)
                                .accessibilityIdentifier("SplitView.sidebar.row.\(page.id)")
                        }
                        .accessibilityIdentifier("SplitView.sidebar.link.\(page.id)")
                    }
                }
                .accessibilityIdentifier("SplitView.sidebar.section.mainPages")
            }
            .navigationDestination(for: NavigationOptions.self) { page in
                NavigationStack(path: $modelData.path) {
                    page.viewForPage()
                        .accessibilityIdentifier("SplitView.sidebar.pageContent.\(page.id)")
                }
                .navigationDestination(for: Landmark.self) { landmark in
                    LandmarkDetailView(landmark: landmark)
                        .accessibilityIdentifier("SplitView.sidebar.landmarkDetail.\(landmark.id)")
                }
                .navigationDestination(for: LandmarkCollection.self) { collection in
                    CollectionDetailView(collection: collection)
                        .accessibilityIdentifier("SplitView.sidebar.collectionDetail.\(collection.id)")
                }
                .showsBadges()
                .accessibilityIdentifier("SplitView.sidebar.navigationStack")
            }
            .frame(minWidth: 150)
            .accessibilityIdentifier("SplitView.sidebar.list")
        } detail: {
            NavigationStack(path: $modelData.path) {
                NavigationOptions.landmarks.viewForPage()
                    .accessibilityIdentifier("SplitView.detail.rootPage.landmarks")
            }
            .navigationDestination(for: Landmark.self) { landmark in
                LandmarkDetailView(landmark: landmark)
                    .accessibilityIdentifier("SplitView.detail.landmarkDetail.\(landmark.id)")
            }
            .showsBadges()
            .accessibilityIdentifier("SplitView.detail.navigationStack")
        }
        // Adds global search, where the system positions the search bar automatically
        // in content views.
        .searchable(text: $modelData.searchString, prompt: "Search")
        // Adds the inspector, which the landmark detail view uses to display
        // additional information.
        .inspector(isPresented: $modelData.isLandmarkInspectorPresented) {
            if let landmark = modelData.selectedLandmark {
                LandmarkDetailInspectorView(landmark: landmark, inspectorIsPresented: $modelData.isLandmarkInspectorPresented)
                    .accessibilityIdentifier("SplitView.inspector.landmarkDetail.\(landmark.id)")
            } else {
                EmptyView()
                    .accessibilityIdentifier("SplitView.inspector.empty")
            }
        }
        .accessibilityIdentifier("SplitView.root")
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()

    LandmarksSplitView()
        .environment(modelData)
        .onGeometryChange(for: CGSize.self) { geometry in
            geometry.size
        } action: {
            modelData.windowSize = $0
        }
}
