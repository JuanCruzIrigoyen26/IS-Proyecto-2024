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
require_relative 'models/account_trivia'
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

  GAME_URL_MAPPING = {
  'Counter Strike 2' => 'csgo',
  'Street Fighter 6' => 'sf6',
  'League Of Legends' => 'lol'

  }


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

  get '/perfil' do
    erb :perfil
  end

  get '/signup' do
    erb :signup
  end

  get '/home' do
    if session[:logged_in]
      @games = Game.all
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
    if session[:logged_in]
      selected_game_name = params[:game]
      account_id = session[:account_id]
  
      unless account_id
        status 400
        body "Account ID is missing in session."
        return
      end
  
      selected_game = Game.find_by(name: selected_game_name)
      
      if selected_game.nil?
        status 400
        body "Game not found."
        return
      end
  
      session[:selected_game] = selected_game.name
  
      if Account.exists?(id: account_id)
        account_game = AccountGame.find_or_create_by(account_id: account_id, game_id: selected_game.id)
        if account_game.save
          game_url_name = GAME_URL_MAPPING[selected_game.name] || selected_game.name
          redirect "/difficult/#{game_url_name}"
        else
          status 400
          body "Unable to save AccountGame."
        end
      else
        status 400
        body "Account ID does not exist."
      end
    else
      redirect "/login"
    end
  end

  post '/perfil' do
    if session[:logged_in]
      account_id = session[:account_id]
      new_username = params[:nickname]
      new_password = params[:password]
  
      account = Account.find(account_id)
  
      if account
        if new_username && !new_username.strip.empty?
          account.update(nickname: new_username) 
        end
  
        if new_password && !new_password.strip.empty?
          account.update(password: new_password) 
        end
  
        if account.save
          redirect '/perfil?success=true'
        else
          redirect '/perfil?error=update_failed'
        end
      else
        redirect '/perfil?error=account_not_found'
      end
    else
      redirect '/home'
    end
  end
  
  get '/final_exam/:test_letter/:question_number' do
    if session[:logged_in]
      account_id = session[:account_id]
      selected_game = Game.find_by(name: session[:selected_game])
  
      # Verificar si se encuentra el juego
      if selected_game.nil?
        puts "Game not found for session[:selected_game]: #{session[:selected_game]}"
        status 400
        return "Game Not Found"
      end
  
      game_name = GAME_URL_MAPPING[selected_game.name]
      game_number = selected_game.number
      puts "Nombre del juego bien puto =#{game_name}"
  
      test_letter = params[:test_letter]
      question_number = params[:question_number].to_i
  
      # Buscar la pregunta asociada con el juego, el test y el número de pregunta
      @question = Question.find_by(number: question_number, test_letter: test_letter, game_number: game_number)
  
      if @question
        # Si se encuentra la pregunta, obtenemos las respuestas y renderizamos la vista del examen
        @answers = Answer.where(question_number: @question.number, test_letter: test_letter, game_number: game_number).shuffle
        @difficulty = test_letter
  
        erb :final_exam, locals: { question: @question, answers: @answers, difficulty: @difficulty }
      else
        # Si no se encuentra la pregunta, redirige de vuelta a la página de selección de dificultad
        redirect "/difficult/#{URI.encode(session[:selected_game])}?error=question_not_found"
      end
    else
      # Redirige a home si el usuario no está logueado
      redirect '/home'
    end
  end
  

  require 'erb'

  post '/start_final_exam' do
    if session[:logged_in]
      account_id = session[:account_id]
      selected_game = Game.find_by(name: session[:selected_game])
      game_name = GAME_URL_MAPPING[selected_game.name]
      game_number = selected_game.number
      puts "Nombre del juego =#{game_name}" 
    
      if game_name.nil?
        # Mostrar mensaje de error si el juego no se encuentra
        puts "Game not found for game_number: #{game_number}"
        status 400
        body "Game not found"
        return
      else
        puts "Game found: #{selected_game.name}"
      end
  
      test_letter = params[:test_letter] || 'F'
  
      # Verificar si ha completado las trivias requeridas
      completed_trivias_count = AccountTrivia.where(account_id: account_id, trivias_completed: true).count
      required_trivias = 3
  
      if completed_trivias_count < required_trivias
        # Redirigir a la pantalla de selección de dificultad con un mensaje de error
        redirect "/difficult/#{game_name}?error=complete_all_trivias"
        return
      end
  
      @test = Test.find_by(letter: test_letter, game_number: game_number)
  
      if @test
        account_test = AccountTest.find_or_initialize_by(account_id: account_id, test: @test)
        account_test.update(correct_answers: 0, test_completed: false)
        
        redirect "/final_exam/#{test_letter}/1"
      else
        redirect '/home'
      end
    else
      redirect '/home'
    end
  end
  
  
  
  
  
  
  post '/submit_final_exam_answer' do
    if session[:logged_in]
      account_id = session[:account_id]
      question_number = params[:question_number].to_i
      test_letter = params[:test_letter]
      selected_option = params[:selected_option]

      selected_game = Game.find_by(name: session[:selected_game])
      game_name = GAME_URL_MAPPING[selected_game.name] 
      game_number = selected_game.number
  
      @question = Question.find_by(number: question_number, test_letter: test_letter, game_number: game_number)
      @test = Test.find_by(letter: test_letter, game_number: game_number)
      account_test = AccountTest.find_or_initialize_by(account_id: account_id, test: @test)
      account_game = AccountGame.find_or_initialize_by(account_id: account_id, game: @test.game)  # Modificado
  
      if @question
        if selected_option
          selected_answer = Answer.find_by(number: selected_option, question_number: question_number, test_letter: test_letter, game_number: game_number)
  
          if selected_answer
            correct = selected_answer.correct
  
            account_answer = AccountAnswer.find_or_initialize_by(account_id: account_id, question_id: @question.id)
            account_answer.update(answer_id: selected_answer.id, correct: correct)
          
            if correct
              account_test.increment(:correct_answers)
            end
            account_test.save
  
            next_question_number = question_number + 1
            next_question = Question.find_by(number: next_question_number, test_letter: test_letter, game_number: game_number)
  
            if next_question
              redirect "/final_exam/#{test_letter}/#{next_question_number}"
            else
              # Examen finalizado
              account_test.update(test_completed: true)
  
              total_questions = Question.where(test_letter: test_letter, game_number: game_number).count
              correct_answers_count = account_test.correct_answers
              correct_answers_percentage = (correct_answers_count.to_f / total_questions * 100).round(2)

              knowledge_increment = (correct_answers_percentage / 10).to_i  
              new_account_knowledge = [account_game.account_knowledge + knowledge_increment, 100].min  # Máximo de 100
              
              account_game.update(account_knowledge: new_account_knowledge)
  
              erb :result_exam, locals: { correct_answers_percentage: correct_answers_percentage, correct_answers_count: correct_answers_count, total_questions: total_questions }
            end
          else
            redirect "/final_exam/#{test_letter}/#{question_number}?error=invalid_option"
          end
        else
          @answers = Answer.where(question_number: @question.number, test_letter: test_letter, game_number:  game_number).shuffle
          @difficulty = test_letter
  
          erb :final_exam, locals: { question: @question, answers: @answers, difficulty: @difficulty, error: 'Debes seleccionar una opción antes de continuar.' }
        end
      else
        redirect "/difficult/#{game_name}"
      end
    else
      redirect '/home'
    end
  end
  
  
    
  

  get '/difficult/:game_alias' do
    if session[:logged_in]
      
      game_mapping = {
        'csgo' => 1,
        'sf6' => 2,
        'lol' => 3
      }
      selected_game_number = game_mapping[params[:game_alias]]
  
      if selected_game_number.nil?
        status 400
        body "Game not found."
        return
      end
  
      game = Game.find_by(number: selected_game_number)
  
      session[:selected_game] = game.name
      @completed_trivias = AccountTrivia.where(account_id: session[:account_id], trivias_completed: true).count
  
      error_message = nil
      if params[:error] == 'complete_all_trivias'
        error_message = 'Debe completar todas las trivias antes de acceder al examen final.'
      end
  
      erb :difficult, locals: { selected_game: game, completed_trivias: @completed_trivias, error_message: error_message }
    else
      redirect '/home'
    end
  end
  
  

  get '/:game/:test_letter/:question_number' do
    if logged_in?
      game_number = params[:game].to_i     
      game = Game.find_by(number: game_number)
  
      unless game
        status 400
        puts "Game not found."
        redirect "/difficult/#{game_number}"
        return
      end
  
      test_letter = params[:test_letter]
      question_number = params[:question_number].to_i
  
      @question = Question.find_by(number: question_number, test_letter: test_letter, game_number: game.number)
  
      if @question
        @answers = Answer.where(question_number: @question.number, test_letter: test_letter, game_number: game.number).shuffle
        @difficulty = test_letter
  
        erb :trivia, locals: { question: @question, answers: @answers, difficulty: @difficulty }
      else
        redirect "/difficult/#{game.number}"
      end
    else
      redirect "/login"
    end
  end
  
  
  
  


  post '/submit_trivia_answer' do
    if session[:logged_in]
      account_id = session[:account_id]
      question_number = params[:question_number].to_i
      test_letter = params[:test_letter]
      selected_option = params[:selected_option]
      selected_game = Game.find_by(name: session[:selected_game])
      game_name = GAME_URL_MAPPING[selected_game.name] 
      
  
      @question = Question.find_by(number: question_number, test_letter: test_letter)
      @test = Test.find_by(letter: test_letter)
  
      if @question
        if selected_option
          selected_answer = Answer.find_by(number: selected_option, question_number: question_number, test_letter: test_letter, game_number: selected_game.number)
  
          if selected_answer
            correct = selected_answer.correct
  
            account_answer = AccountAnswer.find_or_initialize_by(account_id: account_id, question_id: @question.id)
            account_answer.update(answer_id: selected_answer.id, correct: correct)
  
            trivia = Trivia.find_by(number: question_number, test_letter: test_letter, game_number: selected_game.number)
  
            next_question_number = question_number + 1
            if question_number == 5
              account_trivia = AccountTrivia.find_or_create_by(account_id: account_id, trivias_id: trivia.id, trivias_completed: true)
  
              erb :result, locals: {
                correct: correct,
                description: trivia.description,
                question_number: question_number,
                test_letter: test_letter,
                trivia_completed: true,
                exam_final: false,
                selected_game: selected_game
              }
            else
              
              next_question_path = "/#{selected_game.number}/#{test_letter}/#{next_question_number}"
  
              erb :result, locals: {
                correct: correct,
                description: trivia.description,
                question_number: question_number,
                test_letter: test_letter,
                trivia_completed: false,
                exam_final: false,
                next_question_path: next_question_path, 
                selected_game: selected_game
              }
            end
          else
            @answers = Answer.where(question_number: @question.number, test_letter: test_letter).shuffle
            @difficulty = test_letter
  
            erb :trivia, locals: {
              question: @question,
              answers: @answers,
              difficulty: @difficulty,
              error: 'La opción seleccionada no es válida. Por favor, selecciona otra opción.'
            }
          end
        else
          @answers = Answer.where(question_number: @question.number, test_letter: test_letter).shuffle
          @difficulty = test_letter
  
          erb :trivia, locals: {
            question: @question,
            answers: @answers,
            difficulty: @difficulty,
            error: 'Debes seleccionar una opción antes de continuar.'
          }
        end
      else
        redirect "/difficult/#{game_name}"
      end
    else
      redirect "/home"
    end
  end
  

   
  get '/result_exam' do
    if session[:logged_in]
      account_id = session[:account_id]
      test_letter = params[:test_letter]
      selected_game = Game.find_by(name: session[:selected_game])
      game_name = GAME_URL_MAPPING[selected_game.name] 
      puts "Este es#{game_name}"
      game_number = selected_game.number

  
      @test = Test.find_by(letter: test_letter, game_number: game_number)
      correct_answers = AccountTest.find_by(account_id: account_id, test_id: @test.id)
  
      if correct_answers
        total_questions = 5
        correct_answers_count = correct_answers.correct_answers 
        correct_answers_percentage = (correct_answers_count.to_f / total_questions * 100).round(2)

        erb :result_exam, locals: { correct_answers_percentage: correct_answers_percentage }

      else
        redirect "/difficult/#{game_name}"
      end
    else
      redirect '/home'
    end
  end

  get '/progress/:game_name' do
    if session[:logged_in]
      account_id = session[:account_id]
      selected_game = Game.find_by(name: session[:selected_game])
      game_name = GAME_URL_MAPPING[selected_game.name]
      game_number = selected_game.number
 
      
      if game_name.nil?
        status 404
        body "Game not found."
        return
      end
      
      # Obtén el progreso desde AccountGame
      account_game = AccountGame.find_by(account_id: account_id, game_id: selected_game.id)
      
      if account_game.nil?
        status 404
        body "AccountGame not found."
        return
      end
  

      completed_trivias = AccountTrivia.where(account_id: account_id, trivias_completed: true).count
      exam_completed = account_game.test_completed ? 25 : 0
  
      total_progress = (completed_trivias * 25) + exam_completed
  
      content_type :json
      { progress: total_progress }.to_json
    else
      status 401
      body "User not logged in."
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