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

  enable :sessions
  set :session_secret, 'super secret'

  set :views, File.join(File.dirname(__FILE__), 'views')
  set :public_folder, File.join(File.dirname(__FILE__), 'styles')

  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'Reloaded...'
    end
  end

  # app.rb

  AVAILABLE_GAMES = ['Counter Strike', 'Game 2', 'Game 3'].freeze

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
    erb :home
  end

  post '/login' do
    nickname = params[:nickname]
    password = params[:password]

    account = Account.find_by(nickname: nickname, password: password)

    if account
      session[:email] = account.email
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

    if Account.exists?(email: email)
      redirect '/signup?error=Email-already-exists'
    end

    if Account.exists?(nickname: nickname)
      redirect '/signup?error=Nickname-already-exists'
    end

    account = Account.new(email: email, password: password, name: name, nickname: nickname, progress: 0)

    if account.save
      session[:logged_in] = true
      session[:account_id] = account.id
      redirect '/login'
    else
      erb :signup, locals: { error_message: "Error al crear cuenta" }
    end
  end

  post '/home' do
    selected_game = params[:game]
    session[:selected_game] = selected_game
    redirect '/learn'
  end

  get '/learn' do
    selected_game = session[:selected_game]
    # Fetch questions related to the selected game from the database
    # questions = Question.where(game: selected_game) # Assuming you have a Question model
    erb :learn, locals: { selected_game: selected_game }
  end

  post '/learn' do
    selected_game = session[:selected_game]
    difficulty = params[:difficulty]
    "Learning #{selected_game} at difficulty #{difficulty}!"
  end

  post '/logout' do
    session.clear
    redirect '/'
  end
end
