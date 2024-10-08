import Foundation

// 定义Quiz结构
struct Quiz {
    let question: String
    let options: [String] // 四个可选答案
    let correctAnswer: String // 正确答案
}

// 定义章节数据结构
struct Chapter: Identifiable {
    let id = UUID()
    let name: String
    let summary: String
    let pageNumber: Int // 页码
    let quiz: [Quiz] // 每个章节包含多个Quiz
}

// 定义书籍数据结构
struct Book: Identifiable, Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }

    let id = UUID()
    let title: String
    let author: String
    let description: String
    let coverImage: String
    let category: String
    let chapters: [Chapter] // Array of chapters
}

let charlottesWebChapters = [
    Chapter(
        name: "Chapter I: Before Breakfast",
        summary: "Wilbur is born, and Fern saves him from being slaughtered by her father.",
        pageNumber: 8,
        quiz: [
            Quiz(
                question: "Why did Fern's father want to kill Wilbur?",
                options: ["Wilbur was too small", "Wilbur was born as a runt", "Wilbur was sick", "Wilbur was aggressive"],
                correctAnswer: "Wilbur was born as a runt"
            ),
            Quiz(
                question: "How did Fern save Wilbur?",
                options: ["She ran away with him", "She cried until her father agreed", "She offered to take care of him", "She paid her father"],
                correctAnswer: "She offered to take care of him"
            )
        ]
    ),
    Chapter(
        name: "Chapter II: Wilbur",
        summary: "Wilbur grows up under Fern's care but is eventually sold to Homer Zuckerman.",
        pageNumber: 13,
        quiz: [
            Quiz(
                question: "Where was Wilbur kept after being sold?",
                options: ["In a barn", "In a shed", "In Fern's bedroom", "In the woods"],
                correctAnswer: "In a barn"
            ),
            Quiz(
                question: "Who bought Wilbur from Fern?",
                options: ["The Zuckerman family", "The Arables", "Templeton", "The goose"],
                correctAnswer: "The Zuckerman family"
            )
        ]
    ),
    Chapter(
        name: "Chapter III: Escape",
        summary: "Wilbur escapes from his pen but learns the dangers of the outside world.",
        pageNumber: 25,
        quiz: [
            Quiz(
                question: "Why did Wilbur escape from the barn?",
                options: ["He was bored", "He was hungry", "He wanted freedom", "He wanted to explore"],
                correctAnswer: "He was bored"
            ),
            Quiz(
                question: "Who helped Wilbur get back to the barn?",
                options: ["Fern", "A man", "Templeton", "Charlotte"],
                correctAnswer: "A man"
            )
        ]
    ),
    Chapter(
        name: "Chapter IV: Loneliness",
        summary: "Wilbur feels lonely and longs for companionship in the barn.",
        pageNumber: 32,
        quiz: [
            Quiz(
                question: "Why did Wilbur feel lonely?",
                options: ["He missed Fern", "No animals spoke to him", "He was afraid of the dark", "He wanted to explore outside"],
                correctAnswer: "No animals spoke to him"
            ),
            Quiz(
                question: "Who becomes Wilbur's friend?",
                options: ["Templeton", "Charlotte", "The sheep", "The goose"],
                correctAnswer: "Charlotte"
            )
        ]
    ),
    Chapter(
        name: "Chapter V: Charlotte",
        summary: "Charlotte introduces herself to Wilbur and they become friends.",
        pageNumber: 42,
        quiz: [
            Quiz(
                question: "What kind of animal is Charlotte?",
                options: ["A spider", "A cow", "A goose", "A rat"],
                correctAnswer: "A spider"
            ),
            Quiz(
                question: "What did Charlotte promise to do?",
                options: ["Help Wilbur stay alive", "Build him a new pen", "Teach him to escape", "Get him more food"],
                correctAnswer: "Help Wilbur stay alive"
            )
        ]
    ),
    Chapter(
        name: "Chapter VI: Summer Days",
        summary: "Wilbur enjoys summer on the farm with his new animal friends.",
        pageNumber: 48,
        quiz: [
            Quiz(
                question: "What does Wilbur do during the summer?",
                options: ["Eats all day", "Plays in the barnyard", "Sleeps all day", "Explores the farm"],
                correctAnswer: "Plays in the barnyard"
            ),
            Quiz(
                question: "Who becomes Wilbur's closest friend?",
                options: ["Templeton", "Fern", "Charlotte", "The goose"],
                correctAnswer: "Charlotte"
            )
        ]
    ),
    Chapter(
        name: "Chapter VII: Bad News",
        summary: "Wilbur learns that he will be slaughtered for Christmas.",
        pageNumber: 52,
        quiz: [
            Quiz(
                question: "What bad news does Wilbur receive?",
                options: ["He will be sold", "He will be slaughtered", "Fern is leaving", "Charlotte is moving away"],
                correctAnswer: "He will be slaughtered"
            ),
            Quiz(
                question: "Who tells Wilbur the bad news?",
                options: ["The sheep", "Templeton", "Charlotte", "Fern"],
                correctAnswer: "The sheep"
            )
        ]
    ),
    Chapter(
        name: "Chapter VIII: A Talk at Home",
        summary: "Fern talks to her parents about the animals at the barn.",
        pageNumber: 55,
        quiz: [
            Quiz(
                question: "Who does Fern tell her stories to?",
                options: ["Her friends", "Her parents", "Her teacher", "Her siblings"],
                correctAnswer: "Her parents"
            ),
            Quiz(
                question: "What do Fern's parents think of her stories?",
                options: ["They find them amusing", "They believe her", "They worry about her", "They don't listen"],
                correctAnswer: "They worry about her"
            )
        ]
    ),
    Chapter(
        name: "Chapter IX: Wilbur's Boast",
        summary: "Wilbur boasts about his plans to escape his fate, but Charlotte comes up with a better idea.",
        pageNumber: 66,
        quiz: [
            Quiz(
                question: "What does Wilbur boast about?",
                options: ["His strength", "His intelligence", "His ability to escape", "His friendship with Charlotte"],
                correctAnswer: "His ability to escape"
            ),
            Quiz(
                question: "What is Charlotte's plan?",
                options: ["To write words in her web", "To help Wilbur run away", "To make Wilbur stronger", "To convince Fern's father"],
                correctAnswer: "To write words in her web"
            )
        ]
    ),
    Chapter(
        name: "Chapter X: An Explosion",
        summary: "An unexpected explosion occurs, startling the animals and Wilbur.",
        pageNumber: 77,
        quiz: [
            Quiz(
                question: "What caused the explosion?",
                options: ["A firecracker", "A car backfire", "A gas leak", "Templeton"],
                correctAnswer: "A firecracker"
            ),
            Quiz(
                question: "How does Wilbur react to the explosion?",
                options: ["He hides", "He runs", "He squeals", "He remains calm"],
                correctAnswer: "He squeals"
            )
        ]
    ),
    Chapter(
        name: "Chapter XI: The Miracle",
        summary: "Charlotte weaves her first word into the web, and the Zuckermans are astonished.",
        pageNumber: 86,
        quiz: [
            Quiz(
                question: "What word does Charlotte weave into her web?",
                options: ["Some Pig", "Miracle", "Amazing", "Save Wilbur"],
                correctAnswer: "Some Pig"
            ),
            Quiz(
                question: "How does Mr. Zuckerman react?",
                options: ["He is amazed", "He is angry", "He is confused", "He is indifferent"],
                correctAnswer: "He is amazed"
            )
        ]
    ),
    Chapter(
        name: "Chapter XII: A Meeting",
        summary: "The animals hold a meeting to discuss how to save Wilbur from slaughter.",
        pageNumber: 92,
        quiz: [
            Quiz(
                question: "Who calls the meeting in the barn?",
                options: ["Charlotte", "The sheep", "Wilbur", "Templeton"],
                correctAnswer: "Charlotte"
            ),
            Quiz(
                question: "What is the purpose of the meeting?",
                options: ["To plan a party", "To discuss Wilbur's fate", "To complain about the humans", "To help Fern"],
                correctAnswer: "To discuss Wilbur's fate"
            )
        ]
    ),
    Chapter(
        name: "Chapter XIII: Good Progress",
        summary: "Charlotte continues weaving words into her web, and Wilbur grows in popularity.",
        pageNumber: 105,
        quiz: [
            Quiz(
                question: "What new word does Charlotte weave into her web?",
                options: ["Terrific", "Amazing", "Wonderful", "Radiant"],
                correctAnswer: "Terrific"
            ),
            Quiz(
                question: "How does Wilbur react to the attention?",
                options: ["He becomes proud", "He gets nervous", "He ignores it", "He becomes shy"],
                correctAnswer: "He becomes proud"
            )
        ]
    ),
    Chapter(
        name: "Chapter XIV: Dr. Dorian",
        summary: "Dr. Dorian gives his thoughts on the miracle of Charlotte's web and Fern's stories.",
        pageNumber: 113,
        quiz: [
            Quiz(
                question: "What does Dr. Dorian think about Charlotte's web?",
                options: ["He is amazed", "He believes it's natural", "He is skeptical", "He finds it ridiculous"],
                correctAnswer: "He is amazed"
            ),
            Quiz(
                question: "How does Dr. Dorian respond to Fern's stories?",
                options: ["He believes her", "He thinks she is imaginative", "He ignores her", "He thinks she is lying"],
                correctAnswer: "He thinks she is imaginative"
            )
        ]
    ),
    Chapter(
        name: "Chapter XV: The Crickets",
        summary: "The crickets sing of the end of summer, and Wilbur prepares for the upcoming fair.",
        pageNumber: 118,
        quiz: [
            Quiz(
                question: "What do the crickets' songs symbolize?",
                options: ["The end of summer", "The beginning of winter", "The arrival of spring", "A warning"],
                correctAnswer: "The end of summer"
            ),
            Quiz(
                question: "What is Wilbur preparing for?",
                options: ["A race", "A competition", "The fair", "The winter"],
                correctAnswer: "The fair"
            )
        ]
    ),
    Chapter(
        name: "Chapter XVI: Off to the Fair",
        summary: "Wilbur is taken to the county fair in hopes of winning a special prize.",
        pageNumber: 130,
        quiz: [
            Quiz(
                question: "Where is Wilbur taken?",
                options: ["To the city", "To the fair", "To a new farm", "To a competition"],
                correctAnswer: "To the fair"
            ),
            Quiz(
                question: "What does Wilbur hope to win at the fair?",
                options: ["A ribbon", "A new pen", "A medal", "A special prize"],
                correctAnswer: "A special prize"
            )
        ]
    ),
    Chapter(
        name: "Chapter XVII: Uncle",
        summary: "Wilbur meets a large pig named Uncle, who is also competing at the fair.",
        pageNumber: 138,
        quiz: [
            Quiz(
                question: "Who is Uncle?",
                options: ["A pig competing against Wilbur", "A farmer", "A judge", "A spider"],
                correctAnswer: "A pig competing against Wilbur"
            ),
            Quiz(
                question: "How does Wilbur feel about Uncle?",
                options: ["He is scared", "He is impressed", "He is jealous", "He is indifferent"],
                correctAnswer: "He is scared"
            )
        ]
    ),
    Chapter(
        name: "Chapter XVIII: The Cool of the Evening",
        summary: "As evening falls, Charlotte weaves more words into her web, and Wilbur rests.",
        pageNumber: 144,
        quiz: [
            Quiz(
                question: "What does Charlotte do in the evening?",
                options: ["She weaves more words", "She leaves the fair", "She rests", "She talks to Wilbur"],
                correctAnswer: "She weaves more words"
            ),
            Quiz(
                question: "What does Wilbur do after a long day at the fair?",
                options: ["He eats", "He runs around", "He rests", "He talks to Uncle"],
                correctAnswer: "He rests"
            )
        ]
    ),
    Chapter(
        name: "Chapter XIX: The Egg Sac",
        summary: "Charlotte reveals her egg sac, and she grows weaker as the fair progresses.",
        pageNumber: 155,
        quiz: [
            Quiz(
                question: "What does Charlotte reveal to Wilbur?",
                options: ["Her egg sac", "Her new web", "Her escape plan", "Her illness"],
                correctAnswer: "Her egg sac"
            ),
            Quiz(
                question: "How does Wilbur feel about the egg sac?",
                options: ["He is happy", "He is confused", "He is worried", "He is indifferent"],
                correctAnswer: "He is worried"
            )
        ]
    ),
    Chapter(
        name: "Chapter XX: The Hour of Triumph",
        summary: "Wilbur wins a special prize at the fair, but Charlotte grows weaker.",
        pageNumber: 163,
        quiz: [
            Quiz(
                question: "What happens to Wilbur at the fair?",
                options: ["He wins a special prize", "He loses to Uncle", "He runs away", "He gets sick"],
                correctAnswer: "He wins a special prize"
            ),
            Quiz(
                question: "What is happening to Charlotte?",
                options: ["She is growing weaker", "She is leaving", "She is laying more eggs", "She is helping Wilbur"],
                correctAnswer: "She is growing weaker"
            )
        ]
    ),
    Chapter(
        name: "Chapter XXI: Last Day",
        summary: "Charlotte's life comes to an end, and Wilbur helps protect her eggs.",
        pageNumber: 172,
        quiz: [
            Quiz(
                question: "What happens to Charlotte?",
                options: ["She dies", "She leaves", "She wins a prize", "She hatches her eggs"],
                correctAnswer: "She dies"
            ),
            Quiz(
                question: "What does Wilbur do for Charlotte?",
                options: ["He protects her eggs", "He helps her weave", "He runs away", "He helps Templeton"],
                correctAnswer: "He protects her eggs"
            )
        ]
    ),
    Chapter(
        name: "Chapter XXII: A Warm Wind",
        summary: "Charlotte's offspring hatch and leave the barn, but three stay behind with Wilbur.",
        pageNumber: 184,
        quiz: [
            Quiz(
                question: "What happens to Charlotte's eggs?",
                options: ["They hatch", "They are lost", "They don't hatch", "They are destroyed"],
                correctAnswer: "They hatch"
            ),
            Quiz(
                question: "How many of Charlotte's offspring stay with Wilbur?",
                options: ["Three", "Five", "All of them", "None of them"],
                correctAnswer: "Three"
            )
        ]
    )
]




