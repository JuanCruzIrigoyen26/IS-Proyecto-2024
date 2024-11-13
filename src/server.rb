# frozen_string_literal: true

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

# App is a Sinatra application that handles all the routing and
# application logic for the trivia game.
class App < Sinatra::Application
  def initialize(_app = nil)
    super()
  end

  configure :production, :development do
    enable :logging

    logger = Logger.new($stdout)
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

  }.freeze

  get '/login' do
    error_message = params[:error]
    erb :sign, locals: { error_message: error_message }
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

    redirect '/login?error=Email-already-exists' if Account.exists?(email: email)

    redirect '/login?error=Nickname-already-exists' if Account.exists?(nickname: nickname)

    account = Account.new(email: email, password: password, name: name, nickname: nickname, progress: 0)

    if account.save
      session[:logged_in] = true
      session[:account_id] = account.id
      redirect '/login'
    else
      puts "Error al guardar la cuenta: #{account.errors.full_messages.join(', ')}"
      erb :sign, locals: { error_message: 'Error al crear cuenta' }
    end
  end

  post '/home' do
    if session[:logged_in]
      handle_home_request
    else
      redirect '/login'
    end
  end

  def handle_home_request
    account_id = session[:account_id]
    return respond_with_error(400, 'Account ID is missing in session.') unless account_id

    selected_game = find_selected_game(params[:game])
    return respond_with_error(400, 'Game not found.') if selected_game.nil?

    session[:selected_game] = selected_game.name

    if account_exists?(account_id)
      handle_account_game(account_id, selected_game)
    else
      respond_with_error(400, 'Account ID does not exist.')
    end
  end

  def find_selected_game(game_name)
    Game.find_by(name: game_name)
  end

  def account_exists?(account_id)
    Account.exists?(id: account_id)
  end

  def handle_account_game(account_id, selected_game)
    account_game = AccountGame.find_or_create_by(account_id: account_id, game_id: selected_game.id)
    if account_game.save
      redirect_to_game(selected_game)
    else
      respond_with_error(400, 'Unable to save AccountGame.')
    end
  end

  def redirect_to_game(selected_game)
    game_url_name = GAME_URL_MAPPING[selected_game.name] || selected_game.name
    redirect "/difficult/#{game_url_name}"
  end

  def respond_with_error(status_code, message)
    status status_code
    body message
  end

  post '/perfil' do
    if session[:logged_in]
      account_id = session[:account_id]
      new_username = params[:nickname]
      new_password = params[:password]

      account = Account.find(account_id)

      if account
        account.update(nickname: new_username) if new_username && !new_username.strip.empty?

        account.update(password: new_password) if new_password && !new_password.strip.empty?

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
      session[:account_id]
      selected_game = Game.find_by(name: session[:selected_game])

      # Verificar si se encuentra el juego
      if selected_game.nil?
        puts "Game not found for session[:selected_game]: #{session[:selected_game]}"
        status 400
        return 'Game Not Found'
      end

      game_name = GAME_URL_MAPPING[selected_game.name]
      game_number = selected_game.number
      puts "Nombre del juego =#{game_name}"

      test_letter = params[:test_letter]
      question_number = params[:question_number].to_i

      # Buscar la pregunta asociada con el juego, el test y el número de pregunta
      @question = Question.find_by(number: question_number, test_letter: test_letter, game_number: game_number)

      if @question
        # Si se encuentra la pregunta, obtenemos las respuestas y renderizamos la vista del examen
        @answers = Answer.where(question_number: @question.number, test_letter: test_letter,
                                game_number: game_number).shuffle
        @difficulty = test_letter

        erb :final_exam, locals: { question: @question, answers: @answers, difficulty: @difficulty }
      else
        # Si no se encuentra la pregunta, redirige de vuelta a la página de selección de dificultad
        redirect "/difficult/#{game_name}?error=question_not_found"
      end
    else
      # Redirige a home si el usuario no está logueado
      redirect '/home'
    end
  end

  post '/start_final_exam' do
    if session[:logged_in]
      handle_final_exam_start
    else
      redirect '/home'
    end
  end

  def handle_final_exam_start
    account_id = session[:account_id]
    selected_game = find_selected_game(session[:selected_game])

    if selected_game.nil?
      log_and_respond_with_error('Game not found for selected game', 400, 'Game not found')
      return
    end

    test_letter = params[:test_letter] || 'F'

    if required_trivias_completed?(account_id)
      initialize_account_test(account_id, selected_game, test_letter)
    else
      redirect_with_error(selected_game, 'complete_all_trivias')
    end
  end

  def log_and_respond_with_error(log_message, status_code, response_message)
    puts log_message
    status status_code
    body response_message
  end

  def required_trivias_completed?(account_id)
    completed_trivias_count = AccountTrivia.where(account_id: account_id, trivias_completed: true).count
    completed_trivias_count >= 3
  end

  def initialize_account_test(account_id, selected_game, test_letter)
    @test = Test.find_by(letter: test_letter, game_number: selected_game.number)

    if @test
      AccountTest.find_or_initialize_by(account_id: account_id, test: @test).update(correct_answers: 0,
                                                                                    test_completed: false)
      redirect "/final_exam/#{test_letter}/1"
    else
      redirect '/home'
    end
  end

  def redirect_with_error(selected_game, error_code)
    game_name = GAME_URL_MAPPING[selected_game.name] || selected_game.name
    redirect "/difficult/#{game_name}?error=#{error_code}"
  end

  post '/submit_final_exam_answer' do
    if session[:logged_in]
      process_exam_submission
    else
      redirect '/home'
    end
  end

  def process_exam_submission
    account_id = session[:account_id]
    selected_game = Game.find_by(name: session[:selected_game])
    game_number = selected_game.number

    @question = find_question(params[:question_number].to_i, params[:test_letter], game_number)
    @test = find_test(params[:test_letter], game_number)

    account_test = handle_test_record(account_id, @test)
    account_game = handle_game_record(account_id, @test)

    handle_question_submission(account_id, params[:selected_option], params[:question_number].to_i,
                               params[:test_letter], game_number, account_test, account_game)
  end

  private

  def find_question(question_number, test_letter, game_number)
    Question.find_by(number: question_number, test_letter: test_letter, game_number: game_number)
  end

  def find_test(test_letter, game_number)
    Test.find_by(letter: test_letter, game_number: game_number)
  end

  def handle_test_record(account_id, test)
    AccountTest.find_or_initialize_by(account_id: account_id, test: test)
  end

  def handle_game_record(account_id, test)
    AccountGame.find_or_initialize_by(account_id: account_id, game: test.game)
  end

  def handle_question_submission(account_id, selected_option, question_number, test_letter, game_number, account_test,
                                 account_game)
    if @question
      if selected_option
        handle_answer_submission(account_id, selected_option, question_number, test_letter, game_number, account_test,
                                 account_game)
      else
        display_final_exam_error
      end
    else
      redirect_to_game_difficulty
    end
  end

  def handle_answer_submission(account_id, selected_option, question_number, test_letter, game_number, account_test,
                               account_game)
    selected_answer = find_selected_answer(selected_option, question_number, test_letter, game_number)

    if selected_answer
      update_account_answer(account_id, selected_answer)
      update_account_test(account_test, selected_answer)
      redirect_to_next_question(question_number, test_letter, game_number, account_test, account_game)
    else
      redirect_invalid_option(question_number, test_letter)
    end
  end

  def find_selected_answer(selected_option, question_number, test_letter, game_number)
    Answer.find_by(number: selected_option, question_number: question_number, test_letter: test_letter,
                   game_number: game_number)
  end

  def update_account_answer(account_id, selected_answer)
    account_answer = AccountAnswer.find_or_initialize_by(account_id: account_id, question_id: @question.id)
    account_answer.update(answer_id: selected_answer.id, correct: selected_answer.correct)
  end

  def update_account_test(account_test, selected_answer)
    account_test.increment(:correct_answers) if selected_answer.correct
    account_test.save
  end

  def redirect_to_next_question(question_number, test_letter, game_number, account_test, account_game)
    next_question_number = question_number + 1
    next_question = Question.find_by(number: next_question_number, test_letter: test_letter, game_number: game_number)

    if next_question
      redirect "/final_exam/#{test_letter}/#{next_question_number}"
    else
      finalize_exam(account_test, account_game)
    end
  end

  def redirect_invalid_option(question_number, test_letter)
    redirect "/final_exam/#{test_letter}/#{question_number}?error=invalid_option"
  end

  def finalize_exam(account_test, account_game)
    account_test.update(test_completed: true)

    total_questions = Question.where(test_letter: account_test.test.letter, game_number: account_game.game.number).count
    correct_answers_count = account_test.correct_answers
    correct_answers_percentage = calculate_correct_answers_percentage(correct_answers_count, total_questions)

    knowledge_increment = calculate_knowledge_increment(correct_answers_percentage)
    new_account_knowledge = knowledge_increment

    account_game.update(account_knowledge: new_account_knowledge)

    display_exam_results(correct_answers_percentage, correct_answers_count, total_questions, account_game)
  end

  def calculate_correct_answers_percentage(correct_answers_count, total_questions)
    (correct_answers_count.to_f / total_questions * 100).round(2)
  end

  def calculate_knowledge_increment(correct_answers_percentage)
    (correct_answers_percentage / 10).to_i
  end

  def display_exam_results(correct_answers_percentage, correct_answers_count, total_questions, account_game)
    erb :result_exam,
        locals: { correct_answers_percentage: correct_answers_percentage,
                  correct_answers_count: correct_answers_count,
                  total_questions: total_questions,
                  selected_game: account_game.game }
  end

  def display_final_exam_error
    @answers = Answer.where(question_number: @question.number, test_letter: test_letter,
                            game_number: game_number).shuffle
    @difficulty = test_letter

    erb :final_exam,
        locals: { question: @question, answers: @answers, difficulty: @difficulty,
                  error: 'Debes seleccionar una opción antes de continuar.' }
  end

  def redirect_to_game_difficulty
    game_name = GAME_URL_MAPPING[selected_game.name]
    redirect "/difficult/#{game_name}"
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
        body 'Game not found.'
        return
      end

      game = Game.find_by(number: selected_game_number)

      session[:selected_game] = game.name
      @completed_trivias = AccountTrivia.where(account_id: session[:account_id], trivias_completed: true).count
      error_message = params[:error] == 'complete_all_trivias' ? 'Completa 3 trivias para hacer el examen final' : nil

      @is_admin = Account.find(session[:account_id]).admin == 1

      erb :difficult,
          locals: { selected_game: game, completed_trivias: @completed_trivias, error_message: error_message,
                    is_admin: @is_admin }
    else
      redirect '/home'
    end
  end

  post '/create_question' do
    if session[:logged_in] && admin?
      create_question_and_trivia
      redirect "/difficult/#{game_name_for(session[:selected_game])}"
    else
      unauthorized_response
    end
  end

  def admin?
    Account.find(session[:account_id]).admin == 1
  end

  def create_question_and_trivia
    selected_game = find_game(session[:selected_game])
    test_letter = params[:test_letter]
    question_number = next_question_number(test_letter, selected_game.number)

    create_question(question_number, test_letter, selected_game.number)
    create_trivia(question_number, test_letter, selected_game.number)
    create_answers(question_number, test_letter, selected_game.number)
  end

  def next_question_number(test_letter, game_number)
    Question.where(test_letter: test_letter, game_number: game_number).count + 1
  end

  def create_question(number, test_letter, game_number)
    Question.create(
      number: number,
      description: params[:question_description],
      test_letter: test_letter,
      game_number: game_number
    )
  end

  def create_trivia(number, test_letter, game_number)
    Trivia.create(
      number: number,
      title: params[:trivia_title],
      description: params[:trivia_description],
      test_letter: test_letter,
      game_number: game_number
    )
  end

  def create_answers(question_number, test_letter, game_number)
    correct_answer = params[:correct_answer]
    params[:incorrectanswer1]
    params[:incorrectanswer2]

    Answer.create(
      number: 1, correct: true, description: correct_answer,
      question_number: question_number, test_letter: test_letter, game_number: game_number
    )

    Answer.create(
      number: 2, correct: false, description: params[:incorrectanswer1],
      question_number: question_number, test_letter: test_letter, game_number: game_number
    )

    Answer.create(
      number: 3, correct: false, description: params[:incorrectanswer2],
      question_number: question_number, test_letter: test_letter, game_number: game_number
    )
  end

  def unauthorized_response
    status 401
    body 'Unauthorized'
  end

  def find_game(game_name)
    Game.find_by(name: game_name)
  end

  def game_name_for(game_name)
    GAME_URL_MAPPING[game_name] || game_name
  end

  get '/incorrect_questions' do
    if session[:logged_in] && Account.find(session[:account_id]).admin == 1
      @is_admin = true
      incorrect_questions = Question.joins(:account_answers)
                                    .where(account_answers: { correct: false })
                                    .group('questions.description')
                                    .select('questions.description, COUNT(account_answers.id) as incorrect_count')
                                    .distinct
      incorrect_questions_json = incorrect_questions.map do |question|
        {
          description: question.description,
          incorrect_count: question.incorrect_count
        }
      end

      puts incorrect_questions_json.to_json

      content_type :json
      incorrect_questions_json.to_json
    else
      status 403
      { error: 'Acceso no autorizado' }.to_json
    end
  end

  get '/correct_questions' do
    if session[:logged_in] && Account.find(session[:account_id]).admin == 1
      @is_admin = true
      correct_questions = Question.joins(:account_answers)
                                  .where(account_answers: { correct: true })
                                  .group('questions.description')
                                  .select('questions.description, COUNT(account_answers.id) as correct_count')
                                  .distinct
      correct_questions_json = correct_questions.map do |question|
        {
          description: question.description,
          correct_count: question.correct_count
        }
      end

      puts correct_questions_json.to_json

      content_type :json
      correct_questions_json.to_json
    else
      status 403
      { error: 'Acceso no autorizado' }.to_json
    end
  end

  get '/:game/:test_letter/:question_number' do
    if logged_in?
      game_number = params[:game].to_i
      game = Game.find_by(number: game_number)

      unless game
        status 400
        puts 'Game not found.'
        redirect "/difficult/#{game_number}"
        return
      end

      test_letter = params[:test_letter]
      question_number = params[:question_number].to_i

      @question = Question.find_by(number: question_number, test_letter: test_letter, game_number: game.number)

      if @question
        @answers = Answer.where(question_number: @question.number, test_letter: test_letter,
                                game_number: game.number).shuffle
        @difficulty = test_letter

        erb :trivia, locals: { question: @question, answers: @answers, difficulty: @difficulty }
      else
        redirect "/difficult/#{game.number}"
      end
    else
      redirect '/login'
    end
  end

  post '/submit_trivia_answer' do
    redirect '/home' and return unless session[:logged_in]

    account_id = session[:account_id]
    question_number = params[:question_number].to_i
    test_letter = params[:test_letter]
    selected_option = params[:selected_option]
    selected_game = Game.find_by(name: session[:selected_game])
    game_name = GAME_URL_MAPPING[selected_game.name]

    @question = Question.find_by(number: question_number, test_letter: test_letter)
    @test = Test.find_by(letter: test_letter)

    redirect "/difficult/#{game_name}" and return unless @question

    if selected_option
      process_selected_option(
        account_id, question_number, test_letter, selected_option, selected_game
      )
    else
      render_trivia_with_error('Debes seleccionar una opción antes de continuar.')
    end
  end

  def process_selected_option(account_id, question_number, test_letter, selected_option, selected_game)
    selected_answer = Answer.find_by(
      number: selected_option, question_number: question_number,
      test_letter: test_letter, game_number: selected_game.number
    )

    if selected_answer
      handle_answer(account_id, question_number, test_letter, selected_answer, selected_game)
    else
      render_trivia_with_error('La opción seleccionada no es válida. Por favor, selecciona otra opción.')
    end
  end

  def handle_answer(account_id, question_number, test_letter, selected_answer, selected_game)
    correct = selected_answer.correct
    trivia = Trivia.find_by(
      number: question_number, test_letter: test_letter, game_number: selected_game.number
    )

    account_answer = AccountAnswer.find_or_initialize_by(
      account_id: account_id, question_id: @question.id
    )
    account_answer.update(answer_id: selected_answer.id, correct: correct)

    question_limit = Question.where(test_letter: test_letter, game_number: selected_game.number).count

    if question_number == question_limit
      complete_trivia(account_id, trivia, correct, test_letter, question_number, selected_game)
    else
      next_question_path = "/#{selected_game.number}/#{test_letter}/#{question_number + 1}"
      render_result(correct, trivia.description, question_number, test_letter, next_question_path, selected_game)
    end
  end

  def complete_trivia(account_id, trivia, correct, test_letter, question_number, selected_game)
    AccountTrivia.find_or_create_by(
      account_id: account_id, trivias_id: trivia.id, trivias_completed: true
    )

    erb :result, locals: {
      correct: correct,
      description: trivia.description,
      question_number: question_number,
      test_letter: test_letter,
      trivia_completed: true,
      exam_final: false,
      selected_game: selected_game
    }
  end

  def render_result(correct, description, question_number, test_letter, next_question_path, selected_game)
    erb :result, locals: {
      correct: correct,
      description: description,
      question_number: question_number,
      test_letter: test_letter,
      trivia_completed: false,
      exam_final: false,
      next_question_path: next_question_path,
      selected_game: selected_game
    }
  end

  def render_trivia_with_error(error_message)
    @answers = Answer.where(question_number: @question.number, test_letter: params[:test_letter]).shuffle
    @difficulty = params[:test_letter]
    erb :trivia, locals: {
      question: @question,
      answers: @answers,
      difficulty: @difficulty,
      error: error_message
    }
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
      selected_game = Game.find_by(name: params[:game_name]) # Encontrar el juego específico según el parámetro
      return status 404 if selected_game.nil?

      account_game = AccountGame.find_by(account_id: account_id, game_id: selected_game.id)
      total_progress = account_game ? account_game.account_knowledge * 10 : 0
      content_type :json
      { progress: total_progress }.to_json
    else
      status 401
      body 'User not logged in.'
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
