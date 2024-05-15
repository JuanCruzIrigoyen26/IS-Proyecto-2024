AccountTest = Class.new(ActiveRecord::Base)
AccountAnswer = Class.new(ActiveRecord::Base)
AccountTrivia = Class.new(ActiveRecord::Base)
AccountGame = Class.new(ActiveRecord::Base)


# Game 1

game_1 = Game.create(number: 1, name: "Counter Strike 2", genre: "FPS")


#Test A
test_a = Test.create(number: "A", description: "Conceptos de Principiante", cant_questions: 5)

trivia_a1 = Trivia.create(number: 1, title: "CT", description: "CT se los llama al equipo de los Antiterroristas de CS2, los cuales se encargan de defender puntos de plantación de bomba y neutralizar al equipo contrario, los terroristas", test_letter: test_a.letter, mode: "beginner")
trivia_a2 = Trivia.create(number: 2, title: "Dropear", description: "En una partida un jugador Dropea cuando su economia (Cantidad de dinero) es buena y la de un compañero es mala, le pasas un arma para contribuir en la economia del equipo y generar mejores resultados en la ronda", test_letter: test_a.letter, mode: "beginner")
trivia_a3 = Trivia.create(number: 3, title: "Fake", description: "Fake es generar una accion para engañar al contrincante, así obtener un resultado favorable en la partida. Un Fake puede aplicarse de diversas maneras en CS2. Por ejemplo: Hacer creer al enemigo que los TTs van a A y en realidad van a B, defusear por un momento la bomba para engañar al terrorista con el sonido del juego, hacer una entrada falsa con granadas para rotar al otro punto de plantado, etc", test_letter: test_a.letter, mode: "beginner")
trivia_a4 = Trivia.create(number: 4, title: "Frag", description: "Hacer una Frag es eliminar a un jugador del equipo contrario, también puede usarse el termino Fraggear el cual puede significar que la ronda se juegue a eliminar enemigos o que un jugador se dedicara a descontar enemigos (Eliminarlos) durante la ronda", test_letter: test_a.letter, mode: "beginner")
trivia_a5 = Trivia.create(number: 5, title: "Peekear", description: "Un Peek es un angulo que se toma como referencia para apuntar a un lugar especifico y la acción Peekear es asomarse para obtener información sobre un angulo en especifico o una zona del mapa, también se puede considerar Peekear cuando un jugador toma la decisión de asomarse para intentar eliminar un enemigo", test_letter: test_a.letter, mode: "beginner")

question_a1 = Question.create(number: 1, description: "¿Que significa CT?", test_letter: test_a.letter)
question_a2 = Question.create(number: 2, description: "¿Cual de estas acciones es Dropear?", test_letter: test_a.letter)
question_a3 = Question.create(number: 3, description: "¿Cuando se hace un Fake?", test_letter: test_a.letter)
question_a4 = Question.create(number: 4, description: "¿Que significado tiene la palabra Frag?", test_letter: test_a.letter)
question_a5 = Question.create(number: 5, description: "¿Que es Peekear?", test_letter: test_a.letter)

answer_a1 = Answer.create(number: 1, description: "Comunidad Terrorista", correct: false, question_number: question_a1.number, test_letter: test_a.letter)
answer_a2 = Answer.create(number: 2, description: "Antiterrorista", correct: true, question_number: question_a1.number, test_letter: test_a.letter)
answer_a3 = Answer.create(number: 3, description: "Terrorista", correct: false, question_number: question_a1.number, test_letter: test_a.letter)
answer_a4 = Answer.create(number: 1, description: "Ayudar a un compañero a subir a un lugar inalcanzable", correct: false, question_number: question_a2.number, test_letter: test_a.letter)
answer_a5 = Answer.create(number: 2, description: "Llegar rápido al site", correct: false, question_number: question_a2.number, test_letter: test_a.letter)
answer_a6 = Answer.create(number: 3, description: "Pasarle un arma a un compañero que la necesite", correct: true, question_number: question_a2.number, test_letter: test_a.letter)
answer_a7 = Answer.create(number: 1, description: "Cuando se hace una acción para engañar al contrincante", correct: true, question_number: question_a1.number, test_letter: test_a.letter)
answer_a8 = Answer.create(number: 2, description: "Cuando un jugador se asoma de forma rápida para tomar un angulo", correct: false, question_number: question_a1.number, test_letter: test_a.letter)
answer_a9 = Answer.create(number: 3, description: "Cuando todo el equipo se queda en un lugar", correct: false, question_number: question_a1.number, test_letter: test_a.letter)
answer_a10 = Answer.create(number: 1, description: "Eliminar a un enemigo", correct: true, question_number: question_a1.number, test_letter: test_a.letter)
answer_a11 = Answer.create(number: 2, description: "Disparar la mayoría de las balas con un click", correct: false, question_number: question_a1.number, test_letter: test_a.letter)
answer_a12 = Answer.create(number: 3, description: "Eliminar a un compañeor de equipo", correct: false, question_number: question_a1.number, test_letter: test_a.letter)
answer_a13 = Answer.create(number: 1, description: "Obstruir la visión o el paso de un compañero", correct: false, question_number: question_a1.number, test_letter: test_a.letter)
answer_a14 = Answer.create(number: 2, description: "Disparar agachado", correct: false, question_number: question_a1.number, test_letter: test_a.letter)
answer_a15 = Answer.create(number: 3, description: "Asomarse a un angulo/lugar", correct: true, question_number: question_a1.number, test_letter: test_a.letter)


#Test B
test_b = Test.create(number: "B", description: "Conceptos de Casual", cant_questions: 5)


#Test C
test_c = Test.create(number: "C", description: "Conceptos de Profesional", cant_questions: 5)


#Test F
test_f = Test.create(number: "F", description: "Examen Final de Conceptos Competitivos", cant_questions: 15)