// 定义《Charlotte's Web》书籍数据
let charlottesWeb = Book(
    title: "Charlotte's Web",
    author: "E.B. White",
    description: "A story about the friendship between a pig named Wilbur and a spider named Charlotte.",
    coverImage: "book1", // 假设封面图片存在
    category: "Children",
    chapters: charlottesWebChapters
)


// 创建《The Giving Tree》书籍及其章节信息
let theGivingTreeChapters = [
    Chapter(
        name: "Chapter I: The Boy and the Tree",
        summary: "A young boy and a tree form a deep friendship. The tree gives the boy shade, apples, and a place to play.",
        pageNumber: 28,
        quiz: [
            Quiz(
                question: "What does the tree give the boy at first?",
                options: ["Shade and apples", "Leaves", "Branches to swing", "A place to sit"],
                correctAnswer: "Shade and apples"
            ),
            Quiz(
                question: "What does the boy do with the apples?",
                options: ["Eats them", "Sells them", "Throws them away", "Gives them to his friends"],
                correctAnswer: "Eats them"
            )
        ]
    ),
    Chapter(
        name: "Chapter II: Growing Needs",
        summary: "As the boy grows older, he asks for more from the tree. He takes the tree's apples to sell for money.",
        pageNumber: 38,
        quiz: [
            Quiz(
                question: "Why does the boy take the apples?",
                options: ["To sell them for money", "To eat them", "To give them to friends", "To throw them away"],
                correctAnswer: "To sell them for money"
            ),
            Quiz(
                question: "How does the tree feel about giving the apples?",
                options: ["Happy", "Sad", "Indifferent", "Angry"],
                correctAnswer: "Happy"
            )
        ]
    ),
    Chapter(
        name: "Chapter III: Taking More",
        summary: "The boy returns as a man and takes the tree's branches to build a house.",
        pageNumber: 44,
        quiz: [
            Quiz(
                question: "What does the boy ask for this time?",
                options: ["Branches to build a house", "More apples", "Money", "A place to rest"],
                correctAnswer: "Branches to build a house"
            ),
            Quiz(
                question: "What happens to the tree after the boy takes the branches?",
                options: ["It becomes sad", "It grows new branches", "It becomes happier", "It starts to die"],
                correctAnswer: "It becomes sad"
            )
        ]
    ),
    Chapter(
        name: "Chapter IV: The Trunk",
        summary: "The boy, now an adult, takes the tree's trunk to build a boat and sail away.",
        pageNumber: 50,
        quiz: [
            Quiz(
                question: "What does the boy want to do with the tree's trunk?",
                options: ["Build a boat", "Build another house", "Make a fire", "Make furniture"],
                correctAnswer: "Build a boat"
            ),
            Quiz(
                question: "How does the tree feel after giving its trunk?",
                options: ["Happy but tired", "Sad and tired", "Angry", "Indifferent"],
                correctAnswer: "Happy but tired"
            )
        ]
    ),
    Chapter(
        name: "Chapter V: The Stump",
        summary: "The boy, now an old man, returns one last time. The tree, now just a stump, offers a place to sit and rest.",
        pageNumber: 55,
        quiz: [
            Quiz(
                question: "What is left of the tree?",
                options: ["Only a stump", "Its trunk", "A few branches", "Some apples"],
                correctAnswer: "Only a stump"
            ),
            Quiz(
                question: "What does the boy do at the end of the story?",
                options: ["Sits on the stump", "Plants a new tree", "Takes the last apple", "Builds another house"],
                correctAnswer: "Sits on the stump"
            )
        ]
    )
]

