require 'uri'
require 'open-uri'
require 'json'

VALUES = {"201401" => {'jurassic park' => 15165,'american football' => 145408,'bank' => 73418,'netflix' => 234251,'opec' => 46222,'ruth bader ginsburg' => 23749,'npr' => 20167,'silicon valley' => 77166,'barack obama' => 595065,'assassination_of_john_f._kennedy' => 107125,'taylor swift' => 428774,'count dracula' => 37016,'comet' => 52961,'giant clam' => 8611,'mitch mcconnell' => 18023,'republican party (united states)' => 113100,'democratic party (united states)' => 97334,"murphy's law" => 73927,'eiffel tower' => 186085,'general motors' => 85661,'reese witherspoon' => 150100,'katy perry' => 497794,'stephen hawking' => 502288,'eclipse' => 29091,'iran' => 195041,'fidel castro' => 158046,'mila kunis' => 315193,'angela merkel' => 84254,'jesus' => 240102,'moon' => 191804,'oculus rift' => 106792,'exxonmobil' => 41486,'kim jong-un' => 250599,'wichita' => 3767,'lithuania' => 118205,'guantanamo bay naval base' => 25719,'antonin scalia' => 24949,'bob dylan' => 218243,'benedict cumberbatch' => 1008861,'stephen colbert' => 73017,'hydraulic fracturing' => 127227,'asteroid' => 48383,'hillary rodham clinton' => 139880,'israel' => 305762,'quantitative easing' => 68083,'electronic cigarette' => 187610,'international space station' => 125999,'beck' => 79689,'michael keaton' => 95131,'green day' => 120669,'petroleum' => 96078,'google' => 705167,'veto' => 16652,'iraq' => 111047,'japan' => 413432,'clint eastwood' => 214626,'apple inc.' => 291177,'eminem' => 673892,'chicago blackhawks' => 40469,'nascar' => 34027,'snow' => 73694,'tesla motors' => 94506,'fox news channel' => 42970,'africa' => 191277,'walmart' => 112050,'catherine, duchess of cambridge' => 99729,'central intelligence agency' => 83513,'spongebob squarepants' => 165060,'liam neeson' => 227999,'el niño' => 53253,'koch industries' => 43052,'john boehner' => 80089,'ebola' => 10523,'pope francis' => 211242,'bashar al-assad' => 81869,'facebook' => 2270399,'patient protection and affordable care act' => 125412,'deaths in 2015' => 1641908,'fifty shades of grey' => 300877,'julianne moore' => 179514}
          }

TEAMS = { "Giant Clam" => ["taylor swift", "count dracula", "comet", "giant clam", "mitch mcconnell", "republican party (united states)", "democratic party (united states)", "murphy's law", "eiffel tower", "general motors"],
          "Hot Chicks & Jesus" => ["reese witherspoon", "katy perry", "stephen hawking", "eclipse", "iran", "fidel castro", "mila kunis", "angela merkel", "jesus", "moon"],
          "50 Shades of Wiki" => ["fifty shades of grey","julianne moore","oculus rift","exxonmobil","kim jong-un","wichita","lithuania","antonin scalia","guantanamo bay naval base","bob dylan"],
          "Farticles" => ['jurassic park','american football','bank','netflix','opec','ruth bader ginsburg','npr','silicon valley', 'barack obama','assassination_of_john_f._kennedy'],
          "E-Cigs in space" => ["benedict cumberbatch", "stephen colbert", "hydraulic fracturing", "asteroid", "hillary rodham clinton", "israel", "quantitative easing", "electronic cigarette", "international space station", "beck"],
          "The Google, The Veto, and the Mr. Mom" => ["michael keaton", "green day", "petroleum", "google", "veto", "iraq", "japan", "clint eastwood", "apple inc.", "eminem"],
          "Wiki Wiki What?!" => ["chicago blackhawks", "nascar", "snow", "tesla motors", "fox news channel", "africa", "deaths in 2015", "walmart", "catherine, duchess of cambridge", "central intelligence agency"],
          "D's Asters" => ["spongebob squarepants", "liam neeson", "el niño", "koch industries", "john boehner", "ebola", "pope francis", "bashar al-assad", "facebook", "patient protection and affordable care act"],
        }

FREE_AGENTS = []

SCORING = {0 => -4, 0.5 => -2, 0.6 => -1, 0.75 => 0, 0.9 => 1, 0.95 => 2, 1 => 3, 1.05 => 4, 1.15 => 8, 1.3 => 10, 1.6 => 15}

def views_for_article(article, year, month, display = false)
  cached_value = VALUES["#{year}#{month}"][article] if VALUES["#{year}#{month}"]
  if cached_value
    views = cached_value
  else
    content = open(URI.encode("http://stats.grok.se/json/en/#{year}#{month}/#{article}")).read
    views = JSON.parse(content)["daily_views"].values.inject(:+)
  end
  puts "\"#{article}\" => #{views}," if display
  views
end

def get_updated_projections
  TEAMS.each do |k,v|
    v.each do |art|
      views_for_article(art,"2015","01", true)
    end
  end
end

MONTH_ADJUSTMENT = 31.0 / 13

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
      puts "#{article}, #{this_year.to_i}, #{this_year_projected.to_i}, #{last_year}, #{ratio}, #{points}"
    end
    puts "team score: #{team_score}"
  end
end

display_projected_values
# get_updated_projections
