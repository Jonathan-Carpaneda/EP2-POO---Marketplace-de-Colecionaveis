import json
import os
from dataclasses import dataclass, asdict
from typing import List

DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

class User:
    def __init__(self, id, name, email, birthdate, password, user_type, cpf, cnpj, shop_name, phone, address):
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.birthdate = birthdate
        self.user_type = user_type
        self.cpf = cpf
        self.cnpj = cnpj
        self.shop_name = shop_name
        self.phone = phone
        self.address = address


    def __repr__(self):
        return (f"User(id={self.id}, name='{self.name}', email='{self.email}', password='{self.password}' , type='{self.user_type}', ",
                f"birthdate='{self.birthdate}'")


    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'email': self.email,
            'password': self.password,
            'birthdate': self.birthdate,
            'user_type': self.user_type,
            'cpf': self.cpf,
            'cnpj': self.cnpj,
            'shop_name': self.shop_name,
            'phone': self.phone,
            'address': self.address
        }


    @classmethod
    def from_dict(cls, data):
        return cls(
            id=data['id'],
            name=data['name'],
            email=data['email'],
            birthdate=data['birthdate'],
            user_type=data['user_type'],
            password=data.get('password', data.get('password')),
            cpf=data.get('cpf'),
            cnpj=data.get('cnpj'),
            shop_name=data.get('shop_name'),
            phone=data.get('phone'),
            address=data.get('address')
        )


class UserModel:
    FILE_PATH = os.path.join(DATA_DIR, 'users.json')

    def __init__(self):
        self.users = self._load()


    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            data = json.load(f)
            return [User(**item) for item in data]


    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            json.dump([u.to_dict() for u in self.users], f, indent=4, ensure_ascii=False)


    def get_all(self):
        self.users = self._load()
        return self.users


    def get_by_id(self, user_id: int):
        return next((u for u in self.users if u.id == user_id), None)


    def add_user(self, user: User):
        self.users.append(user)
        self._save()


    def update_user(self, updated_user: User):
        for i, user in enumerate(self.users):
            if user.id == updated_user.id:
                self.users[i] = updated_user
                self._save()
                break


    def delete_user(self, user_id: int):
        self.users = [u for u in self.users if u.id != user_id]
        self._save()
