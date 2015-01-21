require 'uri'
require 'open-uri'
require 'json'

SCORING = {0 => -4, 0.5 => -2, 0.6 => -1, 0.75 => 0, 0.9 => 1, 0.95 => 2, 1 => 3, 1.05 => 4, 1.15 => 8, 1.3 => 10, 1.6 => 15}

VALUES = {"201401" => {'jurassic park' => 15165,'american football' => 145408,'bank' => 73418,'netflix' => 234251,'opec' => 46222,'ruth bader ginsburg' => 23749,'npr' => 20167,'silicon valley' => 77166,'barack obama' => 595065,'assassination_of_john_f._kennedy' => 107125,'taylor swift' => 428774,'count dracula' => 37016,'comet' => 52961,'giant clam' => 8611,'mitch mcconnell' => 18023,'republican party (united states)' => 113100,'democratic party (united states)' => 97334,"murphy's law" => 73927,'eiffel tower' => 186085,'general motors' => 85661,'reese witherspoon' => 150100,'katy perry' => 497794,'stephen hawking' => 502288,'eclipse' => 29091,'iran' => 195041,'fidel castro' => 158046,'mila kunis' => 315193,'angela merkel' => 84254,'jesus' => 240102,'moon' => 191804,'oculus rift' => 106792,'exxonmobil' => 41486,'kim jong-un' => 250599,'wichita' => 3767,'lithuania' => 118205,'guantanamo bay naval base' => 25719,'antonin scalia' => 24949,'bob dylan' => 218243,'benedict cumberbatch' => 1008861,'stephen colbert' => 73017,'hydraulic fracturing' => 127227,'asteroid' => 48383,'hillary rodham clinton' => 139880,'israel' => 305762,'quantitative easing' => 68083,'electronic cigarette' => 187610,'international space station' => 125999,'beck' => 79689,'michael keaton' => 95131,'green day' => 120669,'petroleum' => 96078,'google' => 705167,'veto' => 16652,'iraq' => 111047,'japan' => 413432,'clint eastwood' => 214626,'apple inc.' => 291177,'eminem' => 673892,'chicago blackhawks' => 40469,'nascar' => 34027,'snow' => 73694,'tesla motors' => 94506,'fox news channel' => 42970,'africa' => 191277,'walmart' => 112050,'catherine, duchess of cambridge' => 99729,'central intelligence agency' => 83513,'spongebob squarepants' => 165060,'liam neeson' => 227999,'el niño' => 53253,'koch industries' => 43052,'john boehner' => 80089,'ebola' => 10523,'pope francis' => 211242,'bashar al-assad' => 81869,'facebook' => 2270399,'patient protection and affordable care act' => 125412,'deaths in 2015' => 1641908,'fifty shades of grey' => 300877,'julianne moore' => 179514,"\"weird al\" yankovic" => 60360,"alice's adventures in wonderland" => 105439,"art" => 88099,"batman" => 229056,"bigfoot" => 105270,"captain america" => 110701,"charlie chaplin" => 219999,"cops (1989 tv series)" => 20052,"elvis presley" => 378763,"espn" => 53897,"great pyramid of giza" => 140732,"jabba the hutt" => 26346,"johnny cash" => 227491,"kentucky derby" => 18309,"louis c.k." => 175290,"mario" => 83673,"michael jackson" => 395370,"michelangelo" => 134980,"minecraft" => 335718,"pharrell williams" => 497547,"samuel l. jackson" => 130884,"scrabble" => 37603,"sesame street" => 50473,"the simpsons" => 238577,"vincent van gogh" => 207571,"wolfgang amadeus mozart" => 169079,"yoga" => 122060,"bee" => 40416,"bill gates" => 435993,"boeing" => 66219,"cannabis (drug)" => 196491,"charles darwin" => 167450,"coca-cola" => 165027,"cold fusion" => 35752,"dinosaur" => 138104,"dolphin" => 119327,"extraterrestrial life" => 58974,"frog" => 56452,"giant panda" => 143533,"goat" => 60743,"goldman sachs" => 86480,"great barrier reef" => 57307,"harvard university" => 135804,"internet" => 501038,"jellyfish" => 73137,"light" => 84442,"mcdonald's" => 141677,"microsoft" => 215922,"nose" => 11992,"periodic table" => 231941,"root" => 28702,"sun" => 215156,"thomas edison" => 256960,"tide" => 56240,"time" => 78109,"youtube" => 1225985,"abraham lincoln" => 450859,"adolf hitler" => 588297,"antarctica" => 189439,"assassination of john f. kennedy" => 107125,"aung san suu kyi" => 52942,"beijing" => 101439,"boston" => 136970,"brazil" => 305075,"california" => 257348,"chicago" => 229741,"china" => 434016,"david cameron" => 106537,"egypt" => 220049,"george w. bush" => 205425,"india" => 1225593,"lake michigan" => 29082,"mafia" => 46753,"mexico" => 247305,"milwaukee" => 69426,"nigeria" => 190693,"paris" => 198296,"ronald reagan" => 239616,"russia" => 390577,"shanghai" => 118168,"texas" => 168658,"united states" => 1540200,"war on drugs" => 31499,"war on poverty" => 25762,"war on terror" => 47144,"b" => 52338,"bead" => 7322,"bean" => 632335,"beard" => 28163,"beer" => 74889,"champagne" => 42064,"earthquake" => 149612,"hipster (contemporary subculture)" => 83284,"list of internet phenomena" => 41997,"main page" => 347202620,"portal:current events" => 1078457},
          "201501" => {"taylor swift" => 404576,"count dracula" => 16875,"comet" => 29936,"giant clam" => 6191,"mitch mcconnell" => 24275,"republican party (united states)" => 66175,"democratic party (united states)" => 56473,"murphy's law" => 37808,"eiffel tower" => 104580,"general motors" => 47314,"reese witherspoon" => 130022,"katy perry" => 151575,"stephen hawking" => 724093,"eclipse" => 12808,"iran" => 119402,"fidel castro" => 111966,"mila kunis" => 197511,"angela merkel" => 62813,"jesus" => 131363,"moon" => 118278,"fifty shades of grey" => 246015,"julianne moore" => 151948,"oculus rift" => 56766,"exxonmobil" => 25410,"kim jong-un" => 268668,"wichita" => 1876,"lithuania" => 92434,"antonin scalia" => 14590,"guantanamo bay naval base" => 21403,"bob dylan" => 105156,"jurassic park" => 23630,"american football" => 71605,"bank" => 64765,"netflix" => 135426,"opec" => 80517,"ruth bader ginsburg" => 17330,"npr" => 12997,"silicon valley" => 55209,"barack obama" => 297705,"assassination_of_john_f._kennedy" => 47741,"benedict cumberbatch" => 335377,"stephen colbert" => 60734,"hydraulic fracturing" => 59327,"asteroid" => 23667,"hillary rodham clinton" => 66468,"israel" => 200081,"quantitative easing" => 54634,"electronic cigarette" => 42634,"international space station" => 92784,"beck" => 34135,"michael keaton" => 345700,"green day" => 60098,"petroleum" => 64407,"google" => 617487,"veto" => 14562,"iraq" => 73453,"japan" => 215951,"clint eastwood" => 211957,"apple inc." => 149348,"eminem" => 252870,"chicago blackhawks" => 19445,"nascar" => 16999,"snow" => 28179,"tesla motors" => 84287,"fox news channel" => 38464,"africa" => 95173,"deaths in 2015" => 1098020,"walmart" => 65527,"catherine, duchess of cambridge" => 60203,"central intelligence agency" => 59263,"spongebob squarepants" => 68706,"liam neeson" => 302865,"el niño" => 27367,"koch industries" => 24548,"john boehner" => 46840,"ebola" => 18466,"pope francis" => 322340,"bashar al-assad" => 53942,"facebook" => 846728,"patient protection and affordable care act" => 53025}
          # "201501" => {"taylor swift" => 314733,"count dracula" => 11853,"comet" => 22655,"giant clam" => 4851,"mitch mcconnell" => 20555,"republican party (united states)" => 49819,"democratic party (united states)" => 42618,"murphy's law" => 28762,"eiffel tower" => 79121,"general motors" => 35714,"reese witherspoon" => 92277,"katy perry" => 114601,"stephen hawking" => 509985,"eclipse" => 9356,"iran" => 87363,"fidel castro" => 91242,"mila kunis" => 161065,"angela merkel" => 49990,"jesus" => 101307,"moon" => 65640,"fifty shades of grey" => 175778,"julianne moore" => 110232,"oculus rift" => 42562,"exxonmobil" => 19226,"kim jong-un" => 232222,"wichita" => 1230,"lithuania" => 74242,"antonin scalia" => 9680,"guantanamo bay naval base" => 15375,"bob dylan" => 79216,"jurassic park" => 18512,"american football" => 51369,"bank" => 52755,"netflix" => 103005,"opec" => 62726,"ruth bader ginsburg" => 11907,"npr" => 9778,"silicon valley" => 41455,"barack obama" => 215144,"assassination_of_john_f._kennedy" => 35040,"benedict cumberbatch" => 254769,"stephen colbert" => 47630,"hydraulic fracturing" => 46864,"asteroid" => 17160,"hillary rodham clinton" => 50713,"israel" => 145724,"quantitative easing" => 35781,"electronic cigarette" => 32576,"international space station" => 70602,"beck" => 25344,"michael keaton" => 277198,"green day" => 44833,"petroleum" => 48607,"google" => 471538,"veto" => 11946,"iraq" => 54099,"japan" => 161598,"clint eastwood" => 126204,"apple inc." => 112029,"eminem" => 193775,"chicago blackhawks" => 15094,"nascar" => 12672,"snow" => 21992,"tesla motors" => 63900,"fox news channel" => 28868,"africa" => 69652,"deaths in 2015" => 816276,"walmart" => 47680,"catherine, duchess of cambridge" => 45503,"central intelligence agency" => 46257,"spongebob squarepants" => 52475,"liam neeson" => 243535,"el niño" => 20150,"koch industries" => 17607,"john boehner" => 40319,"ebola" => 14395,"pope francis" => 175476,"bashar al-assad" => 39920,"facebook" => 647170,"patient protection and affordable care act" => 41479,"\"weird al\" yankovic" => 28346,"alice's adventures in wonderland" => 38003,"art" => 33162,"batman" => 89514,"bigfoot" => 27032,"captain america" => 61993,"charlie chaplin" => 85306,"cops (1989 tv series)" => 2071,"elvis presley" => 275122,"espn" => 29823,"great pyramid of giza" => 49876,"jabba the hutt" => 7852,"johnny cash" => 85883,"kentucky derby" => 7791,"louis c.k." => 49721,"mario" => 29873,"michael jackson" => 152175,"michelangelo" => 53937,"minecraft" => 111766,"pharrell williams" => 53314,"samuel l. jackson" => 86989,"scrabble" => 14334,"sesame street" => 18539,"the simpsons" => 89329,"vincent van gogh" => 83817,"wolfgang amadeus mozart" => 79080,"yoga" => 52032,"bee" => 14247,"bill gates" => 152800,"boeing" => 30332,"cannabis (drug)" => 50085,"charles darwin" => 61128,"coca-cola" => 55362,"cold fusion" => 11345,"dinosaur" => 46503,"dolphin" => 32806,"extraterrestrial life" => 21914,"frog" => 41833,"giant panda" => 51791,"goat" => 24475,"goldman sachs" => 31172,"great barrier reef" => 20275,"harvard university" => 53389,"internet" => 119460,"jellyfish" => 24415,"light" => 40169,"mcdonald's" => 53475,"microsoft" => 94588,"nose" => 4625,"periodic table" => 122252,"root" => 10522,"sun" => 81809,"thomas edison" => 90643,"tide" => 20741,"time" => 33395,"youtube" => 351852,"abraham lincoln" => 134418,"adolf hitler" => 189662,"antarctica" => 63051,"assassination of john f. kennedy" => 35040,"aung san suu kyi" => 19983,"beijing" => 57300,"boston" => 58316,"brazil" => 132619,"california" => 120221,"chicago" => 83119,"china" => 203036,"david cameron" => 51870,"egypt" => 94764,"george w. bush" => 86127,"india" => 283239,"lake michigan" => 9008,"mafia" => 17254,"mexico" => 105585,"milwaukee" => 22125,"nigeria" => 106585,"paris" => 119322,"ronald reagan" => 88633,"russia" => 162090,"shanghai" => 56408,"texas" => 66757,"united states" => 426798,"war on drugs" => 14517,"war on poverty" => 8838,"war on terror" => 29710,"b" => 9538,"bead" => 2744,"bean" => 20521,"beard" => 11622,"beer" => 26254,"champagne" => 18627,"earthquake" => 65372,"hipster (contemporary subculture)" => 30088,"list of internet phenomena" => 18047,"main page" => 173430407,"portal:current events" => 452966}
          }

