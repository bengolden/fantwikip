require 'uri'
require 'open-uri'
require 'json'

SCORING = {0 => -4, 0.5 => -2, 0.6 => -1, 0.75 => 0, 0.9 => 1, 0.95 => 2, 1 => 3, 1.05 => 4, 1.15 => 8, 1.3 => 10, 1.6 => 15}

VALUES = {
          '201402' => {"taylor swift" => [322685,28],"count dracula" => [32836,28],"comet" => [53083,28],"giant clam" => [8620,28],"mitch mcconnell" => [23507,28],"republican party (united states)" => [116175,28],"democratic party (united states)" => [99595,28],"murphy's law" => [71225,28],"eiffel tower" => [224554,28],"general motors" => [86011,28],"reese witherspoon" => [117129,28],"katy perry" => [424606,28],"stephen hawking" => [369635,28],"eclipse" => [33748,28],"iran" => [202441,28],"fidel castro" => [146419,28],"mila kunis" => [346278,28],"angela merkel" => [87549,28],"jesus" => [217948,28],"moon" => [184875,28],"fifty shades of grey" => [249290,28],"julianne moore" => [198013,28],"oculus rift" => [96815,28],"exxonmobil" => [45213,28],"kim jong-un" => [122508,28],"wichita" => [3199,28],"lithuania" => [137454,28],"guantanamo bay naval base" => [24339,28],"antonin scalia" => [30276,28],"bob dylan" => [238073,28],"jurassic park" => [21120,28],"american football" => [175273,28],"bank" => [69925,28],"opec" => [47170,28],"ruth bader ginsburg" => [23259,28],"npr" => [21302,28],"silicon valley" => [86613,28],"barack obama" => [676482,28],"assassination_of_john_f._kennedy" => [98721,28],"netflix" => [239815,28],"benedict cumberbatch" => [493918,28],"stephen colbert" => [89657,28],"hydraulic fracturing" => [119176,28],"asteroid" => [59363,28],"hillary rodham clinton" => [140062,28],"israel" => [253264,28],"quantitative easing" => [61651,28],"electronic cigarette" => [159416,28],"international space station" => [115031,28],"beck" => [141299,28],"michael keaton" => [112230,28],"green day" => [127354,28],"petroleum" => [94927,28],"google" => [658068,28],"veto" => [22546,28],"iraq" => [98772,28],"clint eastwood" => [213511,28],"apple inc." => [285528,28],"eminem" => [624919,28],"japan" => [414627,28],"chicago blackhawks" => [42038,28],"nascar" => [51356,28],"snow" => [60001,28],"tesla motors" => [124946,28],"fox news channel" => [43859,28],"deaths in 2015" => [1726583,28],"walmart" => [113154,28],"catherine, duchess of cambridge" => [95472,28],"central intelligence agency" => [76429,28],"africa" => [191833,28],"spongebob squarepants" => [138222,28],"liam neeson" => [457877,28],"el niño" => [70709,28],"koch industries" => [47648,28],"john boehner" => [45854,28],"ebola" => [9448,28],"pope francis" => [145747,28],"bashar al-assad" => [108526,28],"facebook" => [2036460,28],"patient protection and affordable care act" => [133084,28]},
          '201403' => {"taylor swift" => [307141,31],"count dracula" => [32615,31],"comet" => [57384,31],"giant clam" => [9386,31],"mitch mcconnell" => [50144,31],"republican party (united states)" => [137642,31],"democratic party (united states)" => [119081,31],"murphy's law" => [80551,31],"eiffel tower" => [217978,31],"general motors" => [98317,31],"reese witherspoon" => [148975,31],"katy perry" => [426154,31],"stephen hawking" => [340938,31],"eclipse" => [38278,31],"iran" => [212660,31],"fidel castro" => [156034,31],"mila kunis" => [545967,31],"angela merkel" => [130470,31],"jesus" => [251490,31],"moon" => [188588,31],"fifty shades of grey" => [232922,31],"julianne moore" => [174339,31],"oculus rift" => [276321,31],"exxonmobil" => [48263,31],"kim jong-un" => [184393,31],"wichita" => [3683,31],"lithuania" => [179456,31],"guantanamo bay naval base" => [30702,31],"antonin scalia" => [33284,31],"bob dylan" => [218286,31],"jurassic park" => [28066,31],"american football" => [103318,31],"bank" => [69204,31],"opec" => [56585,31],"ruth bader ginsburg" => [28149,31],"npr" => [25739,31],"silicon valley" => [90549,31],"barack obama" => [662691,31],"assassination_of_john_f._kennedy" => [115677,31],"netflix" => [216744,31],"benedict cumberbatch" => [480162,31],"stephen colbert" => [108581,31],"hydraulic fracturing" => [133124,31],"asteroid" => [58735,31],"hillary rodham clinton" => [147893,31],"israel" => [293677,31],"quantitative easing" => [59715,31],"electronic cigarette" => [170489,31],"international space station" => [274197,31],"beck" => [153864,31],"michael keaton" => [116120,31],"green day" => [132022,31],"petroleum" => [102494,31],"google" => [675117,31],"veto" => [24169,31],"iraq" => [112976,31],"clint eastwood" => [219683,31],"apple inc." => [302832,31],"eminem" => [729736,31],"japan" => [469388,31],"chicago blackhawks" => [40971,31],"nascar" => [55076,31],"snow" => [38057,31],"tesla motors" => [167218,31],"deaths in 2015" => [1821756,31],"walmart" => [123531,31],"catherine, duchess of cambridge" => [101436,31],"central intelligence agency" => [99433,31],"africa" => [194057,31],"fox news channel" => [52128,31],"spongebob squarepants" => [146658,31],"liam neeson" => [449754,31],"el niño" => [93516,31],"koch industries" => [77148,31],"john boehner" => [38568,31],"ebola" => [60429,31],"pope francis" => [192177,31],"bashar al-assad" => [121700,31],"facebook" => [1907604,31],"patient protection and affordable care act" => [156732,31]},
          '201502' => {"taylor swift" => [546091,28],"count dracula" => [24623,28],"comet" => [39937,28],"giant clam" => [7058,28],"mitch mcconnell" => [21353,28],"republican party (united states)" => [104673,28],"democratic party (united states)" => [90834,28],"murphy's law" => [56106,28],"eiffel tower" => [132791,28],"general motors" => [70855,28],"reese witherspoon" => [163997,28],"katy perry" => [528582,28],"stephen hawking" => [1570329,28],"eclipse" => [25866,28],"iran" => [186418,28],"fidel castro" => [173074,28],"mila kunis" => [319880,28],"angela merkel" => [109409,28],"jesus" => [175795,28],"moon" => [145925,28],"fifty shades of grey" => [2272454,28],"julianne moore" => [442607,28],"oculus rift" => [76240,28],"exxonmobil" => [38738,28],"kim jong-un" => [204918,28],"wichita" => [2402,28],"lithuania" => [113207,28],"guantanamo bay naval base" => [28006,28],"antonin scalia" => [36627,28],"bob dylan" => [186208,28],"jurassic park" => [37297,28],"american football" => [126833,28],"bank" => [593179,28],"opec" => [70930,28],"ruth bader ginsburg" => [76923,28],"npr" => [21446,28],"silicon valley" => [83520,28],"barack obama" => [572315,28],"assassination_of_john_f._kennedy" => [68300,28],"netflix" => [188526,28],"benedict cumberbatch" => [347848,28],"stephen colbert" => [84022,28],"hydraulic fracturing" => [70049,28],"asteroid" => [41529,28],"hillary rodham clinton" => [99576,28],"israel" => [299967,28],"quantitative easing" => [53607,28],"electronic cigarette" => [87555,28],"international space station" => [97044,28],"beck" => [787466,28],"michael keaton" => [385856,28],"green day" => [88439,28],"petroleum" => [84655,28],"google" => [775464,28],"veto" => [19319,28],"iraq" => [126018,28],"clint eastwood" => [278960,28],"apple inc." => [257880,28],"eminem" => [341733,28],"japan" => [313511,28],"chicago blackhawks" => [27304,28],"nascar" => [41987,28],"snow" => [41622,28],"tesla motors" => [122979,28],"fox news channel" => [47353,28],"deaths in 2015" => [1560812,28],"walmart" => [108722,28],"catherine, duchess of cambridge" => [84502,28],"central intelligence agency" => [72821,28],"africa" => [144168,28],"spongebob squarepants" => [143733,28],"liam neeson" => [215142,28],"el niño" => [36750,28],"koch industries" => [44515,28],"john boehner" => [37527,28],"ebola" => [38139,28],"pope francis" => [150917,28],"bashar al-assad" => [102561,28],"facebook" => [1151473,28],"patient protection and affordable care act" => [87801,28]},
          '201503' => {"taylor swift" => [529912,31],"count dracula" => [25895,31],"comet" => [40486,31],"giant clam" => [11375,31],"mitch mcconnell" => [27259,31],"republican party (united states)" => [127867,31],"democratic party (united states)" => [112906,31],"murphy's law" => [74517,31],"eiffel tower" => [505278,31],"general motors" => [82224,31],"reese witherspoon" => [498255,31],"katy perry" => [206651,31],"stephen hawking" => [823145,31],"eclipse" => [69499,31],"iran" => [260649,31],"fidel castro" => [130062,31],"moon" => [159092,31],"angela merkel" => [93102,31],"jesus" => [205423,31],"mila kunis" => [204418,31],"fifty shades of grey" => [803118,31],"julianne moore" => [157948,31],"oculus rift" => [87339,31],"exxonmobil" => [44061,31],"kim jong-un" => [146986,31],"wichita" => [2681,31],"guantanamo bay naval base" => [21402,31],"antonin scalia" => [36682,31],"bob dylan" => [181818,31],"lithuania" => [135128,31],"jurassic park" => [33936,31],"bank" => [667616,31],"opec" => [72645,31],"ruth bader ginsburg" => [50009,31],"npr" => [25643,31],"silicon valley" => [104792,31],"barack obama" => [566456,31],"netflix" => [240763,31],"assassination_of_john_f._kennedy" => [80550,31],"american football" => [77793,31],"benedict cumberbatch" => [221422,31],"stephen colbert" => [72590,31],"hydraulic fracturing" => [68406,31],"asteroid" => [44380,31],"hillary rodham clinton" => [220868,31],"israel" => [427173,31],"quantitative easing" => [65669,31],"beck" => [145086,31],"international space station" => [114177,31],"electronic cigarette" => [79371,31],"michael keaton" => [136654,31],"green day" => [103129,31],"petroleum" => [89212,31],"google" => [941283,31],"veto" => [17873,31],"iraq" => [142135,31],"clint eastwood" => [211354,31],"apple inc." => [341880,31],"eminem" => [461984,31],"japan" => [383320,31],"chicago blackhawks" => [26321,31],"nascar" => [37373,31],"snow" => [28001,31],"tesla motors" => [122393,31],"deaths in 2015" => [1685781,31],"walmart" => [121420,31],"catherine, duchess of cambridge" => [105574,31],"central intelligence agency" => [83583,31],"africa" => [153620,31],"fox news channel" => [48475,31],"spongebob squarepants" => [116006,31],"liam neeson" => [217092,31],"el niño" => [56787,31],"koch industries" => [51638,31],"john boehner" => [54844,31],"ebola" => [43392,31],"pope francis" => [158190,31],"bashar al-assad" => [99723,31],"facebook" => [1092631,31],"patient protection and affordable care act" => [101258,31]}
          }

