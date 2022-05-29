//

import SwiftUI

//@available(iOS 14.0, *)

struct EmotionDetail: Identifiable, Hashable{
    var id = UUID()
    let emotions: String
    let emotionsCount: Int
    let emotionColor: Color
    let emoji: String
}

struct DashboardView: View {
    
    @AppStorage("Happy") var happyCount: Int = 0
    @AppStorage("Sad") var sadCount: Int = 0
    @AppStorage("Disgust") var disgustCount: Int = 0
    @AppStorage("Neutral") var neutralCount: Int = 0
    @AppStorage("Surprise") var surpriseCount: Int = 0
    @AppStorage("Fear") var fearCount: Int = 0
    @AppStorage("Angry") var angryCount: Int = 0
    
    let userEmotionDetails = [
        EmotionDetail(emotions: "Happy", emotionsCount: 1, emotionColor: .yellow, emoji: "😀"),
        EmotionDetail(emotions: "Sad", emotionsCount: 0, emotionColor: .blue, emoji: "☹️"),
        EmotionDetail(emotions: "Disgust", emotionsCount: 0, emotionColor: .green, emoji: "😫"),
        EmotionDetail(emotions: "Neutral", emotionsCount: 1, emotionColor: .brown, emoji: "😐"),
        EmotionDetail(emotions: "Surprise", emotionsCount: 2, emotionColor: .orange, emoji: "😮"),
        EmotionDetail(emotions: "Fear", emotionsCount: 6, emotionColor: .purple, emoji: "😨"),
        EmotionDetail(emotions: "Angry", emotionsCount: 0, emotionColor: .red, emoji: "😡"),
    ]
    
    var total = 7
    let columns = [
        GridItem(.fixed(UIScreen.main.bounds.width/2 - 15), spacing: 15),
        GridItem(.fixed(UIScreen.main.bounds.width/2 - 15), spacing: 15)
    ]
    var emotions: [String] = ["Happy", "Sad", "Angry", "Fear", "Surprise", "Neutral", "Disgust"]
    var emotionCounts: [Int] {
        [happyCount, sadCount, angryCount, fearCount, surpriseCount, neutralCount, disgustCount]
    }
//    var indexes: [Int] = [0, 1, 2, 3, 4, 5, 6]
    var colours: [Color] = [Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.490196079, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.0112339483, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8131402526, green: 0, blue: 0.7656604921, alpha: 1)), Color(#colorLiteral(red: 0.9607843161, green: 0.5402659535, blue: 0.02331045362, alpha: 1)), Color(#colorLiteral(red: 0.6354643879, green: 0.400150011, blue: 0.1502078149, alpha: 1)), Color(#colorLiteral(red: 0.3352483009, green: 0.9607843161, blue: 0.1836980005, alpha: 1))]
//
    var emojis: [String] = ["😀", "☹️", "😡", "😨", "😮", "😐", "😫"]
    
    var maxCount: Int {
        emotionCounts.max() ?? 0
    }
    
//    var colorMax: Color {
//        if maxCount == 0 {
//            return Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
//        } else {
//            if let index = emotionCounts.firstIndex(of: maxCount) {
//                return colours[index]
//            } else {
//                return Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
//            }
//        }
//    }
    
    var emojiMax: String {
        if maxCount == 0 {
            return ""
        } else {
            if let index = emotionCounts.firstIndex(of: maxCount) {
                return emojis[index]
            } else {
                return ""
            }
        }
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            ScrollView(.vertical, showsIndicators: false){
                HStack{
                    Text("Dashboard \(emojiMax)")
                        .bold()
                        .font(Font.system(size: 25))
                    Spacer()
                    Text("\(userEmotionDetails.count)")
                        .font(Font.system(size: 20))
                }
                .padding()
                .foregroundColor(.red)
                
                LazyVGrid(columns: columns) {
                    ForEach(userEmotionDetails, id: \.self) {detail in
                        UserEmotionDetailView(detail: detail)
                    }
                }
            }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .preferredColorScheme(.dark)
    }
    }
    
    
    
}
struct UserEmotionDetailView:View{
    let detail:EmotionDetail
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width/2 - 15, height: UIScreen.main.bounds.width/1.5)
            
            VStack{
                HStack{
                    Text(detail.emotions)
                        .bold()
                        .font(Font.system(size: 25))
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.horizontal, 0)
                
                Spacer()
                
                VStack(alignment: .center){
                    EmotionCircleIndicator(detail: detail)
                    
                    Spacer()
                    
                    Text("\(detail.emotionsCount)")
                        .bold()
                        .font(Font.system(size: 25))
                        .foregroundColor(.white)
                }.padding(.top)
                
            }.padding()
        }
        .padding(.horizontal)
    }
}
struct EmotionCircleIndicator:View{
    let detail:EmotionDetail
    
    var body: some View{
        ZStack{
            Circle()
                .trim(from: 0, to: 1)
                .stroke(detail.emotionColor.opacity(0.35), lineWidth: 10)
                .frame(width: UIScreen.main.bounds.width / 2 - 15 - 50, height: UIScreen.main.bounds.width / 2 - 15 - 50)
            
            Circle()
                .trim(from: 0, to: Double(detail.emotionsCount) / 7.0)
                .stroke(detail.emotionColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .frame(width: UIScreen.main.bounds.width / 2 - 15 - 50, height: UIScreen.main.bounds.width / 2 - 15 - 50)
                .rotationEffect(Angle(degrees: -90))
            
            Text(getEmotionMoodPercentage()+"%")
                .bold()
                .font(Font.system(size: 30))
                .foregroundColor(detail.emotionColor)
        }
    }
    
    func getEmotionMoodPercentage() -> String{
        if detail.emotionsCount == 0{
            return "0"
        }
        
        let frac = Double(detail.emotionsCount) / 7.0
        let per = frac * 100
        return String(format: "%.1f", per)
    }
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}



