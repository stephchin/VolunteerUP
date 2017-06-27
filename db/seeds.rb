unless ENV["extra"]
city = ["Carlsbad", "Chula Vista", "Coronado", "Del Mar", "El Cajon", "Encinitas",
        "Escondido", "Imperial Beach", "La Mesa", "Lemon Grove", "National City",
        "Oceanside", "Poway", "San Diego", "San Marcos", "Santee", "Solana Beach",
        "Vista"]
state = "CA"

orgs = [
    {name: "We Help", description: "We help people.", image: File.open("db/images/wehelp.jpg")},
    {name: "Food Bankers", description: "Down on your luck? We're here to serve!", image: File.open("db/images/foodbankers.jpg")},
    {name: "Red Cross", description: "Don't run away.", image: File.open("db/images/redcross.jpg")},
    {name: "Real Helpers", description: "We are a serious organization!", image: File.open("db/images/realhelpers.jpg")},
    {name: "Salvation Army", description: "Just like your next door neighbor.", image: File.open("db/images/salvationarmy.jpg")},
    {name: "Are We Done Yet", description: "Getting closer and closer to finishing!", image: File.open("db/images/arewedoneyet.jpg")},
    {name: "Not Today", description: "Fighting something? Come join is. Our motto is... Not Today to any and all problems.", image: File.open("db/images/nottoday.jpg")},
    {name: "Big Time Rush", description: "We want to be your bo-bo-bo-bo-bo-body guys. Have a problem? We're worldwide!", image: File.open("db/images/bigtimerush.jpg")},
    {name: "Sudwerk", description: "Drinks for binks? Shots for tots? Baby wipes for Bailey flights? We've got all kinds of drinks for the children!", image: File.open("db/images/sudwerk.jpg")},
    {name: "Greendale", description: "Who is better at being human beings than these human beings! Dean-a-ling-a-ling! Something something Eartha Kitt.", image: File.open("db/images/greendale.jpg")},
    {name: "We Have Time For That", description: "Tired of hearing 'I ain't got time for that?' Then are you in for a treat! Our organization has just that, time!", image: File.open("db/images/wehavetimeforthat.jpg")},
    {name: "Sacred Honors International Team", description: "Here are Sacred Honors International Team, we are the... well, you can read. We lead the way by flushing everyone's problems away on top of wiping away and stain left behind!", image: File.open("db/images/goodstuff.jpg")},
    {name: "Until Dark", description: "Listen, I'm tired. It's almost midnight and I have nothing left in the tank. If you want to volunteer, you're more than welcome to. I'm just going to sleep now.", image: File.open("db/images/untilmidnight.jpg")},
    {name: "Scott's Tots", description: "Hey, Mr. Scott. Watcha gonna do, watcha gonna do? Make our dreams come true!
    Here at Scott's Tots we provide students with college tuition! Or actually
    laptops. Sorry we mean lithium batteries. Man, has it been 10 years already?
    Anyways... We promise to do a lot for the children.", image: File.open("db/images/scottstots.jpg")},
    {name: "Smart Women", description: "Now that we've lured you to our webpage, what we really do is run community events for different causes. Please come join us to make a difference!", image: File.open("db/images/attractivewomen.jpg")}
]

orgs.each do |org|
  phone = "(#{rand(10).to_s * 3})#{rand(10).to_s * 3}-#{rand(10).to_s * 4}"
  Organization.create!(name: org[:name], description: org[:description],
    phone: phone, email: "#{org[:name].split(" ").join("").downcase}@yahoo.com",
    website: "www.#{org[:name].split(" ").join("").downcase}.org",
    facebook: "facebook.com/#{org[:name].split(" ").join("").downcase}",
    twitter: "@#{org[:name].split(" ").join("").downcase}",
    image: org[:image])
    p "Created Organization #{org[:name]}!"
end

# To create all Events
event_locations = [
  {"Carlsbad" => { street: "2924 Carlsbad Blvd", postal_code: "92008" }},
  {"Beverly Hills" => { street: "905 Loma Vista Dr", postal_code: "90210" }},
  {"Indio" => { street: "81800 Avenue 51", postal_code: "92201" }},
  {"Chula Vista" => { street: "285 E Orange Ave", postal_code: "91911" }},
  {"Coronado" => { street: "960 Orange Ave", postal_code: "92118" }},
  {"Santa Barbara" => { street: "1122 N Milpas St", postal_code: "93103" }},
  {"Del Mar" => { street: "1435 Camino Del Mar", postal_code: "92014" }},
  {"Del Mar" => { street: "2200 Jimmy Durante Blvd", postal_code: "92014" }},
  {"El Cajon" => { street: "1591 Magnolia Ave", postal_code: "92020" }},
  {"El Cajon" => { street: "1695 E Main St", postal_code: "92021" }},
  {"Encinitas" => { street: "453 Sante Fe Dr", postal_code: "92024" }},
  {"Goleta" => { street: "879 Embarcadero del Norte", postal_code: "93117" }},
  {"Escondido" => { street: "320 W Valley Pkwy", postal_code: "92025" }},
  {"Escondido" => { street: "3024 La Honda Dr", postal_code: "92027" }},
  {"Imperial Beach" => { street: "700 13th St", postal_code: "91932" }},
  {"San Francisco" => { street: "500 Brannan St", postal_code: "94107" }},
  {"La Mesa" => { street: "8138 La Mesa Blvd", postal_code: "91942" }},
  {"San Francisco" => { street: "1090 Point Lobos Ave", postal_code: "94121" }},
  {"San Francisco" => { street: "300 Finley Rd", postal_code: "94129" }},
  {"Lemon Grove" => { street: "1501 Skyline Dr", postal_code: "91945" }},
  {"National City" => { street: "1401 E Plaza Blvd", postal_code: "91950" }},
  {"Belvedere Tiburon" => { street: "43 Main St", postal_code: "94920" }},
  {"Petaluma" => { street: "621 E Washington St", postal_code: "94952" }},
  {"Oceanside" => { street: "Melrose Dr", postal_code: "92057" }},
  {"Poway" => { street: "12202 Poway Rd", postal_code: "92064" }},
  {"Poway" => { street: "13404 Cricket Hill", postal_code: "92064" }},
  {"San Diego" => { street: "1011 Market St", postal_code: "92101" }},
  {"San Diego" => { street: "3025 El Cajon Blvd", postal_code: "92104" }},
  {"San Marcos" => { street: "126 Knoll Rd", postal_code: "92069" }},
  {"San Marcos" => { street: "1523 San Elijo Rd", postal_code: "92078" }},
  {"Santee" => { street: "9161 Mission Gorge Rd", postal_code: "92071" }},
  {"Novato" => { street: "790 De Long Ave", postal_code: "94945" }},
  {"Napa" => { street: "1275 McKinstry St", postal_code: "94559" }},
  {"Solana Beach" => { street: "512 Via Del La Valle", postal_code: "92075" }},
  {"Vista" => { street: "170 Emerald Dr", postal_code: "92083" }},
  {"Vista" => { street: "790 Sycamore Ave", postal_code: "92083" }}
]
causes = ["Children/Youth", "Animals", "Arts & Culture",
  "Community Development", "Health/Hospitals", "Mental Health",
  "Education/Literacy", "Homelessness", "Other"]

event_names = [
  { "Blood Drive" => { description: "Give blood so that Jesus won't have to.
    Cookies won't be provided, but probably fish and bread."}},
  { "Toy Drive" => { description: "Give toys to those who wish they had a childhood.
    For once, think of the children!"}},
  { "Canned Goods Drive" => { description: "Give canned goods to people who
    would like food that can store for more than a day. We know you're never
    using those canned chickpeas or green beans, so bring them on down."}},
  { "Clothes Drive" => { description: "Give clothes to those who need them.
    Ain't no one want to see that."}},
  { "Pick Up Waste" => { description: "Pick up trash. Just do it."}},
  { "High Fives" => { description: "You ever seen someone down? They just need
    that one thing that will lift their spirits and that is a high five! Bring
    your kids, dogs, cats, uncles, and maybe mom to this event!"}},
  { "Board Game Night" => { description: "Monopoly? Settlers of Catan? Maybe a little
    Game of Thrones. Whatever your fancy is, we hope it gets tickled at this event!"}},
  { "Swing For The Fences" => { description: "Feel like going... downtown? Come
    one, come all to this big time event! Not into baseball? Check out our juices!
    While we guarantee you'll feel great, we can't guarantee that you'll make it
    to the hall in time..."}},
  { "Slap The Bag" => { description: "Just this once! Or twice! Or 20 times!"}},
  { "Plant A Tree" => { description: "Tired of the heat? Need some shade? Well do
    we have the perfect opportunity for you! You'll probably be dead by the time
    the tree is tall enough for you, but at least future generations will reap the
    benefits of your erected tree! (Cannont guarantee the tree will still be erect
    when you're older)"}},
  { "Meetup" => { description: "Let's be honest, you're here to do more than meetup.
    You want more from life than sitting by yourself in front of a computer screen,
    hoping that your friends will call you out, only to stand in the corner letting
    life pass you by. Don't worry, you can do that here too, but at least it's for
    a good cause."}},
  { "Code For Social Good" => { description: "Have a project for the social good?
    Bring it on down!"}},
  { "Yogging, it's a thing people do" => { description: "If you get one foot in front
    of the other, you'll get there eventually."}}
]

30.times do |iter|
  names_index = rand(event_names.length)
  name_key = event_names[names_index].keys[0]
  causes_index = rand(causes.length)
  loc_index = rand(event_locations.length)
  loc_key = event_locations[loc_index].keys[0]
  s = DateTime.now + rand(21) + (rand(24) / 24.0)
  e = s + ((rand(24) + 1) / 24.0)

  Event.create!(name: name_key,
    description: event_names[names_index][name_key][:description],
    cause: causes[causes_index], start_time: s, end_time: e,
    street: event_locations[loc_index][loc_key][:street],
    city: loc_key, state: "CA",
    postal_code: event_locations[loc_index][loc_key][:postal_code], country: "USA",
    volunteers_needed: rand(20) + 10, organization: Organization.order("RANDOM()").first)
  p "Created Event #{iter}!"
end

23.times do |iter|
  names_index = rand(event_names.length)
  name_key = event_names[names_index].keys[0]
  causes_index = rand(causes.length)
  loc_index = rand(event_locations.length)
  loc_key = event_locations[loc_index].keys[0]
  s = DateTime.now - rand(31)
  e = s + ((rand(24) + 1) / 24.0)

  Event.create!(name: name_key,
    description: event_names[names_index][name_key][:description],
    cause: causes[causes_index], start_time: s, end_time: e,
    street: event_locations[loc_index][loc_key][:street],
    city: loc_key, state: "CA",
    postal_code: event_locations[loc_index][loc_key][:postal_code], country: "USA",
    volunteers_needed: rand(20) + 10, organization: Organization.order("RANDOM()").first)
  p "Created Event #{iter}!"
end


# To create all Users
user_names = ["Aya", "Ben", "Colin", "Data", "Elijah", "Freddie", "Ginger",
              "Hannibal", "Isabella", "Jane", "Karen", "Lamorne", "Mackenzie",
              "Neil", "Olivia", "Paget", "Quinn", "Rahul", "Shia", "Tony",
              "Uzo", "Vanessa", "Will", "Xanthipe", "Yvonne", "Zach"]
password = "123456"

user_names.each do |user|
  User.create!(email: user[0] + "@yahoo.com", name: user, password: password,
    city: city[rand(17)], state: state, image: File.open("db/images/#{user[0].downcase}.jpg"))
  p "Created User #{user}!"
end

users = [
    { email: "d_schrute@yahoo.com", name: "Dwight Schrute", password: password,
      city: "Scranton", state: "PA", image: File.open("db/images/dwight-schrute.jpg") },
    { email: "d_com@yahoo.com", name: "Dot Com", password: password,
      city: "New York", state: "NY", image: File.open("db/images/dot-com.jpg") },
    { email: "t_barnes@yahoo.com", name: "Troy Barnes", password: password,
      city: "Greendale", state: "CO", image: File.open("db/images/troy-barnes.jpg") },
    { email: "a_ludgate@yahoo.com", name: "April Ludgate", password: password,
      city: "Pawnee", state: "IN", image: File.open("db/images/april-ludgate.jpg") },
    { email: "t_funke@yahoo.com", name: "Tobias Funke", password: password,
      city: "Newport Beach", state: "CA", image: File.open("db/images/tobias-funke.jpg") },
    { email: "c_baskets@yahoo.com", name: "Christine Baskets", password: password,
      city: "Bakersfield", state: "CA", image: File.open("db/images/christine-baskets.jpg") },
    { email: "l_hewitt@yahoo.com", name: "Lem Hewitt", password: password,
      city: "New York", state: "NY", image: File.open("db/images/lem-hewitt.jpg") },
    { email: "a_santiago@yahoo.com", name: "Amy Santiago", password: password,
      city: "New York", state: "NY", image: File.open("db/images/amy-santiago.jpg") },
    { email: "b_summers@yahoo.com", name: "Buffy Summers", password: password,
      city: "Sunnydale", state: "CA", image: File.open("db/images/buffy-summers.jpg") },
    { email: "r_bunch@yahoo.com", name: "Rebecca Bunch", password: password,
      city: "West Covina", state: "CA", image: File.open("db/images/rebecca-bunch.jpg") },
    { email: "f_crane@yahoo.com", name: "Frasier Crane", password: password,
      city: "Seattle", state: "WA", image: File.open("db/images/frasier-crane.jpg") },
    { email: "c_bing@yahoo.com", name: "Chandler Bing", password: password,
      city: "New York", state: "NY", image: File.open("db/images/chandler-bing.jpg") },
    { email: "l_weir@yahoo.com", name: "Lindsay Weir", password: password,
      city: "Chippewa", state: "MI", image: File.open("db/images/lindsay-weir.jpg") },
    { email: "s_shapiro@yahoo.com", name: "Shoshanna Shapiro", password: password,
      city: "New York", state: "NY", image: File.open("db/images/shoshanna-shapiro.jpg") },
    { email: "d_clark@yahoo.com", name: "Donna Clark", password: password,
      city: "San Francisco", state: "CA", image: File.open("db/images/donna-clark.jpg") },
    { email: "t_mcconnell@yahoo.com", name: "Tracy McConnell", password: password,
      city: "New York", state: "NY", image: File.open("db/images/tracy-mcconnell.jpg") },
    { email: "c_kelly@yahoo.com", name: "Charlie Kelly", password: password,
      city: "Philadelphia", state: "PA", image: File.open("db/images/charlie-kelly.jpg") },
    { email: "m_dobbs@yahoo.com", name: "Mickey Dobbs", password: password,
      city: "Culver City", state: "CA", image: File.open("db/images/mickey-dobbs.jpg") },
    { email: "r_sterling@yahoo.com", name: "Roger Sterling", password: password,
      city: "New York", state: "NY", image: File.open("db/images/roger-sterling.jpg") },
    { email: "j_greenberg@yahoo.com", name: "Josh Greenberg", password: password,
      city: "New York", state: "NY", image: File.open("db/images/josh-greenberg.jpg") },
    { email: "p_dunphy@yahoo.com", name: "Phil Dunphy", password: password,
      city: "Los Angeles", state: "CA", image: File.open("db/images/phil-dunphy.jpg") },
    { email: "o_pope@yahoo.com", name: "Olivia Pope", password: password,
      city: "Washington D.C.", state: "VA", image: File.open("db/images/olivia-pope.jpg") },
    { email: "r_zane@yahoo.com", name: "Rachel Zane", password: password,
      city: "New York", state: "NY", image: File.open("db/images/rachel-zane.jpg") }
]

users.each do |user|
    User.create!(email: user[:email], name: user[:name], password: password,
        city: user[:city], state: user[:state], image: user[:image])
    puts "Created #{user[:name]}!"
end

admin = User.find_by_email("a@yahoo.com")
u12 = User.find_by_email("h@yahoo.com")
u11 = User.find_by_email("i@yahoo.com")
u1 = User.find_by_email("j@yahoo.com")
u2 = User.find_by_email("k@yahoo.com")
u3 = User.find_by_email("l@yahoo.com")
u4 = User.find_by_email("m@yahoo.com")
u5 = User.find_by_email("n@yahoo.com")
u6 = User.find_by_email("o@yahoo.com")
u7 = User.find_by_email("p@yahoo.com")
u8 = User.find_by_email("q@yahoo.com")
u9 = User.find_by_email("r@yahoo.com")
u10 = User.find_by_email("s@yahoo.com")
u13 = User.find_by_email("t@yahoo.com")
u14 = User.find_by_email("u@yahoo.com")
u15 = User.find_by_email("v@yahoo.com")

admin.add_role :admin
p "Created Admin #{admin.name}!"


[u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11, u12, u13, u14, u15].each_with_index do |u, index|
  u.add_role :organizer
  u.user_organizations.create!(
    organization: Organization.find(index + 1),
    is_creator: true)
  p "Created Organizer #{u.name}!"
end

user_length = User.all.length
event_length = Event.all.length

User.all.each do |user|
  (rand(3) + 9).times do |iter|
    e = Event.find(rand(event_length) + 1)
    if !e.users.all.include?(user) && e.remaining_vol > 0
      e.user_events.new(user: user)
      e.save!
    elsif e.remaining_vol <= 0
      waitlist_number = e.user_events.maximum("waitlist");
      if waitlist_number.nil?
        waitlist_number = 1
      end
      e.user_events.new(user: user, waitlist: waitlist_number + 1)
      e.save!
    end
    p "Added #{user.name} to #{e.name} event!"
  end
end

p "All done!"
end



######### DIVIDING LINE #################
if ENV["extra"]
  p "This is running here!"
  event_locations = [
    {"Carlsbad" => { street: "2924 Carlsbad Blvd", postal_code: "92008" }},
    {"Beverly Hills" => { street: "905 Loma Vista Dr", postal_code: "90210" }},
    {"Indio" => { street: "81800 Avenue 51", postal_code: "92201" }},
    {"Chula Vista" => { street: "285 E Orange Ave", postal_code: "91911" }},
    {"Coronado" => { street: "960 Orange Ave", postal_code: "92118" }},
    {"Santa Barbara" => { street: "1122 N Milpas St", postal_code: "93103" }},
    {"Del Mar" => { street: "1435 Camino Del Mar", postal_code: "92014" }},
    {"Del Mar" => { street: "2200 Jimmy Durante Blvd", postal_code: "92014" }},
    {"El Cajon" => { street: "1591 Magnolia Ave", postal_code: "92020" }},
    {"El Cajon" => { street: "1695 E Main St", postal_code: "92021" }},
    {"Encinitas" => { street: "453 Sante Fe Dr", postal_code: "92024" }},
    {"Goleta" => { street: "879 Embarcadero del Norte", postal_code: "93117" }},
    {"Escondido" => { street: "320 W Valley Pkwy", postal_code: "92025" }},
    {"Escondido" => { street: "3024 La Honda Dr", postal_code: "92027" }},
    {"Imperial Beach" => { street: "700 13th St", postal_code: "91932" }},
    {"San Francisco" => { street: "500 Brannan St", postal_code: "94107" }},
    {"La Mesa" => { street: "8138 La Mesa Blvd", postal_code: "91942" }},
    {"San Francisco" => { street: "1090 Point Lobos Ave", postal_code: "94121" }},
    {"San Francisco" => { street: "300 Finley Rd", postal_code: "94129" }},
    {"Lemon Grove" => { street: "1501 Skyline Dr", postal_code: "91945" }},
    {"National City" => { street: "1401 E Plaza Blvd", postal_code: "91950" }},
    {"Belvedere Tiburon" => { street: "43 Main St", postal_code: "94920" }},
    {"Petaluma" => { street: "621 E Washington St", postal_code: "94952" }},
    {"Oceanside" => { street: "Melrose Dr", postal_code: "92057" }},
    {"Poway" => { street: "12202 Poway Rd", postal_code: "92064" }},
    {"Poway" => { street: "13404 Cricket Hill", postal_code: "92064" }},
    {"San Diego" => { street: "1011 Market St", postal_code: "92101" }},
    {"San Diego" => { street: "3025 El Cajon Blvd", postal_code: "92104" }},
    {"San Marcos" => { street: "126 Knoll Rd", postal_code: "92069" }},
    {"San Marcos" => { street: "1523 San Elijo Rd", postal_code: "92078" }},
    {"Santee" => { street: "9161 Mission Gorge Rd", postal_code: "92071" }},
    {"Novato" => { street: "790 De Long Ave", postal_code: "94945" }},
    {"Napa" => { street: "1275 McKinstry St", postal_code: "94559" }},
    {"Solana Beach" => { street: "512 Via Del La Valle", postal_code: "92075" }},
    {"Vista" => { street: "170 Emerald Dr", postal_code: "92083" }},
    {"Vista" => { street: "790 Sycamore Ave", postal_code: "92083" }}
  ]
  causes = ["Children/Youth", "Animals", "Arts & Culture",
    "Community Development", "Health/Hospitals", "Mental Health",
    "Education/Literacy", "Homelessness", "Other"]

  event_names = [
    { "Blood Drive" => { description: "Give blood so that Jesus won't have to.
      Cookies won't be provided, but probably fish and bread."}},
    { "Toy Drive" => { description: "Give toys to those who wish they had a childhood.
      For once, think of the children!"}},
    { "Canned Goods Drive" => { description: "Give canned goods to people who
      would like food that can store for more than a day. We know you're never
      using those canned chickpeas or green beans, so bring them on down."}},
    { "Clothes Drive" => { description: "Give clothes to those who need them.
      Ain't no one want to see that."}},
    { "Pick Up Waste" => { description: "Pick up trash. Just do it."}},
    { "High Fives" => { description: "You ever seen someone down? They just need
      that one thing that will lift their spirits and that is a high five! Bring
      your kids, dogs, cats, uncles, and maybe mom to this event!"}},
    { "Board Game Night" => { description: "Monopoly? Settlers of Catan? Maybe a little
      Game of Thrones. Whatever your fancy is, we hope it gets tickled at this event!"}},
    { "Swing For The Fences" => { description: "Feel like going... downtown? Come
      one, come all to this big time event! Not into baseball? Check out our juices!
      While we guarantee you'll feel great, we can't guarantee that you'll make it
      to the hall in time..."}},
    { "Slap The Bag" => { description: "Just this once! Or twice! Or 20 times!"}},
    { "Plant A Tree" => { description: "Tired of the heat? Need some shade? Well do
      we have the perfect opportunity for you! You'll probably be dead by the time
      the tree is tall enough for you, but at least future generations will reap the
      benefits of your erected tree! (Cannont guarantee the tree will still be erect
      when you're older)"}},
    { "Meetup" => { description: "Let's be honest, you're here to do more than meetup.
      You want more from life than sitting by yourself in front of a computer screen,
      hoping that your friends will call you out, only to stand in the corner letting
      life pass you by. Don't worry, you can do that here too, but at least it's for
      a good cause."}},
    { "Code For Social Good" => { description: "Have a project for the social good?
      Bring it on down!"}},
    { "Yogging, it's a thing people do" => { description: "If you get one foot in front
      of the other, you'll get there eventually."}}
  ]

  30.times do |iter|
    names_index = rand(event_names.length)
    name_key = event_names[names_index].keys[0]
    causes_index = rand(causes.length)
    loc_index = rand(event_locations.length)
    loc_key = event_locations[loc_index].keys[0]
    s = DateTime.now + rand(31) + (rand(24) / 24.0)
    e = s + ((rand(24) + 1) / 24.0)

    ev = Event.create!(name: name_key,
      description: event_names[names_index][name_key][:description],
      cause: causes[causes_index], start_time: s, end_time: e,
      street: event_locations[loc_index][loc_key][:street],
      city: loc_key, state: "CA",
      postal_code: event_locations[loc_index][loc_key][:postal_code], country: "USA",
      volunteers_needed: rand(20) + 10, organization: Organization.order("RANDOM()").first)
    p "Created Event #{iter}!"

    some_rand = rand(5) + 15
    User.order("RANDOM()")[3...some_rand].each do |user|
      if !ev.users.all.include?(user) && ev.remaining_vol > 0
        ev.user_events.new(user: user)
        ev.save!
      elsif ev.remaining_vol <= 0
        waitlist_number = ev.user_events.maximum("waitlist");
        if waitlist_number.nil?
          waitlist_number = 1
        end
        ev.user_events.new(user: user, waitlist: waitlist_number + 1)
        ev.save!
      end
      p "Added #{user.name} to #{ev.name} event!"
    end
  end
end
