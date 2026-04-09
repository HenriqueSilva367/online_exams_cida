# Arquivo de Seeds - Escola de Aviação CIDA ✈️💎
# Reset completo para o estado inicial

puts 'Limpando banco de dados anterior...'
SessionAnswer.destroy_all
ExamSession.destroy_all
Answer.destroy_all
Question.destroy_all
Exam.destroy_all
Topic.destroy_all
User.destroy_all

puts 'Semeando Usuários Padrões... 👤'
admin = User.create!(
  full_name: 'Administrador CIDA',
  email: 'admin@cida.com.br',
  password: 'password',
  role: :admin,
  must_change_password: false
)

student = User.create!(
  full_name: 'Aluno Teste',
  email: 'aluno@teste.com.br',
  password: 'password',
  role: :student,
  must_change_password: false
)

puts 'Semeando Tópicos (Matérias)... 📚'
t1 = Topic.create!(title: 'Matemática', description: 'Testes de matemática')
t2 = Topic.create!(title: 'Regulamentação', description: 'Regulamentação Aeronáutica')
t3 = Topic.create!(title: 'Meteorologia', description: 'Conhecimentos gerais de Meteorologia')
t4 = Topic.create!(title: 'Navegação', description: 'Cálculos e leitura de mapas')
t5 = Topic.create!(title: 'Teoria de Voo', description: 'Fundamentos da aerodinâmica')
t6 = Topic.create!(title: 'Conhecimentos Técnicos', description: 'Estrutura e motores')
t7 = Topic.create!(title: 'Prática de Voo', description: 'Exercícios práticos simulados')

puts 'Semeando Exames (Simulados)... 🏎️'
e1 = Exam.create!(
  title: 'Regulamentação ANAC', 
  description: 'Simulado completo de Regulamentação', 
  topic_id: t2.id, 
  time_duration: 30, 
  difficulty: 'Médio'
)

puts 'Semeando Questões de Elite... 🎯'

# Questão 25 - CBA Art. 156
q25 = Question.create!(
  exam_id: e1.id,
  topic_id: t2.id,
  title: 'DE ACORDO COM O CBA, A FUNÇÃO REMUNERADA A BORDO DE AERONAVE NACIONAL É RESERVADA A',
  explanation: "CBA ( CÓDIGO BRASILEIRO DE AERONÁUTICA )\nArt. 156. § 1o A função remunerada a bordo de aeronaves, nacionais ou estrangeiras, quando operadas por empresa brasileira no formato de intercâmbio, é privativa de titulares de licenças específicas emitidas pela autoridade de aviação civil brasileira e reservada a brasileiros natos ou naturalizados."
)
Answer.create!(question: q25, title: 'A) AERONAUTAS.', is_correct: false)
Answer.create!(question: q25, title: 'B) BRASILEIROS NATOS OU NATURALIZADOS.', is_correct: true)
Answer.create!(question: q25, title: 'C) BRASILEIROS NATOS E ESTRANGEIROS.', is_correct: false)
Answer.create!(question: q25, title: 'D) BRASILEIROS NATOS, APENAS.', is_correct: false)

# Questão 26 - Soberania
q26 = Question.create!(
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
  exam_id: e1.id,
  topic_id: t2.id,
  title: 'UM QUADRADO VERMELHO COM DUAS DIAGONAIS AMARELAS, QUANDO COLOCADO NA ÁREA DE SINALIZAÇÃO DO AERÓDROMO, INDICA QUE:',
  explanation: "ICA 100-12: Um quadrado vermelho com diagonals amarelas indica que os pousos estão proibidos."
)
Answer.create!(question: q28, title: 'Pouso Proibido', is_correct: true)
Answer.create!(question: q28, title: 'Pouso com cautela', is_correct: false)
Answer.create!(question: q28, title: 'Regras de Voo Visual', is_correct: false)
Answer.create!(question: q28, title: 'Regras de Voo por Instrumentos', is_correct: false)

puts '--------------------------------------------------'
puts 'BANCO DE DADOS restaurado com sucesso! 🎉 ✈️'
puts 'Admin: admin@cida.com.br / password'
puts 'Aluno: aluno@teste.com.br / password'
puts '--------------------------------------------------'
