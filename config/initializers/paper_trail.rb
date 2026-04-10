# Garante que o PaperTrail seja carregado corretamente no ActiveRecord
require 'paper_trail'

# Habilita o rastreio globalmente
PaperTrail.config.enabled = true

# Nota: track_associations foi removido nas versões recentes do PaperTrail 
# e agora requer uma gem separada caso seja necessário rastrear associações complexas.
# Para o nosso log de auditoria atual, o rastreio básico é suficiente.
