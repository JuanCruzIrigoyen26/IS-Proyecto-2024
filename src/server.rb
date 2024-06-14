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
      selected_game = params[:game]
      session[:selected_game] = selected_game
      redirect "/difficult/#{selected_game}"
    else
      redirect "/login"
    end
  end

  get '/difficult/:game' do
    if session[:logged_in]
      account_id = session[:account_id]
      @selected_game = params[:game]
  
      completed_trivias = AccountTrivia.where(account_id: account_id).pluck(:test_letter)
      all_trivias_completed = ['A', 'B', 'C'].all? { |letter| completed_trivias.include?(letter) }
  
      erb :difficult, locals: { selected_game: @selected_game, all_trivias_completed: all_trivias_completed, error: params[:error] }
    else
      redirect '/home'
    end
  end
  
  post '/submit_answer' do
    if logged_in?
      test_letter = params[:test_letter]
      question_number = params[:question_number].to_i
      selected_option = params[:selected_option]

      selected_answer = Answer.find_by(number: selected_option, question_number: question_number, test_letter: test_letter)

      correct = selected_answer.correct

      trivia = Trivia.find_by(number: question_number, test_letter: test_letter)

      erb :result, locals: { correct: correct, description: trivia.description, question_number: question_number, test_letter: test_letter }
    else
      redirect "/login"
    end
  end

  get '/final_exam/:test_letter/:question_number' do
    if session[:logged_in]
      account_id = session[:account_id]
      completed_trivias = AccountTrivia.where(account_id: account_id).pluck(:test_letter)
      all_trivias_completed = ['A', 'B', 'C'].all? { |letter| completed_trivias.include?(letter) }

      if all_trivias_completed
        test_letter = params[:test_letter]
        question_number = params[:question_number].to_i
        @question = Question.find_by(number: question_number, test_letter: test_letter)

        if @question
          @answers = Answer.where(question_number: @question.number, test_letter: test_letter).shuffle
          @difficulty = test_letter

          erb :final_exam, locals: { question: @question, answers: @answers, difficulty: @difficulty }
        else
          redirect "/difficult/#{session[:selected_game]}"
        end
      else
        redirect "/difficult/#{session[:selected_game]}?error=complete_all_trivias"
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
  
      @question = Question.find_by(number: question_number, test_letter: test_letter)
  
      if @question
        if selected_option
          selected_answer = Answer.find_by(number: selected_option, question_number: question_number, test_letter: test_letter)
          correct = selected_answer.correct
  
          AccountAnswer.create(
            account_id: account_id,
            answer_id: selected_option,
            question_id: @question.id,
            correct: correct
          )
  
          next_question_number = question_number + 1
          next_question = Question.find_by(number: next_question_number, test_letter: test_letter)
  
          if next_question
            erb :result, locals: {
              correct: correct,
              description: correct ? '¡Respuesta correcta!' : 'Respuesta incorrecta.',
              test_letter: test_letter,
              question_number: question_number
            }
          else
            # Marcar el examen final como completado
            AccountTest.create(
              account_id: account_id,
              test_letter: test_letter,
              test_completed: true
            )
  
            redirect "/final_exam_complete"
          end
        else
          # Si no se seleccionó ninguna opción
          @answers = Answer.where(question_number: @question.number, test_letter: test_letter).shuffle
          @difficulty = test_letter
  
          erb :final_exam, locals: { question: @question, answers: @answers, difficulty: @difficulty, error: 'Debes seleccionar una opción antes de continuar.' }
        end
      else
        redirect "/difficult/#{session[:selected_game]}"
      end
    else
      redirect "/home"
    end
  end
  
  


  get '/difficult/:game' do
    if session[:logged_in]
      @selected_game = params[:game]
      @completed_trivias = AccountTrivia.where(account_id: session[:account_id]).pluck(:test_letter)
      erb :difficult, locals: { selected_game: @selected_game, completed_trivias: @completed_trivias }
    else
      redirect "/home"
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


post '/submit_trivia_answer' do
  if session[:logged_in]
    account_id = session[:account_id]
    question_number = params[:question_number].to_i
    test_letter = params[:test_letter]
    selected_option = params[:selected_option]

    @question = Question.find_by(number: question_number, test_letter: test_letter)

    if @question
      if selected_option
        selected_answer = Answer.find_by(number: selected_option, question_number: question_number, test_letter: test_letter)

        if selected_answer
          correct = selected_answer.correct

          # Buscar si ya existe una entrada en AccountAnswer para esta pregunta y cuenta
          account_answer = AccountAnswer.find_or_initialize_by(account_id: account_id, question_id: @question.id)
          account_answer.update(answer_id: selected_answer.id, correct: correct)

          trivia = Trivia.find_by(number: question_number, test_letter: test_letter)

          # Encontrar el ID del test usando test_letter
          test = Test.find_by(letter: test_letter)
          if test
            test_id = test.id

            next_question_number = question_number + 1
            if question_number == 5
              
                account_test = AccountTest.find_or_create_by(account_id: account_id, test_id: test_id)
                
                account_test.update(
                  test_completed: true,
                  correct_answers: correct_answers_count
                )

                # Contar las respuestas correctas
                correct_answers_count = AccountAnswer.where(account_id: account_id, correct: true).count


                erb :result, locals: { correct: correct, description: trivia.description, question_number: question_number, test_letter: test_letter, trivia_completed: true }
            else
              erb :result, locals: { correct: correct, description: trivia.description, question_number: question_number, test_letter: test_letter, trivia_completed: false }
            end
          else
            erb :trivia, locals: { question: @question, answers: Answer.where(question_number: @question.number, test_letter: test_letter).shuffle, difficulty: test_letter, error: 'Test no encontrado.' }
          end
        else
          # Si no se encuentra la respuesta seleccionada
          @answers = Answer.where(question_number: @question.number, test_letter: test_letter).shuffle
          @difficulty = test_letter

          erb :trivia, locals: { question: @question, answers: @answers, difficulty: @difficulty, error: 'La opción seleccionada no es válida. Por favor, selecciona otra opción.' }
        end
      else
        # Si no se seleccionó ninguna opción
        @answers = Answer.where(question_number: @question.number, test_letter: test_letter).shuffle
        @difficulty = test_letter

        erb :trivia, locals: { question: @question, answers: @answers, difficulty: @difficulty, error: 'Debes seleccionar una opción antes de continuar.' }
      end
    else
      redirect "/difficult/#{session[:selected_game]}"
    end
  else
    redirect "/home"
  end
end

  
  
  
  post '/submit_final_answer' do
    selected_option = params[:selected_option]
    if selected_option
      selected_answer = Answer.find_by(number: selected_option)
      correct = selected_answer.correct
  
      question_number = params[:question_number].to_i
      test_letter = params[:test_letter]
  
      if correct
        message = "¡Respuesta correcta!"
      else
        message = "Respuesta incorrecta."
      end
    
      AccountAnswer.create(account_id: session[:account_id], answer_id: selected_answer.id)
  
      next_question_number = question_number + 1
      redirect "/final_exam/#{test_letter}/#{next_question_number}?message=#{message}"
    else
      redirect back
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
