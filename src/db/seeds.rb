AccountTest = Class.new(ActiveRecord::Base)
AccountAnswer = Class.new(ActiveRecord::Base)
AccountTrivia = Class.new(ActiveRecord::Base)
AccountGame = Class.new(ActiveRecord::Base)


# Game 1
game_1 = Game.find_or_create_by!(number: 1) do |game|
    game.name = "Counter Strike 2"
    game.genre = "FPS"
  end
  
  # Crear un test
  test_a = Test.find_or_create_by!(letter: "A") do |test|
    test.description = "Conceptos de Principiante"
    test.cant_questions = 5
    test.game_number = game_1.number
  end
  
trivia_a1 = Trivia.create(number: 1, title: "CT", description: "En Counter Strike siempre ha existido la división de equipos entre CT y TT, los cuales cumplen sus roles de defender y atacar (En el ámbito competitivo de CS siempre los CT defienden y los TT atacan, esto se debe a que el modo de juego predeterminado para torneos es el de ¨Plantar y desactivar la bomba¨). CT se los llama al equipo de los Antiterroristas, los cuales se encargan de defender puntos de plantación de bomba y neutralizar al equipo contrario, los terroristas (TT). A la hora de desactivar la bomba, tienen un tiempo determinado para lograr desactivarla (40 segundos desde que es plantada) en el cual deben plantear la jugada más eficaz para realizar el Retake. En el mismo, dependiendo la situación, deberán limpiar los Spots del site y eliminar a los jugadores enemigos restantes en el menor tiempo posible, ya que los CT no tienen mucho tiempo para desactivar la bomba (10 segundos si no tiene un kit de desactivación y 5 segundos si lo tiene el jugador que desactiva la bomba). En resumen, es el equipo encargado de defender los ataques enemigos y lograr generar un ataque si el equipo rival logra cumplir su primer objetivo de plantar la bomba.", test_letter: test_a.letter, mode: "beginner")
trivia_a2 = Trivia.create(number: 2, title: "Dropear", description: "En una partida un jugador realiza un Drop cuando su economia (Cantidad de dinero) es buena y la de un compañero es mala, le pasas un arma para contribuir en la economia del equipo y generar mejores resultados en la ronda. En CS2 es importante tener en cuenta que es posible dropear granadas, ya que en anteriores versiones de CS no era posible. Existen otras situaciones que dropear un objeto puede generar un Fake de sonido para engañar al enemigo, ya sea para eliminarlo o infiltrarse en una zona vigilada por ellos.", test_letter: test_a.letter, mode: "beginner")
trivia_a3 = Trivia.create(number: 3, title: "Fake", description: "Un Fake es generar una accion para engañar al enemigo, para así obtener un resultado favorable en la partida. Existen dos tipos de formas de generar un Fake, por el sonido o una jugada falsa. Un Fake puede aplicarse en diversas situaciones en CS2, a continuación te damos ejemplos: Hacer creer al enemigo que los TTs van a A y en realidad van a B, defusear por un momento la bomba para engañar al terrorista con el sonido del juego, hacer una entrada falsa con granadas para rotar al otro punto de plantado, etc.", test_letter: test_a.letter, mode: "beginner")
trivia_a4 = Trivia.create(number: 4, title: "Frag", description: "Generar una Frag es eliminar a un jugador del equipo contrario, también puede usarse el termino Fraggear el cual puede significar que la ronda se juegue a eliminar enemigos o que un jugador se dedicará a descontar enemigos (Eliminarlos) durante la ronda. La mayoría de jugadores pueden hacer Frags, pero en el ámbito competitivo existen los 'EntryFraggers' que son conocidos por generar gran cantidad de eliminaciones por ser los primeros en entrar al Site.", test_letter: test_a.letter, mode: "beginner")
trivia_a5 = Trivia.create(number: 5, title: "Peekear", description: "Un Peek es un ángulo que se toma como referencia para apuntar a un lugar específico del mapa y la acción Peekear es asomarse para obtener información sobre un Spot o una zona del mapa, también se puede considerar Peekear cuando un jugador toma la decisión de asomarse para intentar eliminar un enemigo. La acción de Peekear es muy utilizada en las siguientes situaciones: Cuando el equipo TT entra a un Site y el primer jugador (En competitivo el EntryFragger) debe limpiar cada Spot, cuando el equipo CT debe realizar un Retake en el cual lo primero que se hace es un Peek a los Spots que puedan estar los enemigos para obtener la información necesaria de sus ubicaciones ó cuando se entra en sigilo a lugares recurrentes por el rivaly se debe Peekear cada ángulo.", test_letter: test_a.letter, mode: "beginner")

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
answer_a7 = Answer.create(number: 1, description: "Cuando se hace una acción para engañar al contrincante", correct: true, question_number: question_a3.number, test_letter: test_a.letter)
answer_a8 = Answer.create(number: 2, description: "Cuando un jugador se asoma de forma rápida para tomar un angulo", correct: false, question_number: question_a3.number, test_letter: test_a.letter)
answer_a9 = Answer.create(number: 3, description: "Cuando todo el equipo se queda en un lugar", correct: false, question_number: question_a3.number, test_letter: test_a.letter)
answer_a10 = Answer.create(number: 1, description: "Eliminar a un enemigo", correct: true, question_number: question_a4.number, test_letter: test_a.letter)
answer_a11 = Answer.create(number: 2, description: "Disparar la mayoría de las balas con un click", correct: false, question_number: question_a4.number, test_letter: test_a.letter)
answer_a12 = Answer.create(number: 3, description: "Eliminar a un compañeor de equipo", correct: false, question_number: question_a4.number, test_letter: test_a.letter)
answer_a13 = Answer.create(number: 1, description: "Obstruir la visión o el paso de un compañero", correct: false, question_number: question_a5.number, test_letter: test_a.letter)
answer_a14 = Answer.create(number: 2, description: "Disparar agachado", correct: false, question_number: question_a5.number, test_letter: test_a.letter)
answer_a15 = Answer.create(number: 3, description: "Asomarse a un angulo/lugar", correct: true, question_number: question_a5.number, test_letter: test_a.letter)


