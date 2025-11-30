import json
import os
from dataclasses import dataclass, asdict
from typing import List


DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

@dataclass
class Product:
    id: int
    name: str
    description: str
    price: float
    stock_quantity: int

    def to_dict(self):
        # Usa asdict do dataclass para facilitar a serialização
        return asdict(self)

    @classmethod
    def from_dict(cls, data):
        # Cria uma instância Product a partir de um dicionário
        return cls(**data)


class ProductModel:
    FILE_PATH = os.path.join(DATA_DIR, 'products.json')

    def __init__(self):
        self.products = self._load()


    def _load(self) -> List[Product]:
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            data = json.load(f)
            # Instancia objetos Product a partir dos dados do JSON
            return [Product.from_dict(item) for item in data]


    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            # Salva a lista de produtos convertida para dicionário
            json.dump([p.to_dict() for p in self.products], f, indent=4, ensure_ascii=False)


    def get_all(self) -> List[Product]:
        return self.products


    def get_by_id(self, product_id: int) -> Product | None:
        return next((p for p in self.products if p.id == product_id), None)


    def add_product(self, product: Product):
        self.products.append(product)
        self._save()


    def update_product(self, updated_product: Product):
        for i, product in enumerate(self.products):
            if product.id == updated_product.id:
                self.products[i] = updated_product
                self._save()
                return # Sai assim que encontrar e atualizar


    def delete_product(self, product_id: int):
        self.products = [p for p in self.products if p.id != product_id]
        self._save()

    def search(self, name_query: str = None, price_min: float = None, price_max: float = None) -> List[Product]:
       
        # Começa com todos os produtos
        filtered_products = self.products

        # 1. Filtro por Nome
        if name_query:
            # Filtra onde o nome do produto (em minúsculas) contém a query
            filtered_products = [
                p for p in filtered_products 
                if name_query in p.name.lower()
            ]

        # 2. Filtro por Preço Mínimo
        if price_min is not None:
            filtered_products = [
                p for p in filtered_products 
                if p.price >= price_min
            ]

        # 3. Filtro por Preço Máximo
        if price_max is not None:
            filtered_products = [
                p for p in filtered_products 
                if p.price <= price_max
            ]

        return filtered_products