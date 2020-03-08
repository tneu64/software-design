# Set up for the application and database. DO NOT CHANGE. ###################
require "sinatra"                                                           #
require "sinatra/reloader" if development?                                  #
require "sequel"                                                            #
require "logger"                                                            #
require "twilio-ruby"                                                       #
DB ||= Sequel.connect "sqlite://#{Dir.pwd}/development.sqlite3"             #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                #
def view(template); erb template.to_sym; end                                #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret' #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }   #
after { puts }                                                              #
#############################################################################

events_table = DB.from(:events)
rsvps_table = DB.from(:rsvps)

# need to add a route (/ is the home):
get "/" do
    puts "params: #{params}" #for debugging; only prints to console
    
    pp events_table.all.to_a #get all data from events table
     # list the events using loop
    @events = events_table.all.to_a # first, store events in a var; next add loop to events.erb
    
    view "events"
end