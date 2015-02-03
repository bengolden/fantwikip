require 'uri'
require 'open-uri'
require 'json'

SCORING = {0 => -4, 0.5 => -2, 0.6 => -1, 0.75 => 0, 0.9 => 1, 0.95 => 2, 1 => 3, 1.05 => 4, 1.15 => 8, 1.3 => 10, 1.6 => 15}

VALUES = {"201401" => {'jurassic park' => 15165,'american football' => 145408,'bank' => 73418,'netflix' => 234251,'opec' => 46222,'ruth bader ginsburg' => 23749,'npr' => 20167,'silicon valley' => 77166,'barack obama' => 595065,'assassination_of_john_f._kennedy' => 107125,'taylor swift' => 428774,'count dracula' => 37016,'comet' => 52961,'giant clam' => 8611,'mitch mcconnell' => 18023,'republican party (united states)' => 113100,'democratic party (united states)' => 97334,"murphy's law" => 73927,'eiffel tower' => 186085,'general motors' => 85661,'reese witherspoon' => 150100,'katy perry' => 497794,'stephen hawking' => 502288,'eclipse' => 29091,'iran' => 195041,'fidel castro' => 158046,'mila kunis' => 315193,'angela merkel' => 84254,'jesus' => 240102,'moon' => 191804,'oculus rift' => 106792,'exxonmobil' => 41486,'kim jong-un' => 250599,'wichita' => 3767,'lithuania' => 118205,'guantanamo bay naval base' => 25719,'antonin scalia' => 24949,'bob dylan' => 218243,'benedict cumberbatch' => 1008861,'stephen colbert' => 73017,'hydraulic fracturing' => 127227,'asteroid' => 48383,'hillary rodham clinton' => 139880,'israel' => 305762,'quantitative easing' => 68083,'electronic cigarette' => 187610,'international space station' => 125999,'beck' => 79689,'michael keaton' => 95131,'green day' => 120669,'petroleum' => 96078,'google' => 705167,'veto' => 16652,'iraq' => 111047,'japan' => 413432,'clint eastwood' => 214626,'apple inc.' => 291177,'eminem' => 673892,'chicago blackhawks' => 40469,'nascar' => 34027,'snow' => 73694,'tesla motors' => 94506,'fox news channel' => 42970,'africa' => 191277,'walmart' => 112050,'catherine, duchess of cambridge' => 99729,'central intelligence agency' => 83513,'spongebob squarepants' => 165060,'liam neeson' => 227999,'el niño' => 53253,'koch industries' => 43052,'john boehner' => 80089,'ebola' => 10523,'pope francis' => 211242,'bashar al-assad' => 81869,'facebook' => 2270399,'patient protection and affordable care act' => 125412,'deaths in 2015' => 1641908,'fifty shades of grey' => 300877,'julianne moore' => 179514,"\"weird al\" yankovic" => 60360,"alice's adventures in wonderland" => 105439,"art" => 88099,"batman" => 229056,"bigfoot" => 105270,"captain america" => 110701,"charlie chaplin" => 219999,"cops (1989 tv series)" => 20052,"elvis presley" => 378763,"espn" => 53897,"great pyramid of giza" => 140732,"jabba the hutt" => 26346,"johnny cash" => 227491,"kentucky derby" => 18309,"louis c.k." => 175290,"mario" => 83673,"michael jackson" => 395370,"michelangelo" => 134980,"minecraft" => 335718,"pharrell williams" => 497547,"samuel l. jackson" => 130884,"scrabble" => 37603,"sesame street" => 50473,"the simpsons" => 238577,"vincent van gogh" => 207571,"wolfgang amadeus mozart" => 169079,"yoga" => 122060,"bee" => 40416,"bill gates" => 435993,"boeing" => 66219,"cannabis (drug)" => 196491,"charles darwin" => 167450,"coca-cola" => 165027,"cold fusion" => 35752,"dinosaur" => 138104,"dolphin" => 119327,"extraterrestrial life" => 58974,"frog" => 56452,"giant panda" => 143533,"goat" => 60743,"goldman sachs" => 86480,"great barrier reef" => 57307,"harvard university" => 135804,"internet" => 501038,"jellyfish" => 73137,"light" => 84442,"mcdonald's" => 141677,"microsoft" => 215922,"nose" => 11992,"periodic table" => 231941,"root" => 28702,"sun" => 215156,"thomas edison" => 256960,"tide" => 56240,"time" => 78109,"youtube" => 1225985,"abraham lincoln" => 450859,"adolf hitler" => 588297,"antarctica" => 189439,"assassination of john f. kennedy" => 107125,"aung san suu kyi" => 52942,"beijing" => 101439,"boston" => 136970,"brazil" => 305075,"california" => 257348,"chicago" => 229741,"china" => 434016,"david cameron" => 106537,"egypt" => 220049,"george w. bush" => 205425,"india" => 1225593,"lake michigan" => 29082,"mafia" => 46753,"mexico" => 247305,"milwaukee" => 69426,"nigeria" => 190693,"paris" => 198296,"ronald reagan" => 239616,"russia" => 390577,"shanghai" => 118168,"texas" => 168658,"united states" => 1540200,"war on drugs" => 31499,"war on poverty" => 25762,"war on terror" => 47144,"b" => 52338,"bead" => 7322,"bean" => 632335,"beard" => 28163,"beer" => 74889,"champagne" => 42064,"earthquake" => 149612,"hipster (contemporary subculture)" => 83284,"list of internet phenomena" => 41997,"main page" => 347202620,"portal:current events" => 1078457},
          '201402' => {"taylor swift" => 322685,"count dracula" => 32836,"comet" => 53083,"giant clam" => 8620,"mitch mcconnell" => 23507,"republican party (united states)" => 116175,"democratic party (united states)" => 99595,"murphy's law" => 71225,"eiffel tower" => 224554,"general motors" => 86011,"reese witherspoon" => 117129,"katy perry" => 424606,"stephen hawking" => 369635,"eclipse" => 33748,"iran" => 202441,"fidel castro" => 146419,"mila kunis" => 346278,"angela merkel" => 87549,"jesus" => 217948,"moon" => 184875,"fifty shades of grey" => 249290,"julianne moore" => 198013,"oculus rift" => 96815,"exxonmobil" => 45213,"kim jong-un" => 122508,"wichita" => 3199,"lithuania" => 137454,"guantanamo bay naval base" => 24339,"antonin scalia" => 30276,"bob dylan" => 238073,"jurassic park" => 21120,"american football" => 175273,"bank" => 69925,"netflix" => 239815,"opec" => 47170,"ruth bader ginsburg" => 23259,"npr" => 21302,"silicon valley" => 86613,"barack obama" => 676482,"assassination_of_john_f._kennedy" => 98721,"benedict cumberbatch" => 493918,"stephen colbert" => 89657,"hydraulic fracturing" => 119176,"asteroid" => 59363,"hillary rodham clinton" => 140062,"israel" => 253264,"quantitative easing" => 61651,"electronic cigarette" => 159416,"international space station" => 115031,"beck" => 141299,"michael keaton" => 112230,"green day" => 127354,"petroleum" => 94927,"google" => 658068,"veto" => 22546,"iraq" => 98772,"japan" => 414627,"clint eastwood" => 213511,"apple inc." => 285528,"eminem" => 624919,"chicago blackhawks" => 42038,"nascar" => 51356,"snow" => 60001,"tesla motors" => 124946,"fox news channel" => 43859,"africa" => 191833,"deaths in 2015" => 1726583,"walmart" => 113154,"catherine, duchess of cambridge" => 95472,"central intelligence agency" => 76429,"spongebob squarepants" => 138222,"liam neeson" => 457877,"el niño" => 70709,"koch industries" => 47648,"john boehner" => 45854,"ebola" => 9448,"pope francis" => 145747,"bashar al-assad" => 108526,"facebook" => 2036460,"patient protection and affordable care act" => 133084},
          '201403' => {"taylor swift" => 307141,"count dracula" => 32615,"comet" => 57384,"giant clam" => 9386,"mitch mcconnell" => 50144,"republican party (united states)" => 137642,"democratic party (united states)" => 119081,"murphy's law" => 80551,"eiffel tower" => 217978,"general motors" => 98317,"reese witherspoon" => 148975,"katy perry" => 426154,"stephen hawking" => 340938,"eclipse" => 38278,"iran" => 212660,"fidel castro" => 156034,"mila kunis" => 545967,"angela merkel" => 130470,"jesus" => 251490,"moon" => 188588,"fifty shades of grey" => 232922,"julianne moore" => 174339,"oculus rift" => 276321,"exxonmobil" => 48263,"kim jong-un" => 184393,"wichita" => 3683,"lithuania" => 179456,"guantanamo bay naval base" => 30702,"antonin scalia" => 33284,"bob dylan" => 218286,"jurassic park" => 28066,"american football" => 103318,"bank" => 69204,"netflix" => 216744,"opec" => 56585,"ruth bader ginsburg" => 28149,"npr" => 25739,"silicon valley" => 90549,"barack obama" => 662691,"assassination_of_john_f._kennedy" => 115677,"benedict cumberbatch" => 480162,"stephen colbert" => 108581,"hydraulic fracturing" => 133124,"asteroid" => 58735,"hillary rodham clinton" => 147893,"israel" => 293677,"quantitative easing" => 59715,"electronic cigarette" => 170489,"international space station" => 274197,"beck" => 153864,"michael keaton" => 116120,"green day" => 132022,"petroleum" => 102494,"google" => 675117,"veto" => 24169,"iraq" => 112976,"japan" => 469388,"clint eastwood" => 219683,"apple inc." => 302832,"eminem" => 729736,"chicago blackhawks" => 40971,"nascar" => 55076,"snow" => 38057,"tesla motors" => 167218,"fox news channel" => 52128,"africa" => 194057,"deaths in 2015" => 1821756,"walmart" => 123531,"catherine, duchess of cambridge" => 101436,"central intelligence agency" => 99433,"spongebob squarepants" => 146658,"liam neeson" => 449754,"el niño" => 93516,"koch industries" => 77148,"john boehner" => 38568,"ebola" => 60429,"pope francis" => 192177,"bashar al-assad" => 121700,"facebook" => 1907604,"patient protection and affordable care act" => 156732},
          '201501' => {"taylor swift" => 582391,"count dracula" => 27666,"comet" => 46402,"giant clam" => 8783,"mitch mcconnell" => 36359,"republican party (united states)" => 115451,"democratic party (united states)" => 97018,"murphy's law" => 63428,"eiffel tower" => 161001,"general motors" => 76305,"reese witherspoon" => 183982,"katy perry" => 270972,"stephen hawking" => 1065371,"eclipse" => 20666,"iran" => 197020,"fidel castro" => 175711,"mila kunis" => 284650,"angela merkel" => 94427,"jesus" => 191113,"moon" => 177653,"fifty shades of grey" => 492230,"julianne moore" => 225992,"oculus rift" => 95934,"exxonmobil" => 41216,"kim jong-un" => 368010,"wichita" => 3010,"lithuania" => 133793,"guantanamo bay naval base" => 57052,"antonin scalia" => 25542,"bob dylan" => 186268,"jurassic park" => 34600,"american football" => 113755,"bank" => 87099,"netflix" => 217596,"opec" => 120054,"ruth bader ginsburg" => 38084,"npr" => 21100,"silicon valley" => 86741,"barack obama" => 710554,"assassination_of_john_f._kennedy" => 76611,"benedict cumberbatch" => 488670,"stephen colbert" => 86224,"hydraulic fracturing" => 91616,"asteroid" => 43302,"hillary rodham clinton" => 114803,"israel" => 326152,"quantitative easing" => 119329,"electronic cigarette" => 68728,"international space station" => 128007,"beck" => 52411,"michael keaton" => 429409,"green day" => 95504,"petroleum" => 100614,"google" => 946061,"veto" => 23676,"iraq" => 120362,"japan" => 339872,"clint eastwood" => 343397,"apple inc." => 263200,"eminem" => 395580,"chicago blackhawks" => 29823,"nascar" => 28192,"snow" => 46130,"tesla motors" => 131475,"fox news channel" => 58468,"africa" => 153005,"deaths in 2015" => 1703879,"walmart" => 102932,"catherine, duchess of cambridge" => 95961,"central intelligence agency" => 105378,"spongebob squarepants" => 127247,"liam neeson" => 401274,"el niño" => 42868,"koch industries" => 56076,"john boehner" => 95177,"ebola" => 28099,"pope francis" => 438155,"bashar al-assad" => 84641,"facebook" => 1322429,"patient protection and affordable care act" => 87192},
          '201502' => {"taylor swift" => 38079,"count dracula" => 1746,"comet" => 2462,"giant clam" => 450,"mitch mcconnell" => 1221,"republican party (united states)" => 6664,"democratic party (united states)" => 6026,"murphy's law" => 3945,"eiffel tower" => 8850,"general motors" => 4293,"reese witherspoon" => 8766,"katy perry" => 189114,"stephen hawking" => 62936,"eclipse" => 1393,"iran" => 11976,"fidel castro" => 7062,"mila kunis" => 21231,"angela merkel" => 7042,"jesus" => 10457,"moon" => 8482,"fifty shades of grey" => 67352,"julianne moore" => 10243,"oculus rift" => 5113,"exxonmobil" => 2710,"kim jong-un" => 18609,"wichita" => 183,"lithuania" => 7203,"guantanamo bay naval base" => 2428,"antonin scalia" => 1240,"bob dylan" => 12245,"jurassic park" => 5280,"american football" => 35292,"bank" => 4005,"opec" => 4572,"ruth bader ginsburg" => 1716,"npr" => 1268,"silicon valley" => 5373,"barack obama" => 35111,"assassination_of_john_f._kennedy" => 4336,"netflix" => 12331,"benedict cumberbatch" => 26191,"stephen colbert" => 3972,"hydraulic fracturing" => 4651,"asteroid" => 2698,"hillary rodham clinton" => 6898,"israel" => 18174,"quantitative easing" => 4706,"electronic cigarette" => 4367,"international space station" => 6420,"beck" => 3467,"michael keaton" => 12285,"green day" => 6257,"petroleum" => 5771,"google" => 55217,"veto" => 1011,"iraq" => 7660,"clint eastwood" => 17367,"apple inc." => 17842,"eminem" => 22858,"japan" => 21659,"chicago blackhawks" => 1626,"nascar" => 2291,"snow" => 2898,"tesla motors" => 7447,"fox news channel" => 2650,"deaths in 2015" => 104503,"walmart" => 6267,"catherine, duchess of cambridge" => 5616,"central intelligence agency" => 4663,"africa" => 9233,"spongebob squarepants" => 9334,"liam neeson" => 23787,"el niño" => 2398,"koch industries" => 3732,"john boehner" => 2090,"ebola" => 1403,"pope francis" => 11661,"bashar al-assad" => 5252,"facebook" => 76942,"patient protection and affordable care act" => 6087}
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
    views = cached_value
  else
    content = open(URI.encode("http://stats.grok.se/json/en/#{year}#{month}/#{article}")).read
    views = JSON.parse(content)["daily_views"].values.inject(:+)
  end
  print "\"#{article}\" => #{views}," if display
  views
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

def display_team_scores
  team_scores = {}
  team_details = "\nDetails (article name, this year views, projected this year views, last year views, projected ratio, projected points)\n"
  TEAMS.each do |k,v| 
    team_details << "\n#{k}:\n\n"
    team_score = 0
    v.each_with_index do |article, index|
      this_year = views_for_article(article,'2015','02').to_f
      this_year_projected = this_year * MONTH_ADJUSTMENT
      last_year = views_for_article(article,'2014','02')
      ratio = (this_year_projected / last_year).round(3)
      points = determine_points(ratio) * 1.5
      team_score += points if index < 8
      team_details << "#{article}, #{clean_number(this_year)}, #{clean_number(this_year_projected)}, #{clean_number(last_year)}, #{ratio}, #{points}\n"
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