#Test B
test_b = Test.create(letter: "B", description: "Conceptos de Casual", cant_questions: 5, game_number: game_1.number)

trivia_b1 = Trivia.create(number: 1, title: "Wallbang", description: "Un Wallbang o también en Español 'Shutear' se realiza cuando un jugador dispara a través de paredes. Dependiendo el arma que lleve en sus manos, las balas traspasaran o no ciertas estructuras o paredes, ya sea por sus proporciones o por el material de la estructura. Por ejemplo: Una Glock-18 puede llegar a traspasar maderas aunque el daño que puede generar en un contrincante puede ser poco, pero un AK-47 puede traspasar estas maderas o hasta también paredes de ladrillos, en el primer tipo generando un daño casi proporcional a un disparo directo y en el segundo un daño inferior. En resumen, un wallbang se genera cuando la bala del arma que es disparada traspasa una estructura y puede generara cierta cantidad de daño si hay un rival detrás de la misma.", test_letter: test_b.letter, mode: "casual")
trivia_b2 = Trivia.create(number: 2, title: "Site", description: "En CS siempre han existido los lugares llamados Site donde se planta la bomba (El C4) por parte de los Terroristas (TT) y también las zonas donde defienden los Antiterroristas (CT). En general, los mapas competitivos de Counter Strike siempre tienen dos sites, el site A y B. Cabe recalcar que siempre nos referiremos al Site del modo 'Plantar y desactivar la bomba' porque es la modalidad utilizada para torneos profesionales.", test_letter: test_b.letter, mode: "casual")
trivia_b3 = Trivia.create(number: 3, title: "Spot", description: "Spot es un lugar de vigilancia y Spotear es vigilar una zona del mapa, generalmente una entrada a un site o un lugar que invaden frecuentemente los contrincantes y la mayoria de jugadores con un nivel profesional tienden a Spotear con un AWP, ya que al ser un francotirador de gran potencia, puede asegurar la eliminación de un enemigo. Este concepto se aplica más en los Antiterroristas, ya que ellos son los que defienden zonas del mapa y su principal acción es vigilar puntos de acceso.", test_letter: test_b.letter, mode: "casual")
trivia_b4 = Trivia.create(number: 4, title: "Retake", description: "Un Retake es retomar o tener de nuevo el control, en el caso de Counter Strike el término Retake hace referencia a recuperar el control de un site. Este concepto se hace presente cuando los Terroristas (TT) tienen el control de un site, entonces los Antiterroristas (CT) deciden hacer un Retake para recuperarlo. En la mayoría de situaciones, un Retake se realiza cuando los TT plantan el C4 en un site.", test_letter: test_b.letter, mode: "casual")
trivia_b5 = Trivia.create(number: 5, title: "Tradekill", description: "Un Tradekill o Tradear es eliminar a un enemigo rápidamente luego de que este haya eliminado a un compañero. Esta acción siempre se hace presente en el momento de un Rush hacia un Site (Puede ser para tomar el Site o para realizar un Retake), ya que los jugadores que rushean estan todos juntos y siempre deben hacer un clear (Limpieza) de todas las zonas del site en pequeños grupos, ya sea para hacer más eficiente el clear como también generar tradeos de manera frecuente. Esta mecánica es muy dependiente de la habilidad de cada jugador, porque alguien que recién se integra en el juego no conoce la mayoría de Spots que pueden hacer los contrincantes y su control de la mira puede depender también de ello.", test_letter: test_b.letter, mode: "casual")

