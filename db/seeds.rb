# Arquivo de Seeds - Escola de Aviação CIDA ✈️💎
# Backup oficial das 4 questões fundamentais e gabaritos ANAC.

puts 'Limpando banco de dados anterior...'
SessionAnswer.destroy_all
ExamSession.destroy_all
Answer.destroy_all
Question.destroy_all
Exam.destroy_all
Topic.destroy_all

puts 'Semeando Tópicos (Matérias)... 📚'
t1 = Topic.create!(title: 'Matemática', description: 'Testes de matemática')
t2 = Topic.create!(title: 'Regulamentação', description: '')
t3 = Topic.create!(title: 'Meteorologia', description: '')
t4 = Topic.create!(title: 'Navegação', description: '')
t5 = Topic.create!(title: 'Teoria de Voo', description: '')
t6 = Topic.create!(title: 'Conhecimentos Técnicos', description: '')
t7 = Topic.create!(title: 'Ruby on Rails', description: 'Conhecimentos gerais sobre o framework Ruby on Rails')

puts 'Semeando Exames (Simulados)... 🏎️'
e1 = Exam.create!(title: 'Regulamentação ANAC', description: 'Simulado completo de Regulamentação', topic_id: t2.id, time_duration: 30, difficulty: 'Médio')

puts 'Semeando Questões de Elite (Resgate de Carga Total)... 🎯'

# Questão 25 - CBA Art. 156
q25 = Question.create!(
  id: 25,
  exam_id: e1.id,
  topic_id: t2.id,
  title: 'DE ACORDO COM O CBA, A FUNÇÃO REMUNERADA A BORDO DE AERONAVE NACIONAL É RESERVADA A',
  explanation: "CBA ( CÓDIGO BRASILEIRO DE AERONÁUTICA )\nArt. 156. São tripulantes as pessoas devidamente habilitadas que exercem função a bordo de aeronaves.\n**§ 1o A função remunerada a bordo de aeronaves, nacionais ou estrangeiras, quando operadas por empresa brasileira no formato de intercâmbio, é privativa de titulares de licenças específicas emitidas pela autoridade de aviação civil brasileira e reservada a brasileiros natos ou naturalizados."
)
Answer.create!(question: q25, title: 'A) AERONAUTAS.', is_correct: false)
Answer.create!(question: q25, title: 'B) BRASILEIROS NATOS OU NATURALIZADOS.', is_correct: true)
Answer.create!(question: q25, title: 'C) BRASILEIROS NATOS E ESTRANGEIROS.', is_correct: false)
Answer.create!(question: q25, title: 'D) BRASILEIROS NATOS, APENAS.', is_correct: false)

# Questão 26 - Soberania
q26 = Question.create!(
  id: 26,
  exam_id: e1.id,
  topic_id: t2.id,
  title: 'O BRASIL EXERCE SOBERANIA SOBRE O SEU ESPAÇO AÉREO. TAL SOBERANIA É:',
  explanation: "De acordo com o CBA, o Brasil possui total soberania sobre o espaço aéreo acima do seu território e mar territorial."
)
Answer.create!(question: q26, title: 'A) TOTAL SOBERANIA SOBRE O ESPAÇO AÉREO ALÉM FRONTEIRAS.', is_correct: false)
Answer.create!(question: q26, title: 'B) TOTAL SOBERANIA SOBRE O ESPAÇO AÉREO ACIMA DO SEU TERRITÓRIO E MAR TERRITORIAL.', is_correct: true)
Answer.create!(question: q26, title: 'C) SOBERANIA APENAS SOBRE O ESPAÇO AÉREO ACIMA DE ÁGUAS INTERNACIONAIS.', is_correct: false)
Answer.create!(question: q26, title: 'D) RELATIVA SOBERANIA SOBRE O SEU ESPAÇO AÉREO.', is_correct: false)

# Questão 27 - Aeródromo
q27 = Question.create!(
  id: 27,
  exam_id: e1.id,
  topic_id: t2.id,
  title: 'SEGUNDO O CBA, TODA ÁREA DESTINADA A POUSO, DECOLAGEM E MOVIMENTAÇÃO DE AERONAVE DENOMINA-SE:',
  explanation: "Toda área destinada a pouso, decolagem e movimentação de aeronave denomina-se Aeródromo."
)
Answer.create!(question: q27, title: 'A) PÁTIO.', is_correct: false)
Answer.create!(question: q27, title: 'B) AEROPORTO.', is_correct: false)
Answer.create!(question: q27, title: 'C) AERÓDROMO.', is_correct: true)
Answer.create!(question: q27, title: 'D) HELIPONTO.', is_correct: false)

# Questão 28 - Sinalização
q28 = Question.create!(
  id: 28,
  exam_id: e1.id,
  topic_id: t2.id,
  title: 'UM QUADRADO VERMELHO COM DUAS DIAGONAIS AMARELAS, QUANDO COLOCADO NA ÁREA DE SINALIZAÇÃO DO AERÓDROMO, INDICA QUE:',
  explanation: "ICA 100-12, PÁGINA 49: 4.2.1 POUSO PROIBIDO. Um quadrado vermelho com diagonals amarelas indica que os pousos estão proibidos e que é possível que perdure tal proibição."
)
Answer.create!(question: q28, title: 'Pouso Proibido', is_correct: true)
Answer.create!(question: q28, title: 'Pouso com cautela', is_correct: false)
Answer.create!(question: q28, title: 'Regras de Voo Visual', is_correct: false)
Answer.create!(question: q28, title: 'Regras de Voo por Instrumentos', is_correct: false)

puts '--------------------------------------------------'
puts 'BANCO DE DADOS semeado com sucesso! 🎉 ✈️'
puts '--------------------------------------------------'
