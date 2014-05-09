require 'open-uri'
require 'rubygems'
require 'json'


say 'Welcome to the Calling Congress Phone Line.....', :voice =>'vanessa'

options = { :choices     => "[5 DIGITS]",
            :repeat      => 3,
	    :voice      => 'vanessa',
            :timeout     => 15,
            :onBadChoice => lambda { say 'Invalid entry, please try again.' },
            :onTimeout   => lambda { say 'Timeout, please try again.' },
            :onChoice    => lambda { |choice|

              #Set the URI and  then encode as a URI
              rep_url = 'http://whoismyrepresentative.com/getall_mems.php?output=json'
              query = "&zip=" + choice.value.to_s
              url = URI.encode(rep_url + query)

              #Fetch the JSON from the API and convert the resulting
              #JSON data to a Ruby hash
              rep_data = JSON.parse(open(url).read)

              #Get the relevant weather channel details and throw them into a hash
              rep_results = rep_data["results"]
	      rep_count = rep_results.count 

if rep_results.count > 3
             #Speak back the results
               rep_message = "Press one for Representative #{rep_results[0]["name"]}," + "press two for Representative #{rep_results[1]["name"]}," + 
	          "press three for Senator #{rep_results[2]["name"]}," +  "press four for Senator #{rep_results[3]["name"]}," +
                  "press five to call the Whitehouse," + " OR you can press zero to return to the main menu" 
               rep_message_string = rep_message.to_s

result = ask rep_message_string, {
  :choices => "0,1,2,3,4,5",
  :attempts => 3,
  :voice      => 'vanessa',
  :mode => "dtmf"
  }

#Sub is so that the hyphen are removed.  The sub only removes first occurrence so it must be done twice
 
if result.value == "1"
         message "@HouseFloor a constituent just called Representative #{rep_results[0]["name"]}", {
        :to => "+19188144042",  
        :network => 'SMS'}
        phone1 = rep_results[0]["phone"].sub(/[-]/, '')
        phone1a = phone1.sub(/[-]/, '')
        say "Connecting you now, press star to stop transfer", :voice      => 'vanessa'
        transfer "+1"+ phone1a.to_s, {
        :playvalue => "http://hosting.tropo.com/125535/www/audio/myloop.mp3",
        :terminator => "*",
        :onTimeout => lambda { |event|
        say "Sorry, but nobody answered", :voice      => 'vanessa'}}
end

if result.value == "2"
	message "@HouseFloor a constituent just called Representative #{rep_results[1]["name"]}", {
        :to => "+19188144042",  
        :network => 'SMS'}
        phone2 = rep_results[1]["phone"].sub(/[-]/, '')
        phone2a = phone2.sub(/[-]/, '')
        say "Connecting you now, press star to stop transfer", :voice      => 'vanessa'
        transfer "+1"+ phone2a.to_s, {
        :playvalue => "http://hosting.tropo.com/125535/www/audio/myloop.mp3",
        :terminator => "*",
        :onTimeout => lambda { |event|
        say "Sorry, but nobody answered", :voice      => 'vanessa'}}
end

if result.value == "3"
	message "@SenateFloor a constituent just called Senator #{rep_results[2]["name"]}", {
        :to => "+19188144042",  
        :network => 'SMS'}
        phone3 = rep_results[2]["phone"].sub(/[-]/, '')
        phone3a = phone3.sub(/[-]/, '')
        say "Connecting you now, press star to stop transfer", :voice      => 'vanessa'
        transfer "+1"+ phone3a.to_s, {
        :playvalue => "http://hosting.tropo.com/125535/www/audio/myloop.mp3",
        :terminator => "*",
        :onTimeout => lambda { |event|
        say "Sorry, but nobody answered", :voice      => 'vanessa'}}
end

if result.value == "4"
	message "@SenateFloor a constituent just called Senator #{rep_results[3]["name"]}", {
        :to => "+19188144042",  
        :network => 'SMS'}
        phone4 = rep_results[3]["phone"].sub(/[-]/, '')
        phone4a = phone4.sub(/[-]/, '')
        say "Connecting you now, press star to stop transfer", :voice      => 'vanessa'
        transfer "+1"+ phone4a.to_s, {
        :playvalue => "http://hosting.tropo.com/125535/www/audio/myloop.mp3",
        :terminator => "*",
        :onTimeout => lambda { |event|
        say "Sorry, but nobody answered", :voice      => 'vanessa'}}
end

if result.value == "5"
	message "@Whitehouse a constituent just called The White House", {
        :to => "+19188144042",  
        :network => 'SMS'}
        say "Connecting you now, press star to stop transfer", :voice      => 'vanessa'
        transfer "+12024561111"
end

if result.value == "0"
        transfer "+12024704572"
end
	           
                
else 
              #Speak back the results
               rep_message = "Press one for Representative #{rep_results[0]["name"]}," + "press two for Senator #{rep_results[1]["name"]}," + 
	          "press three for Senator #{rep_results[2]["name"]}," + 
                  "press five to call the Whitehouse," + " OR you can press zero to return to the main menu" 
               rep_message_string = rep_message.to_s

result = ask rep_message_string, {
  :choices => "0,1,2,3,4,5",
  :voice      => 'vanessa',
  :attempts => 3,
  :mode => "dtmf"
  }

#Sub is so that the hyphen are removed.  The sub only removes first occurrence so it must be done twice
 

if result.value == "1"
	message "@HouseFloor a constituent just called Representative #{rep_results[0]["name"]}", {
        :to => "+19188144042",  
        :network => 'SMS'}
        phone1 = rep_results[0]["phone"].sub(/[-]/, '')
        phone1a = phone1.sub(/[-]/, '')
        say "Connecting you now, press star to stop transfer", :voice      => 'vanessa'
        transfer "+1"+ phone1a.to_s, {
        :playvalue => "http://hosting.tropo.com/125535/www/audio/myloop.mp3",
        :terminator => "*",
        :onTimeout => lambda { |event|
        say "Sorry, but nobody answered", :voice      => 'vanessa'}}
end 

if result.value == "2"
	message "@SenateFloor a constituent just called Senator #{rep_results[0]["name"]}", {
        :to => "+19188144042",  
        :network => 'SMS'}
        phone2 = rep_results[1]["phone"].sub(/[-]/, '')
        phone2a = phone2.sub(/[-]/, '')
        say "Connecting you now, press star to stop transfer", :voice      => 'vanessa'
        transfer "+1"+ phone2a.to_s, {
        :playvalue => "http://hosting.tropo.com/125535/www/audio/myloop.mp3",
        :terminator => "*",
        :onTimeout => lambda { |event|
        say "Sorry, but nobody answered", :voice      => 'vanessa'}}
end

if result.value == "3"
	message "@SenateFloor a constituent just called Senator #{rep_results[0]["name"]}", {
        :to => "+19188144042",  
        :network => 'SMS'}
        phone3 = rep_results[2]["phone"].sub(/[-]/, '')
        phone3a = phone3.sub(/[-]/, '')
        say "Connecting you now, press star to stop transfer", :voice      => 'vanessa'
        transfer "+1"+ phone3a.to_s, {
        :playvalue => "http://hosting.tropo.com/125535/www/audio/myloop.mp3",
        :terminator => "*",
        :onTimeout => lambda { |event|
        say "Sorry, but nobody answered", :voice      => 'vanessa'}}
end

if result.value == "5"
	message "@Whitehouse a constituent just called The White House", {
        :to => "+19188144042",  
        :network => 'SMS'}
        say "Connecting you now, press star to stop transfer", :voice      => 'vanessa'
        transfer "+12024561111"
end

if result.value == "0"
        transfer "+12024704572"
end
             
          
  end
  }
  }
ask 'Please enter your 5 digit ZIP code', options
