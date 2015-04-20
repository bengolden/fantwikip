# create league
league = League.create!(name: "Pilot league")

# create users
user1 = User.create!(name: "bg")
user2 = User.create!(name: "ja")
user3 = User.create!(name: "ed")
user4 = User.create!(name: "ck")
user5 = User.create!(name: "kd")
user6 = User.create!(name: "la")
user7 = User.create!(name: "ds")
user8 = User.create!(name: "mm")

# assign teams to users and league
league.teams << [Team.create!(owner_id: user1.id, name: "Farticles"),
								 Team.create!(owner_id: user2.id, name: "Hot Chicks & Jesus"),
								 Team.create!(owner_id: user3.id, name: "The Google, The Veto, and the Mr. Mom"),
								 Team.create!(owner_id: user4.id, name: "E-Cigs in space"),
								 Team.create!(owner_id: user5.id, name: "Wiki Wiki What?"),
								 Team.create!(owner_id: user6.id, name: "50 Shades of Wiki"),
								 Team.create!(owner_id: user7.id, name: "D's Asters"),
								 Team.create!(owner_id: user8.id, name: "Giant Clam")]

# assign time periods to league
jan = TimePeriod.create!(name: "January", duration: "month", start_date: Date.new(2015,1,1), end_date: Date.new(2015,1,31))
feb = TimePeriod.create!(name: "February", duration: "month", start_date: Date.new(2015,2,1), end_date: Date.new(2015,2,28))
mar = TimePeriod.create!(name: "March", duration: "month", start_date: Date.new(2015,3,1), end_date: Date.new(2015,3,31))

league.league_time_periods << [LeagueTimePeriod.create!(time_period_id: jan.id, scoring_weight: 1),
															 LeagueTimePeriod.create!(time_period_id: feb.id, scoring_weight: 1.5),
																LeagueTimePeriod.create!(time_period_id: mar.id, scoring_weight: 2)]

# create articles
article_names = ["michael keaton","ebola","opec","jurassic park","pope francis","stephen hawking","guantanamo bay naval base","mitch mcconnell","liam neeson","quantitative easing","ruth bader ginsburg","clint eastwood","fifty shades of grey","kim jong-un","veto","tesla motors","fox news channel","taylor swift","google","central intelligence agency","julianne moore","koch industries","reese witherspoon","john boehner","bank","stephen colbert","barack obama","lithuania","silicon valley","fidel castro","angela merkel","iraq","israel","petroleum","npr","giant clam","international space station","bashar al-assad","deaths in 2015","antonin scalia","iran","republican party (united states)","exxonmobil","democratic party (united states)","catherine, duchess of cambridge","moon","walmart","netflix","oculus rift","general motors","asteroid","apple inc.","comet","mila kunis","eiffel tower","murphy\'s law","bob dylan","japan","el niño","nascar","africa","jesus","hillary rodham clinton","wichita","green day","american football","spongebob squarepants","count dracula","chicago blackhawks","hydraulic fracturing","assassination_of_john_f._kennedy","eclipse","patient protection and affordable care act","beck","snow","eminem","facebook","katy perry","benedict cumberbatch","electronic cigarette"]
article_names.each do |an|
	Article.create!(name: an)
end

