# Arquivo de Seeds - Escola de Aviação CIDA ✈️💎
# Este arquivo contém o backup dos dados cadastrados localmente (Textos, Gabaritos e Leis).

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
e1 = Exam.create!(title: 'Nível 1', description: 'Simulado de Matemática Nível 1', topic_id: t1.id, time_duration: 2, difficulty: 'Fácil')
e2 = Exam.create!(title: 'Rails Basics', description: 'Test your basic knowledge of Ruby on Rails', topic_id: t7.id, time_duration: 5, difficulty: 'Easy')
e5 = Exam.create!(title: 'Regulamentação', description: 'Simulado oficial de Regulamentação ANAC', topic_id: t2.id, time_duration: 30, difficulty: 'Médio')

puts 'Semeando Questões de Elite (Regulamentação / ANAC)... 🎯'

# Questão 5 - Art 156 do CBA
q5 = Question.create!(
  exam_id: e5.id,
  topic_id: t2.id,
  title: 'DE ACORDO COM O CBA, A FUNÇÃO REMUNERADA A BORDO DE AERONAVE NACIONAL É RESERVADA A',
  explanation: "CBA ( CÓDIGO BRASILEIRO DE AERONÁUTICA )\nArt. 156. São tripulantes as pessoas devidamente habilitadas que exercem função a bordo de aeronaves.\n**§ 1o A função remunerada a bordo de aeronaves, nacionais ou estrangeiras, quando operadas por empresa brasileira no formato de intercâmbio, é privativa de titulares de licenças específicas emitidas pela autoridade de aviação civil brasileira e reservada a brasileiros natos ou naturalizados. (Redação dada pela Lei nº 13.319, de 2016)."
)
Answer.create!(question: q5, title: 'A) AERONAUTAS.', is_correct: false)
Answer.create!(question: q5, title: 'B) BRASILEIROS NATOS OU NATURALIZADOS.', is_correct: true)
Answer.create!(question: q5, title: 'C) BRASILEIROS NATOS E ESTRANGEIROS.', is_correct: false)
Answer.create!(question: q5, title: 'D) BRASILEIROS NATOS, APENAS.', is_correct: false)

# Questão 6 - Soberania Espaço Aéreo
q6 = Question.create!(
  exam_id: e5.id,
  topic_id: t2.id,
  title: 'O BRASIL EXERCE SOBERANIA SOBRE O SEU ESPAÇO AÉREO. TAL SOBERANIA É:',
  explanation: "De acordo com o CBA, o Brasil possui total soberania sobre o espaço aéreo acima do seu território e mar territorial."
)
Answer.create!(question: q6, title: 'A) TOTAL SOBERANIA SOBRE O ESPAÇO AÉREO ALÉM FRONTEIRAS.', is_correct: false)
Answer.create!(question: q6, title: 'B) TOTAL SOBERANIA SOBRE O ESPAÇO AÉREO ACIMA DO SEU TERRITÓRIO E MAR TERRITORIAL.', is_correct: true)
Answer.create!(question: q6, title: 'C) SOBERANIA APENAS SOBRE O ESPAÇO AÉREO ACIMA DE ÁGUAS INTERNACIONAIS.', is_correct: false)
Answer.create!(question: q6, title: 'D) RELATIVA SOBERANIA SOBRE O SEU ESPAÇO AÉREO.', is_correct: false)

# Questão 7 - Definição de Aeródromo
q7 = Question.create!(
  exam_id: e5.id,
  topic_id: t2.id,
  title: 'SEGUNDO O CBA, TODA ÁREA DESTINADA A POUSO, DECOLAGEM E MOVIMENTAÇÃO DE AERONAVE DENOMINA-SE:',
  explanation: "Toda área destinada a pouso, decolagem e movimentação de aeronave denomina-se Aeródromo."
)
Answer.create!(question: q7, title: 'A) PÁTIO.', is_correct: false)
Answer.create!(question: q7, title: 'B) AEROPORTO.', is_correct: false)
Answer.create!(question: q7, title: 'C) AERÓDROMO.', is_correct: true)
Answer.create!(question: q7, title: 'D) HELIPONTO.', is_correct: false)

# Questão 14 - Sinalização Aeródromo (Quadrado Vermelho)
q14 = Question.create!(
  exam_id: e5.id,
  topic_id: t2.id,
  title: 'UM QUADRADO VERMELHO COM DUAS DIAGONAIS AMARELAS, QUANDO COLOCADO NA ÁREA DE SINALIZAÇÃO DO AERÓDROMO, INDICA QUE:',
  explanation: "ICA 100-12, PÁGINA 49: 4.2.1 POUSO PROIBIDO. Um quadrado vermelho com diagonais amarelas indica que os pousos estão proibidos e que é possível que perdure tal proibição."
)
Answer.create!(question: q14, title: 'Pouso Proibido', is_correct: true)
Answer.create!(question: q14, title: 'Pouso com cautela', is_correct: false)
Answer.create!(question: q14, title: 'Regras de Voo Visual', is_correct: false)
Answer.create!(question: q14, title: 'Regras de Voo por Instrumentos', is_correct: false)

puts '--------------------------------------------------'
puts 'Banco de dados semeado com sucesso! 🎉 ✈️'
puts 'Lembre-se de re-anexar as imagens técnicas pelo Painel Admin.'
puts '--------------------------------------------------'
