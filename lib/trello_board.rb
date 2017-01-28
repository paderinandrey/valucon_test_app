require 'yaml'
require 'json'

module Trello
  Request = Struct.new 'Request', :verb, :uri, :headers, :body
  Response = Struct.new 'Response', :code, :headers, :body

  def get(path)
    uri = "https://api.trello.com/#{API_VERSION}#{path}"
    invoke_verb(:get, uri)
  end

  def post(path, body = {})
    uri = "https://api.trello.com/#{API_VERSION}#{path}"
    invoke_verb(:post, uri, body)
  end

  def invoke_verb(name, uri, body = nil)
    request = Request.new name, uri, {}, body
    response = TInternet.execute auth.authorize(request)

    return '' unless response

    if response.code.to_i == 401 && response.body =~ /expired token/
      raise InvalidAccessToken, response.body
    end

    raise Error, response.body unless [200, 201].include? response.code

    response.body
  end

  def get_board(id)
    JSON.parse(get("/board/#{id}"))
  end

  private

  def auth
    Auth.new(attrs_from_file)
  end

  def config_file
    File.join(Dir.home, '.trellorc')
  end

  def attrs_from_file
    if File.exist?(config_file)
      YAML.safe_load(File.read(config_file))
    else
      raise Error, "Missing required configuration file #{config_file}"
    end
  end

  API_VERSION = 1

  # Raise this when we hit a Trello error.
  Error = Class.new(StandardError)

  # This specific error is thrown when your access token is invalid. You should get a new one.
  InvalidAccessToken = Class.new(Error)

  class Auth
    attr_accessor :developer_public_key, :member_token

    def initialize(attrs = {})
      attrs.each {|key, value| instance_variable_set("@#{key}", value) }
    end

    def authorize(request)
      existing_values = request.headers.nil? ? {} : request.headers
      new_values = { key: @developer_public_key, token: @member_token }
      request.headers = { params: new_values.merge(existing_values) }
      Request.new request.verb, request.uri, request.headers, request.body
    end
  end

  class TInternet
    class << self
      require 'rest-client'

      def execute(request)
        try_execute request
      end

      private

      def try_execute(request)

        if request
          result = execute_core request
          Response.new(200, {}, result)
        end
      rescue RestClient::Exception => e
        raise if !e.respond_to?(:http_code) || e.http_code.nil?
        Response.new(e.http_code, {}, e.http_body)

      end

      def execute_core(request)
        RestClient.proxy = ENV['HTTP_PROXY'] if ENV['HTTP_PROXY']
        RestClient::Request.execute(
          method: request.verb,
          url: request.uri.to_s,
          headers: request.headers,
          payload: request.body,
          timeout: 10
        )
      end
    end
  end
end

class TrelloBoard
  include Trello

  attr_accessor :id,
                :name,
                :description

  def initialize(id)
    get_board(id).each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end

  def create_card!(options)
    Card.create(options.merge(board_id: id))
  end
end

class Card
  include Trello

  class << self
    def create(options)
      new(options).save
    end
  end

  def save
    JSON.parse post('/cards', {
      name:   @title,
      desc:   @desc,
      idList: @list_id,
      idBoard: @board_id
    })
  end

  def initialize(fields = {})
    fields.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end
end
