%rebase('layout', title='Gestão de Produtos')

<section class="produto-section">
    <div class="section-header">
        <h1 class="section-title"><i class="fas fa-boxes"></i> Gestão de Produtos</h1>
        <a href="/produtos/add" class="btn btn-primary">
            <i class="fas fa-plus"></i> Novo Produto
        </a>
    </div>

    <div class="search-bar">
        <form action="/produtos/search" method="GET" class="form-inline">
            <input type="text" name="name" placeholder="Buscar por Nome..." value="{{search_query or ''}}">
  
            <input type="number" name="min_price" placeholder="Preço Mínimo" step="0.01" min="0" value="{{'%.2f' % min_price if defined('min_price') and min_price else ''}}">
            <input type="number" name="max_price" placeholder="Preço Máximo" step="0.01" min="0" value="{{'%.2f' % max_price if defined('max_price') and max_price else ''}}">
            
            <button type="submit" class="btn btn-secondary"><i class="fas fa-search"></i> Buscar</button>
            % if defined('search_query') or defined('min_price') or defined('max_price'):
 
            <a href="/produtos" class="btn btn-secondary-outline">Limpar</a>
            % end
        </form>
    </div>
    
    % if defined('error') and error:
    <div class="alert alert-danger">{{error}}</div>
    % end

    <div class="table-container">
        <table class="styled-table">
            <thead>
           <tr>
                    <th>ID</th>
                    <th>Imagem</th> <th>Nome</th>
                    <th>Descrição</th>
                    <th>Preço</th>
           <th>Estoque</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                % for p in produtos:
           <tr>
 
                    <td>{{p.id}}</td>
                    <td> 
                        % if p.image_url:
                        <img src="{{p.image_url}}" alt="Miniatura" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                        % else:
                        N/A
                        % end
                    </td> 
                    <td>{{p.name}}</td>
                    <td>{{p.description[:50] + '...' if len(p.description) > 50 else p.description}}</td>
               
               <td>R$ {{'%.2f' % p.price}}</td>
           <td>
                        % if p.stock_quantity == 0:
                        <span class="tag-danger">Esgotado</span>
                        % else:
                         {{p.stock_quantity}}
                        % end
     
                </td>
                     <td class="actions">
                        <a href="/produtos/view/{{p.id}}" class="btn btn-sm btn-info">
                            <i class="fas fa-eye"></i> Ver Detalhes
                        </a>
 
                     
           <a href="/produtos/edit/{{p.id}}" class="btn btn-sm btn-edit">
                            <i class="fas fa-edit"></i> Editar
           
               </a>

          
               <form action="/produtos/delete/{{p.id}}" method="post"
           
                   onsubmit="return confirm('Tem certeza que deseja excluir o produto {{p.name}}?')">
                      
       <button type="submit" class="btn btn-sm btn-danger">
              
                   <i class="fas fa-trash-alt"></i> Excluir
      
                       </button>
                        </form>
 
                    </td>
      
           </tr>
                % end
 
            </tbody>
        % if not produtos:
        <tfoot>
            <tr>
   
              <td colspan="7" style="text-align: center;
 color: #ffc947; padding: 20px; background-color: #16213e;">
                    Nenhum produto encontrado.
                </td>
            </tr>
        </tfoot>
        % end
        </table>
    </div>
</section>