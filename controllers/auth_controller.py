from bottle import Bottle, request, response, redirect
from .base_controller import BaseController
from services.user_service import UserService

class AuthController(BaseController):
    def __init__(self):
        self.user_service = UserService()

    def login_form(self):
        # Se já estiver logado, manda pra home
        if request.get_cookie("user_id", secret='minha_chave_secreta'):
            return redirect('/')
        return self.render('login', error=None)

    def login(self):
        email = request.forms.get('email')
        password = request.forms.get('password')
        #debug:
        print(f"\n[DEBUG] Tentativa de Login:")
        print(f"Digitei Email: '{email}'")
        print(f"Digitei Senha: '{password}'")
        users = self.user_service.get_all()
        found_user = None
        for u in users:
            print(f"   -> Comparando com usuário do banco: ID={u.id} | Email='{u.email}' | Senha='{u.password}'")
            if u.email == email and u.password == password:
                found_user = u
                break

        if found_user:
            print("[DEBUG] SUCESSO! Usuário encontrado.")
            response.set_cookie("user_id", str(found_user.id), secret='minha_chave_secreta')
            return redirect('/users') 
        else:
            print("[DEBUG] FALHA! Ninguém correspondeu.")
            return self.render('login', error="Email ou senha incorretos.")

       

    def logout(self):
        response.delete_cookie("user_id")
        return redirect('/login')

auth_routes = Bottle()
auth_ctrl = AuthController()

auth_routes.route('/login', method='GET', callback=auth_ctrl.login_form)
auth_routes.route('/login', method='POST', callback=auth_ctrl.login)
auth_routes.route('/logout', method='GET', callback=auth_ctrl.logout)