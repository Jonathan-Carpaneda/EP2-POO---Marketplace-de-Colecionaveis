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

    def to_dict(self):
       
        return asdict(self)

    @classmethod
    def from_dict(cls, data):
        
        return cls(**data)


class produtoModel:
    FILE_PATH = os.path.join(DATA_DIR, 'produtos.json')

    def __init__(self):
        self.produtos = self._load()


    def _load(self) -> List[produto]:
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            data = json.load(f)
            
            return [produto.from_dict(item) for item in data]


    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            
            json.dump([p.to_dict() for p in self.produtos], f, indent=4, ensure_ascii=False)


    def get_all(self) -> List[produto]:
        return self.produtos


    def get_by_id(self, produto_id: int) -> produto | None:
        return next((p for p in self.produtos if p.id == produto_id), None)


    def add_produto(self, produto: produto):
        self.produtos.append(produto)
        self._save()


    def update_produto(self, updated_produto: produto):
        for i, produto in enumerate(self.produtos):
            if produto.id == updated_produto.id:
                self.produtos[i] = updated_produto
                self._save()
                return 


    def delete_produto(self, produto_id: int):
        self.produtos = [p for p in self.produtos if p.id != produto_id]
        self._save()

    def search(self, name_query: str = None, price_min: float = None, price_max: float = None) -> List[produto]:
       
       
        filtered_produtos = self.produtos

        
        if name_query:
            
            filtered_produtos = [
                p for p in filtered_produtos 
                if name_query in p.name.lower()
            ]

        
        if price_min is not None:
            filtered_produtos = [
                p for p in filtered_produtos 
                if p.price >= price_min
            ]

       
        if price_max is not None:
            filtered_produtos = [
                p for p in filtered_produtos 
                if p.price <= price_max
            ]

        return filtered_produtos