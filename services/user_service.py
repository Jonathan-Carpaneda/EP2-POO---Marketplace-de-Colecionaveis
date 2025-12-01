from models.user import UserModel, User
from bottle import request

class UserService:
    def __init__(self):
        self.user_model = UserModel()

    def get_all(self):
        return self.user_model.get_all()

    def get_by_id(self, user_id):
        return self.user_model.get_by_id(user_id)

    def save(self):
        user_type = request.forms.get('user_type')
        email = request.forms.get('email')
        password = request.forms.get('password')

        if user_type == 'PJ':
            name = request.forms.get('name_responsavel')
        else:
            name = request.forms.get('name')

        # Captura os novos campos
        birthdate = request.forms.get('birthdate')
        cpf = request.forms.get('cpf')
        cnpj = request.forms.get('cnpj')
        shop_name = request.forms.get('shop_name')
        phone = request.forms.get('phone')
        address = request.forms.get('address')
        existing_users = self.user_model.get_all()
        new_id = max([u.id for u in existing_users], default=0) + 1
        new_user = User(
            id=new_id,
            name=name,
            email=email,
            password=password,
            birthdate=birthdate,
            user_type=user_type,
            cpf=cpf,
            cnpj=cnpj,
            shop_name=shop_name,
            phone=phone,
            address=address
        )

        self.user_model.add_user(new_user)

    def edit_user(self, user):
        form_user_type = request.forms.get('user_type')
        if form_user_type:
            user.user_type = form_user_type
        if user.user_type == 'PJ':
            user.name = request.forms.get('name_responsavel') or user.name
            user.shop_name = request.forms.get('shop_name') or user.shop_name
            user.cnpj = request.forms.get('cnpj') or user.cnpj
            user.cpf = None 
        else:
            user.name = request.forms.get('name') or user.name
            user.cpf = request.forms.get('cpf') or user.cpf
            user.birthdate = request.forms.get('birthdate') or user.birthdate
            user.shop_name = None
            user.cnpj = None

        user.email = request.forms.get('email') or user.email
        user.password = request.forms.get('password') or user.password
        user.phone = request.forms.get('phone') or user.phone
        user.address = request.forms.get('address') or user.address

        self.user_model.update_user(user)

    def delete(self, user_id):
        self.user_model.delete_user(user_id)