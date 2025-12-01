% rebase('layout', title=f'Detalhes de {produto.name}')

<section class="produto-detalhe-section">
    <div class="header-detalhe">
        <h1><i class="fas fa-info-circle"></i> Detalhes do Produto: {{produto.name}}</h1>
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

        <div class="detalhe-info-group">
            <h3 class="info-title">Preço & Estoque</h3>
            <p><strong>Preço:</strong> <span class="price-value">R$ {{'%.2f' % produto.price}}</span></p>
            
            % if produto.stock_quantity == 0:
            <p><strong>Estoque:</strong> <span class="tag-danger">Esgotado</span></p>
            % else:
            <p><strong>Estoque:</strong> <span class="stock-value">{{produto.stock_quantity}} unidades</span></p>
            % end
        </div>

        <div class="detalhe-info-group full-width">
            <h3 class="info-title">Descrição</h3>
            <p class="description-text">{{produto.description}}</p>
        </div>
        
        <div 
 class="detalhe-actions full-width">
            <a href="/produtos/edit/{{produto.id}}" class="btn btn-edit"><i class="fas fa-edit"></i> Editar Produto</a>
            <form action="/produtos/delete/{{produto.id}}" method="post" style="display:inline;"
 onsubmit="return confirm('Tem certeza que deseja excluir o produto {{produto.name}}?')">
                <button type="submit" class="btn btn-danger"><i class="fas fa-trash-alt"></i> Excluir Produto</button>
            </form>
        </div>
    </div>
</section>