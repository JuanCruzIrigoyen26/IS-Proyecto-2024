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
  set :public_folder, File.join(File.dirname(__FILE__), 'styles')

  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'Reloaded...'
    end
  end

  before do
    @current_user = session[:account_id] && Account.find_by(id: session[:account_id])
  end

  helpers do
    def logged_in?
      !!@current_user
    end
  end

  get '/login' do
    error_message = params[:error]
    erb :login, locals: { error_message: error_message }
  end

  get '/' do
    if logged_in?
      redirect '/home'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    erb :signup
  end

  get '/home' do
    if logged_in?
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
      session[:account_id] = account.id
      session[:logged_in] = true
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
    if logged_in?
      # Obtener el juego seleccionado desde los parámetros del formulario
      selected_game = params[:game]
      # Guardar el juego seleccionado en la sesión
      session[:selected_game] = selected_game
      # Redirigir al usuario a la página de selección de dificultad
      redirect "/difficult/#{selected_game}"
    else
      redirect "/login"
    end
  end

  get '/difficult/:game' do
    if logged_in?
      selected_game = params[:game]
      erb :difficult, locals: { selected_game: selected_game }
    else
      redirect "/login"
    end
  end

  post '/difficult' do
    if logged_in?
      difficulty = params[:difficulty]
      selected_game = session[:selected_game]
      redirect "/trivia/#{difficulty}/#{selected_game}"
    else
      redirect "/login"
    end
  end

  post '/submit_answer' do
    if logged_in?
      test_letter = params[:test_letter]
      question_number = params[:question_number].to_i
      selected_option = params[:selected_option]

      # Encuentra la respuesta seleccionada
      selected_answer = Answer.find_by(number: selected_option, question_number: question_number, test_letter: test_letter)

      # Verifica si la respuesta es correcta
      correct = selected_answer.correct

      # Encuentra la trivia correspondiente para mostrar la descripción
      trivia = Trivia.find_by(number: question_number, test_letter: test_letter)

      # Renderiza la vista de resultado
      erb :result, locals: { correct: correct, description: trivia.description, question_number: question_number, test_letter: test_letter }
    else
      redirect "/login"
    end
  end

  get '/trivia/:test_letter/:question_number' do
    if logged_in?
      test_letter = params[:test_letter]
      question_number = params[:question_number].to_i

      @question = Question.find_by(number: question_number, test_letter: test_letter)

      if @question
        @answers = Answer.where(question_number: @question.number, test_letter: test_letter).shuffle
        @difficulty = params[:test_letter] # Aquí asignamos el valor de dificultad

        erb :trivia, locals: { question: @question, answers: @answers, difficulty: @difficulty }
      else
        redirect "/difficult/#{session[:selected_game]}"
      end
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  post '/logout' do
    session.clear
    redirect '/'
  end
end
