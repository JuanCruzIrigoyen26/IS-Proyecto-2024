# frozen_string_literal: true

AccountTest = Class.new(ActiveRecord::Base)
AccountAnswer = Class.new(ActiveRecord::Base)
AccountTrivia = Class.new(ActiveRecord::Base)
AccountGame = Class.new(ActiveRecord::Base)

Account.find_or_create_by!(admin: 1) do |admin|
  admin.email = 'admin@gmail.com'
  admin.name = 'admin'
  admin.nickname = 'admin'
  admin.password = 'admin123'
  admin.progress = 100
  admin.admin = 1
end

# Game 1
game1 = Game.find_or_create_by!(number: 1) do |game|
  game.name = 'Counter Strike 2'
  game.genre = 'FPS'
  game.image_path = 'csgo.jpeg'
end

game2 = Game.find_or_create_by!(number: 2) do |game|
  game.name = 'Street Fighter 6'
  game.genre = 'Fight'
  game.image_path = 'sf2.jpeg'
end

game3 = Game.find_or_create_by!(number: 3) do |game|
  game.name = 'League Of Legends'
  game.genre = 'MOBA'
  game.image_path = 'Lol.jpeg'
end

# Crear un test
test_a = Test.find_or_create_by!(letter: 'A') do |test|
  test.description = 'Conceptos de Principiante'
  test.cant_questions = 5
  test.game_number = game1.number
end

Trivia.create(
  number: 1,
  title: 'CT',
  description:
              'En Counter Strike siempre ha existido la división de equipos entre CT y TT, los cuales cumplen ' \
              'sus roles de defender y atacar (En el ámbito competitivo de CS siempre los CT defienden y los ' \
              'TT atacan, esto se debe a que el modo de juego predeterminado para torneos es el de "Plantar y ' \
              'desactivar la bomba"). CT se los llama al equipo de los Antiterroristas, los cuales se encargan ' \
              'de defender puntos de plantación de bomba y neutralizar al equipo contrario, los terroristas ' \
              '(TT). A la hora de desactivar la bomba, tienen un tiempo determinado para lograr desactivarla ' \
              '(40 segundos desde que es plantada) en el cual deben plantear la jugada más eficaz para realizar ' \
              'el Retake. En el mismo, dependiendo la situación, deberán limpiar los Spots del site y eliminar ' \
              'a los jugadores enemigos restantes en el menor tiempo posible, ya que los CT no tienen mucho ' \
              'tiempo para desactivar la bomba (10 segundos si no tiene un kit de desactivación y 5 segundos ' \
              'si lo tiene el jugador que desactiva la bomba). En resumen, es el equipo encargado de defender ' \
              'los ataques enemigos y lograr generar un ataque si el equipo rival logra cumplir su primer ' \
              'objetivo de plantar la bomba.',
  test_letter: test_a.letter,
  mode: 'beginner',
  game_number: game1.number
)
Trivia.create(
  number: 2,
  title: 'Dropear',
  description:
              'En una partida un jugador realiza un Drop cuando su economia (Cantidad de dinero) es buena' \
              'y la de un compañero es mala, le pasas un arma para contribuir en la economia del equipo y generar' \
              'mejores resultados en la ronda. En CS2 es importante tener en cuenta que es posible dropear granadas,' \
              'ya que en anteriores versiones de CS no era posible. Existen otras situaciones que dropear un objeto' \
              'puede generar un Fake de sonido para engañar al enemigo, ya sea para eliminarlo o infiltrarse en una' \
              'zona vigilada por ellos.',
  test_letter: test_a.letter,
  mode: 'beginner',
  game_number: game1.number
)
Trivia.create(
  number: 3,
  title: 'Fake',
  description:
              'Un Fake es generar una accion para engañar al enemigo, para así obtener un resultado favorable' \
              'en la partida. Existen dos tipos de formas de generar un Fake, por el sonido o una jugada falsa. ' \
              'Un Fake puede aplicarse en diversas situaciones en CS2, a continuación te damos ejemplos: Hacer creer' \
              'al enemigo que los TTs van a A y en realidad van a B, defusear por un momento la bomba para engañar' \
              'al terrorista con el sonido del juego, hacer una entrada falsa con granadas para rotar al otro punto ' \
              'de plantado, etc.',
  test_letter: test_a.letter,
  mode: 'beginner',
  game_number: game1.number
)
Trivia.create(
  number: 4,
  title: 'Frag',
  description:
              'Generar una Frag es eliminar a un jugador del equipo contrario, también puede usarse el termino' \
              'Fraggear el cual puede significar que la ronda se juegue a eliminar enemigos o que un jugador se' \
              'dedicará a descontar enemigos (Eliminarlos) durante la ronda. La mayoría de jugadores pueden' \
              'hacer Frags, pero en el ámbito competitivo existen los EntryFraggers que son conocidos por generar' \
              'gran cantidad de eliminaciones por ser los primeros en entrar al Site.',
  test_letter: test_a.letter,
  mode: 'beginner',
  game_number: game1.number
)
Trivia.create(
  number: 5,
  title: 'Peekear',
  description:
              'Un Peek es un ángulo que se toma como referencia para apuntar a un lugar específico del mapa y' \
              'la acción Peekear es asomarse para obtener información sobre un Spot o una zona del mapa,' \
              'también se puede considerar Peekear cuando un jugador toma la decisión de asomarse para intentar' \
              'eliminar un enemigo. La acción de Peekear es muy utilizada en las siguientes situaciones:' \
              'Cuando el equipo TT entra a un Site y el primer jugador (En competitivo el EntryFragger) debe limpiar' \
              'cada Spot, cuando el equipo CT debe realizar un Retake en el cual lo primero que se hace es un Peek' \
              'a los Spots que puedan estar los enemigos para obtener la información necesaria de sus ubicaciones' \
              'ó cuando se entra en sigilo a lugares recurrentes por el rivaly se debe Peekear cada ángulo.',
  test_letter: test_a.letter,
  mode: 'beginner',
  game_number: game1.number
)

question_a1 = Question.create(number: 1, description: '¿Que significa CT?', test_letter: test_a.letter,
                              game_number: game1.number)
question_a2 = Question.create(number: 2, description: '¿Cual de estas acciones es Dropear?',
                              test_letter: test_a.letter, game_number: game1.number)
question_a3 = Question.create(number: 3, description: '¿Cuando se hace un Fake?', test_letter: test_a.letter,
                              game_number: game1.number)
question_a4 = Question.create(number: 4, description: '¿Que significado tiene la palabra Frag?',
                              test_letter: test_a.letter, game_number: game1.number)
question_a5 = Question.create(number: 5, description: '¿Que es Peekear?', test_letter: test_a.letter,
                              game_number: game1.number)

Answer.create(number: 1, description: 'Comunidad Terrorista', correct: false,
              question_number: question_a1.number, test_letter: test_a.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Antiterrorista', correct: true,
              question_number: question_a1.number, test_letter: test_a.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Terrorista', correct: false, question_number: question_a1.number,
              test_letter: test_a.letter, game_number: game1.number)
Answer.create(number: 1, description: 'Ayudar a un compañero a subir a un lugar inalcanzable',
              correct: false, question_number: question_a2.number, test_letter: test_a.letter,
              game_number: game1.number)
Answer.create(number: 2, description: 'Llegar rápido al site', correct: false,
              question_number: question_a2.number, test_letter: test_a.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Pasarle un arma a un compañero que la necesite', correct: true,
              question_number: question_a2.number, test_letter: test_a.letter, game_number: game1.number)
Answer.create(number: 1, description: 'Cuando se hace una acción para engañar al contrincante',
              correct: true, question_number: question_a3.number, test_letter: test_a.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Cuando un jugador se asoma de forma rápida para tomar un angulo',
              correct: false, question_number: question_a3.number, test_letter: test_a.letter,
              game_number: game1.number)
Answer.create(number: 3, description: 'Cuando todo el equipo se queda en un lugar', correct: false,
              question_number: question_a3.number, test_letter: test_a.letter, game_number: game1.number)
Answer.create(number: 1, description: 'Eliminar a un enemigo', correct: true,
              question_number: question_a4.number, test_letter: test_a.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Disparar la mayoría de las balas con un click', correct: false,
              question_number: question_a4.number, test_letter: test_a.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Eliminar a un compañero de equipo', correct: false,
              question_number: question_a4.number, test_letter: test_a.letter, game_number: game1.number)
Answer.create(number: 1, description: 'Obstruir la visión o el paso de un compañero', correct: false,
              question_number: question_a5.number, test_letter: test_a.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Disparar agachado', correct: false,
              question_number: question_a5.number, test_letter: test_a.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Asomarse a un ángulo/lugar', correct: true,
              question_number: question_a5.number, test_letter: test_a.letter, game_number: game1.number)

# Test B
test_b = Test.create(letter: 'B', description: 'Conceptos de Casual', cant_questions: 5, game_number: game1.number)

