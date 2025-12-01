% rebase('layout', title='Página Inicial - Nossa Loja')

<section class="hero-section">
    <h1>Bem-vindo ao Relicário Digital</h1>
    <p>Sua loja especializada em itens raros, colecionáveis e os melhores produtos gamer.</p>
</section>

<section class="search-container">
    <form action="/produtos/search" method="GET" class="search-form">
        <input type="text" name="name" placeholder="Buscar por nome, categoria ou descrição..." 
               value="{{search_query if defined('search_query') and search_query else ''}}">
        
        <input type="number" name="min_price" placeholder="Preço Min (R$)" step="0.01" 
               value="{{min_price if defined('min_price') and min_price else ''}}"
               min="0"> <input type="number" name="max_price" placeholder="Preço Máx (R$)" step="0.01" 
               value="{{max_price if defined('max_price') and max_price else ''}}"
               min="0"> <button type="submit" class="btn btn-secondary"><i class="fas fa-filter"></i> Filtrar</button>

        % if defined('search_query') or defined('min_price') or defined('max_price'):
            <a href="/" class="btn-secondary-outline">Limpar Filtros</a>
        % end
    </form>
</section>

<section class="products-section">
    <h2>Nossos Destaques</h2>

    % if defined('produtos') and produtos:
        <div class="products-grid">
            % for produto in produtos:
            <div class="product-card">
                <div class="card-img-top">
                    <i class="fas fa-gamepad"></i>
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
                        <a href="/produtos/edit/{{produto.id}}" class="btn-details">
                            <i class="fas fa-shopping-cart"></i> Ver Detalhes
                        </a>
                    </div>
                </div>
            </div>
            % end
        </div>
    % else:
        <p style="text-align: center; color: #ffc947;">Nenhum produto em destaque no momento.</p>
    % end
</section>