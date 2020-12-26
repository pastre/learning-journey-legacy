import SwiftUI

extension Color {
    enum LearningJourney {
        static let gray = Color(hue: 0, saturation: 0, brightness: 0.9)
        static let darkGray = Color(hue: 0, saturation: 0, brightness: 0.47)
        static let green = Color(hue: 126, saturation: 0.64, brightness: 0.75)
        static let lightGreen = Color(hue: 105, saturation: 0.21, brightness: 0.97)
        
        
        
        enum Green {
            static let light = Color(hue: 105/360, saturation: 0.21, brightness: 0.97)
            static let dark = Color(hue: 126/360, saturation: 0.64, brightness: 0.75)
        }
        enum Orange {
            static let light = Color(hue: 29/360, saturation: 0.21, brightness: 0.97)
            static let dark = Color(hue: 36/360, saturation: 0.64, brightness: 0.75)
        }
        enum Blue {
            static let light = Color(hue: 198/360, saturation: 0.21, brightness: 0.97)
            static let dark = Color(hue: 216/360, saturation: 0.64, brightness: 0.75)
        }
        
        enum Purple {
            static let light = Color(hue: 241/360, saturation: 0.21, brightness: 0.97)
            static let dark = Color(hue: 234/360, saturation: 0.64, brightness: 0.75)
        }
        
        enum Pink {
            static let light = Color(hue: 302/360, saturation: 0.21, brightness: 0.97)
            static let dark = Color(hue: 306/360, saturation: 0.64, brightness: 0.75)
        }
    }
}

struct PillColorScheme: Equatable {
    let backgroundColor: Color
    let color: Color
}

extension PillColorScheme {
    static let done = PillColorScheme(
        backgroundColor: Color.LearningJourney.Green.light,
        color: Color.LearningJourney.Green.dark
    )
    
    static let disabled = PillColorScheme(
        backgroundColor: Color.LearningJourney.gray,
        color: Color.LearningJourney.darkGray
    )
    
    static let novice = PillColorScheme(
        backgroundColor: Color.LearningJourney.Orange.light,
        color: Color.LearningJourney.Orange.dark
    )
    static let intermediate = PillColorScheme(
        backgroundColor: Color.LearningJourney.Blue.light,
        color: Color.LearningJourney.Blue.dark
    )
    static let proficient = PillColorScheme(
        backgroundColor: Color.LearningJourney.Purple.light,
        color: Color.LearningJourney.Purple.dark
    )
    static let expert = PillColorScheme(
        backgroundColor: Color.LearningJourney.Pink.light,
        color: Color.LearningJourney.Pink.dark
    )
    
    
}
