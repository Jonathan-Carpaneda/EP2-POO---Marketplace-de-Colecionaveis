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
                <label for="nome">Nome Completo:</label>
                <input type="text" id="nome" name="nome" 
                       value="{{user.nome if user and user.user_type == 'PF' else ''}}">
            </div>
            <div class="form-group">
                <label for="cpf">CPF:</label>
                <input type="text" id="cpf" name="cpf_cnpj" 
                       value="{{user.cpf_cnpj if user and user.user_type == 'PF' else ''}}" 
                       placeholder="000.000.000-00">
            </div>
            <div class="form-group">
                <label for="data_nascimento">Data de Nascimento:</label>
                <input type="date" id="data_nascimento" name="data_nascimento" 
                       value="{{user.data_nascimento if user and user.user_type == 'PF' else ''}}">
            </div>
        </div>
        
        <div id="pj-fields" style="display: none;">
            <div class="form-group">
                <label for="responsavel">Nome do Responsável:</label>
                <input type="text" id="responsavel" name="nome" 
                       value="{{user.nome if user and user.user_type == 'PJ' else ''}}">
            </div>
            <div class="form-group">
                <label for="nome_loja">Nome da Loja:</label>
                <input type="text" id="nome_loja" name="nome_loja" 
                       value="{{user.nome_loja if user and user.user_type == 'PJ' else ''}}">
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
                   value="{{user.email if user else ''}}">
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
        
        <input type="hidden" name="tipo_documento" id="tipo_documento">

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
    const nomeInput = document.getElementById('nome');
    const responsavelInput = document.getElementById('responsavel');
    const cpfInput = document.getElementById('cpf');
    const cnpjInput = document.getElementById('cnpj');
    const tipoDocumentoHidden = document.getElementById('tipo_documento');
    
    function toggleFields(userType) {
        // Zera os campos não visíveis para não serem enviados no POST (ou manter o valor anterior se for edição)
        // Isso é importante