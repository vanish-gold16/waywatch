//
//  TicketShape.swift
//  waywatch
//
//
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

struct TicketPerforation: Shape {
    var perforation: CGFloat = 0.72
    var notchRadius: CGFloat = 10
    
    func path(in rect: CGRect) -> Path {
        let x = rect.minX + rect.width * perforation
        
        var path = Path()
        path.move(to: CGPoint(x: x, y: rect.minY + notchRadius))
        path.addLine(to: CGPoint(x: x, y: rect.maxY - notchRadius))
        return path
    }
}

#Preview("Light") {
        TicketShape()
            .fill(Waywatch.Palette.primarySoft)
            .overlay {
                TicketPerforation()
                    .stroke(Waywatch.Palette.primary, style: StrokeStyle(lineWidth: 1.5, dash: [4, 4]))
            }
            .background(Waywatch.Palette.background)
            .frame(width: 340, height: 120)
            .padding()
            .preferredColorScheme(.light)
}

#Preview("Dark") {
        TicketShape()
            .fill(Waywatch.Palette.primarySoft)
            .overlay {
                TicketPerforation()
                    .stroke(Waywatch.Palette.primary, style: StrokeStyle(lineWidth: 1.5, dash: [4, 4]))
            }
            .background(Waywatch.Palette.background)
            .frame(width: 340, height: 120)
            .padding()
            .preferredColorScheme(.dark)
}