Trivia.create(
  number: 1,
  title: 'Wallbang',
  description:
              'Un Wallbang o también en Español Shutear se realiza cuando un jugador dispara a través de paredes.' \
              'Dependiendo el arma que lleve en sus manos, las balas traspasaran o no ciertas estructuras o paredes,' \
              'ya sea por sus proporciones o por el material de la estructura. Por ejemplo: Una Glock-18 puede llegar' \
              'a atravesar paredes o estructuras de madera, pero no atravesará un muro grueso de ladrillos o ' \
              'cemento, en cambio un AWP puede atravesar ambos.',
  test_letter: test_b.letter,
  mode: 'casual',
  game_number: game1.number
)
Trivia.create(
  number: 2,
  title: 'One way',
  description:
              'Un One Way es un humo (Smoke) el cual tira un jugador de forma tal que sólo su equipo puede ver del' \
              'otro lado, mientras el equipo contrario no puede ver lo que hay del otro lado del humo. ' \
              'En muchas ocasiones puede suceder que si un jugador tira mal un humo, el equipo contrario se aprovecha' \
              'del error y termina ganando la ronda gracias a esa acción.',
  test_letter: test_b.letter,
  mode: 'casual',
  game_number: game1.number
)
Trivia.create(
  number: 3,
  title: 'Eco',
  description:
              'Se dice que un equipo hace un Eco cuando decide no gastar mucho dinero en esa ronda. ' \
              'Existen diversos factores para decidir si realizar un Eco o no, como el equipo contrario o las rondas ' \
              'ganadas o perdidas que se llevan. Un Eco consiste en no gastar en armamento o gastar el mínimo ' \
              'posible para luego en la ronda siguiente poder tener la cantidad de dinero necesaria para comprar ' \
              'todo el armamento y utilidad.',
  test_letter: test_b.letter,
  mode: 'casual',
  game_number: game1.number
)
Trivia.create(
  number: 4,
  title: 'Ronda cuchillo',
  description:
              'En CS2 se juega una ronda inicial para ver qué equipo comienza en cada lado (CT o TT) en la cual ' \
              'todos los jugadores sólo pueden usar el cuchillo para eliminar a los jugadores contrarios. ' \
              'A la ronda cuchillo también se la llama simplemente cuchillo. También puede suceder que algún jugador ' \
              'en la ronda normal llegue a acercarse tanto a un enemigo que decida sacar el cuchillo para eliminarlo.',
  test_letter: test_b.letter,
  mode: 'casual',
  game_number: game1.number
)
Trivia.create(
  number: 5,
  title: 'AWP',
  description:
              'Un AWP es el rifle de francotirador más utilizado en el ámbito competitivo de CS2. ' \
              'Es el arma más cara del juego (4750$) y es conocida por matar de un solo disparo si el enemigo ' \
              'no tiene casco. La cadencia de tiro del arma es la más baja del juego, pero si el jugador es preciso ' \
              'en sus disparos puede matar a todo el equipo contrario. Sin embargo, su precio elevado y sus ' \
              'limitaciones la hacen un arma difícil de utilizar en todas las rondas.',
  test_letter: test_b.letter,
  mode: 'casual',
  game_number: game1.number
)

question_b1 = Question.create(number: 1, description: '¿Que es un Wallbang?', test_letter: test_b.letter,
                              game_number: game1.number)
question_b2 = Question.create(number: 2, description: '¿Para qué se utiliza un One Way?', test_letter: test_b.letter,
                              game_number: game1.number)
question_b3 = Question.create(number: 3, description: '¿En qué consiste un Eco?', test_letter: test_b.letter,
                              game_number: game1.number)
question_b4 = Question.create(number: 4, description: '¿Qué significa ronda cuchillo en CS2?',
                              test_letter: test_b.letter, game_number: game1.number)
question_b5 = Question.create(number: 5, description: '¿Cual es el arma más cara del juego?',
                              test_letter: test_b.letter, game_number: game1.number)

Answer.create(number: 1, description: 'Una técnica para ver al enemigo a través de la pared',
              correct: false, question_number: question_b1.number, test_letter: test_b.letter,
              game_number: game1.number)
Answer.create(number: 2, description: 'Disparar a través de las paredes', correct: true,
              question_number: question_b1.number, test_letter: test_b.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Destruir una pared', correct: false,
              question_number: question_b1.number, test_letter: test_b.letter, game_number: game1.number)
Answer.create(number: 1, description: 'Para ver sin ser visto', correct: true,
              question_number: question_b2.number, test_letter: test_b.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Para lanzar granadas sin ser detectado', correct: false,
              question_number: question_b2.number, test_letter: test_b.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Para rotar sin hacer ruido', correct: false,
              question_number: question_b2.number, test_letter: test_b.letter, game_number: game1.number)
Answer.create(number: 1, description: 'No gastar dinero en la ronda', correct: true,
              question_number: question_b3.number, test_letter: test_b.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Gastar todo el dinero', correct: false,
              question_number: question_b3.number, test_letter: test_b.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Eliminar al equipo contrario con una sola arma', correct: false,
              question_number: question_b3.number, test_letter: test_b.letter, game_number: game1.number)
Answer.create(number: 1, description: 'Una ronda donde sólo se usan cuchillos', correct: true,
              question_number: question_b4.number, test_letter: test_b.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Una técnica de infiltración', correct: false,
              question_number: question_b4.number, test_letter: test_b.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Una estrategia de emboscada', correct: false,
              question_number: question_b4.number, test_letter: test_b.letter, game_number: game1.number)
Answer.create(number: 1, description: 'AK-47', correct: false, question_number: question_b5.number,
              test_letter: test_b.letter, game_number: game1.number)
Answer.create(number: 2, description: 'AWP', correct: true, question_number: question_b5.number,
              test_letter: test_b.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Desert Eagle', correct: false,
              question_number: question_b5.number, test_letter: test_b.letter, game_number: game1.number)

# Test C
test_c = Test.create(letter: 'C', description: 'Conceptos de Profesional', cant_questions: 5,
                     game_number: game1.number)

Trivia.create(
  number: 1,
  title: 'Entryfragger',
  description:
              'El Entryfragger es el rol que lleva el jugador con mejor puntería (Aim) y conocimiento de ángulos del ' \
              'equipo. Este mismo se encarga de ser el iniciador de la entrada a un site, tomando riesgos grandes ' \
              'para obtener una frag o simplemente información que facilite la próxima decisión que tome su equipo. ' \
              'Por lo tanto, si quieres llevar a cabo este rol en tu equipo deberas tener un gran conocimiento en el ' \
              'mapeado, buena punteria y movimiento fluido para obtener buenos resultados.',
  test_letter: test_c.letter,
  mode: 'professional',
  game_number: game1.number
)
Trivia.create(
  number: 2,
  title: 'Lurker',
  description:
              'El Lurker es el encargado de obtener información para su equipo, ya sea usando el sonido del juego ' \
              'para determinar donde se encuentran los enemigos o infiltrandose en zonas spoteadas por contrincantes ' \
              'para así ofrecer información detallada. En su mayoría, los Lurkers juegan de manera individual, ' \
              'es decir sin estar junto al equipo por el hecho de que se mueven sigilosamente. Para jugar este rol ' \
              'es recomendado tener un buen Mindgame (Buen pensamiento sobre que acciones pueden tomar los ' \
              'contrincantes, por ejemplo hacer una rotación) ya que con ello podrás tomar decisiones de manera ' \
              'individual o para darles una call a tu equipo.',
  test_letter: test_c.letter,
  mode: 'professional',
  game_number: game1.number
)
Trivia.create(
  number: 3,
  title: 'Eco',
  description:
              'Un Eco sucede cuando el equipo no tiene suficiente dinero para comprar un buen equipamiento durante ' \
              'la ronda, por ello se toma la decisión de comprar pocos objetos (Pistolas, chaleco o granadas) y ' \
              'ahorrar el poco dinero que cada jugador tiene, para así utilizarlo en la próxima ronda con el bonus ' \
              'de ronda perdida o si se genera con el dinero de ronda ganada. También existe el Full Eco que se ' \
              'realiza cuando se decide no comprar ningún objeto en la ronda.',
  test_letter: test_c.letter,
  mode: 'professional',
  game_number: game1.number
)
Trivia.create(
  number: 4,
  title: 'Deco',
  description:
              'Un Deco se realiza cuando el equipo tiene que ahorrar dinero pero pueden llevar una pistola ' \
              'Desert Eagle y un defuse. En muchos casos, se hace esta decisión en la segunda ronda cuando tu equipo ' \
              'perdió en cualquiera de los dos bandos (TT o CT) o cuando tu equipo tiene dinero suficiente para ' \
              'hacer una compra pequeña y prepararse para la siguiente ronda.',
  test_letter: test_c.letter,
  mode: 'professional',
  game_number: game1.number
)
Trivia.create(
  number: 5,
  title: 'Jump Throw',
  description:
              'La técnica Jump Throw es utilizada para la preparación al entrar en un Site, especificamente cuando ' \
              'se prepara una jugada con granadas ya que algunos lanzamientos normales no llegan a determinados ' \
              'lugares del mapa, entonces se utiliza el salto para alcanzar una trayectoria de viaje por parte de la ' \
              'granada para caer en el lugar deseado. Esta mecánica se puede hacer de manera normal, es decir saltar ' \
              'justo en el momento que vayas a lanzar la granada o sino usando un bind el cual permita hacer estas ' \
              'dos acciones de manera conjunta.',
  test_letter: test_c.letter,
  mode: 'professional',
  game_number: game1.number
)

question_c1 = Question.create(number: 1, description: '¿Que es un Entryfragger?', test_letter: test_c.letter,
                              game_number: game1.number)
question_c2 = Question.create(number: 2, description: '¿De que se encarga un Lurker?', test_letter: test_c.letter,
                              game_number: game1.number)
