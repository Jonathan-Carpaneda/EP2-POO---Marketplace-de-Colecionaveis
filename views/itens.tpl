% rebase('layout', title='Vitrine')

<section class="marketplace-header">
    <h1>Itens Raros & Colecionáveis</h1>
    <a href="/items/add" class="btn-action">Anunciar Novo Item</a>
</section>

<div class="items-grid">
    % for item in items:
    <div class="item-card">
        <div class="card-image">
            <img src="{{item.image_url if hasattr(item, 'image_url') else 'https://via.placeholder.com/200'}}" alt="{{item.name}}">
        </div>
        
        <div class="card-content">
            <h3>{{item.name}}</h3>
            <p class="category">{{item.category}}</p> [cite: 2]
            <p class="price">R$ {{item.price}}</p>
            
            <div class="card-actions">
                <a href="/items/edit/{{item.id}}" class="btn-edit">Editar</a>
                
                <form action="/items/delete/{{item.id}}" method="post" style="display:inline;"> [cite: 3]
                    <button type="submit" class="btn-delete">X</button>
                </form>
            </div>
        </div>
    </div>
    % end
</div>