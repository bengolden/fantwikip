require 'uri'
require 'open-uri'
require 'json'

SCORING = {0 => -4, 0.5 => -2, 0.6 => -1, 0.75 => 0, 0.9 => 1, 0.95 => 2, 1 => 3, 1.05 => 4, 1.15 => 8, 1.3 => 10, 1.6 => 15}

VALUES = {"201401" => {'jurassic park' => 15165,'american football' => 145408,'bank' => 73418,'netflix' => 234251,'opec' => 46222,'ruth bader ginsburg' => 23749,'npr' => 20167,'silicon valley' => 77166,'barack obama' => 595065,'assassination_of_john_f._kennedy' => 107125,'taylor swift' => 428774,'count dracula' => 37016,'comet' => 52961,'giant clam' => 8611,'mitch mcconnell' => 18023,'republican party (united states)' => 113100,'democratic party (united states)' => 97334,"murphy's law" => 73927,'eiffel tower' => 186085,'general motors' => 85661,'reese witherspoon' => 150100,'katy perry' => 497794,'stephen hawking' => 502288,'eclipse' => 29091,'iran' => 195041,'fidel castro' => 158046,'mila kunis' => 315193,'angela merkel' => 84254,'jesus' => 240102,'moon' => 191804,'oculus rift' => 106792,'exxonmobil' => 41486,'kim jong-un' => 250599,'wichita' => 3767,'lithuania' => 118205,'guantanamo bay naval base' => 25719,'antonin scalia' => 24949,'bob dylan' => 218243,'benedict cumberbatch' => 1008861,'stephen colbert' => 73017,'hydraulic fracturing' => 127227,'asteroid' => 48383,'hillary rodham clinton' => 139880,'israel' => 305762,'quantitative easing' => 68083,'electronic cigarette' => 187610,'international space station' => 125999,'beck' => 79689,'michael keaton' => 95131,'green day' => 120669,'petroleum' => 96078,'google' => 705167,'veto' => 16652,'iraq' => 111047,'japan' => 413432,'clint eastwood' => 214626,'apple inc.' => 291177,'eminem' => 673892,'chicago blackhawks' => 40469,'nascar' => 34027,'snow' => 73694,'tesla motors' => 94506,'fox news channel' => 42970,'africa' => 191277,'walmart' => 112050,'catherine, duchess of cambridge' => 99729,'central intelligence agency' => 83513,'spongebob squarepants' => 165060,'liam neeson' => 227999,'el niño' => 53253,'koch industries' => 43052,'john boehner' => 80089,'ebola' => 10523,'pope francis' => 211242,'bashar al-assad' => 81869,'facebook' => 2270399,'patient protection and affordable care act' => 125412,'deaths in 2015' => 1641908,'fifty shades of grey' => 300877,'julianne moore' => 179514,"\"weird al\" yankovic" => 60360,"alice's adventures in wonderland" => 105439,"art" => 88099,"batman" => 229056,"bigfoot" => 105270,"captain america" => 110701,"charlie chaplin" => 219999,"cops (1989 tv series)" => 20052,"elvis presley" => 378763,"espn" => 53897,"great pyramid of giza" => 140732,"jabba the hutt" => 26346,"johnny cash" => 227491,"kentucky derby" => 18309,"louis c.k." => 175290,"mario" => 83673,"michael jackson" => 395370,"michelangelo" => 134980,"minecraft" => 335718,"pharrell williams" => 497547,"samuel l. jackson" => 130884,"scrabble" => 37603,"sesame street" => 50473,"the simpsons" => 238577,"vincent van gogh" => 207571,"wolfgang amadeus mozart" => 169079,"yoga" => 122060,"bee" => 40416,"bill gates" => 435993,"boeing" => 66219,"cannabis (drug)" => 196491,"charles darwin" => 167450,"coca-cola" => 165027,"cold fusion" => 35752,"dinosaur" => 138104,"dolphin" => 119327,"extraterrestrial life" => 58974,"frog" => 56452,"giant panda" => 143533,"goat" => 60743,"goldman sachs" => 86480,"great barrier reef" => 57307,"harvard university" => 135804,"internet" => 501038,"jellyfish" => 73137,"light" => 84442,"mcdonald's" => 141677,"microsoft" => 215922,"nose" => 11992,"periodic table" => 231941,"root" => 28702,"sun" => 215156,"thomas edison" => 256960,"tide" => 56240,"time" => 78109,"youtube" => 1225985,"abraham lincoln" => 450859,"adolf hitler" => 588297,"antarctica" => 189439,"assassination of john f. kennedy" => 107125,"aung san suu kyi" => 52942,"beijing" => 101439,"boston" => 136970,"brazil" => 305075,"california" => 257348,"chicago" => 229741,"china" => 434016,"david cameron" => 106537,"egypt" => 220049,"george w. bush" => 205425,"india" => 1225593,"lake michigan" => 29082,"mafia" => 46753,"mexico" => 247305,"milwaukee" => 69426,"nigeria" => 190693,"paris" => 198296,"ronald reagan" => 239616,"russia" => 390577,"shanghai" => 118168,"texas" => 168658,"united states" => 1540200,"war on drugs" => 31499,"war on poverty" => 25762,"war on terror" => 47144,"b" => 52338,"bead" => 7322,"bean" => 632335,"beard" => 28163,"beer" => 74889,"champagne" => 42064,"earthquake" => 149612,"hipster (contemporary subculture)" => 83284,"list of internet phenomena" => 41997,"main page" => 347202620,"portal:current events" => 1078457},
          '201402' => {"taylor swift" => [322685,28],"count dracula" => [32836,28],"comet" => [53083,28],"giant clam" => [8620,28],"mitch mcconnell" => [23507,28],"republican party (united states)" => [116175,28],"democratic party (united states)" => [99595,28],"murphy's law" => [71225,28],"eiffel tower" => [224554,28],"general motors" => [86011,28],"reese witherspoon" => [117129,28],"katy perry" => [424606,28],"stephen hawking" => [369635,28],"eclipse" => [33748,28],"iran" => [202441,28],"fidel castro" => [146419,28],"mila kunis" => [346278,28],"angela merkel" => [87549,28],"jesus" => [217948,28],"moon" => [184875,28],"fifty shades of grey" => [249290,28],"julianne moore" => [198013,28],"oculus rift" => [96815,28],"exxonmobil" => [45213,28],"kim jong-un" => [122508,28],"wichita" => [3199,28],"lithuania" => [137454,28],"guantanamo bay naval base" => [24339,28],"antonin scalia" => [30276,28],"bob dylan" => [238073,28],"jurassic park" => [21120,28],"american football" => [175273,28],"bank" => [69925,28],"opec" => [47170,28],"ruth bader ginsburg" => [23259,28],"npr" => [21302,28],"silicon valley" => [86613,28],"barack obama" => [676482,28],"assassination_of_john_f._kennedy" => [98721,28],"netflix" => [239815,28],"benedict cumberbatch" => [493918,28],"stephen colbert" => [89657,28],"hydraulic fracturing" => [119176,28],"asteroid" => [59363,28],"hillary rodham clinton" => [140062,28],"israel" => [253264,28],"quantitative easing" => [61651,28],"electronic cigarette" => [159416,28],"international space station" => [115031,28],"beck" => [141299,28],"michael keaton" => [112230,28],"green day" => [127354,28],"petroleum" => [94927,28],"google" => [658068,28],"veto" => [22546,28],"iraq" => [98772,28],"clint eastwood" => [213511,28],"apple inc." => [285528,28],"eminem" => [624919,28],"japan" => [414627,28],"chicago blackhawks" => [42038,28],"nascar" => [51356,28],"snow" => [60001,28],"tesla motors" => [124946,28],"fox news channel" => [43859,28],"deaths in 2015" => [8,5],"walmart" => [113154,28],"catherine, duchess of cambridge" => [95472,28],"central intelligence agency" => [76429,28],"africa" => [191833,28],"spongebob squarepants" => [138222,28],"liam neeson" => [457877,28],"el niño" => [70709,28],"koch industries" => [47648,28],"john boehner" => [45854,28],"ebola" => [9448,28],"pope francis" => [145747,28],"bashar al-assad" => [108526,28],"facebook" => [2036460,28],"patient protection and affordable care act" => [133084,28]},
          '201403' => {"taylor swift" => 307141,"count dracula" => 32615,"comet" => 57384,"giant clam" => 9386,"mitch mcconnell" => 50144,"republican party (united states)" => 137642,"democratic party (united states)" => 119081,"murphy's law" => 80551,"eiffel tower" => 217978,"general motors" => 98317,"reese witherspoon" => 148975,"katy perry" => 426154,"stephen hawking" => 340938,"eclipse" => 38278,"iran" => 212660,"fidel castro" => 156034,"mila kunis" => 545967,"angela merkel" => 130470,"jesus" => 251490,"moon" => 188588,"fifty shades of grey" => 232922,"julianne moore" => 174339,"oculus rift" => 276321,"exxonmobil" => 48263,"kim jong-un" => 184393,"wichita" => 3683,"lithuania" => 179456,"guantanamo bay naval base" => 30702,"antonin scalia" => 33284,"bob dylan" => 218286,"jurassic park" => 28066,"american football" => 103318,"bank" => 69204,"netflix" => 216744,"opec" => 56585,"ruth bader ginsburg" => 28149,"npr" => 25739,"silicon valley" => 90549,"barack obama" => 662691,"assassination_of_john_f._kennedy" => 115677,"benedict cumberbatch" => 480162,"stephen colbert" => 108581,"hydraulic fracturing" => 133124,"asteroid" => 58735,"hillary rodham clinton" => 147893,"israel" => 293677,"quantitative easing" => 59715,"electronic cigarette" => 170489,"international space station" => 274197,"beck" => 153864,"michael keaton" => 116120,"green day" => 132022,"petroleum" => 102494,"google" => 675117,"veto" => 24169,"iraq" => 112976,"japan" => 469388,"clint eastwood" => 219683,"apple inc." => 302832,"eminem" => 729736,"chicago blackhawks" => 40971,"nascar" => 55076,"snow" => 38057,"tesla motors" => 167218,"fox news channel" => 52128,"africa" => 194057,"deaths in 2015" => 1821756,"walmart" => 123531,"catherine, duchess of cambridge" => 101436,"central intelligence agency" => 99433,"spongebob squarepants" => 146658,"liam neeson" => 449754,"el niño" => 93516,"koch industries" => 77148,"john boehner" => 38568,"ebola" => 60429,"pope francis" => 192177,"bashar al-assad" => 121700,"facebook" => 1907604,"patient protection and affordable care act" => 156732},
          '201501' => {"taylor swift" => 582391,"count dracula" => 27666,"comet" => 46402,"giant clam" => 8783,"mitch mcconnell" => 36359,"republican party (united states)" => 115451,"democratic party (united states)" => 97018,"murphy's law" => 63428,"eiffel tower" => 161001,"general motors" => 76305,"reese witherspoon" => 183982,"katy perry" => 270972,"stephen hawking" => 1065371,"eclipse" => 20666,"iran" => 197020,"fidel castro" => 175711,"mila kunis" => 284650,"angela merkel" => 94427,"jesus" => 191113,"moon" => 177653,"fifty shades of grey" => 492230,"julianne moore" => 225992,"oculus rift" => 95934,"exxonmobil" => 41216,"kim jong-un" => 368010,"wichita" => 3010,"lithuania" => 133793,"guantanamo bay naval base" => 57052,"antonin scalia" => 25542,"bob dylan" => 186268,"jurassic park" => 34600,"american football" => 113755,"bank" => 87099,"netflix" => 217596,"opec" => 120054,"ruth bader ginsburg" => 38084,"npr" => 21100,"silicon valley" => 86741,"barack obama" => 710554,"assassination_of_john_f._kennedy" => 76611,"benedict cumberbatch" => 488670,"stephen colbert" => 86224,"hydraulic fracturing" => 91616,"asteroid" => 43302,"hillary rodham clinton" => 114803,"israel" => 326152,"quantitative easing" => 119329,"electronic cigarette" => 68728,"international space station" => 128007,"beck" => 52411,"michael keaton" => 429409,"green day" => 95504,"petroleum" => 100614,"google" => 946061,"veto" => 23676,"iraq" => 120362,"japan" => 339872,"clint eastwood" => 343397,"apple inc." => 263200,"eminem" => 395580,"chicago blackhawks" => 29823,"nascar" => 28192,"snow" => 46130,"tesla motors" => 131475,"fox news channel" => 58468,"africa" => 153005,"deaths in 2015" => 1703879,"walmart" => 102932,"catherine, duchess of cambridge" => 95961,"central intelligence agency" => 105378,"spongebob squarepants" => 127247,"liam neeson" => 401274,"el niño" => 42868,"koch industries" => 56076,"john boehner" => 95177,"ebola" => 28099,"pope francis" => 438155,"bashar al-assad" => 84641,"facebook" => 1322429,"patient protection and affordable care act" => 87192},
          '201502' => {"taylor swift" => [309139,15],"count dracula" => [13948,15],"comet" => [20730,15],"giant clam" => [3421,15],"mitch mcconnell" => [10335,15],"republican party (united states)" => [53280,15],"democratic party (united states)" => [46952,15],"murphy's law" => [30507,15],"eiffel tower" => [72044,15],"general motors" => [36280,15],"reese witherspoon" => [71363,15],"katy perry" => [428894,15],"stephen hawking" => [733518,15],"eclipse" => [11987,15],"iran" => [96965,15],"fidel castro" => [120270,15],"mila kunis" => [219683,15],"angela merkel" => [71404,15],"jesus" => [85187,15],"moon" => [75314,15],"fifty shades of grey" => [1324671,15],"julianne moore" => [94489,15],"oculus rift" => [43462,15],"exxonmobil" => [20319,15],"kim jong-un" => [111186,15],"wichita" => [1327,15],"lithuania" => [56108,15],"guantanamo bay naval base" => [17191,15],"antonin scalia" => [19376,15],"bob dylan" => [109026,15],"jurassic park" => [22847,15],"american football" => [93451,15],"bank" => [180460,15],"opec" => [39004,15],"ruth bader ginsburg" => [52078,15],"npr" => [11876,15],"silicon valley" => [44406,15],"barack obama" => [310131,15],"assassination_of_john_f._kennedy" => [36162,15],"netflix" => [103100,15],"benedict cumberbatch" => [169647,15],"stephen colbert" => [50241,15],"hydraulic fracturing" => [33905,15],"asteroid" => [21760,15],"hillary rodham clinton" => [52869,15],"israel" => [159399,15],"quantitative easing" => [30196,15],"electronic cigarette" => [32751,15],"international space station" => [47154,15],"beck" => [682493,15],"michael keaton" => [111992,15],"green day" => [46517,15],"petroleum" => [45395,15],"google" => [412515,15],"veto" => [8697,15],"iraq" => [68025,15],"clint eastwood" => [121037,15],"apple inc." => [140702,15],"eminem" => [195331,15],"japan" => [168720,15],"chicago blackhawks" => [13609,15],"nascar" => [16483,15],"snow" => [19640,15],"tesla motors" => [62469,15],"fox news channel" => [25167,15],"deaths in 2015" => [813847,15],"walmart" => [54039,15],"catherine, duchess of cambridge" => [42343,15],"central intelligence agency" => [38345,15],"africa" => [76591,15],"spongebob squarepants" => [86649,15],"liam neeson" => [118030,15],"el niño" => [19157,15],"koch industries" => [24632,15],"john boehner" => [19160,15],"ebola" => [23286,15],"pope francis" => [86745,15],"bashar al-assad" => [63403,15],"facebook" => [656213,15],"patient protection and affordable care act" => [45554,15]}
          # "201501" => {"taylor swift" => 314733,"count dracula" => 11853,"comet" => 22655,"giant clam" => 4851,"mitch mcconnell" => 20555,"republican party (united states)" => 49819,"democratic party (united states)" => 42618,"murphy's law" => 28762,"eiffel tower" => 79121,"general motors" => 35714,"reese witherspoon" => 92277,"katy perry" => 114601,"stephen hawking" => 509985,"eclipse" => 9356,"iran" => 87363,"fidel castro" => 91242,"mila kunis" => 161065,"angela merkel" => 49990,"jesus" => 101307,"moon" => 65640,"fifty shades of grey" => 175778,"julianne moore" => 110232,"oculus rift" => 42562,"exxonmobil" => 19226,"kim jong-un" => 232222,"wichita" => 1230,"lithuania" => 74242,"antonin scalia" => 9680,"guantanamo bay naval base" => 15375,"bob dylan" => 79216,"jurassic park" => 18512,"american football" => 51369,"bank" => 52755,"netflix" => 103005,"opec" => 62726,"ruth bader ginsburg" => 11907,"npr" => 9778,"silicon valley" => 41455,"barack obama" => 215144,"assassination_of_john_f._kennedy" => 35040,"benedict cumberbatch" => 254769,"stephen colbert" => 47630,"hydraulic fracturing" => 46864,"asteroid" => 17160,"hillary rodham clinton" => 50713,"israel" => 145724,"quantitative easing" => 35781,"electronic cigarette" => 32576,"international space station" => 70602,"beck" => 25344,"michael keaton" => 277198,"green day" => 44833,"petroleum" => 48607,"google" => 471538,"veto" => 11946,"iraq" => 54099,"japan" => 161598,"clint eastwood" => 126204,"apple inc." => 112029,"eminem" => 193775,"chicago blackhawks" => 15094,"nascar" => 12672,"snow" => 21992,"tesla motors" => 63900,"fox news channel" => 28868,"africa" => 69652,"deaths in 2015" => 816276,"walmart" => 47680,"catherine, duchess of cambridge" => 45503,"central intelligence agency" => 46257,"spongebob squarepants" => 52475,"liam neeson" => 243535,"el niño" => 20150,"koch industries" => 17607,"john boehner" => 40319,"ebola" => 14395,"pope francis" => 175476,"bashar al-assad" => 39920,"facebook" => 647170,"patient protection and affordable care act" => 41479,"\"weird al\" yankovic" => 28346,"alice's adventures in wonderland" => 38003,"art" => 33162,"batman" => 89514,"bigfoot" => 27032,"captain america" => 61993,"charlie chaplin" => 85306,"cops (1989 tv series)" => 2071,"elvis presley" => 275122,"espn" => 29823,"great pyramid of giza" => 49876,"jabba the hutt" => 7852,"johnny cash" => 85883,"kentucky derby" => 7791,"louis c.k." => 49721,"mario" => 29873,"michael jackson" => 152175,"michelangelo" => 53937,"minecraft" => 111766,"pharrell williams" => 53314,"samuel l. jackson" => 86989,"scrabble" => 14334,"sesame street" => 18539,"the simpsons" => 89329,"vincent van gogh" => 83817,"wolfgang amadeus mozart" => 79080,"yoga" => 52032,"bee" => 14247,"bill gates" => 152800,"boeing" => 30332,"cannabis (drug)" => 50085,"charles darwin" => 61128,"coca-cola" => 55362,"cold fusion" => 11345,"dinosaur" => 46503,"dolphin" => 32806,"extraterrestrial life" => 21914,"frog" => 41833,"giant panda" => 51791,"goat" => 24475,"goldman sachs" => 31172,"great barrier reef" => 20275,"harvard university" => 53389,"internet" => 119460,"jellyfish" => 24415,"light" => 40169,"mcdonald's" => 53475,"microsoft" => 94588,"nose" => 4625,"periodic table" => 122252,"root" => 10522,"sun" => 81809,"thomas edison" => 90643,"tide" => 20741,"time" => 33395,"youtube" => 351852,"abraham lincoln" => 134418,"adolf hitler" => 189662,"antarctica" => 63051,"assassination of john f. kennedy" => 35040,"aung san suu kyi" => 19983,"beijing" => 57300,"boston" => 58316,"brazil" => 132619,"california" => 120221,"chicago" => 83119,"china" => 203036,"david cameron" => 51870,"egypt" => 94764,"george w. bush" => 86127,"india" => 283239,"lake michigan" => 9008,"mafia" => 17254,"mexico" => 105585,"milwaukee" => 22125,"nigeria" => 106585,"paris" => 119322,"ronald reagan" => 88633,"russia" => 162090,"shanghai" => 56408,"texas" => 66757,"united states" => 426798,"war on drugs" => 14517,"war on poverty" => 8838,"war on terror" => 29710,"b" => 9538,"bead" => 2744,"bean" => 20521,"beard" => 11622,"beer" => 26254,"champagne" => 18627,"earthquake" => 65372,"hipster (contemporary subculture)" => 30088,"list of internet phenomena" => 18047,"main page" => 173430407,"portal:current events" => 452966}
          }

