import json
import os
import uuid  # <--- Importante para gerar IDs únicos
from dataclasses import dataclass, asdict
from typing import List

DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

@dataclass
class Produto:
    id: str 
    name: str
    description: str
    price: float
    stock_quantity: int
    owner_id: str = None
    image_url: str = None

    def __post_init__(self):
        if self.id is None:
            self.id = str(uuid.uuid4())
        else:
            self.id = str(self.id)

    def to_dict(self):
        return asdict(self)

    @classmethod
    def from_dict(cls, data):
        return cls(
            id=data.get('id'),
            name=data['name'],
            description=data['description'],
            price=data['price'],
            stock_quantity=data['stock_quantity'],
            owner_id=data.get('owner_id'),
            image_url=data.get('image_url')
        )

class ProdutoModel:
    FILE_PATH = os.path.join(DATA_DIR, 'produtos.json')

    def __init__(self):
        self.produtos = self._load()

    def _load(self) -> List[Produto]:
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            data = json.load(f)
            return [Produto.from_dict(item) for item in data]

    def _save(self):
        os.makedirs(os.path.dirname(self.FILE_PATH), exist_ok=True)
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            json.dump([p.to_dict() for p in self.produtos], f, indent=4, ensure_ascii=False)

    def get_all(self) -> List[Produto]:
        self.produtos = self._load()
        return self.produtos

    def get_by_id(self, produto_id: str) -> Produto | None:
        self.produtos = self._load()
        return next((p for p in self.produtos if p.id == str(produto_id)), None)
    
    def get_by_owner(self, owner_id: str) -> List[Produto]:
        self.produtos = self._load()
        return [p for p in self.produtos if str(p.owner_id) == str(owner_id)]

    def add_produto(self, produto: Produto):
        self.produtos.append(produto)
        self._save()

    def update_produto(self, updated_produto: Produto):
        for i, produto in enumerate(self.produtos):
            if produto.id == updated_produto.id:
                self.produtos[i] = updated_produto
                self._save()
                return 

    def delete_produto(self, produto_id: str):
        self.produtos = [p for p in self.produtos if p.id != str(produto_id)]
        self._save()

    def search(self, name_query: str = None, price_min: float = None, price_max: float = None) -> List[Produto]:
        self.produtos = self._load()
        filtered_produto = self.produtos
        
        if name_query:
            filtered_produto = [p for p in filtered_produto if name_query.lower() in p.name.lower()]
        if price_min is not None:
            filtered_produto = [p for p in filtered_produto if p.price >= price_min]
        if price_max is not None:
            filtered_produto = [p for p in filtered_produto if p.price <= price_max]

        return filtered_produto