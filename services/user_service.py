from models.user import UserModel, User
from bottle import request

class UserService:
    def __init__(self):
        self.user_model = UserModel()
        self._create_default_admin()

    def _create_default_admin(self):
        users = self.user_model.get_all()
        admin_email = "admin@sistema.com"
        if not any(u.email == admin_email for u in users):
            print("[SISTEMA] Criando Admin Padrão...")
            admin_user = User(
                name="Super Admin",
                email=admin_email,
                password="admin",
                birthdate=None,
                user_type="ADMIN",
                cpf=None, cnpj=None, shop_name=None, phone=None, address="Sede"
            )
            self.user_model.add_user(admin_user)

    def get_all(self):
        return self.user_model.get_all()

    def get_by_id(self, user_id):
        if not user_id:
            return None
        return self.user_model.get_by_id(str(user_id))

    def save(self):
        user_type = request.forms.get('user_type')
        email = request.forms.get('email')
        password = request.forms.get('password')
        name = request.forms.get('name')
        birthdate = None
        cpf = None
        cnpj = None
        shop_name = None

        if user_type == 'PJ':
            name = request.forms.get('name_responsavel')
            cnpj = request.forms.get('cnpj')
            shop_name = request.forms.get('shop_name')
        elif user_type == 'PF':
            cpf = request.forms.get('cpf')
            birthdate = request.forms.get('birthdate')
        elif user_type == 'ADMIN':
            pass

        phone = request.forms.get('phone')
        address = request.forms.get('address')

        new_user = User(
            id=None,
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
            user.birthdate = None
        elif user.user_type == 'PF':
            user.name = request.forms.get('name') or user.name
            user.cpf = request.forms.get('cpf') or user.cpf
            user.birthdate = request.forms.get('birthdate') or user.birthdate
            user.shop_name = None
            user.cnpj = None
        elif user.user_type == 'ADMIN':
            user.name = request.forms.get('name') or user.name
            user.cpf = None
            user.cnpj = None
            user.shop_name = None

        user.email = request.forms.get('email') or user.email
        user.password = request.forms.get('password') or user.password
        user.phone = request.forms.get('phone') or user.phone
        user.address = request.forms.get('address') or user.address

        self.user_model.update_user(user)

    def delete(self, user_id):
        self.user_model.delete_user(user_id)