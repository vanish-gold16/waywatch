//
//  Theme.swift
//  waywatch
//
//  Style theme for the whole application
//
import SwiftUI

enum Waywatch {
    
    // MARK: - Color
    
    enum Palette {
        
        // MARK: - Accent

        /// main accent color: buttons, tab bar, links, progress
        static let primary = Color(light: 0xD95A12, dark: 0xFF8A3D)
        /// text and icons placed on top of `primary`
        static let onPrimary = Color(light: 0xFFFFFF, dark: 0x1B0F06)
        /// tinted background for selected chips, filters, highlighted rows
        static let primarySoft = Color(light: 0xFBE6D8, dark: 0x3A2416)

        // MARK: - Background

        /// screen background
        static let background = Color(light: 0xF6F5F2, dark: 0x0E0F13)
        /// cards, list rows, sheets
        static let surface = Color(light: 0xFFFFFF, dark: 0x181A20)
        /// search field, segmented controls, poster placeholder
        static let surfaceSecondary = Color(light: 0xEDECE8, dark: 0x22252D)
        /// dividers and card borders
        static let separator = Color(light: 0xDEDCD6, dark: 0x2C2F38)
        /// gradient under text placed on posters and backdrops
        static let scrim = Color(hex: 0x000000, alpha: 0.65)

        // MARK: - Text

        /// titles, main text
        static let textPrimary = Color(light: 0x16171B, dark: 0xF2F2F4)
        /// year, genres, runtime
        static let textSecondary = Color(light: 0x5D606B, dark: 0xA3A7B3)
        /// placeholders, disabled states
        static let textTertiary = Color(light: 0x8E919B, dark: 0x6B6F7B)

        // MARK: - Watch status

        /// plan to watch
        static let statusPlanned = Color(light: 0x6E56CF, dark: 0xA08BFF)
        /// currently 
        static let statusProcessing = Color(light: 0x1F9D55, dark: 0x3DDC84)
        /// completed
        static let statusCompleted = Color(light: 0x2F6FDB, dark: 0x5B9BFF)
        /// on hold
        static let statusOnHold = Color(light: 0xB7791F, dark: 0xF5B83D)
        /// dropped, also used for destructive actions
        static let statusDropped = Color(light: 0xD64545, dark: 0xFF6B6B)

        // MARK: - Misc

        /// rating stars
        static let rating = Color(light: 0xD49A00, dark: 0xFFC94D)
    }
    
    // MARK: - Spacing
    
    /// 4pt step, named by size rather than purpose: the same gap shows up both
    /// between cards and inside a row.
    enum Space {
        static let x1: CGFloat = 4
        static let x2: CGFloat = 8
        static let x3: CGFloat = 12
        static let x4: CGFloat = 16
        static let x5: CGFloat = 20
        static let x6: CGFloat = 24
        static let x7: CGFloat = 32
        static let x8: CGFloat = 40
    }
    
    // MARK: - Radii
    
    enum Radius {
        /// badges
        static let sm: CGFloat = 8
        
        /// buttons and inputs
        static let md: CGFloat = 12
        
        /// cards
        static let lg: CGFloat = 16
        
        /// sheets
        static let xl: CGFloat = 24
    }
    
    /// The single margin between content and the screen edge.
    static let gutter: CGFloat = 16
    
}

// MARK: — Hex from the web without converting by hand

extension Color {
    /// Creates a color from a hex value such as `0xF27A24`, with an optional alpha.
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
    
    init(light: UInt, dark: UInt) {
        self.init(uiColor: UIColor { traits in
            UIColor(traits.userInterfaceStyle == .dark ? Color(hex: dark) : Color(hex: light))
        })
    }
    
}

private struct PaletteSwatches: View {
    private typealias P = Waywatch.Palette

    private let swatches: [(String, Color)] = [
        ("primary", P.primary), ("primarySoft", P.primarySoft),
        ("surface", P.surface), ("surfaceSecondary", P.surfaceSecondary),
        ("planned", P.statusPlanned), ("watching", P.statusProcessing),
        ("completed", P.statusCompleted), ("onHold", P.statusOnHold),
        ("dropped", P.statusDropped), ("rating", P.rating),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Dune: Part Two")
                .font(.title2.bold())
                .foregroundStyle(P.textPrimary)
            Text("2024 · Sci-Fi · 2h 46m")
                .foregroundStyle(P.textSecondary)
            Text("Add a note…")
                .foregroundStyle(P.textTertiary)
            Text("Add to Watchlist")
                .font(.headline)
                .foregroundStyle(P.onPrimary)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(P.primary, in: .capsule)

            ForEach(swatches, id: \.0) { name, color in
                HStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(color)
                        .stroke(P.separator)
                        .frame(width: 44, height: 24)
                    Text(name)
                        .foregroundStyle(P.textSecondary)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(P.background)
    }
}

#Preview("Light") {
    PaletteSwatches()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    PaletteSwatches()
        .preferredColorScheme(.dark)
}
