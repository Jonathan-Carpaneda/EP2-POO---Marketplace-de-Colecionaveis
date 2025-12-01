import json
import os
from dataclasses import dataclass, asdict
from typing import List


DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

@dataclass
class produto:
    id: int
    name: str
    description: str
    price: float
    stock_quantity: int
    owner_id: str = None
    image_url: str = None 
    def to_dict(self):
        return asdict(self)

    @classmethod
    def from_dict(cls, data):
        return cls(
            id=data['id'],
            name=data['name'],
            description=data['description'],
            price=data['price'],
            stock_quantity=data['stock_quantity'],
            owner_id=data.get('owner_id'), 
            image_url=data.get('image_url') 
        )


class produtoModel:
    FILE_PATH = os.path.join(DATA_DIR, 'produto.json')

    def __init__(self):
        self.produto = self._load()


    def _load(self) -> List[produto]:
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            data = json.load(f)
            
            return [produto.from_dict(item) for item in data]


    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            
            json.dump([p.to_dict() for p in self.produto], f, indent=4, ensure_ascii=False)


    def get_all(self) -> List[produto]:
        self.produtos = self._load()
        return self.produtos


    def get_by_id(self, produto_id: int) -> produto | None:
        return next((p for p in self.produto if p.id == produto_id), None)


    def add_produto(self, produto: produto):
        self.produto.append(produto)
        self._save()


    def update_produto(self, updated_produto: produto):
        for i, produto in enumerate(self.produto):
            if produto.id == updated_produto.id:
                self.produto[i] = updated_produto
                self._save()
                return 


    def delete_produto(self, produto_id: int):
        self.produto = [p for p in self.produto if p.id != produto_id]
        self._save()

    def search(self, name_query: str = None, price_min: float = None, price_max: float = None) -> List[produto]:
       
       
        filtered_produto = self.produto

        
        if name_query:
            
            filtered_produto = [
                p for p in filtered_produto 
                if name_query in p.name.lower()
            ]

        
        if price_min is not None:
            filtered_produto = [
                p for p in filtered_produto 
                if p.price >= price_min
            ]

       
        if price_max is not None:
            filtered_produto = [
                p for p in filtered_produto 
                if p.price <= price_max
            ]

        return filtered_produto