# create lineups
VIEWS = {"201401" => {'jurassic park' => 15165,'american football' => 145408,'bank' => 73418,'netflix' => 234251,'opec' => 46222,'ruth bader ginsburg' => 23749,'npr' => 20167,'silicon valley' => 77166,'barack obama' => 595065,'assassination_of_john_f._kennedy' => 107125,'taylor swift' => 428774,'count dracula' => 37016,'comet' => 52961,'giant clam' => 8611,'mitch mcconnell' => 18023,'republican party (united states)' => 113100,'democratic party (united states)' => 97334,"murphy's law" => 73927,'eiffel tower' => 186085,'general motors' => 85661,'reese witherspoon' => 150100,'katy perry' => 497794,'stephen hawking' => 502288,'eclipse' => 29091,'iran' => 195041,'fidel castro' => 158046,'mila kunis' => 315193,'angela merkel' => 84254,'jesus' => 240102,'moon' => 191804,'oculus rift' => 106792,'exxonmobil' => 41486,'kim jong-un' => 250599,'wichita' => 3767,'lithuania' => 118205,'guantanamo bay naval base' => 25719,'antonin scalia' => 24949,'bob dylan' => 218243,'benedict cumberbatch' => 1008861,'stephen colbert' => 73017,'hydraulic fracturing' => 127227,'asteroid' => 48383,'hillary rodham clinton' => 139880,'israel' => 305762,'quantitative easing' => 68083,'electronic cigarette' => 187610,'international space station' => 125999,'beck' => 79689,'michael keaton' => 95131,'green day' => 120669,'petroleum' => 96078,'google' => 705167,'veto' => 16652,'iraq' => 111047,'japan' => 413432,'clint eastwood' => 214626,'apple inc.' => 291177,'eminem' => 673892,'chicago blackhawks' => 40469,'nascar' => 34027,'snow' => 73694,'tesla motors' => 94506,'fox news channel' => 42970,'africa' => 191277,'walmart' => 112050,'catherine, duchess of cambridge' => 99729,'central intelligence agency' => 83513,'spongebob squarepants' => 165060,'liam neeson' => 227999,'el niño' => 53253,'koch industries' => 43052,'john boehner' => 80089,'ebola' => 10523,'pope francis' => 211242,'bashar al-assad' => 81869,'facebook' => 2270399,'patient protection and affordable care act' => 125412,'deaths in 2015' => 1641908,'fifty shades of grey' => 300877,'julianne moore' => 179514,"\"weird al\" yankovic" => 60360,"alice's adventures in wonderland" => 105439,"art" => 88099,"batman" => 229056,"bigfoot" => 105270,"captain america" => 110701,"charlie chaplin" => 219999,"cops (1989 tv series)" => 20052,"elvis presley" => 378763,"espn" => 53897,"great pyramid of giza" => 140732,"jabba the hutt" => 26346,"johnny cash" => 227491,"kentucky derby" => 18309,"louis c.k." => 175290,"mario" => 83673,"michael jackson" => 395370,"michelangelo" => 134980,"minecraft" => 335718,"pharrell williams" => 497547,"samuel l. jackson" => 130884,"scrabble" => 37603,"sesame street" => 50473,"the simpsons" => 238577,"vincent van gogh" => 207571,"wolfgang amadeus mozart" => 169079,"yoga" => 122060,"bee" => 40416,"bill gates" => 435993,"boeing" => 66219,"cannabis (drug)" => 196491,"charles darwin" => 167450,"coca-cola" => 165027,"cold fusion" => 35752,"dinosaur" => 138104,"dolphin" => 119327,"extraterrestrial life" => 58974,"frog" => 56452,"giant panda" => 143533,"goat" => 60743,"goldman sachs" => 86480,"great barrier reef" => 57307,"harvard university" => 135804,"internet" => 501038,"jellyfish" => 73137,"light" => 84442,"mcdonald's" => 141677,"microsoft" => 215922,"nose" => 11992,"periodic table" => 231941,"root" => 28702,"sun" => 215156,"thomas edison" => 256960,"tide" => 56240,"time" => 78109,"youtube" => 1225985,"abraham lincoln" => 450859,"adolf hitler" => 588297,"antarctica" => 189439,"assassination of john f. kennedy" => 107125,"aung san suu kyi" => 52942,"beijing" => 101439,"boston" => 136970,"brazil" => 305075,"california" => 257348,"chicago" => 229741,"china" => 434016,"david cameron" => 106537,"egypt" => 220049,"george w. bush" => 205425,"india" => 1225593,"lake michigan" => 29082,"mafia" => 46753,"mexico" => 247305,"milwaukee" => 69426,"nigeria" => 190693,"paris" => 198296,"ronald reagan" => 239616,"russia" => 390577,"shanghai" => 118168,"texas" => 168658,"united states" => 1540200,"war on drugs" => 31499,"war on poverty" => 25762,"war on terror" => 47144,"b" => 52338,"bead" => 7322,"bean" => 632335,"beard" => 28163,"beer" => 74889,"champagne" => 42064,"earthquake" => 149612,"hipster (contemporary subculture)" => 83284,"list of internet phenomena" => 41997,"main page" => 347202620,"portal:current events" => 1078457},
         '201402' => {"taylor swift" => 322685,"count dracula" => 32836,"comet" => 53083,"giant clam" => 8620,"mitch mcconnell" => 23507,"republican party (united states)" => 116175,"democratic party (united states)" => 99595,"murphy's law" => 71225,"eiffel tower" => 224554,"general motors" => 86011,"reese witherspoon" => 117129,"katy perry" => 424606,"stephen hawking" => 369635,"eclipse" => 33748,"iran" => 202441,"fidel castro" => 146419,"mila kunis" => 346278,"angela merkel" => 87549,"jesus" => 217948,"moon" => 184875,"fifty shades of grey" => 249290,"julianne moore" => 198013,"oculus rift" => 96815,"exxonmobil" => 45213,"kim jong-un" => 122508,"wichita" => 3199,"lithuania" => 137454,"guantanamo bay naval base" => 24339,"antonin scalia" => 30276,"bob dylan" => 238073,"jurassic park" => 21120,"american football" => 175273,"bank" => 69925,"netflix" => 239815,"opec" => 47170,"ruth bader ginsburg" => 23259,"npr" => 21302,"silicon valley" => 86613,"barack obama" => 676482,"assassination_of_john_f._kennedy" => 98721,"benedict cumberbatch" => 493918,"stephen colbert" => 89657,"hydraulic fracturing" => 119176,"asteroid" => 59363,"hillary rodham clinton" => 140062,"israel" => 253264,"quantitative easing" => 61651,"electronic cigarette" => 159416,"international space station" => 115031,"beck" => 141299,"michael keaton" => 112230,"green day" => 127354,"petroleum" => 94927,"google" => 658068,"veto" => 22546,"iraq" => 98772,"japan" => 414627,"clint eastwood" => 213511,"apple inc." => 285528,"eminem" => 624919,"chicago blackhawks" => 42038,"nascar" => 51356,"snow" => 60001,"tesla motors" => 124946,"fox news channel" => 43859,"africa" => 191833,"deaths in 2015" => 1726583,"walmart" => 113154,"catherine, duchess of cambridge" => 95472,"central intelligence agency" => 76429,"spongebob squarepants" => 138222,"liam neeson" => 457877,"el niño" => 70709,"koch industries" => 47648,"john boehner" => 45854,"ebola" => 9448,"pope francis" => 145747,"bashar al-assad" => 108526,"facebook" => 2036460,"patient protection and affordable care act" => 133084},
         '201403' => {"taylor swift" => 307141,"count dracula" => 32615,"comet" => 57384,"giant clam" => 9386,"mitch mcconnell" => 50144,"republican party (united states)" => 137642,"democratic party (united states)" => 119081,"murphy's law" => 80551,"eiffel tower" => 217978,"general motors" => 98317,"reese witherspoon" => 148975,"katy perry" => 426154,"stephen hawking" => 340938,"eclipse" => 38278,"iran" => 212660,"fidel castro" => 156034,"mila kunis" => 545967,"angela merkel" => 130470,"jesus" => 251490,"moon" => 188588,"fifty shades of grey" => 232922,"julianne moore" => 174339,"oculus rift" => 276321,"exxonmobil" => 48263,"kim jong-un" => 184393,"wichita" => 3683,"lithuania" => 179456,"guantanamo bay naval base" => 30702,"antonin scalia" => 33284,"bob dylan" => 218286,"jurassic park" => 28066,"american football" => 103318,"bank" => 69204,"netflix" => 216744,"opec" => 56585,"ruth bader ginsburg" => 28149,"npr" => 25739,"silicon valley" => 90549,"barack obama" => 662691,"assassination_of_john_f._kennedy" => 115677,"benedict cumberbatch" => 480162,"stephen colbert" => 108581,"hydraulic fracturing" => 133124,"asteroid" => 58735,"hillary rodham clinton" => 147893,"israel" => 293677,"quantitative easing" => 59715,"electronic cigarette" => 170489,"international space station" => 274197,"beck" => 153864,"michael keaton" => 116120,"green day" => 132022,"petroleum" => 102494,"google" => 675117,"veto" => 24169,"iraq" => 112976,"japan" => 469388,"clint eastwood" => 219683,"apple inc." => 302832,"eminem" => 729736,"chicago blackhawks" => 40971,"nascar" => 55076,"snow" => 38057,"tesla motors" => 167218,"fox news channel" => 52128,"africa" => 194057,"deaths in 2015" => 1821756,"walmart" => 123531,"catherine, duchess of cambridge" => 101436,"central intelligence agency" => 99433,"spongebob squarepants" => 146658,"liam neeson" => 449754,"el niño" => 93516,"koch industries" => 77148,"john boehner" => 38568,"ebola" => 60429,"pope francis" => 192177,"bashar al-assad" => 121700,"facebook" => 1907604,"patient protection and affordable care act" => 156732},
         '201501' => {"taylor swift" => 582391,"count dracula" => 27666,"comet" => 46402,"giant clam" => 8783,"mitch mcconnell" => 36359,"republican party (united states)" => 115451,"democratic party (united states)" => 97018,"murphy's law" => 63428,"eiffel tower" => 161001,"general motors" => 76305,"reese witherspoon" => 183982,"katy perry" => 270972,"stephen hawking" => 1065371,"eclipse" => 20666,"iran" => 197020,"fidel castro" => 175711,"mila kunis" => 284650,"angela merkel" => 94427,"jesus" => 191113,"moon" => 177653,"fifty shades of grey" => 492230,"julianne moore" => 225992,"oculus rift" => 95934,"exxonmobil" => 41216,"kim jong-un" => 368010,"wichita" => 3010,"lithuania" => 133793,"guantanamo bay naval base" => 57052,"antonin scalia" => 25542,"bob dylan" => 186268,"jurassic park" => 34600,"american football" => 113755,"bank" => 87099,"netflix" => 217596,"opec" => 120054,"ruth bader ginsburg" => 38084,"npr" => 21100,"silicon valley" => 86741,"barack obama" => 710554,"assassination_of_john_f._kennedy" => 76611,"benedict cumberbatch" => 488670,"stephen colbert" => 86224,"hydraulic fracturing" => 91616,"asteroid" => 43302,"hillary rodham clinton" => 114803,"israel" => 326152,"quantitative easing" => 119329,"electronic cigarette" => 68728,"international space station" => 128007,"beck" => 52411,"michael keaton" => 429409,"green day" => 95504,"petroleum" => 100614,"google" => 946061,"veto" => 23676,"iraq" => 120362,"japan" => 339872,"clint eastwood" => 343397,"apple inc." => 263200,"eminem" => 395580,"chicago blackhawks" => 29823,"nascar" => 28192,"snow" => 46130,"tesla motors" => 131475,"fox news channel" => 58468,"africa" => 153005,"deaths in 2015" => 1703879,"walmart" => 102932,"catherine, duchess of cambridge" => 95961,"central intelligence agency" => 105378,"spongebob squarepants" => 127247,"liam neeson" => 401274,"el niño" => 42868,"koch industries" => 56076,"john boehner" => 95177,"ebola" => 28099,"pope francis" => 438155,"bashar al-assad" => 84641,"facebook" => 1322429,"patient protection and affordable care act" => 87192}}