question_c3 = Question.create(number: 3, description: '¿Que se hace en un Eco?', test_letter: test_c.letter,
                              game_number: game1.number)
question_c4 = Question.create(number: 4, description: '¿Que se compra en un Deco?', test_letter: test_c.letter,
                              game_number: game1.number)
question_c5 = Question.create(number: 5, description: '¿Cuando se realiza un Jump Throw?', test_letter: test_c.letter,
                              game_number: game1.number)

Answer.create(number: 1, description: 'Un rol que se encarga de ser el primero en entrar a un site',
              correct: true, question_number: question_c1.number, test_letter: test_c.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Una técnica para lanzar granadas de entrada', correct: false,
              question_number: question_c1.number, test_letter: test_c.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Una forma de limpiar angulos cuando se hace un rush',
              correct: false, question_number: question_c1.number, test_letter: test_c.letter,
              game_number: game1.number)
Answer.create(number: 1, description: 'Descontar enemigos de manera solitaria', correct: false,
              question_number: question_c2.number, test_letter: test_c.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Obtener equipamiento para el equipo', correct: false,
              question_number: question_c2.number, test_letter: test_c.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Obtener información de los contrincantes para informar a tu equipo',
              correct: true, question_number: question_c2.number, test_letter: test_c.letter, game_number: game1.number)
Answer.create(number: 1, description: 'Ahorrar el dinero con el equipo y comprar poco equipamiento',
              correct: true, question_number: question_c3.number, test_letter: test_c.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Comprar equipamiento con todo el dinero', correct: false,
              question_number: question_c3.number, test_letter: test_c.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Ahorrar el dinero con el equipo y no comprar equipamiento',
              correct: false, question_number: question_c3.number, test_letter: test_c.letter,
              game_number: game1.number)
Answer.create(number: 1, description: 'Un AWP para cada jugador y un chaleco', correct: false,
              question_number: question_c4.number, test_letter: test_c.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Un rifle con chaleco y casco', correct: false,
              question_number: question_c4.number, test_letter: test_c.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Una Desert Eagle con un defuse', correct: true,
              question_number: question_c4.number, test_letter: test_c.letter, game_number: game1.number)
Answer.create(number: 1, description: 'Cuando disparas mientras estas saltando', correct: false,
              question_number: question_c5.number, test_letter: test_c.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Cuando lanzas una granada saltando', correct: true,
              question_number: question_c5.number, test_letter: test_c.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Cuando lanzas un arma saltando', correct: false,
              question_number: question_c5.number, test_letter: test_c.letter, game_number: game1.number)

# Test F
test_f = Test.create(letter: 'F', description: 'Examen Final de Conceptos Competitivos', cant_questions: 5,
                     game_number: game1.number)

Trivia.create(
  number: 1,
  title: 'Site',
  description:
              'En CS siempre han existido los lugares llamados Site donde se planta la bomba (El C4) por parte de ' \
              'los Terroristas (TT) y también las zonas donde defienden los Antiterroristas (CT). ' \
              'En general, los mapas competitivos de Counter Strike siempre tienen dos sites, el site A y B. ' \
              'Cabe recalcar que siempre nos referiremos al Site del modo Plantar y desactivar la bomba porque es la ' \
              'modalidad utilizada para torneos profesionales.',
  test_letter: test_f.letter,
  mode: 'FinalExam',
  game_number: game1.number
)
Trivia.create(
  number: 2,
  title: 'Awper',
  description:
              'El Awper es el jugador experimentado en jugar con el arma AWP, el cual es un francotirador de gran ' \
              'precisión y daño. Este rol se limita a dar por sentado quien es el jugador capaz de llevar este arma ' \
              'y sacarle el mejor beneficio posible, ya sea por su entendimiento de donde posicionarse o por su gran ' \
              'capacidad de reacción para acertar un disparo. En equipos competitivos siempre se limita a tener un ' \
              'Awper porque en CS es importante cuidar la economia del equipo y llevar dos jugadores Awper puede ' \
              'afectar a este, ya que el AWP es una de las armas más costosas en el juego y perder una de estas ' \
              'puede afectar al curso de la partida. Cabe recalcar que un Awper puede llevar siempre un rifle, pero ' \
              'siempre se lo busca como el indicado para usar un AWP',
  test_letter: test_f.letter,
  mode: 'FinalExam',
  game_number: game1.number
)
Trivia.create(
  number: 3,
  title: 'Eco',
  description:
              'Un Eco sucede cuando el equipo no tiene suficiente dinero para comprar un buen equipamiento durante ' \
              'la ronda, por ello se toma la decisión de comprar pocos objetos (Pistolas, chaleco o granadas) y ' \
              'ahorrar el poco dinero que cada jugador tiene, para así utilizarlo en la próxima ronda con el bonus ' \
              'de ronda perdida o si se genera con el dinero de ronda ganada. También existe el Full Eco que se ' \
              'realiza cuando se decide no comprar ningún objeto en la ronda.',
  test_letter: test_f.letter,
  mode: 'FinalExam',
  game_number: game1.number
)
Trivia.create(
  number: 4,
  title: 'Stack',
  description:
              'Un Stack es una estrategia que se realiza por parte del equipo de los CT (Antiterroristas) donde los ' \
              'cinco (5) jugadores se quedan defendiendo un solo Site. Esta estrategia generalmente se llega a hacer ' \
              'en un Eco, ya que los CT buscan sorprender a los rivales para descontar a la mayor cantidad posible ' \
              'de ellos para arruinar su economia y así llevarse su equipamiento para utilizarlo en la próxima ronda.',
  test_letter: test_f.letter,
  mode: 'FinalExam',
  game_number: game1.number
)
Trivia.create(
  number: 5,
  title: 'Lurker',
  description:
              'El Lurker es el encargado de obtener información para su equipo, ya sea usando el sonido del juego ' \
              'para determinar donde se encuentran los enemigos o infiltrandose en zonas spoteadas por contrincantes ' \
              'para así ofrecer información detallada. En su mayoría, los Lurkers juegan de manera individual, ' \
              'es decir sin estar junto al equipo por el hecho de que se mueven sigilosamente. Para jugar este rol ' \
              'es recomendado tener un buen Mindgame (Buen pensamiento sobre que acciones pueden tomar los ' \
              'contrincantes, por ejemplo hacer una rotación) ya que con ello podrás tomar decisiones de manera ' \
              'individual o para darles una call a tu equipo.',
  test_letter: test_f.letter,
  mode: 'FinalExam',
  game_number: game1.number
)

question_f1 = Question.create(number: 1, description: '¿Donde debemos plantar la bomba?', test_letter: test_f.letter,
                              game_number: game1.number)
question_f2 = Question.create(number: 2, description: '¿Que es un Awper?', test_letter: test_f.letter,
                              game_number: game1.number)
question_f3 = Question.create(number: 3, description: '¿Que objetos comprarias en un Eco?', test_letter: test_f.letter,
                              game_number: game1.number)
question_f4 = Question.create(number: 4, description: '¿Que se hace en un Stack?', test_letter: test_f.letter,
                              game_number: game1.number)
question_f5 = Question.create(number: 5, description: '¿Que no debe hacer un Lurker?', test_letter: test_f.letter,
                              game_number: game1.number)

Answer.create(number: 1, description: 'En el site', correct: true, question_number: question_f1.number,
              test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 2, description: 'En cualquier parte del mapa', correct: false,
              question_number: question_f1.number, test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 3, description: 'En un lugar escondido', correct: false,
              question_number: question_f1.number, test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 1, description: 'Tipo de francotirador', correct: false,
              question_number: question_f2.number, test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Spot frecuente de un AWP', correct: false,
              question_number: question_f2.number, test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Jugador especializado en el AWP', correct: true,
              question_number: question_f2.number, test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 1, description: 'Una pistola y granadas', correct: true,
              question_number: question_f3.number, test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Un rifle con chaleco', correct: false,
              question_number: question_f3.number, test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Un AWP solamente', correct: false,
              question_number: question_f3.number, test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 1, description: 'Volver a tener el control de un Site', correct: false,
              question_number: question_f4.number, test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Defender los cinco jugadores en un mismo Site', correct: true,
              question_number: question_f4.number, test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Atacar los cinco jugadores a un mismo Site', correct: false,
              question_number: question_f4.number, test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 1, description: 'Obtener información del enemigo usando el sonido', correct: false,
              question_number: question_f5.number, test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 2, description: 'Llevar siempre un AWP cuando sea posible', correct: true,
              question_number: question_f5.number, test_letter: test_f.letter, game_number: game1.number)
Answer.create(number: 3, description: 'Infiltrarse en zonas frecuentadas por el enemigo', correct: false,
              question_number: question_f5.number, test_letter: test_f.letter, game_number: game1.number)

test_sf = Test.create(letter: 'A') do |test|
  test.description = 'Conceptos de Principiante'
  test.cant_questions = 5
  test.game_number = game2.number
