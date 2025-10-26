/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view with a toggle button that shows or hides earned badges in a vertical layout.
*/

import SwiftUI

/// A view with a toggle button that shows or hides earned badges in a vertical layout.
struct BadgesView: View {
    @Environment(ModelData.self) private var modelData
    @State private var isExpanded: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        // Organizes the badges and toggle button to animate together.
        GlassEffectContainer(spacing: Constants.badgeGlassSpacing) {
            VStack(alignment: .center, spacing: Constants.badgeButtonTopSpacing) {
                if isExpanded {
                    VStack(spacing: Constants.badgeSpacing) {
                        ForEach(modelData.earnedBadges) {
                            BadgeLabel(badge: $0)
                                // Adds Liquid Glass to the badge.
                                .glassEffect(.regular, in: .rect(cornerRadius: Constants.badgeCornerRadius))
                                // Adds an identifier to the badge for animation.
                                .glassEffectID($0.id, in: namespace)
                                // Accessibility identifier for each badge image.
                                .accessibilityIdentifier("BadgesView.badge.\($0.id)")
                        }
                    }
                    .accessibilityIdentifier("BadgesView.badgeStack")
                }

                Button {
                    // Animates this button and badges when `isExpanded` changes values.
                    withAnimation {
                        isExpanded.toggle()
                    }
                } label: {
                    ToggleBadgesLabel(isExpanded: isExpanded)
                        .frame(width: Constants.badgeShowHideButtonWidth,
                               height: Constants.badgeShowHideButtonHeight)
                }
                // Adds Liquid Glass to the button.
                .buttonStyle(.glass)
                #if os(macOS)
                .tint(.clear)
                #endif
                // Adds an identifier to the button for animation.
                .glassEffectID("togglebutton", in: namespace)
                .accessibilityIdentifier("BadgesView.toggleButton")
            }
            .frame(width: Constants.badgeFrameWidth)
            .accessibilityIdentifier("BadgesView.containerStack")
        }
        .accessibilityIdentifier("BadgesView.glassContainer")
    }
}

private struct BadgeLabel: View {
    var badge: Badge
    var body: some View {
        Image(systemName: badge.symbolName)
            .foregroundStyle(.white)
            .font(.system(size: badge.fontSize()))
            .fontWeight(.medium)
            .frame(width: Constants.badgeSize, height: Constants.badgeSize)
            .background(content: {
                Image(systemName: "hexagon.fill")
                    .foregroundStyle(badge.badgeColor)
                    .font(.system(size: Constants.hexagonSize))
                    .frame(width: Constants.badgeSize,
                           height: Constants.badgeSize)
            })
            .padding(Constants.badgeImagePadding)
            .accessibilityLabel(Text(badge.badgeName))
            .accessibilityIdentifier("BadgeLabel.image.\(badge.id)")
    }
}

private struct ToggleBadgesLabel: View {
    var isExpanded: Bool
    var body: some View {
        Label(isExpanded ? "Hide Badges" : "Show Badges",
            systemImage: isExpanded ? "xmark" : "hexagon.fill")
        .foregroundStyle(Color("badgeShowHideColor"))
        .labelStyle(.iconOnly)
        .font(.system(size: Constants.toggleButtonFontSize))
        .fontWeight(.medium)
        .imageScale(.large)
        .accessibilityIdentifier("BadgesView.toggleLabel.\(isExpanded ? "hide" : "show")")
    }
}

#Preview {
    @Previewable @State var model = ModelData()
    BadgesView()
        .environment(model)
        .accessibilityIdentifier("BadgesView.previewRoot")
}

/// A view modifier that places ``BadgesView`` over a modified view, in the lower trailing corner.
private struct ShowsBadgesViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            content
                .accessibilityIdentifier("ShowsBadgesViewModifier.content")
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    BadgesView()
                        .padding()
                        .accessibilityIdentifier("ShowsBadgesViewModifier.badgesView")
                }
            }
            .accessibilityIdentifier("ShowsBadgesViewModifier.overlayStack")
        }
        .accessibilityIdentifier("ShowsBadgesViewModifier.root")
    }
}

// MARK: - View Extensions

extension View {
    /// A function that returns a view after it applies `ShowBadgesViewModifier` to it.
    func showsBadges() -> some View {
        modifier(ShowsBadgesViewModifier())
    }
}

