//
//  NyanCatCanvas.swift
//  touchbar_nyancat
//
//  Created by Aslan Vatsaev on 05/11/2016.
//  Copyright © 2016 AVatsaev. All rights reserved.
//

import Cocoa
import Swifter

class NyanCatCanvas: NSImageView {
    var timer:Timer? = nil
    var server = HttpServer()

    var imageLoaded:Bool = false;

    var xPosition: CGFloat = -680 {
        didSet {
            self.frame = CGRect(x: xPosition, y: 10, width: 680, height: 30)
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        
        self.animates = true
        
        //if(self.timer == nil) {
        //    timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.moveNyancat), userInfo: nil, repeats: true)
        //}

        if(!self.imageLoaded){
            self.downloadImage()
        }
        
        self.canDrawSubviewsIntoLayer = true
        self.frame = CGRect(x: xPosition, y: 10, width: 680, height: 30)
    }
    
    override func touchesBegan(with event: NSEvent) {
        // Calling super causes the cat to jump back to its original position 🤔
        //super.touchesBegan(with: event)
    }
    
    override func didAddSubview(_ subview: NSView) {
        
    }
    
    public func moveNyancat() {
        if (xPosition < 0) {
            xPosition += 1
        }
    }
    
    func updateProgress() -> ((HttpRequest) -> HttpResponse) {
        return { r in
            let progress : NSNumber? = NumberFormatter().number(from: r.params.first!.value)
            
            if progress != nil {
                // 6.8 is 680/100
                self.xPosition = -680 + 6.8 * CGFloat(progress!)
                
                return .ok(.html("Progress: \(self.xPosition)"))
            }else{
                return .ok(.html("No progress"))
            }
        }
    }
 
    func downloadImage() {
        
        let url = URL(string: "https://i.imgur.com/7pgdK28.gif")

        getDataFromUrl(url: url!) { (data, response, error)  in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async() { () -> Void in
                self.image = NSImage(data: data)
                self.imageLoaded = true;
            }
        }
        
        server["/progress/:progress"] = updateProgress()
        do {
            try server.start(12345)
        } catch {
            print(error)
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
}
