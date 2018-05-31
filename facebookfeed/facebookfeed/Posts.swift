//
//  Posts.swift
//  facebookfeed
//
//  Created by andyron<http://andyron.com> on 2018/5/31.
//  Copyright © 2018年 andyron. All rights reserved.
//

import Foundation


class Post {
    var name: String?
    var profileImageName: String?
    var statusText: String?
    var statusImageName: String?
    var numLikes: Int?
    var numComments: Int?
    
    var statusImageUrl: String?
}

class Posts {
    private var postsList = [Post]()
    
    init() {
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        postMark.statusText = "By giving people the power to share, we're making the world more transparent."
        postMark.profileImageName = "zuckprofile"
        postMark.statusImageName = "zuckdog"
        postMark.numLikes = 234
        postMark.numComments = 23
        postMark.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/mark_zuckerberg_background.jpg"
        
        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.statusText = "Desing is not just what it looks like and feels like. Desing is how it works.\n\n"
            + "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying"
            + "we've done something wonderful, that's what matters to me.\n\n"
            + "Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and"
            + " get on with improving your other innovations."
        postSteve.profileImageName = "steveprofile"
//        postSteve.statusImageName = "steve_status"
        postSteve.numLikes = 1010
        postSteve.numComments = 345
        postSteve.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/steve_jobs_background.jpg"

        
        let postGandhi = Post()
        postGandhi.name = "Mahatma Gandhi"
        postGandhi.statusText = "Mohandas Karamchand Gandhi was an Indian activist who was the leader of the Indian independence movement against British rule."
        postGandhi.profileImageName = "gandhiprofile"
//        postGandhi.statusImageName = "gandhi_status"
        postGandhi.numLikes = 678
        postGandhi.numComments = 231
        postGandhi.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/gandhi_status.jpg"

        let postBillGates = Post()
        postBillGates.name = "Bill Gates"
        postBillGates.profileImageName = "bill_gates_profile"
        postBillGates.statusText = "Success is a lousy teacher. It seduces smart people into thinking they can't lose.\n\n" +
            "Your most unhappy customers are your greatest source of learning.\n\n" +
        "As we look ahead into the next century, leaders will be those who empower others."
        postBillGates.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/gates_background.jpg"
        
        let postTimCook = Post()
        postTimCook.name = "Tim Cook"
        postTimCook.profileImageName = "tim_cook_profile"
        postTimCook.statusText = "The worst thing in the world that can happen to you if you're an engineer that has given his life to something is for someone to rip it off and put their name on it."
        postTimCook.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/Tim+Cook.png"
        
        let postDonaldTrump = Post()
        postDonaldTrump.name = "Donald Trump"
        postDonaldTrump.profileImageName = "donald_trump_profile"
        postDonaldTrump.statusText = "An ‘extremely credible source’ has called my office and " +
        "told me that Barack Obama’s birth certificate is a fraud."
        postDonaldTrump.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/trump_background.jpg"
        
        postsList = [postDonaldTrump, postGandhi, postSteve, postBillGates, postTimCook, postMark]
    }
    
    func numberOfPosts() -> Int {
        return postsList.count
    }
    
    subscript(indexPath: IndexPath) -> Post {
        return postsList[indexPath.row]
    }
}
