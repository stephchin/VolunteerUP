city = ["Carlsbad", "Chula Vista", "Coronado", "Del Mar", "El Cajon", "Encinitas",
        "Escondido", "Imperial Beach", "La Mesa", "Lemon Grove", "National City",
        "Oceanside", "Poway", "San Diego", "San Marcos", "Santee", "Solana Beach",
        "Vista"]
state = "CA"

# To create all Organizations
org_names = ["We Help", "Food Bankers", "Red Cross", "Real Helpers",
  "Salvation Army", "Are We Done Yet", "Not Today", "Big Time Rush", "Sudwerk",
  "Greendale", "We Have Time For That", "Sacred Honors International Team", "Until Dark"]
descriptions = ["We help people.", "Animals are our priority.", "Don't run away",
  "We are serious organization!", "Just like your next door neighbor.",
  "Getting closer and closer to finshing!",
  "Fighting something? Come join us. Our motto is... Not Today to any and all problems.",
  "We want to be your bo-bo-bo-bo-bo-body guys. Have a problem? We're worldwide!",
  "Drinks for binks? Shots for tots? Baby wipes for Bailey flights? We've got all kinds of drinks for the children!",
  "Who is better at being human beings than these human beings! Dean-a-ling-a-ling! Something Something Eartha Kitt.",
  "Tired of hearing 'I ain't got time for that?' Then are you in for a treat! Our organization has just that, time!",
  "Here at Sacred Honors International Team, we are the... well, you can read. We lead the way by flushing everyone's problems away on top of wiping away any stain left behind!",
  "Listen, I'm tired. It's almost midnight and I have left in the tank. If you want to volunteer, you're more than welcome to. I'm just going to sleep now."
]

org_names.each_with_index do |org, index|
  phone = "(#{rand(10).to_s * 3})#{rand(10).to_s * 3}-#{rand(10).to_s * 4}"
  Organization.create!(name: org, description: descriptions[index],
    phone: phone, email: "#{org.split(" ").join("")}@yahoo.com",
    website: "www.#{org.split(" ").join("")}.org")
end

