% rebase('layout', title='Formulário Produto') 

<section class="form-section">
    <h1>{{'Editar Produto' if produto else 'Adicionar Produto'}}</h1>
    
    % if defined('error') and error:
    <div class="alert alert-danger">{{error}}</div>
    % end
    
    <form action="{{action}}" method="post" class="form-container">
        
        <div class="form-group">
            <label for="name">Nome do Produto:</label>
            <input type="text" id="name" name="name" required 
                   value="{{produto.name if produto else ''}}" 
                   placeholder="Ex: Smartphone XYZ">
        </div>

        <div class="form-group">
            <label for="description">Descrição Detalhada:</label>
            <textarea id="description" name="description" rows="4" required 
                      placeholder="Características, especificações e diferenciais.">{{produto.description if produto else ''}}</textarea>
        </div>
        
        <div class="form-group">
            <label for="price">Preço (R$):</label>
            <input type="number" id="price" name="price" required step="0.01"
                   value="{{'%.2f' % produto.price if produto and produto.price is not None else ''}}"
                   placeholder="99.99">
        </div>

        <div class="form-group">
            <label for="stock_quantity">Quantidade em Estoque:</label>
            <input type="number" id="stock_quantity" name="stock_quantity" required 
                   value="{{produto.stock_quantity if produto and produto.stock_quantity is not None else ''}}"
                   placeholder="0">
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn-submit">Salvar Produto</button>
            <a href="/produto" class="btn-cancel">Voltar para a Lista</a>
        </div>
    </form>
</section>