SCORING = {0 => -4, 0.5 => -2, 0.6 => -1, 0.75 => 0, 0.9 => 1, 0.95 => 2, 1 => 3, 1.05 => 4, 1.15 => 8, 1.3 => 10, 1.6 => 15}

def determine_points(ratio)
  output = 0
  SCORING.each do |k,v|
    output = v if ratio > k
  end
  output
end

fart1 = Team.find_by_name("Farticles").lineups.create!(time_period_id: jan.id)
["jurassic park", "american football", "bank", "netflix", "opec", "ruth bader ginsburg", "npr", "silicon valley"].each do |art|
	fart1.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art], views: VIEWS["201501"][art], points: determine_points(VIEWS["201501"][art].to_f / VIEWS["201401"][art]))
end
fart2 = Team.find_by_name("Farticles").lineups.create!(time_period_id: feb.id)
["jurassic park", "american football", "bank", "barack obama", "opec", "ruth bader ginsburg", "npr", "silicon valley"].each do |art|
	fart2.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art])
end

clam1 = Team.find_by_name("Giant Clam").lineups.create!(time_period_id: jan.id)
["taylor swift", "count dracula", "comet", "giant clam", "mitch mcconnell", "republican party (united states)", "democratic party (united states)", "murphy's law"].each do |art|
	clam1.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art], views: VIEWS["201501"][art], points: determine_points(VIEWS["201501"][art].to_f / VIEWS["201401"][art]))
