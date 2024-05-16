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
      session[:logged_in] = true
      session[:account_id] = account.id

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

    valid_email_format = /^[a-zA-Z0-9_.+-]+@(gmail|outlook|hotmail|live)\.[a-z.]+$/
    valid_password_format = /(?=(?:.*[A-Z].*)+)(?=(?:.*[a-z].*)+)(?=(?:.*\d.*)+)(?!(?:.*\s.*)+)^(?=.{8,}$).*/
    valid_name_format = /(?=(?:^\D*$)+)/
    valid_nickname_format = /(?=(?:^\S*$)+)/

    unless email =~ valid_email_format && password =~ valid_password_format && name =~ valid_name_format && nickname =~ valid_nickname_format
      redirect '/signup?error=Invalid-input-format'
    end

    if Account.exists?(email: email)
      redirect '/signup?error=Email-already-exists'
    elsif Account.exists?(nickname: nickname)
      redirect '/signup?error=Nickname-already-exists'
    else
      account = Account.new(email: email, password: password, name: name, nickname: nickname, progress: 0)
      if account.save
        redirect '/login'
      else
        redirect '/signup?error=Account-creation-failed'
      end
    end
  end



end
