from models.produto import produtoModel, produto
from typing import List

class ProdutoService:
    """
    Camada de Serviço para a entidade Produto.
    Encapsula a lógica de negócio e interage com o ProdutoModel.
    """
    
    def __init__(self):
        self.model = produtoModel()

    # --- Métodos de Leitura (GET) ---

    def get_all_produtos(self) -> List[produto]:
        """Retorna todos os produtos."""
        return self.model.get_all()

    def get_produto_by_id(self, produto_id: int) -> produto | None:
        """Retorna um produto pelo ID."""
        return self.model.get_by_id(produto_id)

    def search_produtos(self, name_query: str = None, price_min: float = None, price_max: float = None) -> List[produto]:
        """Busca produtos por nome e faixa de preço."""
        return self.model.search(name_query, price_min, price_max)

    # --- Métodos de Escrita/Manipulação (POST/PUT/DELETE) ---

    def create_produto(self, produto_data: dict) -> produto:
        """Cria um novo produto, incluindo a lógica para determinar o próximo ID."""
        
        all_produtos = self.model.get_all()
        next_id = max(p.id for p in all_produtos) + 1 if all_produtos else 1
        
        new_produto = produto(
            id=next_id,
            name=produto_data['name'],
            description=produto_data['description'],
            price=produto_data['price'],
            stock_quantity=produto_data['stock_quantity']
        )
        
        self.model.add_produto(new_produto)
        return new_produto

    def update_produto(self, produto_id: int, produto_data: dict) -> bool:
        """Atualiza um produto existente. Retorna True se atualizado, False caso contrário."""
        
        existing_produto = self.model.get_by_id(produto_id)
        if not existing_produto:
            return False
        
        updated_produto = produto(
            id=produto_id, 
            name=produto_data['name'],
            description=produto_data['description'],
            price=produto_data['price'],
            stock_quantity=produto_data['stock_quantity']
        )
        
        self.model.update_produto(updated_produto)
        return True

    def delete_produto(self, produto_id: int):
        """Deleta um produto pelo ID."""
        self.model.delete_produto(produto_id)


produto_service = ProdutoService()