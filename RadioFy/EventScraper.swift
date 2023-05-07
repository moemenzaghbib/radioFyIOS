import Foundation
import SwiftSoup

struct Event {
    let title: String
    let date: String
    let desc: String
    let eventUrl: String
    let image: String
}

class EventScraper {
    func scrapeEvents() throws -> [Event] {
        let url = "https://www.shemsfm.net/fr/actualites/actualites-tunisie-news"
        let html = try String(contentsOf: URL(string: url)!)
        let doc: Document = try SwiftSoup.parse(html)

        let events = try doc.select("div.col-sm-12").select("div#showsList")

        let eventsSize = try events.select("div.row").size()

        var scrapedEvents = [Event]()

        for i in 0..<eventsSize {
            let title = try events.select("h2.title")
                .select("a")
                .eq(i)
                .text()
            let date = try events.select("div.date")
                .eq(i)
                .text()
            let desc = try events.select("p.intro")
                .eq(i)
                .text()
            let eventurlSpecf = try events.select("div.col-xs-5.col-sm-5.col-md-5.thumb")
                .select("a")
                .eq(i)
                .attr("href")
            let eventUrl = "https://www.shemsfm.net" + eventurlSpecf
            let imageSpecf =  try events.select("div.col-xs-5.col-sm-5.col-md-5.thumb")
                .select("a")
                .select("img")
                .eq(i)
                .attr("src")
            let image = "https://media.shemsfm.net/" + imageSpecf

            let event = Event(title: title, date: date, desc: desc, eventUrl: eventUrl, image: image)
            scrapedEvents.append(event)
        }

        return scrapedEvents
    }
}
