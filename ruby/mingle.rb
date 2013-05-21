#!/usr/bin/env ruby

require "rexml/document"
require File.dirname(__FILE__) + '/rest_connection'

class Mingle
  
  def initialize(config, password)
    @base_url = config['base_url']
    @username = config['username']
    @password = password
    @project = config['project']
    @config = config
  end
  
  def execute_mql(args={})
    get 'cards/execute_mql', args
  end
  
  def card(card_number, args)
    get "cards/#{card_number}", args
  end
  
  def cards(args={})
    get 'cards', args
  end
  
  def event_feed(args={})
    # this will change from "feed" to "feeds/events"
    get 'feed', args
  end
  
  def post_murmur(text)
    post 'murmurs', 'murmur[murmur]' => text
  end
  
  private
  def post(resource, args)
    rest_connection.request_post("api/v2/projects/#{@project}/#{resource}.xml", args)
  end
  
  def rest_connection
    REST::Connection.new(@base_url, :username => @username, :password => @password)
  end
  
  def get(resource, args)
    connection = rest_connection
    response = connection.request_get("api/v2/projects/#{@project}/#{resource}.xml", args)
    REXML::Document.new(response)
  end
end

mingle = Mingle.new({'base_url' => 'http://10.3.11.122:8080/mingle/projects', 'project' => 'java', 'username' => 'admin'}, 'admin')






#cards_xml_doc = mingle.execute_mql('mql' => "SELECT Number,Name")
#card_elements = cards_xml_doc.root.elements.to_a # REXML::XPath.match(cards_xml_doc, "//result") 
#puts "--card_elements-------------------------"
#card_elements.each do |card_element|
#  puts "Number: #{card_element.elements['number'].text}, Name: #{card_element.elements['name'].text}"
#end
