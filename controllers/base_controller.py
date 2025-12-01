from bottle import static_file, request, redirect as bottle_redirect
from services.user_service import UserService

class BaseController:
    def __init__(self, app=None):
        self.app = app
        self.user_service = UserService()
        
        if self.app:
            self._setup_base_routes()

    def _setup_base_routes(self):
        """Configura rotas básicas comuns a todos os controllers"""
        self.app.route('/', method='GET', callback=self.home_redirect)
        self.app.route('/helper', method=['GET'], callback=self.helper)
        self.app.route('/static/<filename:path>', callback=self.serve_static)

    def home_redirect(self):
        """Redireciona a rota raiz para /users"""
        return self.redirect('/users')

    def helper(self):
        return self.render('helper-final')

    def serve_static(self, filename):
        """Serve arquivos estáticos da pasta static/"""
        return static_file(filename, root='./static')

    def get_current_user(self):
        user_id = request.get_cookie("user_id", secret='minha_chave_secreta')

        print(f"[DEBUG BASE] Cookie lido: {user_id}")

        if user_id:
            user = self.user_service.get_by_id(user_id)
            
            if user:
                print(f"[DEBUG BASE] Usuário validado: {user.name} ({user.user_type})")
            else:
                print(f"[DEBUG BASE] Cookie existe mas usuário não encontrado no JSON.")
            
            return user
        
        return None

    def require_admin(self):
        """Bloqueia a execução se o usuário não for ADMIN"""
        user = self.get_current_user()
        if user:
            print(f"[DEBUG SECURITY] Verificando acesso para: {user.name} ({user.user_type})")
            if user.user_type != 'ADMIN':
                print("[DEBUG SECURITY] BLOQUEADO: Usuário existe mas não é ADMIN.")
        else:
            print("[DEBUG SECURITY] BLOQUEADO: Usuário não logado (None).")
        if not user or user.user_type != 'ADMIN':
            bottle_redirect('/login')

    def render(self, template_name, **context):
        from bottle import template as render_template
        current_user = self.get_current_user()
        context['current_user'] = current_user
        return render_template(template_name, **context)

    def redirect(self, path, code=302):
        from bottle import HTTPResponse, response as bottle_response
        try:
            bottle_response.status = code
            bottle_response.set_header('Location', path)
            return bottle_response
        except Exception as e:
            print(f"ERRO NO REDIRECT: {type(e).__name__} - {str(e)}")
            return HTTPResponse(
                body=f'<script>window.location.href="{path}";</script>',
                status=200,
                headers={'Content-Type': 'text/html'}
            )