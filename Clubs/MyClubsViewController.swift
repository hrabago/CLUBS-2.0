import UIKit
import Parse
import ParseUI

class MyClubsViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
  
    
    var clubEventPosts: [PFObject]!
    
    var clubNameArray: [String]!
    var clubDescriptionArray: [String]!
    var clubLocationArray: [String]!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
        clubNameArray = ["Computer Science Society", "Autism Speaks U", "Campus Activities Board", "Contemporary Sciecne Fiction", "Codepath", "Ampersand", "Asili", "Acedmia Hispana", "Astronomy Club", "Ballroom Dancing", "College Republicans", "Economics SOciety", "Gamers United", "Jewish Student Organization", "Korean Studenta Association", "The Ram", "Special Olympics Club at Fordham", "Robotics Club", "Psychology Club", "Model UN", "Mimers and Mummers"]
        clubDescriptionArray = ["The Computing Sciences Society is an academic club aimed at bringing together students interested in technology with their peers, professors, research projects, and experimental hardware. The club educates students about the field of computer science and its application in society. Also, the club will give assistance to students interested in computer science and related fields as they prepare for their transition from college to a career.", "Our mission is to help raise funds, advocacy, and awareness for autism, a neurological condition that affects about 1 in every 68 children in the US, 1 in 42 boys. In our efforts to raise awareness and educate the public about autism, we will be holding fundraising events both on campus and around NYC. 100% of the profits we receive go to the Autism Speaks foundation to help fund both research pertaining to autism and advocacy for autistic children all over the country.", "CAB is the primary programming entity on the Rose Hill Campus. We bring you both small and large scale events to make your life at Fordham an exciting one. Our mission is to provide high quality social, cultural, educational and informational programming that appeals to all interests within the student community. CAB consists of 9 committees plus a General Board that each handles specific areas of programming to bring you the best variety of fun. ", "Contemporary Science Fiction, also known as CSF, is a social club in which people interested in science fiction, Japanese animation, video games, and social gaming can meet to discuss and share these interests with fellow, like-minded individuals.", "the Ampersand is an umbrella organization that encompasses projects such as The Ampersand (Fordham's student-run literary magazine), The Vagabond (monthly supplement of student work). The club's primary aim is to create, maintain, and promote a forum in which the Fordham student body can express itself through poetry, prose, short stories, spoken work, photography, and artwork.", "ASILI - the black student alliance at Fordham, is a lot more than a club, we're a family. We assume responsibilities for academic and cultural representation of underrepresented students at Fordham, however we invite everyone from all sides of the spectrum to become a member. We're diverse, always welcome new members and host unforgettable events. If you're interested in expanding your cultural horizons through great events and discussions, with great people who know how to have a good time, then ASILI is for you. Peace and love, ASILI", "Academia Hispana is one of the Hispanic/Latino-focused organizations in Fordham University. Through meetings, events, fundraisers, and volunteer opportunities, we hope to promote interest, awareness, and understanding of the issues pertinent to the Hispanic community on campus, in the US, and abroad. Academia is open to all members of the Fordham community. We invite students, faculty, and staff of all backgrounds to join in our events and meetings. No matter what your knowledge/familiarity with the topics covered, Academia is a space for you to share your opinions, ideas, experiences, and questions.", "The Fordham Astronomy club is a group of friends dedicated to pursuing the hobby of astronomy and furthering our collective knowlege of the stars on Fordham's campus.", "Ballroom Dance is a social club that wishes to educate people in Ballroom Dance! We teach many styles of Ballroom dance including Latin and Rhythm. At any given lesson you may see one or more of these dances being taught: Waltz; Tango; Foxtrot; Hustle; East Coast Swing/Jive; Merengue; Cha-Cha; Samba; Mambo/Salsa; and Rumba! However, in addition to teaching the dances it is within our goals to take club members on outings and even have some simple purely social activities like watching dance movies! Everyone is welcome to join, and there is no experience necessary. PS. Don't have a dance partner? No worries! At ballroom dance we are all friends and we regularly switch partners and pair up all of our members so that everyone has the opportunity to dance!", "The mission of the College Republicans is to promote the values of the Republican Party on and off campus while providing a venue for community amongst conservative Fordham students. *** We believe in the merits of limited government, free markets, strong national defense, individual liberties, and traditional social values and we stand in defense of them. *** We aim to fight apathy on campus by raising awareness of current events while spreading Republican ideals through educational campaigns, debates, and events. We attend national conferences and workshops, and support the publication of The Liberty Forum, Fordham's quarterly conservative magazine. *** We work to promote the election of Republican officials nationwide. All members and interested students are encouraged to join our group for the latest on club activities! Don't consider yourself a Republican? We're also the club for all you conservative, libertarian, or generally right-leaning students!", " The purpose of this club is to expose Economic and Finance Students to current real life economic situations through various field trips, guest speakers, and competitions. The club will work toward the mission of Fordham University and attempt to advance the social, moral, cultural, intellectual, and spiritual development of its members.", "Welcome to Gamers United at Fordham University's Rose Hill Campus. We are a club dedicated to anything video gaming-related for Fordham students. We set up tournaments, scrimmages, and coaching! This year we meet monday's at 6pm in a room TBA. Come to our meetings and see what we're about!", "The purpose of the JSO is to provide for the Jewish population at Fordham or those who wish to respectfully learn about the Jewish religion or who are affiliated with Judaism in some way. Some provisions may include but are not limited to: attending services at affiliated synagogues, providing at least two meetings a month for community building, and any activities that the members and officers of the club deem appropriate.", "Our main goal is to establish a community where students can come together to network, share experiences, and engage in various cultural and social activities. The association encourages non-Korean students to step out of the American lifestyle and explore others. KSA will help freshman and transfer students to adapt to a new environment by creating a friendly and supportive community. KSA will also raise awareness of Korean culture and traditions on campus by hosting prominent Korean American guest speakers, organizing food tastings events, and distributing communication newsletters. ", "The Ram is the University journal of record, serving campus and community since 1918. The Ram office is located in the basement of the McGinley Center, room B-52.", "The Special Olympics Club at Fordham (SOFordham) seeks to engage the Fordham community in Special Olympics events throughout New York City and spread its values of acceptance, respect, support, and compassion around campus. We strive towards being support systems and friends to the Special Olympic athletes in New York City and to each other. We intend on hosting events on campus that resemble and activate our values to share Special Olympics' mission with our community.", "We are interested in researching, designing, and building robots. Our robots may compete in competitions or are just made for fun.", "The purpose of the Psychology Club will be to enable members to learn more about the field of psychology (e.g. graduate schools, career options, courses in the department), meet other students with similar interests, and to build relationships with faculty in the Psychology Department.", "Model United Nations is an academic simulation of the UN that aims to educate participants about current events, diplomacy and the UN agenda. Students role-play as delegates representing a country in a UN committee. Delegates research a country, take on roles as diplomats, investigate international issues, debate, deliberate, consult and then develop solutions to world problems.", "The Mimes and Mummers are the oldest club on campus. As the main stage theater club on campus we operate out of the theater in Collins, on the second floor. We hire professionals from the city to direct and musical direct our productions, but the club is entirely student run and produced. We produce two shows a semester, a musical and play (drama or comedy). Anyone can audition or technically work on productions but to become a member of the club one must participate in two production strikes. As a member you can vote on upcoming shows and run for the executive board."]
        
        clubLocationArray = ["Dealy Hall 115", "Keating 1st Auditorium", "McGinley 237", "Keating 215", "Rodrigue's Coffee House (in the basement)", "Dealy 206", "Rose Hill Commons", "Edwards Parade", "McGinley Ballroom", "Hughes 208", "Keating 319", "Hughes C04A", "Library", "Keating 204", "McGinley B-52", "Keating 1st Auditorium", "Freeman B06", "McGinley 2nd", "Dealy 101", "Collins Auditorium"]

        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
        if let row = tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(row, animated: false)
        }
        
        
        PFUser.currentUser()!.fetchInBackgroundWithBlock({ (currentUser: PFObject?, error: NSError?) -> Void in
            
            // Update your data
            
            if let user = currentUser as? PFUser {
                
                if user.authenticated{
                    
                }
                
            }
        })

        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        //return self.clubEventPosts == nil ? 0 : self.clubEventPosts.count
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ClubTableViewCell") as! ClubTableViewCell
        //cell.clubEventPost = clubEventPosts[indexPath.row]
        
        
        switch(indexPath.row){
            
        case 0:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 1:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 2:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 3:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 4:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 5:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 6:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 7:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 8:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 9:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 10:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 11:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 12:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 13:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 14:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 15:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 16:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 17:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 18:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            
        case 19:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            cell.clubDescriptionLabel.text = clubDescriptionArray[indexPath.row]
            cell.clubLocationLabel.text = clubLocationArray[indexPath.row]
            

        default:
            
            cell.clubNameLabel.text = "Other Club"
            
        }
        
        
        return cell
        
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