question_b1 = Question.create(number: 1, description: "¿Cuando se realiza un Wallbang?", test_letter: test_b.letter)
question_b2 = Question.create(number: 2, description: "¿Que es un Site?", test_letter: test_b.letter)
question_b3 = Question.create(number: 3, description: "¿Que significa Spot?", test_letter: test_b.letter)
question_b4 = Question.create(number: 4, description: "¿En que situación se realiza un Retake?", test_letter: test_b.letter)
question_b5 = Question.create(number: 5, description: "¿Cuando sucede un Tradekill?", test_letter: test_b.letter)

answer_b1 = Answer.create(number: 1, description: "Cheat que permite ver a través de las paredes", correct: false, question_number: question_b1.number, test_letter: test_b.letter)
answer_b2 = Answer.create(number: 2, description: "Hacer rebotar una granada en una pared", correct: false, question_number: question_b1.number, test_letter: test_b.letter)
answer_b3 = Answer.create(number: 3, description: "Disparar a través de paredes", correct: true, question_number: question_b1.number, test_letter: test_b.letter)
answer_b4 = Answer.create(number: 1, description: "Lugar donde se planta la C4", correct: true, question_number: question_b2.number, test_letter: test_b.letter)
answer_b5 = Answer.create(number: 2, description: "Lugar donde aparecen los jugadores de cada equipo", correct: false, question_number: question_b2.number, test_letter: test_b.letter)
answer_b6 = Answer.create(number: 3, description: "Lugar de compra de equipamiento", correct: false, question_number: question_b2.number, test_letter: test_b.letter)
answer_b7 = Answer.create(number: 1, description: "Un lugar de vigiliancia", correct: true, question_number: question_b3.number, test_letter: test_b.letter)
answer_b8 = Answer.create(number: 2, description: "Ubicación para lanzar granadas de entry", correct: false, question_number: question_b3.number, test_letter: test_b.letter)
answer_b9 = Answer.create(number: 3, description: "Zona donde frecuentan los Terroristas (TT)", correct: false, question_number: question_b3.number, test_letter: test_b.letter)
answer_b10 = Answer.create(number: 1, description: "Cuando se toma el control del site por parte de los TT", correct: false, question_number: question_b4.number, test_letter: test_b.letter)
answer_b11 = Answer.create(number: 2, description: "Cuando se retoma el control del site por parte de los CT", correct: true, question_number: question_b4.number, test_letter: test_b.letter)
answer_b12 = Answer.create(number: 3, description: "Cuando se retoma una jugada realizada de la ronda anterior", correct: false, question_number: question_b4.number, test_letter: test_b.letter)
answer_b13 = Answer.create(number: 1, description: "En el momento que un jugador elimina a dos enemigos con una secuencia de disparos", correct: false, question_number: question_b5.number, test_letter: test_b.letter)
answer_b14 = Answer.create(number: 2, description: "Cuando dos jugadores se eliminan en el mismo momento", correct: false, question_number: question_b5.number, test_letter: test_b.letter)
answer_b15 = Answer.create(number: 3, description: "Cuando se elimina a un enemigo rápidamente después de que haya eliminado a un compañero", correct: true, question_number: question_b5.number, test_letter: test_b.letter)


