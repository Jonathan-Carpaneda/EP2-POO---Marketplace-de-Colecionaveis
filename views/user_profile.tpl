% rebase('layout', title=f'Perfil de {user.name}')

<section class="user-profile-section">
    <div class="section-header">
        <h1 class="section-title"><i class="fas fa-user-circle"></i> Perfil do Usuário</h1>
        <a href="/users/edit/{{user.id}}" class="btn btn-warning">
            <i class="fas fa-edit"></i> Editar Perfil
        </a>
    </div>
    
    <div class="card detail-card mt-4">
        <div class="card-header bg-primary text-white">
            Informações de Acesso
        </div>
        <div class="card-body">
            <p><strong>ID:</strong> {{user.id}}</p>
            <p><strong>Email:</strong> <a href="mailto:{{user.email}}">{{user.email}}</a></p>
            <p><strong>Tipo de Usuário:</strong> 
                % if user.user_type == 'PF':
                    <span class="user-tag tag-pf">Pessoa Física</span>
                % else:
                    <span class="user-tag tag-pj">Lojista (Pessoa Jurídica)</span>
                % end
            </p>
        </div>
    </div>

    % if user.user_type == 'PF':
    <div class="card detail-card mt-4">
        <div class="card-header bg-secondary text-white">
            Detalhes de Pessoa Física (PF)
        </div>
        <div class="card-body">
            <p><strong>Nome Completo:</strong> {{user.name}}</p>
            <p><strong>CPF:</strong> {{user.cpf if user.cpf else '-'}}</p>
            <p><strong>Data de Nascimento:</strong> {{user.birthdate if user.birthdate else '-'}}</p>
        </div>
    </div>
    % else:
    <div class="card detail-card mt-4">
        <div class="card-header bg-secondary text-white">
            Detalhes de Lojista (PJ)
        </div>
        <div class="card-body">
            <p><strong>Nome do Responsável:</strong> {{user.name}}</p>
            <p><strong>Nome da Loja:</strong> {{user.shop_name if user.shop_name else '-'}}</p>
            <p><strong>CNPJ:</strong> {{user.cnpj if user.cnpj else '-'}}</p>
        </div>
    </div>
    % end
    
    <div class="card detail-card mt-4">
        <div class="card-header bg-secondary text-white">
            Detalhes de Contato e Endereço
        </div>
        <div class="card-body">
            <p><strong>Telefone:</strong> {{user.phone if user.phone else '-'}}</p>
            <p><strong>Endereço:</strong> {{user.address if user.address else '-'}}</p>
        </div>
    </div>

    <div class="mt-4">
        <a href="/users" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left"></i> Voltar para a Gestão de Usuários
        </a>
    </div>
</section>

<style>
.user-profile-section { padding: 20px; }
.detail-card { 
    border-radius: 8px; 
    overflow: hidden; 
    box-shadow: 0 4px 8px rgba(0,0,0,0.4);
    background-color: #16213e; 
    margin-bottom: 20px;
}
.detail-card .card-header { 
    padding: 15px; 
    font-weight: bold; 
    color: white;
    background-color: #0f3460; 
}
.detail-card .bg-primary { background-color: #e94560 !important; }
.detail-card .bg-secondary { background-color: #2e4a86 !important; }
.detail-card .card-body { padding: 15px; }
.detail-card .card-body p { 
    margin-bottom: 8px; 
    padding: 5px 0;
    border-bottom: 1px solid #1a1a2e; 
    color: #e0e0e0;
}
.detail-card .card-body p:last-child { border-bottom: none; margin-bottom: 0;}
.user-tag {
    padding: 2px 8px;
    border-radius: 4px;
    font-size: 0.9em;
    font-weight: bold;
    display: inline-block;
}
.tag-pf { background-color: #ffc947; color: #1a1a2e; }
.tag-pj { background-color: #e94560; color: white; }
.mt-4 { margin-top: 1.5rem; }
</style>