<meta charset="UTF-8">
% rebase('layout', title=f'Detalhes de {produto.name}')

<section class="produto-detalhe-section">
    <div class="section-header">
        <h1 class="section-title"><i class="fas fa-info-circle"></i> Detalhes do Produto: {{produto.name}}</h1>
        <a href="/produtos" class="btn btn-cancel"><i class="fas fa-arrow-left"></i> Voltar para a Lista</a>
    </div>

    <div class="detalhe-card">
        
        % if produto.image_url:
        <div class="detalhe-image-container full-width">
            <img src="{{produto.image_url}}" alt="Imagem do Produto {{produto.name}}" class="produto-detalhe-image">
        </div>
        % end
        
        <div class="detalhe-info-group">
            <h3 class="info-title">Informações Básicas</h3>
            <p><strong>ID:</strong> {{produto.id}}</p>
            <p><strong>Nome:</strong> {{produto.name}}</p>
 
        </div>

        <div class="image-gallery-column">
            <div class="card detail-card product-gallery-card">
                <div class="card-header bg-primary text-white">
                    Galeria de Imagens
                </div>
                <div class="card-body">
                    <div class="image-slider-container">
                        <div class="slider-track">
                            <div class="slide"><i class="fas fa-gamepad product-icon-placeholder"></i></div>
                            <div class="slide"><i class="fas fa-cube product-icon-placeholder"></i></div>
                            <div class="slide"><i class="fas fa-box product-icon-placeholder"></i></div>
                        </div>
                        <div class="slider-dots">
                            <span class="dot active"></span>
                            <span class="dot"></span>
                            <span class="dot"></span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="card detail-card mt-4">
                <div class="card-header bg-secondary text-white">
                    Descrição Completa
                </div>
                <div class="card-body">
                    <p class="description-text">{{produto.description}}</p>
                </div>
            </div>
        </div>

<div class="info-actions-column">
            
            <div class="card detail-card">
                <div class="card-header bg-primary text-white">
                    Informações Básicas
                </div>
                <div class="card-body">
                    <p><strong>ID:</strong> <span style="font-family: monospace;">{{produto.id}}</span></p>
                    <p><strong>Nome:</strong> {{produto.name}}</p>
                </div>
            </div>

            <div class="card detail-card mt-4">
                <div class="card-header bg-secondary text-white">
                    Descrição
                </div>
                <div class="card-body">
                    <p class="description-text">{{produto.description}}</p>
                </div>
            </div>

            <div class="card detail-card mt-4">
                <div class="card-header bg-secondary text-white">
                    Preço & Estoque
                </div>
                <div class="card-body">
                    <p><strong>Preço:</strong> <span class="price-value">R$ {{'%.2f' % produto.price}}</span></p>
                    
                    % if produto.stock_quantity == 0:
                        <p><strong>Estoque:</strong> <span class="tag-out-of-stock tag-large">Esgotado</span></p>
                    % else:
                        <p><strong>Estoque:</strong> <span class="stock-value tag-success tag-large">{{produto.stock_quantity}} unidades</span></p>
                    % end
                </div>
            </div>

            % if defined('current_user') and current_user and (current_user.user_type == 'ADMIN' or str(current_user.id) == str(produto.owner_id)):
            <div class="card detail-card mt-4">
                <div class="card-header bg-secondary text-white">
                    Ações Administrativas
                </div>
                <div class="card-body detail-actions-buttons">
                    <a href="/produtos/edit/{{produto.id}}" class="btn btn-edit btn-lg">
                        <i class="fas fa-edit"></i> Editar Produto
                    </a>
                    
                    <form action="/produtos/delete/{{produto.id}}" method="post" style="display:inline;"
                          onsubmit="return confirm('Tem certeza que deseja excluir o produto {{produto.name}}?')">
                        <button type="submit" class="btn btn-danger btn-lg">
                            <i class="fas fa-trash-alt"></i> Excluir
                        </button>
                    </form>
                </div>
            </div>
            % end

        </div>

    </div>