// 定义《The Giving Tree》书籍数据
let theGivingTree = Book(
    title: "The Giving Tree",
    author: "Shel Silverstein",
    description: "A heartwarming story about the selfless love of a tree for a boy throughout the boy's life.",
    coverImage: "book2", // 假设封面图片存在
    category: "Children",
    chapters: theGivingTreeChapters
)


let theVeryHungryCaterpillarChapters = [
    Chapter(
        name: "Chapter I: The Egg and the Caterpillar",
        summary: "A tiny egg lies on a leaf, and soon, a very hungry caterpillar hatches.",
        pageNumber: 8,
        quiz: [
            Quiz(
                question: "What is on the leaf at the start of the story?",
                options: ["A cocoon", "A butterfly", "An egg", "A flower"],
                correctAnswer: "An egg"
            ),
            Quiz(
                question: "What hatches from the egg?",
                options: ["A bee", "A butterfly", "A caterpillar", "A spider"],
                correctAnswer: "A caterpillar"
            )
        ]
    ),
    Chapter(
        name: "Chapter II: The Caterpillar Eats",
        summary: "The caterpillar eats through various fruits and foods, growing bigger each day.",
        pageNumber: 22,
        quiz: [
            Quiz(
                question: "What does the caterpillar eat on Monday?",
                options: ["One apple", "Two pears", "Three plums", "Four strawberries"],
                correctAnswer: "One apple"
            ),
            Quiz(
                question: "What happens to the caterpillar after eating too much?",
                options: ["It grows bigger", "It becomes sick", "It sleeps", "It builds a cocoon"],
                correctAnswer: "It becomes sick"
            )
        ]
    ),
    Chapter(
        name: "Chapter III: The Cocoon and the Butterfly",
        summary: "After recovering from overeating, the caterpillar builds a cocoon and turns into a butterfly.",
        pageNumber: 26,
        quiz: [
            Quiz(
                question: "What does the caterpillar build after eating?",
                options: ["A nest", "A cocoon", "A house", "A web"],
                correctAnswer: "A cocoon"
            ),
            Quiz(
                question: "What does the caterpillar become at the end?",
                options: ["A moth", "A caterpillar", "A butterfly", "A bee"],
                correctAnswer: "A butterfly"
            )
        ]
    )
]

