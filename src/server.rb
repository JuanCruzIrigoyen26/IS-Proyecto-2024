require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'

require 'sinatra/reloader' if Sinatra::Base.environment == :development


require_relative 'models/account'

class App < Sinatra::Application
  def initialize(app = nil)
    super()
  end

  configure :production, :development do
    enable :logging

    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG if development?
    set :logger, logger
  end

  set :views, File.join(File.dirname(__FILE__), 'views')
  set :public_folder, File.join(File.dirname(__FILE__), 'styles')

  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'Reloaded...'
    end
  end

  get '/login' do
    error_message = params[:error]
    erb :login, locals: { error_message: error_message }
  end


  get '/' do
    redirect '/login'
  end

  get '/signup' do
    erb :signup
  end

  get '/home' do
    'Home'
  end

  post '/login' do
    nickname = params[:nickname]
    password = params[:password]

    account = Account.find_by(nickname: nickname, password: password)

    if account

      redirect '/home'
    else
      redirect '/login?error=Invalid-username-or-password'
    end
  end



  post '/signup' do
    email = params[:email]
    password = params[:password]
    name = params[:name]
    nickname = params[:nickname]

    account = Account.new(email: email, password: password, name: name, nickname: nickname, progress: 0)

    if account.save
      redirect '/login'
    else
      redirect '/signup?error=Invalid-input-format'
    end
  end




end
