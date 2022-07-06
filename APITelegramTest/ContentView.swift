//
//  ContentView.swift
//  APITelegramTest
//
//  Created by Дмитрий Спичаков on 06.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: PROPERTIES
    
    @State var message = ""
    
    // MARK: BODY
    
    var body: some View {
        VStack {
            TextField("Enter your message for telegram", text: $message)
            Button {
                sendMessage()
            } label: {
                Text("SEND MESSAGE")
            }
        }
        .padding(60)
    }
    
    // MARK: SEND MESSAGE FUNC
    
    func sendMessage() {
        let headers = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        let parameters: [String: Any] = [
            // Dynamic message from textField
            "text": message,
            "disable_web_page_preview": false,
            "disable_notification": false,
            // Your chat id (you can find it in @JsonDumpBot)
            "chat_id": ""
        ]
        // Replace (YourBotToken) with bot token from @BotFather
        let request = NSMutableURLRequest(url: NSURL(
            string: "https://api.telegram.org/bot(YourBotToken)/sendMessage")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let session = URLSession.shared
        let dataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "error")
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse ?? "error")
            }
        })
        dataTask.resume()
    }
}

// MARK: PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

