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
                <li><a href="/items">Ver Itens</a></li>
                <li><a href="/items/add">Vender Item</a></li>
                <li><a href="/users">Usuários</a></li>
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