end
Trivia.create(
  number: 1,
  title: 'Poke',
  description:
              'Un Poke es un golpe de largo alcance y bajo riesgo que usaremos en el Neutro para molestar al rival y ' \
              'en el mejor caso intentar que cometa un error. Si uno de los jugadores falla un Poke y el otro ' \
              'responde con uno, se produce un Counter Poke, donde puede llevarse a una combinación de Combo ' \
              'dependiendo del personaje. Cabe menciona que un Counter Poke no es lo mismo a un Whiff Punish, ya que ' \
              'el mismo no se produce por reacción, sino por conocimiento de como actua el rival. La acción del ' \
              'mismo se conoce como Pokear.',
  test_letter: test_sf.letter,
  mode: 'beginner',
  game_number: game2.number
)
Trivia.create(
  number: 2,
  title: 'Neutro',
  description:
              'El Neutro o Juego Neutro se refiere a la situación de la partida en la que ningún jugador tiene ' \
              'iniciativa sobre el otro. Durante el mismo, los jugadores usaran Footsies (Generalmente usando ' \
              'ataques de Poke o buscando el Whiff Punish), Antiaéreos y Zoneo con proyectiles para tener la ' \
              'situación controlada hsata que se rompa esta situación donde alguno de los jugadores obtendra ventaja ' \
              'sobre el otro, ya sea por haber hecho un Whiff Punish o por simple mala defensa. Estos momentos en ' \
              'partida se presentan en todo momento y sirven para conocer las posibles jugadas que puede tomar el ' \
              'rival, pero también como responder a las mismas, como si fuese un ajedrez mental. ' \
              'En la saga Street Fighter ha estado muy presente ya que en su mayoría de juegos se manifiestan estas ' \
              'situaciones a nivel profesional constantemente y que en su mayoría han dado un análisis profundo de ' \
              'como jugar a nivel alto.',
  test_letter: test_sf.letter,
  mode: 'beginner',
  game_number: game2.number
)
Trivia.create(
  number: 3,
  title: 'Confirm',
  description:
              'Un Confirm o en Español Confirmar es la acción de ejecutar un ataque/movimiento y reaccionar al mismo ' \
              'si ha golpeado para continuar en combo o detener la presión del rival. En la mayoría de ocasiones ' \
              'donde el Confirm fallé perderemos la presión o nos quedaremos sin forma posible de defendernos y el ' \
              'rival nos podrá castigar. La ventana de margen para realizar un Confirm depende del juego y el ' \
              'movimiento, siendo a veces muy amplia o muy apretada, requiriendo muchos reflejos para no fallarlo. ' \
              'En Street Fighter 6, los Confirms requieren mucha reacción por ser un juego rápido y por tener una ' \
              'ventana muy corta para su ejecución.',
  test_letter: test_sf.letter,
  mode: 'beginner',
  game_number: game2.number
)
Trivia.create(
  number: 4,
  title: 'Antiaéreo',
  description:
              'Los Antiaéreos son los ataques para defendernos de saltos que realice el rival para ganar presión o ' \
              'si leemos un Oki mal ejecutado. En la mayoría de juegos de pelea, los Antiaéreos pueden ser ataques ' \
              'normales (Comandos realizados por un botón o la combinación de un botón con una dirección de ' \
              'movimiento) o especiales (Ataques que necesitan una Motion o Comand para ser ejecutados). ' \
              'En Street Fighter 6, los Antiaéreos más usados son Shoryuken o Shoryu (Personajes como Ken, Ryu, ' \
              'Luke, Akuma, Terry, Kimberly, Rashid, Juri, Chun-Li, Guile, Dee Jay, Cammy, Blanka, Zangief o Ed) ' \
              'o ataques normales medios/fuertes (Personajes como Lily, JP, A.K.I, E.Honda, Dhalsim, Marisa, Manon, ' \
              'Jamie o M.Bison), algunos personajes teniendo las dos opciones posibles para ejecutar uno.',
  test_letter: test_sf.letter,
  mode: 'beginner',
  game_number: game2.number
)
Trivia.create(
  number: 5,
  title: 'Shoto',
  description:
              'Un Shoto es un personaje que tiene un estilo de lucha determinado por tener tres movimientos: ' \
              'Hadouken, Shoryuken y Tatsu. Estos personajes son los que tienden a utilizar jugadores nuevos a este ' \
              'estilo de juegos, ya sea por su ejecución simple de movimientos o por ser en su mayoría los más ' \
              'caracteristicos de su saga. Ahora bien, cada personaje de este estilo tiene movimientos diferentes a ' \
              'otro del mismo, entre los cuales puede ser un/os ataque/s especial/es diferentes o por ser más usados ' \
              'en estrategias ofensivas o defensivas. En Street Fighter 6, los personajes Shoto son: Ryu, Ken, ' \
              'Akuma, Luke o Terry (Personaje Shoto de la saga Fatal Fury/The King Of Fighters).',
  test_letter: test_sf.letter,
  mode: 'beginner',
  game_number: game2.number
)

question_d1 = Question.create(number: 1, description: '¿Cuando ejecutamos un Poke?', test_letter: test_sf.letter,
                              game_number: game2.number)
question_d2 = Question.create(number: 2, description: '¿Que es el Neutro?', test_letter: test_sf.letter,
                              game_number: game2.number)
question_d3 = Question.create(number: 3, description: '¿Que se necesita para hacer un Confirm?',
                              test_letter: test_sf.letter, game_number: game2.number)
question_d4 = Question.create(number: 4, description: '¿Para que usamos un Antiaéreo?', test_letter: test_sf.letter,
                              game_number: game2.number)
question_d5 = Question.create(number: 5, description: '¿Que es un Shoto?', test_letter: test_sf.letter,
                              game_number: game2.number)

Answer.create(number: 1, description: 'En el Neutro', correct: true, question_number: question_d1.number,
              test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 2, description: 'En Wake Up', correct: false, question_number: question_d1.number,
              test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 3, description: 'En un salto', correct: false, question_number: question_d1.number,
              test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Estrategia para jugar', correct: false,
              question_number: question_d2.number, test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Movimiento normal para Pokear', correct: false,
              question_number: question_d2.number, test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Una situación de partida', correct: true,
              question_number: question_d2.number, test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Buena reacción ', correct: true,
              question_number: question_d3.number, test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Buen conocimiento de Combo', correct: false,
              question_number: question_d3.number, test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Un buen personaje', correct: false,
              question_number: question_d3.number, test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Para atacar', correct: false, question_number: question_d4.number,
              test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Para defensa ', correct: true, question_number: question_d4.number,
              test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Para iniciar un Combo', correct: false,
              question_number: question_d4.number, test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Un ataque que tienen todos los personajes', correct: false,
              question_number: question_d5.number, test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Un Super movimiento invulnerable ', correct: false,
              question_number: question_d5.number, test_letter: test_sf.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Un estilo de personaje ', correct: true,
              question_number: question_d5.number, test_letter: test_sf.letter, game_number: game2.number)

# Test T
test_t = Test.create(letter: 'B', description: 'Conceptos de Casual', cant_questions: 5, game_number: game2.number)

Trivia.create(
  number: 1,
  title: 'Crossup',
  description:
              'El término Crossup viene de la palabra Cruzar. Es la acción de golpear a tu rival por el lado ' \
              'contrario al que están bloqueando. Como en la mayoría de juegos de pelea bloqueas caminando para ' \
              'atrás, un Crossup te obliga a cambiar la dirección hacia el lado opuesto del ataque de forma muy ' \
              'rápida. Una situación de Crossup común es en salto con ángulo complicado de reconocer en el lugar ' \
              'que caeremos y podremos golpear al rival en el lado opuesto donde esta mirando. También existen otros ' \
              'movimientos donde cruzan al rival de manera natural, por ejemplo en Street Fighter 6 el personaje ' \
              'Terry tiene un movimiento Target Combo que permite saltar al lado opuesto y sino usarlo a su favor ' \
              'para engañar al rival. Esta situación también podemos usarla para engañar al rival y hacer que cometa ' \
              'un error como puede ser tirar un Antiaéreo preventivo que fallé, lo que se llama Fake Crossup.',
  test_letter: test_t.letter,
  mode: 'casual',
  game_number: game2.number
)
Trivia.create(
  number: 2,
  title: 'Mixup',
  description:
              'Un Mixup se realiza cuando variamos nuestra ofensiva entre ataques normales que golpeen en zonas ' \
              'bajas y altas del personaje del rival o agarres. Esta manera de atacar se utiliza para complicar la ' \
              'defensa del rival y buscar una entrada para quitar vida o si es posible llevarlo a Combo. Entre los ' \
              'personajes de Street Fighter 6 que tienden a ser jugados con esta forma de ofensiva se encuentran: ' \
              'Rashid, Jamie, Cammy, Juri, Dee Jay o Chun-Li',
  test_letter: test_t.letter,
  mode: 'casual',
  game_number: game2.number
)
Trivia.create(
  number: 3,
  title: 'FrameTrap',
  description:
              'Se conoce como FrameTrap a la posibilidad de atacar usando un movimiento en especifico que lo ' \
              'permita cuando bloqueamos un ataque del rival. Este movimiento debe de tener un Startup menor que ' \
              'el Startup del siguiente ataque del rival teniendo en cuenta los Frames de ventaja que dejo el ' \
              'ataque anterior, es decir cuando el personaje del contrincante no posee un movimiento tan rápido ' \
              'como uno del nuestro. Por lo general esto ocurre en todos los juegos de pelea, tanto en situacione ' \
              'de Clash o para interrumpir un Mixup del rival.',
  test_letter: test_t.letter,
  mode: 'casual',
  game_number: game2.number
)
Trivia.create(
  number: 4,
  title: 'Wall Splat',
  description:
              'Un Wall Splat ocurre cuando uno de los personajes sufre unos segundos de Stun por la colisión en ' \
              'el/la Corner/Esquina/Pared, quedando así con posibilidades de ser castigado por el rival y quitar ' \
              'una cantidad de daño grande si queda en buena oportunidad de combo, además de quedarse con la ' \
              'presión. En Street Fighter 6 esto sucede generalmente al utilizar un Drive Impact cerca del Corner ' \
              'para castigar al rival y dejarlo estampado. Si el mismo no tiene barra de Drive, se genera un Stun ' \
              'por estar en el estado de Burnout y así lograr un Combo de gran daño mientras se tiene la presión ' \
              'del Corner.',
  test_letter: test_t.letter,
  mode: 'casual',
  game_number: game2.number
)
Trivia.create(
  number: 5,
  title: 'Safe Jump',
  description:
              'Un Safe Jump como la palabra lo indica, es un salto seguro que se realiza cuando el rival esta en ' \
              'Wake Up. Si el mismo se levanta realizando un ataque en Wake Up (En Street Fighter 6 puede ser un ' \
              'Shoryuken/DP o un Super) o alguna mecánica defensiva (En Street Fighter 6 se usa el Drive Reversal) y ' \
              'nosotros realizamos un salto, podremos bloquear lo que decide lanzar el rival al levantarse y hacer ' \
              'un Punish para llevarlo a Combo, además de continuar con la presión. Cabe mencionar que estos saltos ' \
              'dependen mucho de la Frame Data y cuantos Frames tiene que esperar el rival para levantarse, ya que ' \
              'si este se levanta antes que logremos terminar el salto, nos podrá castigar con un ataque en Wake Up.',
  test_letter: test_t.letter,
  mode: 'casual',
  game_number: game2.number
)