end
clam2 = Team.find_by_name("Giant Clam").lineups.create!(time_period_id: feb.id)
["taylor swift", "count dracula", "comet", "giant clam", "mitch mcconnell", "republican party (united states)", "democratic party (united states)", "murphy's law"].each do |art|
	clam2.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art])
end

jesu1 = Team.find_by_name("Hot Chicks & Jesus").lineups.create!(time_period_id: jan.id)
["reese witherspoon", "katy perry", "stephen hawking", "eclipse", "iran", "fidel castro", "mila kunis", "angela merkel"].each do |art|
	jesu1.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art], views: VIEWS["201501"][art], points: determine_points(VIEWS["201501"][art].to_f / VIEWS["201401"][art]))
end
jesu2 = Team.find_by_name("Hot Chicks & Jesus").lineups.create!(time_period_id: feb.id)
["reese witherspoon", "katy perry", "stephen hawking", "eclipse", "iran", "fidel castro", "mila kunis", "angela merkel"].each do |art|
	jesu2.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art])
end

shad1 = Team.find_by_name("50 Shades of Wiki").lineups.create!(time_period_id: jan.id)
["fifty shades of grey", "julianne moore", "oculus rift", "exxonmobil", "kim jong-un", "wichita", "lithuania", "guantanamo bay naval base"].each do |art|
	shad1.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art], views: VIEWS["201501"][art], points: determine_points(VIEWS["201501"][art].to_f / VIEWS["201401"][art]))