TEAMS = { "Giant Clam" => ["taylor swift", "count dracula", "comet", "giant clam", "mitch mcconnell", "republican party (united states)", "democratic party (united states)", "murphy's law", "eiffel tower", "general motors"],
          "Hot Chicks & Jesus" => ["reese witherspoon", "katy perry", "stephen hawking", "eclipse", "iran", "fidel castro", "moon", "angela merkel", "jesus", "mila kunis"],
          "50 Shades of Wiki" => ["fifty shades of grey","julianne moore","oculus rift","exxonmobil","kim jong-un","wichita","guantanamo bay naval base","antonin scalia","bob dylan","lithuania"],
          "Farticles" => ['jurassic park','bank','opec','ruth bader ginsburg','npr','silicon valley', 'barack obama','netflix','assassination_of_john_f._kennedy','american football'],
          "E-Cigs in space" => ["benedict cumberbatch", "stephen colbert", "hydraulic fracturing", "asteroid", "hillary rodham clinton", "israel", "quantitative easing", "beck", "international space station", "electronic cigarette"],
          "The Google, The Veto, and the Mr. Mom" => ["michael keaton", "green day", "petroleum", "google", "veto", "iraq", "clint eastwood", "apple inc.", "eminem", "japan"],
          "Wiki Wiki What?!" => ["chicago blackhawks", "nascar", "snow", "tesla motors", "deaths in 2015", "walmart", "catherine, duchess of cambridge", "central intelligence agency","africa", "fox news channel"],
          "D's Asters" => ["spongebob squarepants", "liam neeson", "el niño", "koch industries", "john boehner", "ebola", "pope francis", "bashar al-assad", "facebook", "patient protection and affordable care act"]
        }

