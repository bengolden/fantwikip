require 'open-uri'
require 'json'

VALUES = {"201401" => {'jurassic%20park' => 15165,'american%20football' => 145408,'bank' => 73418,'netflix' => 234251,'opec' => 46222,'ruth%20bader%20ginsburg' => 23749,'npr' => 20167,'silicon%20valley' => 77166,'barack%20obama' => 595065,'assassination_of_john_f._kennedy' => 107125,'taylor%20swift' => 428774,'count%20dracula' => 37016,'comet' => 52961,'giant%20clam' => 8611,'mitch%20mcconnell' => 18023,'republican%20party%20(united%20states)' => 113100,'democratic%20party%20(united%20states)' => 97334,"murphy's%20law" => 73927,'eiffel%20tower' => 186085,'general%20motors' => 85661,'reese%20witherspoon' => 150100,'katy%20perry' => 497794,'stephen%20hawking' => 502288,'eclipse' => 29091,'iran' => 195041,'fidel%20castro' => 158046,'mila%20kunis' => 315193,'angela%20merkel' => 84254,'jesus' => 240102,'moon' => 191804,'oculus%20rift' => 106792,'exxonmobil' => 41486,'kim%20jong-un' => 250599,'wichita' => 3767,'lithuania' => 118205,'guantanamo%20bay%20naval%20base' => 25719,'antonin%20scalia' => 24949,'bob%20dylan' => 218243,'benedict%20cumberbatch' => 1008861,'stephen%20colbert' => 73017,'hydraulic%20fracturing' => 127227,'asteroid' => 48383,'hillary%20rodham%20clinton' => 139880,'israel' => 305762,'quantitative%20easing' => 68083,'electronic%20cigarette' => 187610,'international%20space%20station' => 125999,'beck' => 79689,'michael%20keaton' => 95131,'green%20day' => 120669,'petroleum' => 96078,'google' => 705167,'veto' => 16652,'iraq' => 111047,'japan' => 413432,'clint%20eastwood' => 214626,'apple%20inc.' => 291177,'eminem' => 673892,'chicago%20blackhawks' => 40469,'nascar' => 34027,'snow' => 73694,'tesla%20motors' => 94506,'fox%20news%20channel' => 42970,'africa' => 191277,'walmart' => 112050,'catherine,%20duchess%20of%20cambridge' => 99729,'central%20intelligence%20agency' => 83513,'spongebob%20squarepants' => 165060,'liam%20neeson' => 227999,'el%20niño' => 53253,'koch%20industries' => 43052,'john%20boehner' => 80089,'ebola' => 10523,'pope%20francis' => 211242,'bashar%20al-assad' => 81869,'facebook' => 2270399,'patient%20protection%20and%20affordable%20care%20act' => 125412,'deaths%20in%202015' => 1641908,'fifty%20shades%20of%20grey' => 300877,'julianne%20moore' => 179514},
          "201501" => {'taylor%20swift' => 232503, 'count%20dracula' => 8691, 'comet' => 15522, 'giant%20clam' => 2217, 'mitch%20mcconnell' => 16396, 'republican%20party%20(united%20states)' => 35053, 'democratic%20party%20(united%20states)' => 29770, "murphy's%20law" => 20421, 'eiffel%20tower' => 53603, 'general%20motors' => 24526, 'reese%20witherspoon' => 60989, 'katy%20perry' => 82574, 'stephen%20hawking' => 329862, 'eclipse' => 6559, 'iran' => 60803, 'fidel%20castro' => 67322, 'mila%20kunis' => 133734, 'angela%20merkel' => 32101, 'jesus' => 72824, 'moon' => 42041, 'fifty%20shades%20of%20grey' => 105625, 'julianne%20moore' => 54159, 'oculus%20rift' => 31161, 'exxonmobil' => 12891, 'kim%20jong-un' => 185947, 'wichita' => 809, 'lithuania' => 58153, 'antonin%20scalia' => 6445, 'guantanamo%20bay%20naval%20base' => 9997, 'bob%20dylan' => 56590, 'jurassic%20park' => 14380, 'american%20football' => 33390, 'bank' => 37884, 'netflix' => 74529, 'opec' => 39753, 'ruth%20bader%20ginsburg' => 8385, 'npr' => 6763, 'silicon%20valley' => 29212, 'barack%20obama' => 148138, 'assassination_of_john_f._kennedy' => 24243, 'benedict%20cumberbatch' => 178178, 'stephen%20colbert' => 35610, 'hydraulic%20fracturing' => 33063, 'asteroid' => 11669, 'hillary%20rodham%20clinton' => 36819, 'israel' => 93214, 'quantitative%20easing' => 22957, 'electronic%20cigarette' => 23051, 'international%20space%20station' => 38651, 'beck' => 18522, 'michael%20keaton' => 63823, 'green%20day' => 32537, 'petroleum' => 32350, 'google' => 342949, 'veto' => 8733, 'iraq' => 36746, 'japan' => 114348, 'clint%20eastwood' => 83337, 'apple%20inc.' => 76845, 'eminem' => 139285, 'chicago%20blackhawks' => 11369, 'nascar' => 8784, 'snow' => 15653, 'tesla%20motors' => 46444, 'fox%20news%20channel' => 18074, 'africa' => 45523, 'deaths%20in%202015' => 587727, 'walmart' => 32590, 'catherine,%20duchess%20of%20cambridge' => 34319, 'central%20intelligence%20agency' => 28424, 'spongebob%20squarepants' => 39225, 'liam%20neeson' => 175911, 'el%20niño' => 14025, 'koch%20industries' => 12637, 'john%20boehner' => 29249, 'ebola' => 10129, 'pope%20francis' => 97150, 'bashar%20al-assad' => 27835, 'facebook' => 487813, 'patient%20protection%20and%20affordable%20care%20act' => 29759}
          }