TEAMS = { "Giant Clam" => ["taylor swift", "count dracula", "comet", "giant clam", "mitch mcconnell", "republican party (united states)", "democratic party (united states)", "murphy's law", "eiffel tower", "general motors"],
          "Hot Chicks & Jesus" => ["reese witherspoon", "katy perry", "stephen hawking", "eclipse", "iran", "fidel castro", "mila kunis", "angela merkel", "jesus", "moon"],
          "50 Shades of Wiki" => ["fifty shades of grey","julianne moore","oculus rift","exxonmobil","kim jong-un","wichita","lithuania","guantanamo bay naval base","antonin scalia","bob dylan"],
          "Farticles" => ['jurassic park','american football','bank','opec','ruth bader ginsburg','npr','silicon valley', 'barack obama','assassination_of_john_f._kennedy','netflix'],
          "E-Cigs in space" => ["benedict cumberbatch", "stephen colbert", "hydraulic fracturing", "asteroid", "hillary rodham clinton", "israel", "quantitative easing", "electronic cigarette", "international space station", "beck"],
          "The Google, The Veto, and the Mr. Mom" => ["michael keaton", "green day", "petroleum", "google", "veto", "iraq", "clint eastwood", "apple inc.", "eminem", "japan"],
          "Wiki Wiki What?!" => ["chicago blackhawks", "nascar", "snow", "tesla motors", "fox news channel", "deaths in 2015", "walmart", "catherine, duchess of cambridge", "central intelligence agency","africa"],
          "D's Asters" => ["spongebob squarepants", "liam neeson", "el niño", "koch industries", "john boehner", "ebola", "pope francis", "bashar al-assad", "facebook", "patient protection and affordable care act"]
        }

