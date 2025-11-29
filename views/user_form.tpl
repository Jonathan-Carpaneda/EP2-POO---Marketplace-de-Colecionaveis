% rebase('layout', title='Formulário Usuário') 

<section class="form-section">
    <h1>{{'Editar Usuário' if user else 'Adicionar Usuário'}}</h1>
    
    <form action="{{action}}" method="post" class="form-container">
        
        % if not user:
        <div class="form-group">
            <label for="user_type">Tipo de Cadastro:</label>
            <select id="user_type" name="user_type" required>
                <option value="">Selecione...</option> [cite: 16]
                <option value="PF">Pessoa Física</option>
                <option value="PJ">Lojista (Pessoa Jurídica)</option>
            </select>
        </div>
        % else:
        <input type="hidden" name="user_type" value="{{user.user_type}}">
        <p>Tipo de Usuário: <strong>{{'Pessoa Física' if user.user_type == 'PF' else 'Lojista'}}</strong></p> [cite: 17]
        % end
        
        <div id="pf-fields" style="display: none;">
            <div class="form-group">
                <label for="nome_pf">Nome Completo:</label>
                <input type="text" id="nome_pf" name="nome" 
                       [cite_start]value="{{user.nome if user and user.user_type == 'PF' else ''}}" [cite: 18]
                       placeholder="Seu nome completo">
            </div>
            <div class="form-group">
                <label for="cpf">CPF:</label>
                <input type="text" id="cpf" name="cpf_cnpj" 
                       value="{{user.cpf_cnpj if user and user.user_type == 'PF' else ''}}" 
                       [cite_start]placeholder="000.000.000-00"> [cite: 19]
            </div>
            <div class="form-group">
                <label for="data_nascimento">Data de Nascimento:</label>
                <input type="date" id="data_nascimento" name="data_nascimento" 
                       [cite_start]value="{{user.data_nascimento if user and user.user_type == 'PF' else ''}}"> [cite: 20]
            </div>
        </div>
        
        <div id="pj-fields" style="display: none;">
            <div class="form-group">
                <label for="responsavel">Nome do Responsável:</label>
                <input type="text" id="responsavel" name="nome" 
                       [cite_start]value="{{user.nome if user and user.user_type == 'PJ' else ''}}" [cite: 21]
                       placeholder="Nome do Sócio/Responsável">
            </div>
            <div class="form-group">
                <label for="nome_loja">Nome da Loja:</label>
                <input type="text" id="nome_loja" name="nome_loja" 
                       [cite_start]value="{{user.nome_loja if user and user.user_type == 'PJ' else ''}}" [cite: 22]
                       placeholder="Nome Fantasia da Loja">
            </div>
            <div class="form-group">
                <label for="cnpj">CNPJ:</label>
                <input type="text" id="cnpj" name="cpf_cnpj" 
                       [cite_start]value="{{user.cpf_cnpj if user and user.user_type == 'PJ' else ''}}" [cite: 23]
                       placeholder="XX.XXX.XXX/0001-XX">
            </div>
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required 
                   [cite_start]value="{{user.email if user else ''}}" [cite: 24]
                   placeholder="seu.email@exemplo.com">
        </div>
        
        {*AQUI ESTÁ A SENHA BÁSICA QUE IMPLEMENTEI PEDRO PAULO ALMEIDA ARAÚJO. LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO
LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO*}{*AQUI ESTÁ A SENHA BÁSICA QUE IMPLEMENTEI PEDRO PAULO ALMEIDA ARAÚJO. LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO
LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO*}{*AQUI ESTÁ A SENHA BÁSICA QUE IMPLEMENTEI PEDRO PAULO ALMEIDA ARAÚJO. LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO
LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO*}

        <div class="form-group">
            <label for="password">Senha:</label>
            <input type="password" id="password" name="password" required>
        </div>

        {*AQUI ESTÁ A SENHA BÁSICA QUE IMPLEMENTEI PEDRO PAULO ALMEIDA ARAÚJO. LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO
LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO*}{*AQUI ESTÁ A SENHA BÁSICA QUE IMPLEMENTEI PEDRO PAULO ALMEIDA ARAÚJO. LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO
LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO*}{*AQUI ESTÁ A SENHA BÁSICA QUE IMPLEMENTEI PEDRO PAULO ALMEIDA ARAÚJO. LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO
LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO, LEIA ISSO*}
        
        <div class="form-group">
            <label for="telefone">Telefone (Whatsapp):</label>
            <input type="tel" id="telefone" name="telefone" required 
                   [cite_start]value="{{user.telefone if user else ''}}" [cite: 25]
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
    const pfFields = document.getElementById('pf-fields'); [cite: 27]
    const pjFields = document.getElementById('pj-fields');
    // Renomeei 'nomeInput' para 'nomePFInput' para clareza
    const nomePFInput = document.getElementById('nome_pf'); 
    const responsavelInput = document.getElementById('responsavel'); [cite: 27]
    const cpfInput = document.getElementById('cpf'); [cite: 27]
    const cnpjInput = document.getElementById('cnpj'); [cite: 28]
    const dataNascimentoInput = document.getElementById('data_nascimento');
    const nomeLojaInput = document.getElementById('nome_loja');
    
    // Valores originais (Apenas para garantir que o jinja/bottle renderize no campo certo no load)
    const originalPFValues = {
        nome: "{{user.nome if user and user.user_type == 'PF' else ''}}",
        cpf_cnpj: "{{user.cpf_cnpj if user and user.user_type == 'PF' else ''}}",
        data_nascimento: "{{user.data_nascimento if user and user.user_type == 'PF' else ''}}"
    };
    const originalPJValues = {
        responsavel: "{{user.nome if user and user.user_type == 'PJ' else ''}}",
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
            if(nomePFInput) nomePFInput.setAttribute('required', 'required');
            if(cpfInput) cpfInput.setAttribute('required', 'required');
            if(dataNascimentoInput) dataNascimentoInput.setAttribute('required', 'required');
            
            // Limpa valores PJ para evitar envio de dados duplicados/incorretos no POST
            if(responsavelInput) responsavelInput.value = '';
            if(nomeLojaInput) nomeLojaInput.value = '';
            if(cnpjInput) cnpjInput.value = '';

            // Restaura valores PF (útil em edição)
            if(nomePFInput) nomePFInput.value = originalPFValues.nome;
            if(cpfInput) cpfInput.value = originalPFValues.cpf_cnpj;
            if(dataNascimentoInput) dataNascimentoInput.value = originalPFValues.data_nascimento;

        } else if (userType === 'PJ') {
            pfFields.style.display = 'none';
            pjFields.style.display = 'block';

            // Define 'required' para campos PJ
            if(responsavelInput) responsavelInput.setAttribute('required', 'required');
            if(nomeLojaInput) nomeLojaInput.setAttribute('required', 'required');
            if(cnpjInput) cnpjInput.setAttribute('required', 'required');

            // Limpa valores PF para evitar envio de dados duplicados/incorretos no POST
            if(nomePFInput) nomePFInput.value = '';
            if(cpfInput) cpfInput.value = '';
            if(dataNascimentoInput) dataNascimentoInput.value = '';

            // Restaura valores PJ (útil em edição)
            if(responsavelInput) responsavelInput.value = originalPJValues.responsavel;
            if(nomeLojaInput) nomeLojaInput.value = originalPJValues.nome_loja;
            if(cnpjInput) cnpjInput.value = originalPJValues.cpf_cnpj;
            
        } else {
            // Caso 'Selecione...'
            pfFields.style.display = 'none';
            pjFields.style.display = 'none';
        }
    }

    // Inicialização (Modo Adição)
    if (userTypeSelect) {
        userTypeSelect.addEventListener('change', (e) => {
            toggleFields(e.target.value);
        });
        
        // Aplica o estado inicial, se já houver um valor
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