let theVeryHungryCaterpillar = Book(
    title: "The Very Hungry Caterpillar",
    author: "Eric Carle",
    description: "A story about a small caterpillar who eats his way through a variety of foods before pupating and emerging as a beautiful butterfly. The story teaches children about counting, the days of the week, and the life cycle of a butterfly.",
    coverImage: "book3", // 示例封面图片
    category: "Children",
    chapters: theVeryHungryCaterpillarChapters
)


// 《Winnie The Pooh》 书籍的完整数据
let winnieThePooh = Book(
    title: "Winnie The Pooh",
    author: "A. A. Milne",
    description: "A collection of delightful tales centered around Winnie the Pooh, Piglet, and their friends in the Hundred Acre Wood, exploring friendship and adventures.",
    coverImage: "book4", // 示例封面图片
    category: "Children",
    chapters: [
        Chapter(
            name: "Chapter 1: Intro of Winnie the Pooh",
            summary: "The introduction of Winnie the Pooh and his friends in the Hundred Acre Wood.",
            pageNumber: 13,
            quiz: [
                Quiz(
                    question: "Who is introduced in the first chapter?",
                    options: ["Winnie the Pooh", "Piglet", "Tigger", "Christopher Robin"],
                    correctAnswer: "Winnie the Pooh"
                ),
                Quiz(
                    question: "Where does the story take place?",
                    options: ["Hundred Acre Wood", "Piglet's House", "London", "Rabbit's Garden"],
                    correctAnswer: "Hundred Acre Wood"
                )
            ]
        ),
        Chapter(
            name: "Chapter 2: Pooh goes visiting and gets into a tight place",
            summary: "Pooh visits Rabbit's house and eats too much honey, getting stuck in Rabbit's hole.",
            pageNumber: 18,
            quiz: [
                Quiz(
                    question: "Where does Pooh get stuck?",
                    options: ["Rabbit's hole", "Eeyore's house", "Piglet's tree", "Owl's nest"],
                    correctAnswer: "Rabbit's hole"
                ),
                Quiz(
                    question: "Why did Pooh get stuck?",
                    options: ["He ate too much honey", "He fell asleep", "He was chasing bees", "He was scared"],
                    correctAnswer: "He ate too much honey"
                )
            ]
        ),
        Chapter(
            name: "Chapter 3: Pooh and Piglet go hunting and nearly catch a woozle",
            summary: "Pooh and Piglet try to catch a mysterious creature called a woozle but fail.",
            pageNumber: 22,
            quiz: [
                Quiz(
                    question: "What were Pooh and Piglet trying to catch?",
                    options: ["A woozle", "A heffalump", "A rabbit", "A bee"],
                    correctAnswer: "A woozle"
                ),
                Quiz(
                    question: "Did Pooh and Piglet manage to catch the woozle?",
                    options: ["No", "Yes", "They almost did", "They didn't try"],
                    correctAnswer: "No"
                )
            ]
        ),
        Chapter(
            name: "Chapter 4: Eeyore loses a tail and pooh finds one",
            summary: "Eeyore loses his tail, and Pooh sets off on a mission to help him find it.",
            pageNumber: 27,
            quiz: [
                Quiz(
                    question: "What does Eeyore lose?",
                    options: ["His tail", "His house", "His hat", "His honey pot"],
                    correctAnswer: "His tail"
                ),
                Quiz(
                    question: "Who helps Eeyore find his tail?",
                    options: ["Pooh", "Piglet", "Rabbit", "Christopher Robin"],
                    correctAnswer: "Pooh"
                )
            ]
        ),
        Chapter(
            name: "Chapter 5: Piglet meets a Heffalump",
            summary: "Piglet imagines a scary Heffalump, but in reality, the Heffalump is quite friendly.",
            pageNumber: 34,
            quiz: [
                Quiz(
                    question: "Who meets the Heffalump?",
                    options: ["Piglet", "Pooh", "Eeyore", "Tigger"],
                    correctAnswer: "Piglet"
                ),
                Quiz(
                    question: "How does Piglet feel about the Heffalump at first?",
                    options: ["Scared", "Excited", "Happy", "Curious"],
                    correctAnswer: "Scared"
                )
            ]
        ),
        Chapter(
            name: "Chapter 6: Eeyore has a birthday and gets two presents",
            summary: "Eeyore's friends give him two presents for his birthday.",
            pageNumber: 43,
            quiz: [
                Quiz(
                    question: "Whose birthday is it?",
                    options: ["Eeyore's", "Pooh's", "Piglet's", "Christopher Robin's"],
                    correctAnswer: "Eeyore's"
                ),
                Quiz(
                    question: "How many presents does Eeyore receive?",
                    options: ["Two", "One", "Three", "None"],
                    correctAnswer: "Two"
                )
            ]
        ),
        Chapter(
            name: "Chapter 7: Kanga and Baby Roo come to the forest and Piglet has a bath",
            summary: "Kanga and Roo arrive in the forest, and Piglet accidentally gets a bath.",
            pageNumber: 53,
            quiz: [
                Quiz(
                    question: "Who arrives in the forest?",
                    options: ["Kanga and Roo", "Rabbit and Owl", "Tigger and Eeyore", "Pooh and Piglet"],
                    correctAnswer: "Kanga and Roo"
                ),
                Quiz(
                    question: "What happens to Piglet?",
                    options: ["He gets a bath", "He gets lost", "He falls asleep", "He finds honey"],
                    correctAnswer: "He gets a bath"
                )
            ]
        ),
        Chapter(
            name: "Chapter 8: Christopher Robin leads an expedition to the North Pole",
            summary: "Christopher Robin organizes an expedition with his friends to find the North Pole.",
            pageNumber: 63,
            quiz: [
                Quiz(
                    question: "Who leads the expedition?",
                    options: ["Christopher Robin", "Pooh", "Piglet", "Eeyore"],
                    correctAnswer: "Christopher Robin"
                ),
                Quiz(
                    question: "Where are they going on the expedition?",
                    options: ["To the North Pole", "To Rabbit's house", "To find honey", "To the South Pole"],
                    correctAnswer: "To the North Pole"
                )
            ]
        ),
        Chapter(
            name: "Chapter 9: Piglet is entirely surrounded by water",
            summary: "Piglet finds himself surrounded by water after a big rainstorm.",
            pageNumber: 71,
            quiz: [
                Quiz(
                    question: "Why is Piglet surrounded by water?",
                    options: ["There was a rainstorm", "He was playing in the pond", "He fell into the river", "Pooh poured water"],
                    correctAnswer: "There was a rainstorm"
                ),
                Quiz(
                    question: "Who helps Piglet?",
                    options: ["Pooh", "Eeyore", "Rabbit", "Christopher Robin"],
                    correctAnswer: "Pooh"
                )
            ]
        ),
        Chapter(
            name: "Chapter 10: Christopher Robin gives a Pooh party, and we say good-bye",
            summary: "Christopher Robin organizes a party for Pooh and all of his friends, and they say goodbye.",
            pageNumber: 78,
            quiz: [
                Quiz(
                    question: "Who is the party for?",
                    options: ["Pooh", "Piglet", "Eeyore", "Tigger"],
                    correctAnswer: "Pooh"
                ),
                Quiz(
                    question: "What do they say at the end of the party?",
                    options: ["Good-bye", "Hello", "Thank you", "See you later"],
                    correctAnswer: "Good-bye"
                )
            ]
        )
    ]
)




