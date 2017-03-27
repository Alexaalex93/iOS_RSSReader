//
//  FeedParser.swift
//  SimpleRSSReader
//
//  Created by cice on 27/3/17.
//  Copyright © 2017 355 Berry Street. All rights reserved.
//

import UIKit

class FeedParser: NSObject, XMLParserDelegate {

    var rssItems: [(title:String, description: String, pubDate: String)] = []
    var currentElement = ""
    
    var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentDescription = "" {
        didSet{
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentPubDate = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    var parserCompletionHandler: (([(title: String, description: String, pubdate: String)]) -> Void)?
    
    func parseFeed(feedUrl: String, completionHandler: (([(title: String, description: String, pubdate: String)]) -> Void)?) -> Void {
        
        self.parserCompletionHandler = completionHandler
        let request = URLRequest(url: URL(string: feedUrl)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request){ (data, response, error) in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
            return
            }
        //Parseamos el xml
        let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        rssItems = []
    }
    
    //Funcion que se llama cunado empieza a parsear un elemento
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "title" {
        currentTitle = ""
        currentPubDate = ""
        currentDescription = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        
        switch currentElement { //Tags del xml
        case "title":
            currentElement += string
        case "description":
            currentDescription += string
        case "pubDate":
            currentPubDate += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = (title: currentTitle, description: currentDescription, pubDate: currentPubDate)
            rssItems += [rssItem]
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems as! [(title: String, description: String, pubdate: String)])
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
    
}