question_t1 = Question.create(number: 1, description: '¿Cuando hacemos normalmente un Crossup?',
                              test_letter: test_t.letter, game_number: game2.number)
question_t2 = Question.create(number: 2, description: '¿Que es un Mixup?', test_letter: test_t.letter,
                              game_number: game2.number)
question_t3 = Question.create(number: 3, description: '¿Cuando sucede un FrameTrap?', test_letter: test_t.letter,
                              game_number: game2.number)
question_t4 = Question.create(number: 4, description: '¿En que lugar sucede un Wall Splat?',
                              test_letter: test_t.letter, game_number: game2.number)
question_t5 = Question.create(number: 5, description: '¿Para que sirve un Safe Jump?', test_letter: test_t.letter,
                              game_number: game2.number)

Answer.create(number: 1, description: 'Con un Target Comob', correct: false,
              question_number: question_t1.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Cuando saltamos al lado opuesto del rival', correct: true,
              question_number: question_t1.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 3, description: 'En una situación de Oki', correct: false,
              question_number: question_t1.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Una secuencia de ataques especiales', correct: false,
              question_number: question_t2.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Un Combo que finaliza con un Super', correct: false,
              question_number: question_t2.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Una forma de ofensiva con ataques normales y agarres',
              correct: true, question_number: question_t2.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Cuando estamos en Positivo', correct: false,
              question_number: question_t3.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Cuando tenemos un movimiento rápido con Frames de ventaja',
              correct: true, question_number: question_t3.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Cuando estamos  en Negativo', correct: false,
              question_number: question_t3.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 1, description: 'En el Corner/Esquina', correct: true,
              question_number: question_t4.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 2, description: 'En Mid Screen', correct: false,
              question_number: question_t4.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 3, description: 'En un Air to Air', correct: false,
              question_number: question_t4.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Para saltar al lado opuesto del rival', correct: false,
              question_number: question_t5.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Para esquivar un Super', correct: false,
              question_number: question_t5.number, test_letter: test_t.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Para seguir con la presión y evitar un ataque en Wake Up',
              correct: true, question_number: question_t5.number, test_letter: test_t.letter, game_number: game2.number)

# Test U
test_u = Test.create(letter: 'C', description: 'Conceptos de Profesional', cant_questions: 5,
                     game_number: game2.number)

Trivia.create(
  number: 1,
  title: 'Setup',
  description:
              'Un Setup se realiza cuando el rival esta en Knockdown y dependiendo nuestro personaje, podemos usar ' \
              'mecánicas para efectuar Mixups mucho más fuertes en Wake Up. En Street Fighter 6 varios personajes ' \
              'pueden generar este tipo de situaciones usando movimientos, entre ellos están: ' \
              'JP (Utilizando Departure/Departure OD), Blanka (Utilizando Blanka-chan Bomb), Rashid ' \
              '(Utilizando Ysaar), A.K.I (Utilizando Nightshade Pulse o Orchid Spring), Ed (Utilizando Psycho Spark ' \
              'o Psycho Cannon) y Kimberly (Utilizando Shuriken Bomb)',
  test_letter: test_u.letter,
  mode: 'professional',
  game_number: game2.number
)
Trivia.create(
  number: 2,
  title: 'Techear',
  description:
              'Una de las formas de defenderse de un agarre es haciendo un Tech, esta se genera cuando realizamos ' \
              'la acción de agarrar al mismo tiempo que el rival, dando como resultado un efecto de Pushback entre ' \
              'si y escapando del intento de agarre. Obviamente, esto requiere mucha reacción y reflejos aunque ' \
              'muchas veces usando los Mindgames o por simple experiencia es posible predecir los agarres ' \
              'dependiendo la situación. Cabe mencionar que los Command Grabs no pueden Techearse, ya que estos son ' \
              'agarres que requieren un Motion/Command para ser ejecutados. En Street Fighter 6 los personajes que ' \
              'tienen este tipo de agarres son: A.K.I (Sinister Slide + Entrapment), Blanka (Wild Hunt), Cammy ' \
              '(Hooligan Combination + Fatal Leg Twister), Kimberly (Sprint + Arc Step + Bushin Izuna Otoshi), Manon ' \
              '(Manège Doré o Pas de Deux), Marisa (Scutum + Enfold), E.Honda (Oicho Throw), Lily (Mexican Typhoon o ' \
              'Raging Typhoon), Jamie (Tenshin + Nivel de bebida 3 o superior) y Zangief (Screw Piledriver, Russian ' \
              'Suplex, Siberian Express o Bolshoi Storm Buster).',
  test_letter: test_u.letter,
  mode: 'professional',
  game_number: game2.number
)
Trivia.create(
  number: 3,
  title: 'Meaty',
  description:
              'Un Meaty es ejecutar un golpe en el primer Frame posible en cuanto se esta levantando del suelo el ' \
              'rival. Esto hace que el oponente tenga dos opciones: Bloquear o hacer un movimiento invulnerable (Un ' \
              'Shoryuken o Super), pero si intenta tirar un ataque normal no llegará y será golpeado en Counter Hit, ' \
              'ya que tu golpe esta por encima en los Frames activos. Si un golpe en Meaty impacta en los últimos ' \
              'Frames activos seguirá manteniendo el mismo Recovery, con lo cual algunas ocasiones tendremos presión ' \
              'o Combos que sólo funcionarán en una situación de este estilo.',
  test_letter: test_u.letter,
  mode: 'professional',
  game_number: game2.number
)
Trivia.create(
  number: 4,
  title: 'Okizeme',
  description:
              'El Okizeme o abreviado como Oki es la situación que el rival se esta levantando del suelo y el ' \
              'atacante tiene toda la ventaja para aplicar cualquier Mixup o presión que quiera. Cuando se está ' \
              'levantando del suelo, las opciones del que defiende son muy limitadas así que el atacante tiene ' \
              'muchas opciones como un Meaty. un Crossup o simplemente Baitear un Reversal. Cuando un personaje ' \
              'tiene Oki después de hacer algo se refiere a que nos quedaremos lo suficiente cerca del rival ' \
              'cuando se levanta para continuar presionando y si no tiene Oki quiere decir que deja al oponente ' \
              'muy lejos, por lo que tu presión a finalizado.',
  test_letter: test_u.letter,
  mode: 'professional',
  game_number: game2.number
)
Trivia.create(
  number: 5,
  title: 'Buffer',
  description:
              'Un Buffer o hacer un golpe con Buffering se refiere a tirar un ataque Whiffeando/al aire y ' \
              'cancelarlo con especiales que unicamente saldrán si nuestro golpe impacta. Esto nos permite ' \
              'Pokear golpes y cancelarlos con especiales que nos lo permitan para hacer más daño y hasta dejar ' \
              'al rival en Knockdown, dando así una opción segura para jugar en el Neutro. Aunque parezca ' \
              'sencillo, hay que tener en cuenta que si el rival bloquea nuestro primer ataque y el especial, ' \
              'nos quedaremos sin forma de defendernos. En Street Fighter 6 esto puede aplicarse a la mayoría de ' \
              'personajes y con combinaciones inmensas, por lo que te invitamos a probar en el Training Room ' \
              'diferentes formas de aplicar esta técnica en el juego.',
  test_letter: test_u.letter,
  mode: 'professional',
  game_number: game2.number
)

question_u1 = Question.create(number: 1, description: '¿Porque se hace un Setup?', test_letter: test_u.letter,
                              game_number: game2.number)
question_u2 = Question.create(number: 2, description: '¿Para que se Techea?', test_letter: test_u.letter,
                              game_number: game2.number)
question_u3 = Question.create(number: 3, description: '¿Cuando ejecutamos un Meaty?', test_letter: test_u.letter,
                              game_number: game2.number)
