//
//  TicketShape.swift
//  waywatch
//
//  Created by Vanya on 26.10.2026.
//
import SwiftUI

struct TicketShape: Shape {
    var perforation: CGFloat = 0.72
    var notchRadius: CGFloat = 10
    
    func path(in rect: CGRect) -> Path {
        let body = RoundedRectangle(cornerRadius: Waywatch.Radius.md).path(in: rect)
        let x = rect.minX + rect.width * perforation
        
        // circles
        //
        // x, y - locations in rectangle (body)
        // width, height - circle sizings
        let top = Circle().path(in: CGRect(
            x: x - notchRadius,
            y: rect.minY - notchRadius,
            width: notchRadius * 2,
            height: notchRadius * 2
        ))
        let bottom = Circle().path(in: CGRect(
            x: x - notchRadius,
            y: rect.maxY - notchRadius,
            width: notchRadius * 2,
            height: notchRadius * 2
        ))
        
        return body.subtracting(top).subtracting(bottom)
    }
}

#Preview("Light") {
        TicketShape()
            .fill(Waywatch.Palette.primarySoft)
            .frame(width: 340, height: 120)
            .padding()
            .preferredColorScheme(.light)
}

#Preview("Dark") {
        TicketShape()
            .fill(Waywatch.Palette.primarySoft)
            .frame(width: 340, height: 120)
            .padding()
            .preferredColorScheme(.dark)
}