end
shad2 = Team.find_by_name("50 Shades of Wiki").lineups.create!(time_period_id: feb.id)
["fifty shades of grey", "julianne moore", "oculus rift", "exxonmobil", "kim jong-un", "wichita", "lithuania", "guantanamo bay naval base"].each do |art|
	shad2.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art])
end

ecig1 = Team.find_by_name("E-Cigs in space").lineups.create!(time_period_id: jan.id)
["benedict cumberbatch", "stephen colbert", "hydraulic fracturing", "asteroid", "hillary rodham clinton", "israel", "quantitative easing", "electronic cigarette"].each do |art|
	ecig1.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art], views: VIEWS["201501"][art], points: determine_points(VIEWS["201501"][art].to_f / VIEWS["201401"][art]))
end
ecig2 = Team.find_by_name("E-Cigs in space").lineups.create!(time_period_id: feb.id)
["benedict cumberbatch", "stephen colbert", "hydraulic fracturing", "asteroid", "hillary rodham clinton", "israel", "quantitative easing", "electronic cigarette"].each do |art|
	ecig2.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art])
end

goog1 = Team.find_by_name("The Google, The Veto, and the Mr. Mom").lineups.create!(time_period_id: jan.id)
["michael keaton", "green day", "petroleum", "google", "veto", "iraq", "japan", "clint eastwood"].each do |art|
	goog1.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art], views: VIEWS["201501"][art], points: determine_points(VIEWS["201501"][art].to_f / VIEWS["201401"][art]))
end
goog2 = Team.find_by_name("The Google, The Veto, and the Mr. Mom").lineups.create!(time_period_id: feb.id)
["michael keaton", "green day", "petroleum", "google", "veto", "iraq", "clint eastwood", "apple inc."].each do |art|
	goog2.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art])
end

www1 = Team.find_by_name("Wiki Wiki What?").lineups.create!(time_period_id: jan.id)
["chicago blackhawks", "nascar", "snow", "tesla motors", "fox news channel", "africa", "deaths in 2015", "walmart"].each do |art|
	www1.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art], views: VIEWS["201501"][art], points: determine_points(VIEWS["201501"][art].to_f / VIEWS["201401"][art]))
end
www2 = Team.find_by_name("Wiki Wiki What?").lineups.create!(time_period_id: feb.id)
["chicago blackhawks", "nascar", "snow", "tesla motors", "fox news channel", "deaths in 2015", "walmart", "catherine, duchess of cambridge"].each do |art|
	www2.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art])
end

astr1 = Team.find_by_name("D's Asters").lineups.create!(time_period_id: jan.id)
["spongebob squarepants", "liam neeson", "el niño", "koch industries", "john boehner", "ebola", "pope francis", "bashar al-assad"].each do |art|
	astr1.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art], views: VIEWS["201501"][art], points: determine_points(VIEWS["201501"][art].to_f / VIEWS["201401"][art]))
end
astr2 = Team.find_by_name("D's Asters").lineups.create!(time_period_id: feb.id)
["spongebob squarepants", "liam neeson", "el niño", "koch industries", "john boehner", "ebola", "pope francis", "bashar al-assad"].each do |art|
	astr2.lineup_articles.create!(article_id: Article.find_by_name(art).id, last_year_views: VIEWS["201401"][art])
end
