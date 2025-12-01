<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>RelicárioDigital - {{title or 'Home'}}</title>
    <link rel="stylesheet" href="/static/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <header>
        <nav class="navbar">
            <div class="logo">
                <a href="/" class="logo-text"> RELICÁRIO DIGITAL </a>
            </div>
        
            <ul class="nav-links">
                
                % if defined('current_user') and current_user:
                    <li style="color: #ffc947; display: flex; align-items: center; gap: 8px;">
                        <i class="fas fa-user-circle"></i> 
                        {{current_user.name.split()[0]}}
                        
                        % if current_user.user_type == 'ADMIN':
                            <span style="background: #e94560; color: #fff; padding: 2px 6px; border-radius: 4px; font-size: 0.7em;">ADM</span>
                        % end
                    </li>

                    <li>
                        <a href="/logout" title="Sair do sistema">
                            <i class="fas fa-sign-out-alt"></i> Sair
                        </a>
                    </li>
                % else:
                    <li><a href="/login"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                    <li><a href="/users/add"><i class="fas fa-user-plus"></i> Cadastrar</a></li>
                % end

                <li class="dropdown">
                    <a href="#" class="dropdown-toggle"><i class="fas fa-bars"></i> Menu</a>
                    <ul class="dropdown-menu">
                    
                        <li><a href="/">Home</a></li>

                        % if defined('current_user') and current_user:
                            <li><a href="/produtos">Gestão de Produtos</a></li>
                            <li><a href="/produtos/add">Novo Produto</a></li>
                        % end

                        % if defined('current_user') and current_user and current_user.user_type == 'ADMIN':
                            <li><a href="/users" style="color: #e94560; font-weight: bold;">Gestão de Usuários</a></li>
                        % end
              
                    </ul>
                </li>
            </ul>
        </nav>
    </header>

    <main class="container">
        {{!base}}
    </main>

    <footer>
        <p>&copy; 2025 RelicárioDigital - Colecionáveis e Jogos</p>
    </footer>

</body>
</html>