% rebase('layout', title='Formulário Produto') 

<section class="form-section">
    <h1>{{'Editar Produto' if produto else 'Adicionar Produto'}}</h1>
    
    % if defined('error') and error:
    <div class="alert alert-danger">{{error}}</div>
    % end
    
    <form action="{{action}}" method="post" class="form-container" enctype="multipart/form-data">
        
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
            <label for="image_file">Upload da Imagem:</label>
            <input type="file" id="image_file" name="image_file" accept="image/*">
            
            % if produto and produto.image_url:
            <p style="margin-top: 5px; font-size: 0.9em; color: #aaa;">Imagem atual:</p>
            <img src="{{produto.image_url}}" alt="Imagem Atual" style="max-width: 150px; height: auto; display: block; margin-top: 5px;">
            % end
        </div>

        <div class="form-group">
            <label for="price">Preço (R$):</label>
            <input type="number" id="price" name="price" required step="0.01" min="0.00"
                   value="{{'%.2f' % produto.price if produto and produto.price is not None else ''}}"
                   placeholder="99.99">
        </div>

        <div class="form-group">
            <label for="stock_quantity">Quantidade em Estoque:</label>
            <input type="number" id="stock_quantity" name="stock_quantity" min="0" required 
                   value="{{produto.stock_quantity if produto and produto.stock_quantity is not None else ''}}"
                   placeholder="0">
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn-submit"><i class="fas fa-save"></i> Salvar Produto</button>
            <a href="/produtos" class="btn-cancel"><i class="fas fa-times"></i> Cancelar</a>
        </div>
    </form>
</section>