TEAMS = { "Moser's Hosers" => ["taylor%20swift", "count%20dracula", "comet", "giant%20clam", "mitch%20mcconnell", "republican%20party%20(united%20states)", "democratic%20party%20(united%20states)", "murphy's%20law", "eiffel%20tower", "general%20motors"],
          "Hot Chicks & Jesus" => ["reese%20witherspoon", "katy%20perry", "stephen%20hawking", "eclipse", "iran", "fidel%20castro", "mila%20kunis", "angela%20merkel", "jesus", "moon"],
          "50 Shades of Wiki" => ["fifty%20shades%20of%20grey","julianne%20moore","oculus%20rift","exxonmobil","kim%20jong-un","wichita","lithuania","antonin%20scalia","guantanamo%20bay%20naval%20base","bob%20dylan"],
          "Farticles" => ['jurassic%20park','american%20football','bank','netflix','opec','ruth%20bader%20ginsburg','npr','silicon%20valley', 'barack%20obama','assassination_of_john_f._kennedy'],
          "Chris's Misses" => ["benedict%20cumberbatch", "stephen%20colbert", "hydraulic%20fracturing", "asteroid", "hillary%20rodham%20clinton", "israel", "quantitative%20easing", "electronic%20cigarette", "international%20space%20station", "beck"],
          "Damia...notgonnawin" => ["michael%20keaton", "green%20day", "petroleum", "google", "veto", "iraq", "japan", "clint%20eastwood", "apple%20inc.", "eminem"],
          "Drake's Mistakes" => ["chicago%20blackhawks", "nascar", "snow", "tesla%20motors", "fox%20news%20channel", "africa", "deaths%20in%202015", "walmart", "catherine,%20duchess%20of%20cambridge", "central%20intelligence%20agency"],
          "D's Asters" => ["spongebob%20squarepants", "liam%20neeson", "el%20niño", "koch%20industries", "john%20boehner", "ebola", "pope%20francis", "bashar%20al-assad", "facebook", "patient%20protection%20and%20affordable%20care%20act"],
        }

SCORING = {0 => -4, 0.5 => -2, 0.6 => -1, 0.75 => 0, 0.9 => 1, 0.95 => 2, 1 => 3, 1.05 => 4, 1.15 => 8, 1.3 => 10, 1.6 => 15}

def views_for_article(article, year, month)
  cached_value = VALUES["#{year}#{month}"][article] if VALUES["#{year}#{month}"]
  # puts "\n#{article.gsub("%20",' ').capitalize}\n"
  if cached_value
    views = cached_value
  else
    content = open("http://stats.grok.se/json/en/#{year}#{month}/#{article}").read
    views = JSON.parse(content)["daily_views"].values.inject(:+)
  end
  # puts "\"#{article}\" => #{views},"
  views
end

def get_updated_projections
  TEAMS.each do |k,v|
    v.each do |art|
      views_for_article(art,"2015","01")
    end
  end
end

MONTH_ADJUSTMENT = 31.0 / 11

def display_projected_values
  puts "article name, this year views, projected this year views, last year views, projected ratio, projected points"
  TEAMS.each do |k,v| 
    puts "\n#{k}:\n\n"
    team_score = 0
    v.each_with_index do |article, index|
      this_year = views_for_article(article,'2015','01').to_f
      this_year_projected = this_year * MONTH_ADJUSTMENT
      last_year = views_for_article(article,'2014','01')
      ratio = (this_year_projected / last_year).round(3)
      points = 0
      SCORING.each do |k,v|
        points = v if ratio > k
      end
      team_score += points if index < 8
      puts "#{article.gsub('%20'," ")}, #{this_year.to_i}, #{this_year_projected.to_i}, #{last_year}, #{ratio}, #{points}"
    end
    puts "team score: #{team_score}"
  end
end

display_projected_values
# get_updated_projections