question_u4 = Question.create(number: 4, description: '¿En que situación hacemos un Oki?', test_letter: test_u.letter,
                              game_number: game2.number)
question_u5 = Question.create(number: 5, description: '¿Con que se hace un Buffer?', test_letter: test_u.letter,
                              game_number: game2.number)

Answer.create(number: 1, description: 'Para defenderse', correct: false,
              question_number: question_u1.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Para continuar la presión en Corner', correct: true,
              question_number: question_u1.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Para evitar que el rival salte', correct: false,
              question_number: question_u1.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Para evitar un golpe', correct: false,
              question_number: question_u2.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Para evitar un Command Grab', correct: false,
              question_number: question_u2.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Para evitar un agarre', correct: true,
              question_number: question_u2.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 1, description: 'En el último frame de Wake Up del rival', correct: false,
              question_number: question_u3.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 2, description: 'En el primer frame de Wake Up del rival', correct: true,
              question_number: question_u3.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 3, description: 'En cualquier frame de Wake Ip del rival', correct: false,
              question_number: question_u3.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Cuando podemos presionar mientras el rival se levanta',
              correct: true, question_number: question_u4.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Cuando queremos responder en Wake Up', correct: false,
              question_number: question_u4.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Cuando estamos con poca presión', correct: false,
              question_number: question_u4.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Con ataques normales', correct: false,
              question_number: question_u5.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Con Drive Rush', correct: false,
              question_number: question_u5.number, test_letter: test_u.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Con ataques especiales', correct: true,
              question_number: question_u5.number, test_letter: test_u.letter, game_number: game2.number)

# Test Y
test_y = Test.create(letter: 'F', description: 'Examen Final de Conceptos Competitivos', cant_questions: 5,
                     game_number: game2.number)

Trivia.create(
  number: 1,
  title: 'Buffer',
  description:
              'Un Buffer o hacer un golpe con Buffering se refiere a tirar un ataque Whiffeando/al aire y cancelarlo ' \
              'con especiales que unicamente saldrán si nuestro golpe impacta. Esto nos permite Pokear golpes y ' \
              'cancelarlos con especiales que nos lo permitan para hacer más daño y hasta dejar al rival ' \
              'en Knockdown, dando así una opción segura para jugar en el Neutro. Aunque parezca sencillo, hay ' \
              'que tener en cuenta que si el rival bloquea nuestro primer ataque y el especial, nos quedaremos sin ' \
              'forma de defendernos. En Street Fighter 6 esto puede aplicarse a la mayoría de personajes y con ' \
              'combinaciones inmensas, por lo que te invitamos a probar en el Training Room diferentes formas de ' \
              'aplicar esta técnica en el juego.',
  test_letter: test_y.letter,
  mode: 'FinalExam',
  game_number: game2.number
)
Trivia.create(
  number: 2,
  title: 'Mixup',
  description:
              'Un Mixup se realiza cuando variamos nuestra ofensiva entre ataques normales que golpeen en zonas ' \
              'bajas y altas del personaje del rival o agarres. Esta manera de atacar se utiliza para complicar la ' \
              'defensa del rival y buscar una entrada para quitar vida o si es posible llevarlo a Combo. Entre los ' \
              'personajes de Street Fighter 6 que tienden a ser jugados con esta forma de ofensiva se encuentran: ' \
              'Rashid, Jamie, Cammy, Juri, Dee Jay o Chun-Li',
  test_letter: test_y.letter,
  mode: 'FinalExam',
  game_number: game2.number
)
Trivia.create(
  number: 3,
  title: 'Shoto',
  description:
              'Un Shoto es un personaje que tiene un estilo de lucha determinado por tener tres movimientos: ' \
              'Hadouken, Shoryuken y Tatsu. Estos personajes son los que tienden a utilizar jugadores nuevos a ' \
              'este estilo de juegos, ya sea por su ejecución simple de movimientos o por ser en su mayoría los ' \
              'más caracteristicos de su saga. Ahora bien, cada personaje de este estilo tiene movimientos ' \
              'diferentes a otro del mismo, entre los cuales puede ser un/os ataque/s especial/es diferentes o por ' \
              'ser más usados en estrategias ofensivas o defensivas. En Street Fighter 6, los personajes Shoto son: ' \
              'Ryu, Ken, Akuma, Luke o Terry (Personaje Shoto de la saga Fatal Fury/The King Of Fighters).',
  test_letter: test_y.letter,
  mode: 'FinalExam',
  game_number: game2.number
)
Trivia.create(
  number: 4,
  title: 'Antiaéreo',
  description:
              'Los Antiaéreos son los ataques para defendernos de saltos que realice el rival para ganar presión o ' \
              'si leemos un Oki mal ejecutado. En la mayoría de juegos de pelea, los Antiaéreos pueden ser ataques ' \
              'normales (Comandos realizados por un botón o la combinación de un botón con una dirección de ' \
              'movimiento) o especiales (Ataques que necesitan una Motion o Comand para ser ejecutados). ' \
              'En Street Fighter 6, los Antiaéreos más usados son Shoryuken o Shoryu (Personajes como Ken, Ryu, ' \
              'Luke, Akuma, Terry, Kimberly, Rashid, Juri, Chun-Li, Guile, Dee Jay, Cammy, Blanka, Zangief o Ed) o ' \
              'ataques normales medios/fuertes (Personajes como Lily, JP, A.K.I, E.Honda, Dhalsim, Marisa, Manon, ' \
              'Jamie o M.Bison), algunos personajes teniendo las dos opciones posibles para ejecutar uno.',
  test_letter: test_y.letter,
  mode: 'FinalExam',
  game_number: game2.number
)
Trivia.create(
  number: 5,
  title: 'Techear',
  description:
              'Una de las formas de defenderse de un agarre es haciendo un Tech, esta se genera cuando realizamos ' \
              'la acción de agarrar al mismo tiempo que el rival, dando como resultado un efecto de Pushback entre ' \
              'si y escapando del intento de agarre. Obviamente, esto requiere mucha reacción y reflejos aunque ' \
              'muchas veces usando los Mindgames o por simple experiencia es posible predecir los agarres ' \
              'dependiendo la situación. Cabe mencionar que los Command Grabs no pueden Techearse, ya que estos son ' \
              'agarres que requieren un Motion/Command para ser ejecutados. En Street Fighter 6 los personajes que ' \
              'tienen este tipo de agarres son: A.K.I (Sinister Slide + Entrapment), Blanka (Wild Hunt), Cammy ' \
              '(Hooligan Combination + Fatal Leg Twister), Kimberly (Sprint + Arc Step + Bushin Izuna Otoshi), Manon ' \
              '(Manège Doré o Pas de Deux), Marisa (Scutum + Enfold), E.Honda (Oicho Throw), Lily (Mexican Typhoon o ' \
              'Raging Typhoon), Jamie (Tenshin + Nivel de bebida 3 o superior) y Zangief (Screw Piledriver, Russian ' \
              'Suplex, Siberian Express o Bolshoi Storm Buster).',
  test_letter: test_y.letter,
  mode: 'FinalExam',
  game_number: game2.number
)

question_y1 = Question.create(number: 1, description: '¿Con que ataques se hacen un Buffer?',
                              test_letter: test_y.letter, game_number: game2.number)
question_y2 = Question.create(number: 2, description: '¿Que partes hay que castigar en un Mixup?',
                              test_letter: test_y.letter, game_number: game2.number)
question_y3 = Question.create(number: 3, description: '¿Que grupo de personajes son Shotos?',
                              test_letter: test_y.letter, game_number: game2.number)
question_y4 = Question.create(number: 4, description: '¿De que forma llamamos a los Antiaéreos?',
                              test_letter: test_y.letter, game_number: game2.number)
question_y5 = Question.create(number: 5, description: '¿Que ofensivas podemos Techear?', test_letter: test_y.letter,
                              game_number: game2.number)

Answer.create(number: 1, description: 'Ataques normales', correct: false,
              question_number: question_y1.number, test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Ataques especiales', correct: true,
              question_number: question_y1.number, test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Super Arts', correct: false, question_number: question_y1.number,
              test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Zonas bajas', correct: false, question_number: question_y2.number,
              test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Zonas altas', correct: false, question_number: question_y2.number,
              test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Zonas bajas y altas', correct: true,
              question_number: question_y2.number, test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Ryu, Ken y Akuma', correct: true,
              question_number: question_y3.number, test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Manon y Zangief', correct: false,
              question_number: question_y3.number, test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Cammy, Juri y Dee Jay', correct: false,
              question_number: question_y3.number, test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Shoryuken/DP', correct: true, question_number: question_y4.number,
              test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Uppercut', correct: false, question_number: question_y4.number,
              test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Rising Fist/RF', correct: false,
              question_number: question_y4.number, test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 1, description: 'Command Grab', correct: false, question_number: question_y5.number,
              test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 2, description: 'Super Arts', correct: false, question_number: question_y5.number,
              test_letter: test_y.letter, game_number: game2.number)
Answer.create(number: 3, description: 'Agarres/grabs', correct: true, question_number: question_y5.number,
              test_letter: test_y.letter, game_number: game2.number)

test_l = Test.create(letter: 'L') do |test|
  test.description = 'Conceptos de Principiante'
  test.cant_questions = 5
  test.game_number = game3.number
end