SCORES = {"Giant Clam" => 32, "Hot Chicks & Jesus" => 32, "50 Shades of Wiki" => 54, "Farticles" => 61, "E-Cigs in space" => 18, "The Google, The Veto, and the Mr. Mom" => 52, "Wiki Wiki What?!" => 22, "D's Asters" => 66}

FREE_AGENTS = ["\"weird al\" yankovic", "alice's adventures in wonderland", "art", "batman", "bigfoot", "captain america", "charlie chaplin", "cops (1989 tv series)", "elvis presley", "espn", "great pyramid of giza", "jabba the hutt", "johnny cash", "kentucky derby", "louis c.k.", "mario", "michael jackson", "michelangelo", "minecraft", "pharrell williams", "samuel l. jackson", "scrabble", "sesame street", "the simpsons", "vincent van gogh", "wolfgang amadeus mozart", "yoga", "bee", "bill gates", "boeing", "cannabis (drug)", "charles darwin", "coca-cola", "cold fusion", "dinosaur", "dolphin", "extraterrestrial life", "frog", "giant panda", "goat", "goldman sachs", "great barrier reef", "harvard university", "internet", "jellyfish", "light", "mcdonald's", "microsoft", "nose", "periodic table", "root", "sun", "thomas edison", "tide", "time", "youtube", "abraham lincoln", "adolf hitler", "antarctica", "assassination of john f. kennedy", "aung san suu kyi", "beijing", "boston", "brazil", "california", "chicago", "china", "david cameron", "egypt", "george w. bush", "india", "lake michigan", "mafia", "mexico", "milwaukee", "nigeria", "paris", "ronald reagan", "russia", "shanghai", "texas", "united states", "war on drugs", "war on poverty", "war on terror", "b", "bead", "bean", "beard", "beer", "champagne", "earthquake", "hipster (contemporary subculture)", "list of internet phenomena", "main page", "portal:current events"]