</section>

<style>
/* Estilos Específicos do Produto (Garantindo o visual de "caixa" do formulário) */
.produto-detalhe-section { padding: 20px 0; }

.product-detail-layout {
    display: flex;
    gap: 30px;
}

.image-gallery-column {
    flex-basis: 60%; 
    min-width: 300px;
}

.info-actions-column {
    flex-basis: 40%; 
}

/* Aplicando estilos de card/form-container */
.detail-card { 
    border-radius: 8px; 
    overflow: hidden; 
    /* Box-shadow mais evidente, similar ao do form-container */
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
    background-color: #16213e; /* Fundo do form-container */
    margin-bottom: 20px;
}

/* Estilos internos do card, conforme o CSS global */
.detail-card .card-header { 
    padding: 15px; 
    font-weight: bold; 
    color: white;
    background-color: #0f3460; 
}
.detail-card .bg-primary { background-color: #e94560 !important; }
.detail-card .bg-secondary { background-color: #2e4a86 !important; }

.detail-card .card-body { padding: 15px; }
.detail-card .card-body p { 
    margin-bottom: 8px; 
    padding: 5px 0;
    border-bottom: 1px solid #1a1a2e; /* Linha de separação escura */
    color: #e0e0e0;
}
.detail-card .card-body p:last-child { border-bottom: none; margin-bottom: 0;}


/* Estilos de Preço e Estoque */
.price-value {
    font-size: 1.5em;
    font-weight: bold;
    color: #e94560; 
}

.stock-value {
    font-weight: bold;
    color: #38a169; /* Cor de sucesso */
}

.tag-success { /* Ajuste a cor da tag de estoque disponível para o verde (tag-pf) */
    background-color: #38a169; 
    color: #fff;
}

.tag-out-of-stock {
    background-color: #e94560; 
    color: white;
}

.tag-large {
    padding: 5px 10px;
    border-radius: 5px;
    font-size: 0.9em;
    text-transform: uppercase;
    font-weight: bold;
    display: inline-block;
}

.description-text {
    line-height: 1.8;
    color: #b0b0b0;
    white-space: pre-wrap; 
}

/* Galeria de Imagens */
.product-gallery-card .card-body {
    padding: 0;
}

.image-slider-container {
    overflow: hidden;
    position: relative;
    background-color: #1a1a2e;
    border-radius: 0 0 8px 8px;
}

.slider-track {
    display: flex;
    width: 300%; /* 3 slides de placeholder */
    transition: transform 0.5s ease-in-out;
}

.slide {
    width: calc(100% / 3); 
    height: 350px; 
    display: flex;
    align-items: center;
    justify-content: center;
}

.product-icon-placeholder {
    color: #e94560; 
    font-size: 6em;
}

.slider-dots {
    position: absolute;
    bottom: 10px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 10px;
}

.dot {
    height: 10px;
    width: 10px;
    background-color: #555;
    border-radius: 50%;
    display: inline-block;
    cursor: pointer;
    transition: background-color 0.3s;
}

.dot.active {
    background-color: #ffc947;
}

/* Botões de Ação */
.detail-actions-buttons {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.btn-lg {
    padding: 12px 20px;
    font-size: 1em;
    width: 100%; 
}

.btn-edit {
    background-color: #ffc947; 
    color: #1a1a2e; 
    transition: background-color 0.3s;
}
.btn-edit:hover {
    background-color: #ffd873; 
}

.btn-danger {
    background-color: #e94560; 
    color: white;
    transition: background-color 0.3s;
}
.btn-danger:hover {
    background-color: #ff6b86;
}

.mt-4 { margin-top: 1.5rem; }

/* Responsividade */
@media (max-width: 992px) {
    .product-detail-layout {
        flex-direction: column;