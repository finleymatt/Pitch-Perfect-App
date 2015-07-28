import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    init (filePathUrl: NSURL!, title: String!){
        
        self.filePathUrl = filePathUrl
        self.title = title
        
    }
}
