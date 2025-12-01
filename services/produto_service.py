from models.produto import ProdutoModel, Produto
from typing import List

class ProdutoService:
    def __init__(self):
        self.model = ProdutoModel()

    def get_all_produtos(self) -> List[Produto]:
        return self.model.get_all()

    def get_produto_by_id(self, produto_id) -> Produto | None:
        return self.model.get_by_id(str(produto_id))

    def get_produtos_by_owner(self, owner_id: str) -> List[Produto]:
        return self.model.get_by_owner(str(owner_id))

    def search_produtos(self, name_query: str = None, price_min: float = None, price_max: float = None) -> List[Produto]:
        return self.model.search(name_query, price_min, price_max)

    def create_produto(self, produto_data: dict, owner_id: str) -> Produto:
        new_produto = Produto(
            id=None,
            name=produto_data['name'],
            description=produto_data['description'],
            price=produto_data['price'],
            stock_quantity=produto_data['stock_quantity'],
            owner_id=owner_id, 
            image_url=produto_data.get('image_url')
        )
        
        self.model.add_produto(new_produto)
        return new_produto

    def update_produto(self, produto_id, produto_data: dict) -> bool:
        pid_str = str(produto_id)
        existing_produto = self.model.get_by_id(pid_str)
        if not existing_produto:
            return False
        
        updated_produto = Produto(
            id=pid_str, 
            name=produto_data['name'],
            description=produto_data['description'],
            price=produto_data['price'],
            stock_quantity=produto_data['stock_quantity'],
            owner_id=existing_produto.owner_id,
            image_url=produto_data.get('image_url')
        )
        
        self.model.update_produto(updated_produto)
        return True

    def delete_produto(self, produto_id):
        self.model.delete_produto(str(produto_id))