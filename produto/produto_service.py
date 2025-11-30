from bottle import request
from models.product import ProductModel, Product

class ProductService:
    def __init__(self):
        self.product_model = ProductModel()


    def get_all(self):
        return self.product_model.get_all()


    def save(self):
        # Lógica para gerar o novo ID
        last_id = max([p.id for p in self.product_model.get_all()], default=0)
        new_id = last_id + 1

        # Coleta de dados do formulário
        name = request.forms.get('name')
        description = request.forms.get('description')
        # Tenta converter para float (preço) e int (quantidade)
        try:
            price = float(request.forms.get('price'))
            stock_quantity = int(request.forms.get('stock_quantity'))
        except (ValueError, TypeError):
            return False, "Preço e Quantidade devem ser números válidos."

        # Validação simples
        if not name or price is None or stock_quantity is None:
            return False, "Nome, Preço e Quantidade em Estoque são obrigatórios."

        # Cria a instância do Produto
        product = Product(
            id=new_id, 
            name=name, 
            description=description, 
            price=price, 
            stock_quantity=stock_quantity
        )
        
        self.product_model.add_product(product)
        return True, "Produto cadastrado com sucesso!"
    

    def get_by_id(self, product_id):
        return self.product_model.get_by_id(product_id)


    def edit_product(self, product: Product):
        # Coleta de dados atualizados
        name = request.forms.get('name')
        description = request.forms.get('description')
        
        try:
            price = float(request.forms.get('price'))
            stock_quantity = int(request.forms.get('stock_quantity'))
        except (ValueError, TypeError):
            # No contexto de edição, você pode querer retornar False ou lançar um erro
            return False, "Preço e Quantidade devem ser números válidos."

        # Atualiza o objeto Produto com os novos dados
        product.name = name
        product.description = description
        product.price = price
        product.stock_quantity = stock_quantity

        self.product_model.update_product(product)
        return True, "Produto editado com sucesso!"


    def delete_product(self, product_id):
        self.product_model.delete_product(product_id)