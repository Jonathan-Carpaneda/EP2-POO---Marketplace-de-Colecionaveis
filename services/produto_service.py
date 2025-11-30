from bottle import request
from models.produto import produtoModel, produto

class produtoService:
    def __init__(self):
        self.produto_model = produtoModel()


    def get_all(self):
        return self.produto_model.get_all()


    def save(self):
        
        last_id = max([p.id for p in self.produto_model.get_all()], default=0)
        new_id = last_id + 1

        
        name = request.forms.get('name')
        description = request.forms.get('description')
        
        try:
            price = float(request.forms.get('price'))
            stock_quantity = int(request.forms.get('stock_quantity'))
        except (ValueError, TypeError):
            return False, "Preço e Quantidade devem ser números válidos."

       
        if not name or price is None or stock_quantity is None:
            return False, "Nome, Preço e Quantidade em Estoque são obrigatórios."

        
        produto = produto(
            id=new_id, 
            name=name, 
            description=description, 
            price=price, 
            stock_quantity=stock_quantity
        )
        
        self.produto_model.add_produto(produto)
        return True, "Produto cadastrado com sucesso!"
    

    def get_by_id(self, produto_id):
        return self.produto_model.get_by_id(produto_id)


    def edit_produto(self, produto: produto):
        
        name = request.forms.get('name')
        description = request.forms.get('description')
        
        try:
            price = float(request.forms.get('price'))
            stock_quantity = int(request.forms.get('stock_quantity'))
        except (ValueError, TypeError):
            
            return False, "Preço e Quantidade devem ser números válidos."

        
        produto.name = name
        produto.description = description
        produto.price = price
        produto.stock_quantity = stock_quantity

        self.produto_model.update_produto(produto)
        return True, "Produto editado com sucesso!"


    def delete_produto(self, produto_id):
        self.produto_model.delete_produto(produto_id)

    def search_produto(self, name_query: str = None, price_min: float = None, price_max: float = None):
       
        
        if name_query:
            
            name_query = name_query.strip().lower()
        
       
        return self.produto_model.search(name_query, price_min, price_max)