// 示例：更新 currentlyReadingBooks 变量
//var currentlyReadingBooks = getUserCurrentlyReadingBooks()

let recommendedBooks: [Book] = [
    charlottesWeb,
    theGivingTree,
    theVeryHungryCaterpillar,
    winnieThePooh
]

let popularBooks: [Book] = [
    theGivingTree,
    theVeryHungryCaterpillar,
    winnieThePooh
]


//// Function to fetch currently reading books
//func getCurrentlyReadingBooks() -> [Book] {
//    return currentlyReadingBooks
//}

// Function to fetch recommended books
func getRecommendedBooks() -> [Book] {
    return recommendedBooks
}

// Function to fetch popular books
func getPopularBooks() -> [Book] {
    return popularBooks
}


struct Category: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let image: String // Image representing the category
}

let categories = [
        Category(name: "Children", image: "book1"),
        Category(name: "Fiction", image: "book9"),
        Category(name: "Science", image: "book13"),
        Category(name: "History", image: "book10")
        
    ]

// Function to fetch popular books
func getCategories() -> [Category] {
    return categories
}

// Helper function to get books for each category
func getBooksForCategory(category: String) -> [Book] {
    return recommendedBooks.filter { $0.category.lowercased() == category.lowercased() }
}


struct UserBookProgress: Identifiable, Codable {
    let id = UUID()
    let username: String
    var booksProgress: [String: Double] // 字典：key 是书名，value 是进度（0.0 - 1.0 的浮点数）