TEAMS = { "Giant Clam" => ["taylor swift", "count dracula", "comet", "giant clam", "mitch mcconnell", "republican party (united states)", "democratic party (united states)", "murphy's law", "eiffel tower", "general motors"],
          "Hot Chicks & Jesus" => ["reese witherspoon", "katy perry", "stephen hawking", "eclipse", "iran", "fidel castro", "mila kunis", "angela merkel", "jesus", "moon"],
          "50 Shades of Wiki" => ["fifty shades of grey","julianne moore","oculus rift","exxonmobil","kim jong-un","wichita","lithuania","antonin scalia","guantanamo bay naval base","bob dylan"],
          "Farticles" => ['jurassic park','american football','bank','netflix','opec','ruth bader ginsburg','npr','silicon valley', 'barack obama','assassination_of_john_f._kennedy'],
          "E-Cigs in space" => ["benedict cumberbatch", "stephen colbert", "hydraulic fracturing", "asteroid", "hillary rodham clinton", "israel", "quantitative easing", "electronic cigarette", "international space station", "beck"],
          "The Google, The Veto, and the Mr. Mom" => ["michael keaton", "green day", "petroleum", "google", "veto", "iraq", "japan", "clint eastwood", "apple inc.", "eminem"],
          "Wiki Wiki What?!" => ["chicago blackhawks", "nascar", "snow", "tesla motors", "fox news channel", "africa", "deaths in 2015", "walmart", "catherine, duchess of cambridge", "central intelligence agency"],
          "D's Asters" => ["spongebob squarepants", "liam neeson", "el niño", "koch industries", "john boehner", "ebola", "pope francis", "bashar al-assad", "facebook", "patient protection and affordable care act"]
        }

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
      views_for_article(art,"2015","01", true)
    end
  end
  print "}"
