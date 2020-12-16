import SwiftUI

struct TextPill: View {
    let title: String
    let backgroundColor: Color
    let titleColor: Color

    var body: some View {
        Text(title)
            .font(.system(size: 14))
            .bold()
            .foregroundColor(titleColor)
            .padding(EdgeInsets(
                top: 0,
                leading: 8,
                bottom: 0,
                trailing: 8
            ))
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}

extension TextPill {
    static let core = TextPill(
        title: "Core",
        backgroundColor: .init(red: 0xD1 / 0xFF, green: 0xF7 / 0xFF, blue: 0xC4 / 0xFF),
        titleColor: .init(red: 0x44 / 0xFF, green: 0xBE / 0xFF, blue: 0x50 / 0xFF)
    )

    static let elective = TextPill(
        title: "Elective",
        backgroundColor: .init(hex: 0xFFEAB6),
        titleColor: .init(hex: 0xCF9641)
    )

    static let basicKnowledge = TextPill(
        title: "Basic Knowledge",
        backgroundColor: .init(hex: 0xD1C4F7),
        titleColor: .init(hex: 0x6B44BE)
    )

    static let completed = TextPill(
        title: "Completed",
        backgroundColor: .init(hex: 0xF7C4C4),
        titleColor: .init(hex: 0xBE4444)
    )

    static let novice = TextPill(
        title: "Novice",
        backgroundColor: .init(hex: 0xF7E3C4),
        titleColor: .init(hex: 0xBE7F44)
    )

    static let intermediate = TextPill(
        title: "Intermediate",
        backgroundColor: .init(hex: 0xC4E8F7),
        titleColor: .init(hex: 0x4475BE)
    )

    static let proficient = TextPill(
        title: "Proficient",
        backgroundColor: .init(hex: 0xC5C4F7),
        titleColor: .init(hex: 0x4450BE)
    )

    static let expert = TextPill(
        title: "Expert",
        backgroundColor: .init(hex: 0xF7C4F5),
        titleColor: .init(hex: 0xBE44B2)
    )
}

struct TextPill_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextPill.core
            TextPill.elective
            TextPill.basicKnowledge
            TextPill.completed
            TextPill.novice
            TextPill.intermediate
            TextPill.proficient
            TextPill.expert
        }
    }
}