#Test C
test_c = Test.create(letter: "C", description: "Conceptos de Profesional", cant_questions: 5, game_number: game_1.number)

trivia_c1 = Trivia.create(number: 1, title: "Entryfragger", description: "El Entryfragger es el rol que lleva el jugador con mejor puntería (Aim) y conocimiento de ángulos del equipo. Este mismo se encarga de ser el iniciador de la entrada a un site, tomando riesgos grandes para obtener una frag o simplemente información que facilite la próxima decisión que tome su equipo. Por lo tanto, si quieres llevar a cabo este rol en tu equipo deberas tener un gran conocimiento en el mapeado, buena punteria y movimiento fluido para obtener buenos resultados.", test_letter: test_c.letter, mode: "professional")
trivia_c2 = Trivia.create(number: 2, title: "Lurker", description: "El Lurker es el encargado de obtener información para su equipo, ya sea usando el sonido del juego para determinar donde se encuentran los enemigos o infiltrandose en zonas spoteadas por contrincantes para así ofrecer información detallada. En su mayoría, los Lurkers juegan de manera individual, es decir sin estar junto al equipo por el hecho de que se mueven sigilosamente. Para jugar este rol es recomendado tener un buen Mindgame (Buen pensamiento sobre que acciones pueden tomar los contrincantes, por ejemplo hacer una rotación) ya que con ello podrás tomar decisiones de manera individual o para darles una call a tu equipo.", test_letter: test_c.letter, mode: "professional")
trivia_c3 = Trivia.create(number: 3, title: "Eco", description: "Un Eco sucede cuando el equipo no tiene suficiente dinero para comprar un buen equipamiento durante la ronda, por ello se toma la decisión de comprar pocos objetos (Pistolas, chaleco o granadas) y ahorrar el poco dinero que cada jugador tiene, para así utilizarlo en la próxima ronda con el bonus de ronda perdida o si se genera con el dinero de ronda ganada. También existe el 'Full Eco' que se realiza cuando se decide no comprar ningún objeto en la ronda.", test_letter: test_c.letter, mode: "professional")
trivia_c4 = Trivia.create(number: 4, title: "Deco", description: "Un Deco se realiza cuando el equipo tiene que ahorrar dinero pero pueden llevar una pistola 'Desert Eagle' y un defuse. En muchos casos, se hace esta decisión en la segunda ronda cuando tu equipo perdió en cualquiera de los dos bandos (TT o CT) o cuando tu equipo tiene dinero suficiente para hacer una compra pequeña y prepararse para la siguiente ronda.", test_letter: test_c.letter, mode: "professional")
trivia_c5 = Trivia.create(number: 5, title: "Jump Throw", description: "La técnica Jump Throw es utilizada para la preparación al entrar en un Site, especificamente cuando se prepara una jugada con granadas ya que algunos lanzamientos normales no llegan a determinados lugares del mapa, entonces se utiliza el salto para alcanzar una trayectoria de viaje por parte de la granada para caer en el lugar deseado. Esta mecánica se puede hacer de manera normal, es decir saltar justo en el momento que vayas a lanzar la granada o sino usando un bind el cual permita hacer estas dos acciones de manera conjunta.", test_letter: test_c.letter, mode: "professional")

question_c1 = Question.create(number: 1, description: "¿Que es un Entryfragger?", test_letter: test_c.letter)
question_c2 = Question.create(number: 2, description: "¿De que se encarga un Lurker?", test_letter: test_c.letter)
question_c3 = Question.create(number: 3, description: "Que se hace en un Eco?", test_letter: test_c.letter)
question_c4 = Question.create(number: 4, description: "¿Que se compra en un Deco?", test_letter: test_c.letter)
question_c5 = Question.create(number: 5, description: "¿Cuando se realiza un Jump Throw?", test_letter: test_c.letter)

