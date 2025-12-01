% rebase('layout', title='Login')

<section class="form-section">
    <h1 style="text-align: center;"><i class="fas fa-sign-in-alt"></i> Acesso ao Sistema</h1>
    
    % if defined('error') and error:
    <div class="alert alert-danger" style="color: #ffc947; background-color: #3e0c19; border: 1px solid #e94560; padding: 15px; margin-bottom: 25px; border-radius: 6px; font-weight: bold;">
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
        
        <div class="form-actions" style="display: flex; flex-direction: column; gap: 15px; margin-top: 20px;">
            <button type="submit" class="btn-submit" style="width: 100%;">Entrar</button>
            
            <p style="text-align: center; margin: 0; color: #b0b0b0;">
                Ainda não tem conta? <a href="/users/add" style="color: #ffc947; text-decoration: none; font-weight: bold;">Cadastre-se aqui</a>
            </p>
        </div>
    </form>
</section>