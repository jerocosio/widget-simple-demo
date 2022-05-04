//
//  AeromexicoWidget.swift
//  AeromexicoWidget
//
//  Created by Jeronimo Cosio on 03/05/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct AeromexicoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack{
            HStack{
                Image("aeromexico-logo").resizable()
                    .scaledToFit().frame(width: 30, height: 30)
                Spacer()
                HStack{
                    Circle().fill(Color.green).frame(width: 10, height: 10)
                    Text("On time")
                        .font(.footnote)
                        .bold()
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/).foregroundColor(.green)
                }
            }
            Spacer()
            HStack{
                VStack{
                    Text("MEX").font(.title3).fontWeight(.bold).foregroundColor(.white).bold()
                    Text("8th May").font(.caption2).foregroundColor(Color.gray)
                    Text("9:45").font(.caption2).foregroundColor(Color.gray)
                    
                }
                Spacer()
                Image("white-arrow").resizable()
                    .scaledToFit().frame(width: 75, height: 30)
                Spacer()
                VStack{
                    Text("MEX").font(.title3).fontWeight(.bold).foregroundColor(.white).bold()
                    Text("8th May").font(.caption2).foregroundColor(Color.gray)
                    Text("9:45").font(.caption2).foregroundColor(Color.gray)
                }
                VStack{
                    Text("64")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    Text("Gate")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                    Text("12 A")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    Text("Seat")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                }
                .padding(.leading)
            }
        }
        .padding(.all)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.014, green: 0.16, blue: 0.333)/*@END_MENU_TOKEN@*/)
    }
}

@main
struct AeromexicoWidget: Widget {
    let kind: String = "AeromexicoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            AeromexicoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Aermexico Flights")
        .description("Get the latest detailed information for your Aermexico Flights.")
    }
}

struct AeromexicoWidget_Previews: PreviewProvider {
    static var previews: some View {
        AeromexicoWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