def views_for_article(article, year, month, display = false)
  cached_value = VALUES["#{year}#{month}"][article] if VALUES["#{year}#{month}"]
  if cached_value
    views = cached_value[0]
    days = cached_value[1]
  else
    content = open(URI.encode("http://stats.grok.se/json/en/#{year}#{month}/#{article}")).read
    views = JSON.parse(content)["daily_views"].values.inject(:+)
    days = JSON.parse(content)["daily_views"].values.select{|v| v > 0}.count
  end
  print "\"#{article}\" => [#{views},#{days}]," if display
  [views,days]
end

def get_updated_projections
  TEAMS.each do |k,v|
    v.each do |art|
      views_for_article(art,"2015","02", true)
    end
  end
  print "}\n"
end

def get_free_agent_projections
  FREE_AGENTS.each do |a|
    views_for_article(a,"2015","02",true)
  end
end 

MONTH_ADJUSTMENT = 28.0 / (Time.now.day - 1)

SCORING_METHOD = "totals"

def display_team_scores
  team_scores = {}
  team_details = "\nDetails (article name, this year views, projected this year views, last year views, projected ratio, projected points)\n"
  TEAMS.each do |k,v| 
    team_details << "\n#{k}:\n\n"
    team_score = 0
    v.each_with_index do |article, index|
      this_year = views_for_article(article,'2015','02')[0].to_f
      this_year_projected = if SCORING_METHOD == "totals"
        this_year * MONTH_ADJUSTMENT
      elsif SCORING_METHOD == "averages"
        this_year * 28.0 / views_for_article(article,'2015','02')[1]
      end
      last_year = views_for_article(article,'2014','02')[0]
      ratio = (this_year_projected / last_year)
      points = determine_points(ratio) * 1.5
      team_score += points if index < 8
      team_details << "#{article}, #{clean_number(this_year)}, #{clean_number(this_year_projected)}, #{clean_number(last_year)}, #{ratio.round(3)}, #{points}\n"
    end
    team_details << "team score: #{team_score}\n"
    team_scores[k] = team_score
  end
  puts "Standings:\n\n"
  team_scores.sort_by{|k,v| v + SCORES[k]}.reverse.each_with_index do |k,i| 
    puts "#{i+1}) #{k[0]}: #{k[1]} (#{k[1] + SCORES[k[0]]})"
  end
  puts team_details