SCORES = {"Giant Clam" => 57.5, "Hot Chicks & Jesus" => 108.5, "50 Shades of Wiki" => 133.5, "Farticles" => 149.5, "E-Cigs in space" => 21, "The Google, The Veto, and the Mr. Mom" => 113.5, "Wiki Wiki What?!" => 29.5, "D's Asters" => 91.5}

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
  TEAMS.values.each do |array|
    array.each do |article|
      views_for_article(article,"2015","03", true)
    end
  end
  print "}\n"
end

def get_free_agent_projections
  FREE_AGENTS.each do |article|
    views_for_article(article,"2015","03",true)
  end
end 

def display_view_counts_for_a_team(team_name)
  VALUES.each do |key,value|
    puts key
    TEAMS[team_name].each do |article|
      puts article
      puts value[article]
    end
  end
end

MONTH_ADJUSTMENT = 28.0 / (Time.now.day - 1)

SCORING_METHOD = "averages"

def display_team_scores
  team_scores = {}
  team_details = "\nDetails (article name, this year views, projected this year views, last year views, projected ratio, projected points[* if locked for the month])\n"
  TEAMS.each do |k,v| 
    team_details << "\n#{k}:\n\n"
    team_score = 0
    v.each_with_index do |article, index|
      this_year = views_for_article(article,'2015','03')[0].to_f
      this_year_projected = if SCORING_METHOD == "totals"
        this_year * MONTH_ADJUSTMENT
      elsif SCORING_METHOD == "averages"
        this_year * 31.0 / views_for_article(article,'2015','03')[1]
      end
      last_year = views_for_article(article,'2014','03')[0]
      ratio = (this_year_projected / last_year)
      points = determine_points(ratio) * 2
      team_score += points if index < 8
      team_details << "#{article}, #{clean_number(this_year)}, #{clean_number(this_year_projected)}, #{clean_number(last_year)}, #{ratio.round(3)}, #{points}#{'*' if this_year / last_year > SCORING.keys.max}\n"
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
    this_year = views_for_article(article,'2015','03').to_f
    this_year_projected = this_year * MONTH_ADJUSTMENT
    last_year = views_for_article(article,'2014','03')
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
      ratios[art] = (VALUES['201503'][art].to_f / VALUES['201403'][art]).round(2)
    end
  end
  puts ratios.sort_by{|k,v| v}.reverse.map{|k,v| "#{k}: #{v}"}
end


# display_view_counts_for_a_team("Farticles")
# display_article_rankings
# display_free_agent_scores

def standard_run
  if VALUES["201503"]
    display_team_scores
  else
    get_updated_projections
  end
end
standard_run
