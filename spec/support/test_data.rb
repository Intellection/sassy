TEST_VARIABLES = [
  {
    :name=>"Respondent_ID", 
    :type=>"character", 
    :label=>"ID", 
    :values=>
    {
      "generated"=>"Generated"
    }
  },  
  {
    :name=>"AGE_GROUP", 
    :type=>"single", 
    :label=>"Age group", 
    :values=>
    {
      "1"=>"18-29", 
      "2"=>"30-44", 
      "3"=>"45+"
    }
  }, 
  {
    :name=>"Q24", 
    :type=>"single", 
    :label=>"Favourite tourist attraction", 
    :values=>
    {
      "1"=>"The Waterfront", 
      "2"=>"Table Mountain", 
      "3"=>"Cape Point", 
      "4"=>"Whale spotting", 
      "5"=>"The Garden Route", 
      "6"=>"Township Tour", 
      "7"=>"Shark cage diving", 
      "8"=>"Wine tasting"
      "9"=>"Watch Bokke smash All Blacks"
      "10"=>"Robben Island"
    }
  },  
  {
    :name=>"Q32", 
    :type=>"quantity", 
    :label=>"Years as loyal customer", 
    :values=>
    {
      "range"=>"-9..99"
    }
  }]

TEST_ANSWERS = [
  ["m09876543211", 2, 3, 11],
  ["27720628423", 1, 10, 3],
  ["27712345678", 1, 6, -2]
]

# OR

TEST_ANSWERS_BY_COLUMN = [
  ["m09876543211", "27720628423", "27712345678"],
  [2, 1, 1],
  [3, 10, 6],
  [11, 3, -2]
]

# Skeleton Code

  # $KCODE = 'UTF8'
  # xml_builder = Builder::XmlMarkup.new(indent: 2)
  # xml_builder.instruct!(:xml, :version=> "1.0", :encoding => "UTF-8")

  # xml_builder.sss(version: 1.2) do |x|
  #   x.date("date_text")
  #   x.time("time_text")
  #   x.origin("origin_text")
  #   x.user("user_text")
  #   x.survey do |s|
  #     s.name("survey_name")
  #     s.title("survey_title_text")
  #     s.record(ident: "record_id") do |r|
  #       r.variable(:ident => 5, :type => "single") do |v| 
  #         v.name("Q1")
  #         v.label("Number of visits")
  #         v.position(start: "1")
  #         v.values do |va| 
  #           va.value("First visit", code: 1)
  #           va.value("Visited before within the year", code: 2)
  #           va.value("Visited before that", code: 3)
  #         end
  #       end
  #       r.variable(ident: 3, type: "character") do |v|
  #         v.name("Q3")
  #         v.label("Other attractions visited")
  #         v.position(start: 11, finish: 40)
  #         v.size("30")
  #       end
  #       r.variable(ident: 99, type: "quantity") do |v|
  #         v.name("Q99")
  #         v.label("case weight")
  #         v.position(start: 48, finish: 54)
  #         v.range(from: "0.0000", to: "99.9999")
  #       end
  #     end
  #   end
  # end
