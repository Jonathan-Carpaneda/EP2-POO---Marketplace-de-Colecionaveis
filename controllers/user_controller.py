from bottle import Bottle, request
from .base_controller import BaseController
from services.user_service import UserService

class UserController(BaseController):
    def __init__(self, app):
        super().__init__(app)

        self.setup_routes()
        self.user_service = UserService()


    
    def setup_routes(self):
        self.app.route('/users', method='GET', callback=self.list_users)
        self.app.route('/users/add', method=['GET', 'POST'], callback=self.add_user)
        self.app.route('/users/edit/<user_id>', method=['GET', 'POST'], callback=self.edit_user)
        self.app.route('/users/delete/<user_id>', method='POST', callback=self.delete_user)
        self.app.route('/profile', method='GET', callback=self.meu_perfil)
        self.app.route('/users/profile/<user_id>', method='GET', callback=self.view_user_profile)

    def meu_perfil(self):
        user = self.get_current_user()
        if not user:
            return self.redirect('/login')
        return self.render('user_profile', user=user)
    
    def list_users(self):
        self.require_admin()
        users = self.user_service.get_all()
        return self.render('users', users=users)


    def view_user_profile(self, user_id):
        self.require_admin() 
        user = self.user_service.get_by_id(user_id)
        if not user:
            return "Usuário não encontrado"
        return self.render('user_profile', user=user)

    
    def add_user(self):
        if request.method == 'GET':
            return self.render('user_form', user=None, action="/users/add")
        else:
            try:
                self.user_service.save()
                current = self.get_current_user()
                if current and current.user_type == 'ADMIN':
                    return self.redirect('/users')
                else:
                    return self.redirect('/login')
            except Exception as e:
                return f"Erro ao salvar: {e}"


    def edit_user(self, user_id):
        user = self.user_service.get_by_id(user_id)
        if not user:
            return "Usuário não encontrado"
        current = self.get_current_user()
        if not current:
             return self.redirect('/login')
        
        if current.user_type != 'ADMIN' and current.id != user.id:
            return "Acesso negado"

        if request.method == 'GET':
            return self.render('user_form', user=user, action=f"/users/edit/{user_id}")
        else:
            self.user_service.edit_user(user)
            if current.user_type == 'ADMIN' and current.id != user.id:
                self.redirect('/users')
            else:
                self.redirect('/profile')

    def delete_user(self, user_id):
        self.require_admin()
        self.user_service.delete(user_id)
        self.redirect('/users')


user_routes = Bottle()
user_controller = UserController(user_routes)