    init(username: String) {
        self.username = username
        self.booksProgress = [:] // 初始化时字典为空
    }
}



// 更新用户某本书的阅读进度
func updateUserProgress(for username: String, bookTitle: String, progress: Double) {
    var userProgress = loadUserProgress(username: username)
    userProgress.booksProgress[bookTitle] = progress
    saveUserProgress(userProgress)
}

func saveUserProgress(_ progress: UserBookProgress) {
    if let encodedData = try? JSONEncoder().encode(progress) {
        UserDefaults.standard.set(encodedData, forKey: "\(progress.username)_progress")
    }
}

func loadUserProgress(username: String) -> UserBookProgress {
    if let savedData = UserDefaults.standard.data(forKey: "\(username)_progress"),
       let savedProgress = try? JSONDecoder().decode(UserBookProgress.self, from: savedData) {
        return savedProgress
    } else {
        return UserBookProgress(username: username) // 没有保存进度时，返回一个新的进度
    }
}

// 修改 getUserCurrentlyReadingBooks 函数，传入 username 参数
func getUserCurrentlyReadingBooks(for username: String) -> [Book] {
    // 加载该用户的进度
    let userProgress = loadUserProgress(username: username)
    
    let books = recommendedBooks // 假设从推荐书籍列表中获取所有书籍
    
    // 过滤出进度未完成的书籍
    let currentlyReading = books.filter { book in
        let progress = userProgress.booksProgress[book.title] ?? 0.0
        return progress > 0.0 && progress < 1.0
    }

    return currentlyReading
}

func getUserHistoryBooks(for username: String) -> [Book] {
    // 加载该用户的进度
    let userProgress = loadUserProgress(username: username)
    
    let books = recommendedBooks // 假设从推荐书籍列表中获取所有书籍
    
    // 过滤出进度未完成的书籍
    let historyReading = books.filter { book in
        let progress = userProgress.booksProgress[book.title] ?? 0.0
        return progress > 0.0
    }

    return historyReading
}