Trivia.create(
  number: 1,
  title: 'ADC',
  description:
              'Un ADC (o Attack Damage Carry) suele hacer referencia a la clase Tirador, un carry de largo alcance ' \
              'que va al carril inferior con un apoyo y juega en la retaguardia durante los combates. Algunos ' \
              'tiradores entran dentro de este término a pesar de que hacen el mismo daño mágico e incluso a veces ' \
              'más que el físico (piensa en Kaisa, Kogmaw, Varus en ataque, etc.). El término se utiliza a menudo ' \
              'indistintamente con el de carril inferior, que a veces puede ser una clase de mago que se convierte ' \
              'en un rol secundario. En estos casos, la gente suele referirse al carril inferior como APC ' \
              '(Ability Power Carry), lo que significa que un portador de daño mágico.',
  test_letter: test_l.letter,
  mode: 'beginner',
  game_number: game3.number
)
Trivia.create(
  number: 2,
  title: 'Gank',
  description:
              'Movimiento (tradicionalmente de los junglas) por el que emboscan una línea junto al jugador de ese ' \
              'carril. Para el resto de posiciones se utiliza el término Roam.',
  test_letter: test_l.letter,
  mode: 'beginner',
  game_number: game3.number
)
Trivia.create(
  number: 3,
  title: 'Invade',
  description:
              'Invasión a la jungla enemiga para acabar con los monstruos de la zona rival. También se refiere a ' \
              'una estrategia a nivel uno que consiste en ir a buscar a los campeones enemigos al campamento ' \
              'inicial del jungla rival.',
  test_letter: test_l.letter,
  mode: 'beginner',
  game_number: game3.number
)
Trivia.create(
  number: 4,
  title: 'Splitpush',
  description:
              'Estrategia que consiste en empujar una línea separado del equipo mientras ellos ejercen presión ' \
              'en otra zona del mapa.',
  test_letter: test_l.letter,
  mode: 'beginner',
  game_number: game3.number
)
Trivia.create(
  number: 5,
  title: 'Aggro',
  description:
              'Puede hacer referencia a un estilo de juego (agresivo) o a ser objetivo de ataques de monstruos, ' \
              'súbditos, campeones o torretas enemigas.',
  test_letter: test_l.letter,
  mode: 'beginner',
  game_number: game3.number
)

question_l1 = Question.create(number: 1, description: '¿Que tipo de daño realiza por lo general un ADC?',
                              test_letter: test_l.letter, game_number: game3.number)
question_l2 = Question.create(number: 2, description: '¿En donde se realizan Ganks?', test_letter: test_l.letter,
                              game_number: game3.number)
question_l3 = Question.create(number: 3, description: '¿Quien decide realizar un invade generalmente?',
                              test_letter: test_l.letter, game_number: game3.number)
question_l4 = Question.create(number: 4, description: '¿Cuando se hace Splitpush?', test_letter: test_l.letter,
                              game_number: game3.number)
question_l5 = Question.create(number: 5, description: '¿Que es ser Aggro?', test_letter: test_l.letter,
                              game_number: game3.number)

Answer.create(number: 1, description: 'AP', correct: false, question_number: question_l1.number,
              test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 2, description: 'AD', correct: true, question_number: question_l1.number,
              test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 3, description: 'CC', correct: false, question_number: question_l1.number,
              test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 1, description: 'En la jungla', correct: false, question_number: question_l2.number,
              test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 2, description: 'En un objetivo ', correct: false,
              question_number: question_l2.number, test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 3, description: 'En una linea', correct: true, question_number: question_l2.number,
              test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 1, description: 'Jungla', correct: true, question_number: question_l3.number,
              test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Midlaner ', correct: false, question_number: question_l3.number,
              test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Support', correct: false, question_number: question_l3.number,
              test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 1, description: 'Cuando se empuja una linea individualmente', correct: true,
              question_number: question_l4.number, test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Cuando se empuja una linea con tu equipo ', correct: false,
              question_number: question_l4.number, test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Cuando te dejas empujar la linea por el enemigo', correct: false,
              question_number: question_l4.number, test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 1, description: 'Neutro', correct: false, question_number: question_l5.number,
              test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Centrado en los objetivos', correct: false,
              question_number: question_l5.number, test_letter: test_l.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Agresivo', correct: true, question_number: question_l5.number,
              test_letter: test_l.letter, game_number: game3.number)

# Test K
test_k = Test.create(letter: 'B', description: 'Conceptos de Casual', cant_questions: 5, game_number: game3.number)

Trivia.create(
  number: 1,
  title: 'Tower Dive',
  description:
              'Tower Dives (Bucear en Torre) es cuando varios jugadores persiguen a un jugador enemigo bajo la ' \
              'protección de su torre, ignorando el daño que inflige, mientras intentan hacer malabares con el ' \
              'aggro de la torreta y matar al oponente a la vez. Esto es algo que no debería intentarse a menos ' \
              'que el enemigo tenga muy pocos puntos de vida, que tu equipo y tú estéis bien coordinados o que ' \
              'seáis tan fuertes que podáis ignorar el daño de la torreta.',
  test_letter: test_k.letter,
  mode: 'casual',
  game_number: game3.number
)
Trivia.create(
  number: 2,
  title: 'Creeps',
  description:
              'Este término cuenta la cantidad de minions y monstruos que un jugador ha matado. Es importante ' \
              'tenerlo en cuenta porque es una forma directa de comparar cómo se comportan los laners y los ' \
              'junglers. Una puntuación de CS/min más alta suele significar que has ganado el carril, a menos ' \
              'que pierdas un montón de 1v1 tempranos. Unos 15 minions suelen valer la misma cantidad de oro ' \
              'que una muerte en solitario.',
  test_letter: test_k.letter,
  mode: 'casual',
  game_number: game3.number
)
Trivia.create(
  number: 3,
  title: 'Facechecking',
  description:
              'Esto significa entrar en la jungla enemiga o en la Niebla de Guerra sin ver al equipo enemigo. ' \
              'El riesgo que esto supone es grande, pero también puede proporcionar mucha información ' \
              'relevante a tu equipo si vigilas la zona y defines la visión. Sin embargo, el facechecking a ' \
              'menudo conlleva sus desastres, como pueden atestiguar la mayoría de los jugadores de LoL. ' \
              'Sopesa el riesgo antes de decidirte a chequear ese arbusto y decide si puedes o no aceptar ese ' \
              'combate si las cosas se tuercen.',
  test_letter: test_k.letter,
  mode: 'casual',
  game_number: game3.number
)
Trivia.create(
  number: 4,
  title: 'Backdoor',
  description:
              'En inglés significa puerta trasera. Hace referencia a una forma de acabar la partida que ' \
              'consiste en asaltar la base enemiga (generalmente con el nexo al descubierto) sin que se ' \
              'percante hasta que sea demasiado tarde.',
  test_letter: test_k.letter,
  mode: 'casual',
  game_number: game3.number
)
Trivia.create(
  number: 5,
  title: 'Base Race',
  description:
              'En inglés significa carrera de bases. Se utiliza para describir situaciones en las que ' \
              'los dos equipos han cedido su defensa e intentan acabar la partida a la vez, cada uno en ' \
              'un lado del mapa.',
  test_letter: test_k.letter,
  mode: 'casual',
  game_number: game3.number
)

question_k1 = Question.create(number: 1, description: '¿Con cuantos jugadores se hace un Tower Dive por lo menos?',
                              test_letter: test_k.letter, game_number: game3.number)
question_k2 = Question.create(number: 2, description: '¿Que son los Creeps?', test_letter: test_k.letter,
                              game_number: game3.number)
question_k3 = Question.create(number: 3, description: '¿En donde se hacen Facechecking?', test_letter: test_k.letter,
                              game_number: game3.number)
question_k4 = Question.create(number: 4, description: '¿Que se hace en un Backdoor?', test_letter: test_k.letter,
                              game_number: game3.number)
question_k5 = Question.create(number: 5, description: '¿Que hacen los dos equipos durante un Base Race?',
                              test_letter: test_k.letter, game_number: game3.number)

Answer.create(number: 1, description: '3', correct: false, question_number: question_k1.number,
              test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 2, description: '2', correct: true, question_number: question_k1.number,
              test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 3, description: '4', correct: false, question_number: question_k1.number,
              test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 1, description: 'Cantidad de oro obtenido', correct: false,
              question_number: question_k2.number, test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Cantidad de torres destruidas', correct: false,
              question_number: question_k2.number, test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Cantidad de minions y monstruos asesinados', correct: true,
              question_number: question_k2.number, test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 1, description: 'En la jungla y arbustos', correct: true,
              question_number: question_k3.number, test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 2, description: 'En la linea ', correct: false, question_number: question_k3.number,
              test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 3, description: 'En la base enemiga', correct: false,
              question_number: question_k3.number, test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 1, description: 'Asaltar la base enemiga y ganar la partida', correct: true,
              question_number: question_k4.number, test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Robar un Dragon o Baron Nashor ', correct: false,
              question_number: question_k4.number, test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Destruir una torre sin minions', correct: false,
              question_number: question_k4.number, test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 1, description: 'Dejar los objetivos y farmear creeps ', correct: false,
              question_number: question_k5.number, test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Dejar las torres y hacer objetivos ', correct: false,
              question_number: question_k5.number, test_letter: test_k.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Dejar sus bases y intentar terminar la partida ', correct: true,
              question_number: question_k5.number, test_letter: test_k.letter, game_number: game3.number)

