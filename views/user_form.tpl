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
            </select>
        </div>
        % else:
        <input type="hidden" name="user_type" value="{{user.user_type}}">
        <p>Tipo de Usuário: <strong>{{'Pessoa Física' if user.user_type == 'PF' else 'Lojista'}}</strong></p>
        % end
        
        <div id="pf-fields" style="display: none;">
            <div class="form-group">
                <label for="name_pf">Nome Completo:</label>
                <input type="text" id="name_pf" name="name" 
                       value="{{user.name if user and user.user_type == 'PF' else ''}}" 
                       placeholder="Seu nome completo">
            </div>
            <div class="form-group">
                <label for="cpf">CPF:</label>
                <input type="text" id="cpf" name="cpf_cnpj" 
                       value="{{user.cpf_cnpj if user and user.user_type == 'PF' else ''}}"
                       placeholder="000.000.000-00">
            </div>
            <div class="form-group">
                <label for="birthdate">Data de Nascimento:</label>
                <input type="date" id="birthdate" name="birthdate" 
                       value="{{user.birthdate if user and user.user_type == 'PF' else ''}}">
            </div>
        </div>
        
        <div id="pj-fields" style="display: none;">
            <div class="form-group">
                <label for="responsavel">Nome do Responsável:</label>
                <input type="text" id="responsavel" name="name" 
                       value="{{user.name if user and user.user_type == 'PJ' else ''}}"
                       placeholder="Nome do Sócio/Responsável">
            </div>
            <div class="form-group">
                <label for="nome_loja">Nome da Loja:</label>
                <input type="text" id="nome_loja" name="nome_loja" 
                       value="{{user.nome_loja if user and user.user_type == 'PJ' else ''}}"
                       placeholder="Nome Fantasia da Loja">
            </div>
            <div class="form-group">
                <label for="cnpj">CNPJ:</label>
                <input type="text" id="cnpj" name="cpf_cnpj" 
                       value="{{user.cpf_cnpj if user and user.user_type == 'PJ' else ''}}"
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
            <input type="password" id="password" name="password" required placeholder="Insira sua senha">
        </div>
        
        <div class="form-group">
            <label for="telefone">Telefone (Whatsapp):</label>
            <input type="tel" id="telefone" name="telefone" required 
                   value="{{user.telefone if user else ''}}"
                   placeholder="(XX) 9XXXX-XXXX">
        </div>
        
        <div class="form-group">
            <label for="endereco">Endereço Completo:</label>
            <textarea id="endereco" name="endereco" rows="3" required>{{user.endereco if user else ''}}</textarea>
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
    const pjFields = document.getElementById('pj-fields');
    const namePFInput = document.getElementById('name_pf'); 
    const responsavelInput = document.getElementById('responsavel');
    const cpfInput = document.getElementById('cpf');
    const cnpjInput = document.getElementById('cnpj');
    const birthdateInput = document.getElementById('birthdate');
    const nomeLojaInput = document.getElementById('nome_loja');

    // CORRIGIDO: Adicionado 'if user' em todas as propriedades para evitar erro de renderização do Bottle
    const originalPFValues = {
        name: "{{user.name if user and user.user_type == 'PF' else ''}}",
        cpf_cnpj: "{{user.cpf_cnpj if user and user.user_type == 'PF' else ''}}",
        birthdate: "{{user.birthdate if user and user.user_type == 'PF' else ''}}"
    };
    const originalPJValues = {
        responsavel: "{{user.name if user and user.user_type == 'PJ' else ''}}",
        nome_loja: "{{user.nome_loja if user and user.user_type == 'PJ' else ''}}",
        cpf_cnpj: "{{user.cpf_cnpj if user and user.user_type == 'PJ' else ''}}"
    };


    function toggleFields(userType) {
        // Remove 'required' de todos os campos que podem ser PF ou PJ
        document.querySelectorAll('#pf-fields input, #pj-fields input').forEach(el => el.removeAttribute('required'));

        if (userType === 'PF') {
            pfFields.style.display = 'block';
            pjFields.style.display = 'none';

            // Define 'required' para campos PF
            if(namePFInput) namePFInput.setAttribute('required', 'required');
            if(cpfInput) cpfInput.setAttribute('required', 'required');
            if(birthdateInput) birthdateInput.setAttribute('required', 'required');
            
            // Limpa valores PJ para evitar envio de dados duplicados/incorretos no POST
            if(responsavelInput) responsavelInput.value = '';
            if(nomeLojaInput) nomeLojaInput.value = '';
            if(cnpjInput) cnpjInput.value = '';

            // Restaura valores PF (útil em edição)
            if(namePFInput) namePFInput.value = originalPFValues.name;
            if(cpfInput) cpfInput.value = originalPFValues.cpf_cnpj;
            if(birthdateInput) birthdateInput.value = originalPFValues.birthdate;

        } else if (userType === 'PJ') {
            pfFields.style.display = 'none';
            pjFields.style.display = 'block';

            // Define 'required' para campos PJ
            if(responsavelInput) responsavelInput.setAttribute('required', 'required');
            if(nomeLojaInput) nomeLojaInput.setAttribute('required', 'required');
            if(cnpjInput) cnpjInput.setAttribute('required', 'required');

            // Limpa valores PF para evitar envio de dados duplicados/incorretos no POST
            if(namePFInput) namePFInput.value = '';
            if(cpfInput) cpfInput.value = '';
            if(birthdateInput) birthdateInput.value = '';

            // Restaura valores PJ (útil em edição)
            if(responsavelInput) responsavelInput.value = originalPJValues.responsavel;
            if(nomeLojaInput) nomeLojaInput.value = originalPJValues.nome_loja;
            if(cnpjInput) cnpjInput.value = originalPJValues.cpf_cnpj;
            
        } else {
            // Caso 'Selecione...' (Estado Inicial)
            pfFields.style.display = 'none';
            pjFields.style.display = 'none';
        }
    }

    // Inicialização (Modo Adição)
    if (userTypeSelect) {
        userTypeSelect.addEventListener('change', (e) => {
            toggleFields(e.target.value);
        });
        
        // Aplica o estado inicial, que é 'Selecione...'
        toggleFields(userTypeSelect.value);
    }
    
    // Inicialização (Modo Edição)
    % if user:
    const initialUserType = "{{user.user_type}}";
    // Define o valor dos campos documentais, pois eles compartilham o nome 'cpf_cnpj'
    if (initialUserType === 'PF' && cpfInput) {
        cpfInput.value = originalPFValues.cpf_cnpj;
    } else if (initialUserType === 'PJ' && cnpjInput) {
        cnpjInput.value = originalPJValues.cpf_cnpj;
    }
    toggleFields(initialUserType);
    % end
</script>