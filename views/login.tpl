% rebase('layout', title='Login')

<section class="form-section">
    <h1>Acesso ao Sistema</h1>
    
    % if defined('error') and error:
    <div class="alert-error" style="color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 10px; margin-bottom: 20px; border-radius: 4px;">
        {{error}}
    </div>
    % end

    <form action="/login" method="post" class="form-container">
        
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required 
                   placeholder="seu.email@exemplo.com">
        </div>
        
        <div class="form-group">
            <label for="password">Senha:</label>
            <input type="password" id="password" name="password" required 
                   placeholder="Sua senha">
        </div>
        
        <div class="form-actions" style="display: flex; flex-direction: column; gap: 15px;">
            <button type="submit" class="btn-submit" style="width: 100%;">Entrar</button>
            
            <p style="text-align: center; margin: 0;">
                Ainda não tem conta? <a href="/users/add">Cadastre-se aqui</a>
            </p>
        </div>
    </form>
</section>