end

def display_free_agent_scores
  FREE_AGENTS.each do |article|
    this_year = views_for_article(article,'2015','02').to_f
    this_year_projected = this_year * MONTH_ADJUSTMENT
    last_year = views_for_article(article,'2014','02')
    ratio = (this_year_projected / last_year).round(3)
    points = determine_points(ratio)
    puts "#{article}, #{clean_number(this_year)}, #{clean_number(this_year_projected)}, #{clean_number(last_year)}, #{ratio}, #{points}"
  end
end

def determine_points(ratio)
  output = 0
  SCORING.each do |k,v|
    output = v if ratio > k
  end
  output
end

def clean_number(float)
  if float >= 1000000
    return (float / 1000000).round(1).to_s + "M"
  elsif float >= 10000
    return (float / 1000).round(0).to_s + "k"
  else
    return float.to_i.to_s
  end
end

def display_article_rankings
  ratios = {}
  TEAMS.each do |k,v|
    v.each do |art|
      ratios[art] = (VALUES['201502'][art].to_f / VALUES['201402'][art]).round(2)
    end
  end
  puts ratios.sort_by{|k,v| v}.reverse.map{|k,v| "#{k}: #{v}"}
end

# display_article_rankings
# display_free_agent_scores

# get_updated_projections
display_team_scores