answer_c1 = Answer.create(number: 1, description: "Un rol que se encarga de ser el primero en entrar a un site", correct: true, question_number: question_c1.number, test_letter: test_c.letter)
answer_c2 = Answer.create(number: 2, description: "Una técnica para lanzar granadas de entrada", correct: false, question_number: question_c1.number, test_letter: test_c.letter)
answer_c3 = Answer.create(number: 3, description: "Una forma de limpiar angulos cuando se hace un rush", correct: false, question_number: question_c1.number, test_letter: test_c.letter)
answer_c4 = Answer.create(number: 1, description: "Descontar enemigos de manera solitaria", correct: false, question_number: question_c2.number, test_letter: test_c.letter)
answer_c5 = Answer.create(number: 2, description: "Obtener equipamiento para el equipo", correct: false, question_number: question_c2.number, test_letter: test_c.letter)
answer_c6 = Answer.create(number: 3, description: "Obtener información de los contrincantes para informar a tu equipo", correct: true, question_number: question_c2.number, test_letter: test_c.letter)
answer_c7 = Answer.create(number: 1, description: "Ahorrar el dinero con el equipo y comprar poco equipamiento", correct: true, question_number: question_c3.number, test_letter: test_c.letter)
answer_c8 = Answer.create(number: 2, description: "Comprar equipamiento con todo el dinero", correct: false, question_number: question_c3.number, test_letter: test_c.letter)
answer_c9 = Answer.create(number: 3, description: "Ahorrar el dinero con el equipo y no comprar equipamiento", correct: false, question_number: question_c3.number, test_letter: test_c.letter)
answer_c10 = Answer.create(number: 1, description: "Un AWP para cada jugador y un chaleco", correct: false, question_number: question_c4.number, test_letter: test_c.letter)
answer_c11 = Answer.create(number: 2, description: "Un rifle con chaleco y casco", correct: false, question_number: question_c4.number, test_letter: test_c.letter)
answer_c12 = Answer.create(number: 3, description: "Una Desert Eagle con un defuse", correct: true, question_number: question_c4.number, test_letter: test_c.letter)
answer_c13 = Answer.create(number: 1, description: "Cuando disparas mientras estas saltando", correct: false, question_number: question_c5.number, test_letter: test_c.letter)
answer_c14 = Answer.create(number: 2, description: "Cuando lanzas una granada saltando", correct: true, question_number: question_c5.number, test_letter: test_c.letter)
answer_c15 = Answer.create(number: 3, description: "Cuando lanzas un arma saltando", correct: false, question_number: question_c5.number, test_letter: test_c.letter)

#Test F
test_f = Test.create(letter: "F", description: "Examen Final de Conceptos Competitivos", cant_questions: 15, game_number:game_1.number)

trivia_f1 = Trivia.create(number: 1, title: "Site", description: "En CS siempre han existido los lugares llamados Site donde se planta la bomba (El C4) por parte de los Terroristas (TT) y también las zonas donde defienden los Antiterroristas (CT). En general, los mapas competitivos de Counter Strike siempre tienen dos sites, el site A y B. Cabe recalcar que siempre nos referiremos al Site del modo 'Plantar y desactivar la bomba' porque es la modalidad utilizada para torneos profesionales.", test_letter: test_f.letter, mode: "FinalExam")
trivia_f2 = Trivia.create(number: 2, title: "Awper", description: "El Awper es el jugador experimentado en jugar con el arma AWP, el cual es un francotirador de gran precisión y daño. Este rol se limita a dar por sentado quien es el jugador capaz de llevar este arma y sacarle el mejor beneficio posible, ya sea por su entendimiento de donde posicionarse o por su gran capacidad de reacción para acertar un disparo. En equipos competitivos siempre se limita a tener un Awper porque en CS es importante cuidar la economia del equipo y llevar dos jugadores Awper puede afectar a este, ya que el AWP es una de las armas más costosas en el juego y perder una de estas puede afectar al curso de la partida. Cabe recalcar que un Awper puede llevar siempre un rifle, pero siempre se lo busca como el indicado para usar un AWP", test_letter: test_f.letter, mode: "FinalExam")
trivia_f3 = Trivia.create(number: 3, title: "Eco", description: "Un Eco sucede cuando el equipo no tiene suficiente dinero para comprar un buen equipamiento durante la ronda, por ello se toma la decisión de comprar pocos objetos (Pistolas, chaleco o granadas) y ahorrar el poco dinero que cada jugador tiene, para así utilizarlo en la próxima ronda con el bonus de ronda perdida o si se genera con el dinero de ronda ganada. También existe el 'Full Eco' que se realiza cuando se decide no comprar ningún objeto en la ronda.", test_letter: test_f.letter, mode: "FinalExam")
trivia_f4 = Trivia.create(number: 4, title: "Stack", description: "Un Stack es una estrategia que se realiza por parte del equipo de los CT (Antiterroristas) donde los cinco (5) jugadores se quedan defendiendo un solo Site. Esta estrategia generalmente se llega a hacer en un Eco, ya que los CT buscan sorprender a los rivales para descontar a la mayor cantidad posible de ellos para arruinar su economia y así llevarse su equipamiento para utilizarlo en la próxima ronda.", test_letter: test_f.letter, mode: "FinalExam")
trivia_f5 = Trivia.create(number: 5, title: "Lurker", description: "El Lurker es el encargado de obtener información para su equipo, ya sea usando el sonido del juego para determinar donde se encuentran los enemigos o infiltrandose en zonas spoteadas por contrincantes para así ofrecer información detallada. En su mayoría, los Lurkers juegan de manera individual, es decir sin estar junto al equipo por el hecho de que se mueven sigilosamente. Para jugar este rol es recomendado tener un buen Mindgame (Buen pensamiento sobre que acciones pueden tomar los contrincantes, por ejemplo hacer una rotación) ya que con ello podrás tomar decisiones de manera individual o para darles una call a tu equipo.", test_letter: test_f.letter, mode: "FinalExam")

