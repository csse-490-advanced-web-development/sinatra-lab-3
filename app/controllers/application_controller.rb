require './config/environment'

class ApplicationController < Sinatra::Application
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    logger = Logger.new(File.open("#{root}/../log/#{environment}.log", 'a'))
    logger.level = Logger::DEBUG unless production?
    set :logger, logger
    ActiveRecord::Base.logger = logger
    enable :sessions
  end

  get '/' do
    redirect "/tasks"
  end
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text.to_s)
  end

  def hattr(text)
    Rack::Utils.escape_path(text.to_s)
  end
end
