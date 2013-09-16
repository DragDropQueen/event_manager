require "csv"
require "sunlight/congress"
require "erb"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_phone_numbers(phone_number)
  numbers = phone_number.to_s.gsub(/[^0-9]/,"").rjust(10,"0")
  if numbers[0] == "0"
    numbers = "###"
  elsif numbers.length == 11 && numbers[0] == "1"
    numbers = numbers[1..-1]
  else numbers
  end
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

puts "EventManager Initialized!"
contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_numbers(row[:homephone])
  legislators = legislators_by_zipcode(zipcode)
  form_letter = erb_template.result(binding)
  Dir.mkdir("output") unless Dir.exists? "output"
  filename = "output/thanks_#{id}.haml"
  File.open(filename, "w") do |file|
    file.puts form_letter
  end
end

