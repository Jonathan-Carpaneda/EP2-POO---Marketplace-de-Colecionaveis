% rebase('layout', title='Página Inicial - Nossa Loja')

<!-- Estilos específicos da Home (Vitrine) -->
<style>
    /* Hero Section (Banner) */
    .hero-section {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 60px 20px;
        text-align: center;
        border-radius: 12px;
        margin-bottom: 40px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    .hero-section h1 { font-size: 2.5rem; margin-bottom: 10px; }
    .hero-section p { font-size: 1.2rem; opacity: 0.9; }

    /* Barra de Busca */
    .search-container {
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 30px;
        border: 1px solid #e9ecef;
    }
    .search-form {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
        justify-content: center;
    }
    .search-form input {
        padding: 10px;
        border: 1px solid #ced4da;
        border-radius: 5px;
        flex: 1;
        min-width: 150px;
    }
    .btn-search {
        background-color: #764ba2;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        transition: background 0.3s;
    }
    .btn-search:hover { background-color: #5a3780; }

    /* Grid de Produtos */
    .products-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 30px;
        padding-bottom: 40px;
    }

    /* Card do Produto */
    .product-card {
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        transition: transform 0.3s, box-shadow 0.3s;
        border: 1px solid #eee;
        display: flex;
        flex-direction: column;
    }
    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    }
    
    /* Imagem (Placeholder, já que o model não tem imagem) */
    .card-img-top {
        width: 100%;
        height: 200px;
        background-color: #e9ecef;
        object-fit: cover;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #adb5bd;
        font-size: 3rem;
    }

    .card-body {
        padding: 20px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }

    .card-title {
        font-size: 1.25rem;
        margin: 0 0 10px 0;
        color: #333;
        font-weight: 700;
    }

    .card-text {
        font-size: 0.9rem;
        color: #666;
        margin-bottom: 15px;
        flex-grow: 1;
    }

    .price-tag {
        font-size: 1.5rem;
        color: #28a745;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .stock-info {
        font-size: 0.85rem;
        margin-bottom: 15px;
    }
    .in-stock { color: #28a745; }
    .out-stock { color: #dc3545; }

    .card-actions {
        margin-top: auto;
    }
    
    .btn-details {
        display: block;
        width: 100%;
        text-align: center;
        background-color: #007bff;
        color: white;
        padding: 10px;
        text-decoration: none;
        border-radius: 5px;
        transition: background 0.2s;
    }
    .btn-details:hover { background-color: #0056b3; }
</style>

<!-- Banner Principal -->
<div class="hero-section">
    <h1>Bem-vindo à TechStore</h1>
    <p>Os melhores produtos com os melhores preços você encontra aqui.</p>
</div>

<!-- Área de Filtros e Busca -->
<div class="search-container">
    <form action="/produtos/search" method="GET" class="search-form">
        <input type="text" name="name" placeholder="Buscar produto..." value="{{search_query if defined('search_query') and search_query else ''}}">
        <input type="number" name="min_price" placeholder="Preço Min (R$)" step="0.01" value="{{min_price if defined('min_price') and min_price else ''}}">
        <input type="number" name="max_price" placeholder="Preço Máx (R$)" step="0.01" value="{{max_price if defined('max_price') and max_price else ''}}">
        <button type="submit" class="btn-search"><i class="fas fa-search"></i> Filtrar</button>
        % if defined('search_query') or defined('min_price') or defined('max_price'):
            <a href="/produtos" style="align-self: center; margin-left: 10px; color: #666;">Limpar</a>
        % end
    </form>
</div>

<!-- Listagem de Produtos -->
<section>
    % if defined('error') and error:
        <div style="background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-bottom: 20px;">
            {{error}}
        </div>
    % end

    % if not produtos:
        <div style="text-align: center; padding: 50px; color: #666;">
            <i class="fas fa-box-open" style="font-size: 3rem; margin-bottom: 15px;"></i>
            <h3>Nenhum produto encontrado.</h3>
            <p>Tente ajustar seus filtros de busca.</p>
        </div>
    % else:
        <div class="products-grid">
            % for produto in produtos:
            <div class="product-card">
                <!-- Placeholder de imagem usando FontAwesome ou Placehold.co -->
                <div class="card-img-top">
                    <img src="https://placehold.co/400x300/EEE/31343C?text={{produto.name[:3].upper()}}" alt="{{produto.name}}" style="width:100%; height:100%; object-fit:cover;">
                </div>
                
                <div class="card-body">
                    <h3 class="card-title">{{produto.name}}</h3>
                    
                    <p class="card-text">
                        {{produto.description[:100]}}{{ '...' if len(produto.description) > 100 else '' }}
                    </p>
                    
                    <div class="price-tag">
                        R$ {{'%.2f' % produto.price}}
                    </div>
                    
                    <div class="stock-info">
                        % if produto.stock_quantity > 0:
                            <span class="in-stock"><i class="fas fa-check-circle"></i> Em estoque ({{produto.stock_quantity}})</span>
                        % else:
                            <span class="out-stock"><i class="fas fa-times-circle"></i> Indisponível</span>
                        % end
                    </div>

                    <div class="card-actions">
                        <!-- Link aponta para edição, mas numa loja real seria 'Ver Detalhes' ou 'Comprar' -->
                        <a href="/produtos/edit/{{produto.id}}" class="btn-details">
                            <i class="fas fa-shopping-cart"></i> Ver Detalhes
                        </a>
                    </div>
                </div>
            </div>
            % end
        </div>
    % end
</section>