# To create all Events
event_locations = [
  {"Carlsbad" => { street: "2924 Carlsbad Blvd", postal_code: "92008" }},
  {"Carlsbad" => { street: "3557 Monroe St", postal_code: "92008" }},
  {"Chula Vista" => { street: "2127 Olympic Parkway", postal_code: "91915" }},
  {"Chula Vista" => { street: "285 E Orange Ave", postal_code: "91911" }},
  {"Coronado" => { street: "960 Orange Ave", postal_code: "92118" }},
  {"Coronado" => { street: "699 Rodgers Rd", postal_code: "92118" }},
  {"Del Mar" => { street: "1435 Camino Del Mar", postal_code: "92014" }},
  {"Del Mar" => { street: "2200 Jimmy Durante Blvd", postal_code: "92014" }},
  {"El Cajon" => { street: "1591 Magnolia Ave", postal_code: "92020" }},
  {"El Cajon" => { street: "1695 E Main St", postal_code: "92021" }},
  {"Encinitas" => { street: "453 Sante Fe Dr", postal_code: "92024" }},
  {"Encinitas" => { street: "160 S Rancho Santa Fe Rd", postal_code: "92024" }},
  {"Escondido" => { street: "320 W Valley Pkwy", postal_code: "92025" }},
  {"Escondido" => { street: "3024 La Honda Dr", postal_code: "92027" }},
  {"Imperial Beach" => { street: "700 13th St", postal_code: "91932" }},
  {"Imperial Beach" => { street: "1079 Seacoast Dr", postal_code: "91932" }},
  {"La Mesa" => { street: "8138 La Mesa Blvd", postal_code: "91942" }},
  {"La Mesa" => { street: "5746 Amaya Dr", postal_code: "91941" }},
  {"Lemon Grove" => { street: "3521 Lemon Grove Ave", postal_code: "91945" }},
  {"Lemon Grove" => { street: "1501 Skyline Dr", postal_code: "91945" }},
  {"National City" => { street: "1401 E Plaze Blvd", postal_code: "91950" }},
  {"National City" => { street: "500 Mile of Cars Way", postal_code: "91950" }},
  {"Oceanside" => { street: "1779 Oceanside Blbd", postal_code: "92054" }},
  {"Oceanside" => { street: "Melorse Dr", postal_code: "92057" }},
  {"Poway" => { street: "12202 Poway Rd", postal_code: "92064" }},
  {"Poway" => { street: "13404 Cricket Hill", postal_code: "92064" }},
  {"San Diego" => { street: "1011 Market St", postal_code: "92101" }},
  {"San Diego" => { street: "3025 El Cajon Blvd", postal_code: "92104" }},
  {"San Marcos" => { street: "126 Knoll Rd", postal_code: "92069" }},
  {"San Marcos" => { street: "1523 San Elijo Rd", postal_code: "92078" }},
  {"Santee" => { street: "9161 Mission Gorge Rd", postal_code: "92071" }},
  {"Santee" => { street: "9200 Inwood Dr", postal_code: "92071" }},
  {"Solana Beach" => { street: "125 Lomas  Santa Fe Dr", postal_code: "92075" }},
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
    #cause: causes[rand(causes.length)] }},
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

33.times do |iter|
  names_index = rand(event_names.length)
  name_key = event_names[names_index].keys[0]
  causes_index = rand(causes.length)
  loc_index = rand(event_locations.length)
  loc_key = event_locations[loc_index].keys[0]
  s = DateTime.now + rand(14)
  e = s + ((rand(24) + 1) / 24.0)

  Event.create!(name: name_key,
    description: event_names[names_index][name_key][:description],
    cause: causes[causes_index], start_time: s, end_time: e,
    street: event_locations[loc_index][loc_key][:street],
    city: loc_key, state: "CA",
    postal_code: event_locations[loc_index][loc_key][:postal_code], country: "USA",
    volunteers_needed: rand(20) + 1, organization: Organization.order("RANDOM()").first)
end


# To create all Users
user_names = ["Ally", "Barney", "Carson", "Dierdre", "Esther", "Fox", "Gary",
              "Hannibal", "Ingrid", "Julius", "Kendra", "Lily", "Marshall",
              "Newton", "Odell", "Pierce", "Queen", "Robin", "Sia", "Ted",
              "Utah", "Vinnie", "Washington", "Xanthipe", "Yosh", "Zeke"]
password = "123456"

user_names.each do |user|
  User.create!(email: user[0] + "@yahoo.com", name: user, password: password,
    city: city[rand(17)], state: state)
end

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

[u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11, u12, u13].each_with_index do |u, index|
  u.add_role :organizer
  u.user_organizations.create!(
    organization: Organization.find_by_name(org_names[index]),
    is_creator: true)
end

# Changes
first_names = ["Alex", "Boris", "Cathy", "Dude", "Elbert", "Fran", "Guy", "Hero",
  "Izzy", "Janice", "Karl", "Lorne", "Max", "Neil", "Oscar", "Paulo", "Qent", "Ryan",
  "Sophie", "Turner", "Ulysses", "Vernon", "Wallace", "Xavier", "Yedd", "Zenon"]
last_names = ["Adams", "Brown", "Cooper"]#, "Dalby", "Eads", "Fielder", "Gabel",
  #{}"Haden", "Ibanes", "Jones", "King", "Lancaster", "Martin"]#, "Nicholson", "Owen",
  #{}"Pryor", "Qi", "Richards", "Smith", "Terry", "Udrih", "Valentine", "Williams",
  #{}"Xanthos", "Yates", "Zed"]

first_names.each do |first|
  last_names.each do |last|
    User.create!(email: "#{first[0]}#{last[0]}@yahoo.com", name: "#{first} #{last}",
      password: password, city: city[rand(17)], state: state)
  end
end

user_length = User.all.length
event_length = Event.all.length

User.all.each do |user|
  10.times do |iter|
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
  end
end