question_f1 = Question.create(number: 1, description: "¿Donde debemos plantar la bomba?", test_letter: test_f.letter)
question_f2 = Question.create(number: 2, description: "¿Que es un Awper?", test_letter: test_f.letter)
question_f3 = Question.create(number: 3, description: "¿Que objetos comprarias en un Eco?", test_letter: test_f.letter)
question_f4 = Question.create(number: 4, description: "¿Que se hace en un Stack?", test_letter: test_f.letter)
question_f5 = Question.create(number: 5, description: "¿Que no debe hacer un Lurker?", test_letter: test_f.letter)

answer_f1 = Answer.create(number: 1, description: "En el site", correct: true, question_number: question_f1.number, test_letter: test_f.letter)
answer_f2 = Answer.create(number: 2, description: "En cualquier parte del mapa", correct: false, question_number: question_f1.number, test_letter: test_f.letter)
answer_f3 = Answer.create(number: 3, description: "En un lugar escondido", correct: false, question_number: question_f1.number, test_letter: test_f.letter)
answer_f4 = Answer.create(number: 1, description: "Tipo de francotirador", correct: false, question_number: question_f2.number, test_letter: test_f.letter)
answer_f5 = Answer.create(number: 2, description: "Spot frecuente de un AWP", correct: false, question_number: question_f2.number, test_letter: test_f.letter)
answer_f6 = Answer.create(number: 3, description: "Jugador especializado en el AWP", correct: true, question_number: question_f2.number, test_letter: test_f.letter)
answer_f7 = Answer.create(number: 1, description: "Una pistola y granadas", correct: true, question_number: question_f3.number, test_letter: test_f.letter)
answer_f8 = Answer.create(number: 2, description: "Un rifle con chaleco", correct: false, question_number: question_f3.number, test_letter: test_f.letter)
answer_f9 = Answer.create(number: 3, description: "Un AWP solamente", correct: false, question_number: question_f3.number, test_letter: test_f.letter)
answer_f10 = Answer.create(number: 1, description: "Volver a tener el control de un Site", correct: false, question_number: question_f4.number, test_letter: test_f.letter)
answer_f11 = Answer.create(number: 2, description: "Defender los cinco jugadores en un mismo Site", correct: true, question_number: question_f4.number, test_letter: test_f.letter)
answer_f12 = Answer.create(number: 3, description: "Atacar los cinco jugadores a un mismo Site", correct: false, question_number: question_f4.number, test_letter: test_f.letter)
answer_f13 = Answer.create(number: 1, description: "Obtener información del enemigo usando el sonido", correct: false, question_number: question_f5.number, test_letter: test_f.letter)
answer_f14 = Answer.create(number: 2, description: "Llevar siempre un AWP cuando sea posible", correct: true, question_number: question_f5.number, test_letter: test_f.letter)
answer_f15 = Answer.create(number: 3, description: "Infiltrarse en zonas frecuentadas por el enemigo", correct: false, question_number: question_f5.number, test_letter: test_f.letter)
