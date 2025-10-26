/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that lets a person edit a collection's title, description, and list of landmarks.
*/

import SwiftUI

/// A view that lets a person edit a collection's title, description, and list of landmarks.
struct CollectionDetailEditingView: View {
    
    @Bindable var collection: LandmarkCollection
    @Binding var isShowingLandmarksSelection: Bool
    @Binding var isShowingDeleteConfirmation: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Title")
                Spacer()
            }
            .foregroundColor(.secondary)
            .font(.title2)
            .fontWeight(.semibold)
            // Adjust the vertical padding due to the TextEditor.
            .padding(.bottom, collection.isFavoritesCollection ? 0 : -2)
            .padding([.top])
            .accessibilityIdentifier("CollectionEdit.title.header")
            
            VStack {
                if collection.isFavoritesCollection {
                    HStack {
                        Text(collection.name)
                            .font(.largeTitle)
                            .accessibilityIdentifier("CollectionEdit.title.readonly.\(collection.id)")
                        Spacer()
                    }
                    .padding()
                    .accessibilityIdentifier("CollectionEdit.title.readonly.row")
                } else {
                    TextField("Name", text: $collection.name)
                        .padding()
                        .textFieldStyle(.plain)
                        .accessibilityIdentifier("CollectionEdit.title.textField.\(collection.id)")
                }
            }
            .background(Constants.editingBackgroundStyle, in: RoundedRectangle(cornerRadius: Constants.cornerRadius))
            .accessibilityIdentifier("CollectionEdit.title.container")
            
            HStack {
                Text("Description")
                Spacer()
            }
            .foregroundColor(.secondary)
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.bottom, -2) // Adjust the vertical padding due to the TextEditor.
            .padding([.top])
            .accessibilityIdentifier("CollectionEdit.description.header")
            
            if !collection.isFavoritesCollection {
                VStack() {
                    TextEditor(text: $collection.description)
                        .scrollContentBackground(.hidden)
                        .frame(height: Constants.textEditorHeight)
                        .padding()
                        .accessibilityIdentifier("CollectionEdit.description.textEditor.\(collection.id)")
                }
                .background(Constants.editingBackgroundStyle, in: RoundedRectangle(cornerRadius: Constants.cornerRadius))
                .accessibilityIdentifier("CollectionEdit.description.container")
            }
            
            HStack {
                Text("Landmarks")
                Spacer()
            }
            .foregroundColor(.secondary)
            .font(.title2)
            .fontWeight(.semibold)
            .padding([.top])
            .accessibilityIdentifier("CollectionEdit.landmarks.header")
            
            VStack {
                HStack {
                    Spacer()
                    Button("Select") {
                        isShowingLandmarksSelection.toggle()
                    }
                    .padding([.top, .leading, .trailing])
                    .accessibilityIdentifier("CollectionEdit.landmarks.selectButton")
                }
                LandmarksGrid(landmarks: $collection.landmarks, forEditing: true)
                    .padding([.leading, .trailing, .bottom])
                    .accessibilityIdentifier("CollectionEdit.landmarks.grid.\(collection.id)")
            }
            .background(Constants.editingBackgroundStyle, in: RoundedRectangle(cornerRadius: Constants.cornerRadius))
            .accessibilityIdentifier("CollectionEdit.landmarks.container")
        }
        .padding([.leading, .trailing], Constants.leadingContentInset)
        .accessibilityIdentifier("CollectionEdit.root.\(collection.id)")
        
    }
}

#Preview {
    let modelData = ModelData()
    let previewCollection = modelData.userCollections.last!

    CollectionDetailEditingView(collection: previewCollection,
                                isShowingLandmarksSelection: .constant(false),
                                isShowingDeleteConfirmation: .constant(false))
}

