require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'

require 'sinatra/reloader' if Sinatra::Base.environment == :development

require_relative 'models/account'
require_relative 'models/answer'
require_relative 'models/test'
require_relative 'models/trivia'
require_relative 'models/game'
require_relative 'models/question'
require_relative 'models/account_trivias'
require_relative 'models/account_test'
require_relative 'models/account_game'
require_relative 'models/account_answer'



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
  set :styles, File.join(File.dirname(__FILE__), 'styles')
  set :public_folder, File.join(File.dirname(__FILE__), 'assets')
  
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
    if session[:email]
      erb :home
    else
      redirect '/login'
    end
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
      puts "Error al guardar la cuenta: #{account.errors.full_messages.join(", ")}"
      erb :signup, locals: { error_message: "Error al crear cuenta" }
    end
  end

  post '/home' do
    selected_game = params[:game]
    session[:selected_game] = selected_game
    redirect "/difficult/#{selected_game}"
  end

  get '/difficult/:game' do
    selected_game = params[:game]
    erb :difficult, locals: { selected_game: selected_game }
  end

  post '/difficult' do
    difficulty = params[:difficult]
    redirect "/trivia/#{difficulty}"
  end
  

 get '/trivia/:test_letter/:lesson_number' do
    if session[:logged_in] == true

      test_letter = params[:test_letter]
      lesson_number = params[:lesson_number]

      @test = Test.find_by(letter: test_letter)
      @trivia = Trivia.find_by(test_letter: test_letter, number: lesson_number)


      # Se obtiene la letra del test que se corresponde con la leccion
      related_test_letter = @trivia.test_letter

      # Se obtienen todas las preguntas y las lecciones que estan relacionadas con el test
      @questions = Question.where(test_letter: related_test_letter)
      @trivias = Trivia.where(test_letter: related_test_letter)

      # Se obtiene la ultima leccion
      last_lesson_in_group = @trivias.last.number

      # Se verifica si la leccion actual es la ultima
      @current_is_last = @trivia.number == last_lesson_in_group

      # Se obtiene la (supuesta) proxima leccion
      next_lesson = @trivia.number + 1

      # Se almacena la url a donde debera ser redirigido el usuario dependiendo de la situacion
      @next_step = @current_is_last ? "/test/#{related_test_letter}/#{@questions.minimum(:number)}" : "/trivia/#{related_test_letter}/#{next_lesson}"

      account = Account.find(session[:account_id])
      trivia = Trivia.find_by(test_letter: test_letter, number: lesson_number)

      if trivia
        accounts_lesson = AccountLesson.find_by(lesson_id: trivia.id, account_id: account.id)

        if accounts_lesson
          # Actualizar el valor de lesson_completed
          accounts_lesson.update(lesson_completed: true)
        end
      end

      erb :trivia
    else
      redirect "/"
    end
  end
  
  
  
  get 'logout' do
    redirect '/'
  end

  post '/logout' do
    session.clear
    redirect '/'
  end
end