end

def get_free_agent_projections
  FREE_AGENTS.each do |a|
    views_for_article(a,"2015","01",true)
  end
end 

MONTH_ADJUSTMENT = 31.0 / 20

def display_team_scores
  team_scores = {}
  team_details = "\nDetails (article name, this year views, projected this year views, last year views, projected ratio, projected points)\n"
  TEAMS.each do |k,v| 
    team_details << "\n#{k}:\n\n"
    team_score = 0
    v.each_with_index do |article, index|
      this_year = views_for_article(article,'2015','01').to_f
      this_year_projected = this_year * MONTH_ADJUSTMENT
      last_year = views_for_article(article,'2014','01')
      ratio = (this_year_projected / last_year).round(3)
      points = determine_points(ratio)
      team_score += points if index < 8
      team_details << "#{article}, #{clean_number(this_year)}, #{clean_number(this_year_projected)}, #{clean_number(last_year)}, #{ratio}, #{points}\n"
    end
    team_details << "team score: #{team_score}\n"
    team_scores[k] = team_score
  end
  puts "Standings:\n\n"
  team_scores.sort_by{|k,v| v}.reverse.each_with_index do |k,i| 
    puts "#{i+1}) #{k[0]}: #{k[1]}"
  end
  puts team_details
end

def display_free_agent_scores
  FREE_AGENTS.each do |article|
    this_year = views_for_article(article,'2015','01').to_f
    this_year_projected = this_year * MONTH_ADJUSTMENT
    last_year = views_for_article(article,'2014','01')
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
  elsif float >= 1000
    return (float / 1000).round(0).to_s + "k"
  else
    return float.to_s
  end
end

display_team_scores
# get_updated_projections