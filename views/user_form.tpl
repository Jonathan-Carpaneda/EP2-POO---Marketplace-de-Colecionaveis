% rebase('layout', title='Formulário Usuário') 

<section class="form-section">
    <h1>{{'Editar Usuário' if user else 'Adicionar Usuário'}}</h1>
    
    <form action="{{action}}" method="post" class="form-container">
        
        % if not user:
        <div class="form-group">
            <label for="user_type">Tipo de Cadastro:</label>
            <select id="user_type" name="user_type" required>
                <option value="">Selecione...</option>
                <option value="PF">Pessoa Física</option>
                <option value="PJ">Lojista (Pessoa Jurídica)</option>
                
                % if defined('current_user') and current_user and current_user.user_type == 'ADMIN':
                <option value="ADMIN" style="color: #e94560; font-weight: bold;">Administrador</option>
                % end
            </select>
        </div>
        % else:
        <input type="hidden" name="user_type" value="{{user.user_type}}">
        <p>Tipo de Usuário: <strong>{{user.user_type}}</strong></p>
        % end
        
        <div id="pf-fields" style="display: none;">
            <div class="form-group">
                <label for="name_pf">Nome Completo:</label>
                <input type="text" id="name_pf" name="name" 
                       value="{{user.name if user and user.user_type in ['PF', 'ADMIN'] else ''}}" 
                       placeholder="Nome completo">
            </div>
            
            <div id="pf-only-docs">
                <div class="form-group">
                    <label for="cpf">CPF:</label>
                    <input type="text" id="cpf" name="cpf" 
                           value="{{user.cpf if user and user.user_type == 'PF' else ''}}"
                           placeholder="000.000.000-00">
                </div>
                <div class="form-group">
                    <label for="birthdate">Data de Nascimento:</label>
                    <input type="date" id="birthdate" name="birthdate" 
                           value="{{user.birthdate if user and user.user_type == 'PF' else ''}}">
                </div>
            </div>
        </div>
        
        <div id="pj-fields" style="display: none;">
            <div class="form-group">
                <label for="responsavel">Nome do Responsável:</label>
                <input type="text" id="responsavel" name="name_responsavel" 
                       value="{{user.name if user and user.user_type == 'PJ' else ''}}"
                       placeholder="Nome do Sócio/Responsável">
            </div>
            <div class="form-group">
                <label for="nome_loja">Nome da Loja:</label>
                <input type="text" id="nome_loja" name="shop_name" 
                       value="{{user.shop_name if user and user.user_type == 'PJ' else ''}}"
                       placeholder="Nome Fantasia da Loja">
            </div>
            <div class="form-group">
                <label for="cnpj">CNPJ:</label>
                <input type="text" id="cnpj" name="cnpj" 
                       value="{{user.cnpj if user and user.user_type == 'PJ' else ''}}"
                       placeholder="XX.XXX.XXX/0001-XX">
            </div>
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required 
                   value="{{user.email if user else ''}}"
                   placeholder="seu.email@exemplo.com">
        </div>
        
        <div class="form-group">
            <label for="password">Senha:</label>
            <input type="password" id="password" name="password" 
                   {{'required' if not user else ''}} 
                   placeholder="Insira sua senha">
        </div>
        
        <div class="form-group">
            <label for="telefone">Telefone (Whatsapp):</label>
            <input type="tel" id="telefone" name="phone" required 
                   value="{{user.phone if user else ''}}"
                   placeholder="(XX) 9XXXX-XXXX">
        </div>
        
        <div class="form-group">
            <label for="endereco">Endereço Completo:</label>
            <textarea id="endereco" name="address" rows="3" required>{{user.address if user else ''}}</textarea>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn-submit">Salvar</button>
            <a href="/users" class="btn-cancel">Voltar</a>
        </div>
    </form>
</section>

<script>
    const userTypeSelect = document.getElementById('user_type');
    const pfFields = document.getElementById('pf-fields');
    const pfOnlyDocs = document.getElementById('pf-only-docs'); // Nova div
    const pjFields = document.getElementById('pj-fields');
    
    // Inputs
    const namePFInput = document.getElementById('name_pf'); 
    const cpfInput = document.getElementById('cpf');
    const birthdateInput = document.getElementById('birthdate');
    
    const responsavelInput = document.getElementById('responsavel');
    const nomeLojaInput = document.getElementById('nome_loja');
    const cnpjInput = document.getElementById('cnpj');

    // Valores Originais (Ajustados para incluir ADMIN no nome)
    const originalPFValues = {
        name: "{{user.name if user and user.user_type in ['PF', 'ADMIN'] else ''}}",
        cpf: "{{user.cpf if user and user.user_type == 'PF' else ''}}",
        birthdate: "{{user.birthdate if user and user.user_type == 'PF' else ''}}"
    };
    const originalPJValues = {
        responsavel: "{{user.name if user and user.user_type == 'PJ' else ''}}",
        shop_name: "{{user.shop_name if user and user.user_type == 'PJ' else ''}}",
        cnpj: "{{user.cnpj if user and user.user_type == 'PJ' else ''}}"
    };

    function toggleFields(userType) {
        // 1. Limpa todos os requireds específicos
        document.querySelectorAll('#pf-fields input, #pj-fields input').forEach(el => el.removeAttribute('required'));

        if (userType === 'PF') {
            pfFields.style.display = 'block';
            pfOnlyDocs.style.display = 'block'; // Mostra CPF/Data
            pjFields.style.display = 'none';

            if(namePFInput) namePFInput.setAttribute('required', 'required');
            if(cpfInput) cpfInput.setAttribute('required', 'required');
            if(birthdateInput) birthdateInput.setAttribute('required', 'required');
            
            // Restaura valores
            if(namePFInput) namePFInput.value = originalPFValues.name;

        } else if (userType === 'PJ') {
            pfFields.style.display = 'none';
            pjFields.style.display = 'block';

            if(responsavelInput) responsavelInput.setAttribute('required', 'required');
            if(nomeLojaInput) nomeLojaInput.setAttribute('required', 'required');
            if(cnpjInput) cnpjInput.setAttribute('required', 'required');
            
            // Restaura valores
            if(responsavelInput) responsavelInput.value = originalPJValues.responsavel;

        } else if (userType === 'ADMIN') {
            // LÓGICA DO ADMIN
            pfFields.style.display = 'block'; 
            pfOnlyDocs.style.display = 'none'; // ESCONDE CPF/Data
            pjFields.style.display = 'none';

            // Apenas nome é obrigatório
            if(namePFInput) namePFInput.setAttribute('required', 'required');
            
            // Restaura nome
            if(namePFInput) namePFInput.value = originalPFValues.name;

        } else {
            pfFields.style.display = 'none';
            pjFields.style.display = 'none';
        }
    }

    if (userTypeSelect) {
        userTypeSelect.addEventListener('change', (e) => {
            toggleFields(e.target.value);
        });
        toggleFields(userTypeSelect.value);
    }
    
    % if user:
    const initialUserType = "{{user.user_type}}";
    toggleFields(initialUserType);
    % end
</script>