# Test J
test_j = Test.create(letter: 'C', description: 'Conceptos de Profesional', cant_questions: 5,
                     game_number: game3.number)

Trivia.create(
  number: 1,
  title: 'Lane Freeze',
  description:
              'Es cuando un laner ralentiza el empuje de una oleada de minion influyendo en qué minions atacan a qué ' \
              'minions. Esto requiere atacar estratégicamente a los minions en último lugar (atacarlos solo en el ' \
              'último segundo para conseguir oro), de modo que puedas mantener al laner enemigo atrapado en una ' \
              'posición. Esto sirve tanto para poner al laner enemigo en posición de una posible emboscada aliada ' \
              'como para mantenerlo fuera del alcance de los XP y el oro de los minions asesinos.',
  test_letter: test_j.letter,
  mode: 'professional',
  game_number: game3.number
)
Trivia.create(
  number: 2,
  title: 'Blind Pick',
  description:
              'Esto significa elegir un campeón antes de que lo haga el laner enemigo. Esto puede ser muy malo si ' \
              'el enemigo elige un rival para tu campeón, por lo que la ‘elección a ciegas’ suele considerarse ' \
              'arriesgada a menos que el campeón que elijas sea increíblemente OP. Blind pick también puede ser útil ' \
              'cuando se elige una fuerte elección flexible, forzando al enemigo a elegir un counter que puede ser ' \
              'útil o no, o dejando impune una elección blind pick poderosa.',
  test_letter: test_j.letter,
  mode: 'professional',
  game_number: game3.number
)
Trivia.create(
  number: 3,
  title: 'Spacing',
  description:
              'Movimiento con el que mantenemos distancias con el enemigo (de forma ofensiva u defensiva) de forma ' \
              'que podamos golpear a máximo rango minimizando la oportunidad de recibir daño y maximizando ' \
              'nuestra eficacia.',
  test_letter: test_j.letter,
  mode: 'professional',
  game_number: game3.number
)
Trivia.create(
  number: 4,
  title: 'Macrogame',
  description:
              'Conjunto de estrategias que depende de todos los jugadores y ' \
              'suele implicar el juego entorno a objetivos',
  test_letter: test_j.letter,
  mode: 'professional',
  game_number: game3.number
)
Trivia.create(
  number: 5,
  title: 'Pathing',
  description:
              'Camino seguido por un determinado campeón a lo largo de la partida. Se utiliza principalmente ' \
              'para hablar de las rutas que siguen los jugadores en la jungla (orden de campamentos, emboscadas, etc)',
  test_letter: test_j.letter,
  mode: 'professional',
  game_number: game3.number
)

question_j1 = Question.create(number: 1, description: '¿Que tipo de enemigos se ralentizan en un Lane Freeze?',
                              test_letter: test_j.letter, game_number: game3.number)
question_j2 = Question.create(number: 2, description: '¿Que se eligue en un Blind Pick?', test_letter: test_j.letter,
                              game_number: game3.number)
question_j3 = Question.create(number: 3, description: '¿Que se hace en un Spacing?', test_letter: test_j.letter,
                              game_number: game3.number)
question_j4 = Question.create(number: 4, description: '¿Que es un Macrogame?', test_letter: test_j.letter,
                              game_number: game3.number)
question_j5 = Question.create(number: 5, description: '¿Que es un Pathing?', test_letter: test_j.letter,
                              game_number: game3.number)

Answer.create(number: 1, description: 'Monstruos', correct: false, question_number: question_j1.number,
              test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Minions', correct: true, question_number: question_j1.number,
              test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Dragones', correct: false, question_number: question_j1.number,
              test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 1, description: 'Objetivo', correct: false, question_number: question_j2.number,
              test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Summoners', correct: false, question_number: question_j2.number,
              test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Campeón', correct: true, question_number: question_j2.number,
              test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 1, description: 'Mantener la distancia con el enemigo', correct: true,
              question_number: question_j3.number, test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Alejarse del enemigo', correct: false,
              question_number: question_j3.number, test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Acercarse al enemigo', correct: false,
              question_number: question_j3.number, test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 1, description: 'Conjunto de estrategias con relación a objetivos', correct: true,
              question_number: question_j4.number, test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Conjunto de estrategias con relación a Gankeos', correct: false,
              question_number: question_j4.number, test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Conjunto de estrategias con relación a Invades', correct: false,
              question_number: question_j4.number, test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 1, description: 'Camino seguido por el equipo', correct: false,
              question_number: question_j5.number, test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Camino seguido por el equipo enemigo', correct: false,
              question_number: question_j5.number, test_letter: test_j.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Camino seguido por un campeón', correct: true,
              question_number: question_j5.number, test_letter: test_j.letter, game_number: game3.number)

# Test H
test_h = Test.create(letter: 'F', description: 'Examen Final de Conceptos Competitivos', cant_questions: 5,
                     game_number: game3.number)

Trivia.create(
  number: 1,
  title: 'Lane Freeze',
  description:
              'Es cuando un laner ralentiza el empuje de una oleada de minion influyendo en qué minions atacan a ' \
              'qué minions. Esto requiere atacar estratégicamente a los minions en último lugar (atacarlos solo en ' \
              'el último segundo para conseguir oro), de modo que puedas mantener al laner enemigo atrapado en una ' \
              'posición. Esto sirve tanto para poner al laner enemigo en posición de una posible emboscada aliada ' \
              'como para mantenerlo fuera del alcance de los XP y el oro de los minions asesinos.',
  test_letter: test_h.letter,
  mode: 'FinalExam',
  game_number: game3.number
)
Trivia.create(
  number: 2,
  title: 'Gank',
  description:
              'Movimiento (tradicionalmente de los junglas) por el que emboscan una línea junto al jugador de ese ' \
              'carril. Para el resto de posiciones se utiliza el término Roam.',
  test_letter: test_h.letter,
  mode: 'FinalExam',
  game_number: game3.number
)
Trivia.create(
  number: 3,
  title: 'ADC',
  description:
              'Un ADC (o Attack Damage Carry) suele hacer referencia a la clase Tirador, un carry de largo alcance ' \
              'que va al carril inferior con un apoyo y juega en la retaguardia durante los combates. Algunos ' \
              'tiradores entran dentro de este término a pesar de que hacen el mismo daño mágico e incluso a veces ' \
              'más que el físico (piensa en Kaisa, Kogmaw, Varus en ataque, etc.). El término se utiliza a menudo ' \
              'indistintamente con el de carril inferior, que a veces puede ser una clase de mago que se convierte ' \
              'en un rol secundario. En estos casos, la gente suele referirse al carril inferior como APC (Ability ' \
              'Power Carry), lo que significa que un portador de daño mágico.',
  test_letter: test_h.letter,
  mode: 'FinalExam',
  game_number: game3.number
)
Trivia.create(
  number: 4,
  title: 'Splitpush',
  description:
              'Estrategia que consiste en empujar una línea separado del equipo mientras ellos ejercen presión en ' \
              'otra zona del mapa.',
  test_letter: test_h.letter,
  mode: 'FinalExam',
  game_number: game3.number
)
Trivia.create(
  number: 5,
  title: 'Backdoor',
  description:
              'En inglés significa puerta trasera. Hace referencia a una forma de acabar la partida que consiste en ' \
              'asaltar la base enemiga (generalmente con el nexo al descubierto) sin que se percante hasta que sea ' \
              'demasiado tarde.',
  test_letter: test_h.letter,
  mode: 'FinalExam',
  game_number: game3.number
)

question_h1 = Question.create(number: 1, description: '¿A que tipo de Creeps se les hace Lane Freeze?',
                              test_letter: test_h.letter, game_number: game3.number)
question_h2 = Question.create(number: 2, description: '¿Que rol por lo general hace Ganks durante la partida?',
                              test_letter: test_h.letter, game_number: game3.number)
question_h3 = Question.create(number: 3, description: '¿Que personaje es un ADC?', test_letter: test_h.letter,
                              game_number: game3.number)
question_h4 = Question.create(number: 4, description: '¿Que rol hace generalmente Splitpush?',
                              test_letter: test_h.letter, game_number: game3.number)
question_h5 = Question.create(number: 5, description: '¿Por cual jugador surgió el término Backdoor?',
                              test_letter: test_h.letter, game_number: game3.number)

Answer.create(number: 1, description: 'Monstros', correct: false, question_number: question_h1.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Minions', correct: true, question_number: question_h1.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Campeones', correct: false, question_number: question_h1.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 1, description: 'ADC', correct: false, question_number: question_h2.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Support', correct: false, question_number: question_h2.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Jungla', correct: true, question_number: question_h2.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 1, description: 'Jhin ', correct: true, question_number: question_h3.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Azir ', correct: false, question_number: question_h3.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Garen', correct: false, question_number: question_h3.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 1, description: 'Toplaner', correct: true, question_number: question_h4.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Jungla ', correct: false, question_number: question_h4.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 3, description: 'Support', correct: false, question_number: question_h4.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 1, description: 'Faker', correct: false, question_number: question_h5.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 2, description: 'Ocelote', correct: false, question_number: question_h5.number,
              test_letter: test_h.letter, game_number: game3.number)
Answer.create(number: 3, description: 'xPeke', correct: true, question_number: question_h5.number,
              test_letter: test_h.letter, game_number: game3.number)
