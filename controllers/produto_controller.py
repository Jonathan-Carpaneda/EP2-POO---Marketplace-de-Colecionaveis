import os
import uuid
from bottle import Bottle, request, redirect 
from controllers.base_controller import BaseController
from services.produto_service import produto_service 
from models.produto import produto 

UPLOAD_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'static', 'images', 'produtos')


class ProdutoController(BaseController): 
    def __init__(self, app):
        super().__init__(app)
        self.setup_routes()
        self.produto_service = produto_service


    def setup_routes(self):
        
        self.app.route('/', method='GET', callback=self.home_index) 
        
        
        self.app.route('/produtos', method='GET', callback=self.list_produtos)
        self.app.route('/produtos/search', method='GET', callback=self.search_produtos_route) 
        
        
        self.app.route('/produtos/add', method=['GET', 'POST'], callback=self.add_produto)
        self.app.route('/produtos/edit/<produto_id:int>', method=['GET', 'POST'], callback=self.edit_produto)
        self.app.route('/produtos/delete/<produto_id:int>', method='POST', callback=self.delete_produto)
        
       
        self.app.route('/produtos/view/<produto_id:int>', method='GET', callback=self.view_produto_details) 

    
    def _save_uploaded_file(self, upload):
        """Salva o arquivo de upload e retorna o caminho público."""
        if not upload or not upload.filename:
            return None
        
        
        os.makedirs(UPLOAD_DIR, exist_ok=True)
        
        
        name, ext = os.path.splitext(upload.filename)
        
        if ext.lower() not in ('.png', '.jpg', '.jpeg', '.gif'):
            raise ValueError("Tipo de arquivo não permitido.")
            
        safe_filename = f"{uuid.uuid4()}{ext.lower()}"
        file_path = os.path.join(UPLOAD_DIR, safe_filename)
        
        upload.save(file_path)
        
        return f"/static/images/produtos/{safe_filename}"


    def home_index(self):
        """Exibe a página inicial do site (vitrine de produtos)."""
       
        produtos = self.produto_service.get_all_produtos()
        
        return self.render(
            'home',
            produtos=produtos,
            search_query=None,
            min_price=None,
            max_price=None
        )

    def list_produtos(self):
       
        produtos = self.produto_service.get_all_produtos()
        
        return self.render(
            'produto_lista', 
            produtos=produtos,
            search_query=None,
            min_price=None,
            max_price=None
        )

    
    def search_produtos_route(self):
        name_query = request.query.get('name')
        
        try:
            price_min = float(request.query.get('min_price')) if request.query.get('min_price') else None
            price_max = float(request.query.get('max_price')) if request.query.get('max_price') else None
            
        except ValueError:
            produtos = self.produto_service.get_all_produtos()
           
            
            return self.render('produto_lista', produtos=produtos, error="Erro: Preço mínimo ou máximo inválido.", search_query=name_query, min_price=price_min, max_price=price_max)

        produtos = self.produto_service.search_produtos(name_query, price_min, price_max)
        
        
        return self.render('produto_lista', produtos=produtos, search_query=name_query, min_price=price_min, max_price=price_max)


    def add_produto(self):
        if request.method == 'GET':
            return self.render('produto_cadastro', produto=None, action="/produtos/add")
        else:
            try:
                current_user = self.get_current_user()
                if not current_user:
                    return self.redirect('/login')
                
                uploaded_file = request.files.get('image_file')
                image_url = self._save_uploaded_file(uploaded_file)
                
                produto_data = {
                    'name': request.forms.get('name'),
                    'description': request.forms.get('description'),
                    'price': float(request.forms.get('price')),
                    'stock_quantity': int(request.forms.get('stock_quantity')),
                    'image_url': image_url
                }
                
                self.produto_service.create_produto(produto_data, owner_id=current_user.id)
                return self.redirect('/produtos')
                
            except Exception as e:
                error_message = f"Erro ao salvar: {e}"
                temp_produto = produto(
                    id=0, 
                    name=request.forms.get('name', ''),
                    description=request.forms.get('description', ''),
                    price=0.0,
                    stock_quantity=0,
                    owner_id=None,
                    image_url=''
                )
                return self.render('produto_cadastro', produto=temp_produto, action="/produtos/add", error=error_message)


    def edit_produto(self, produto_id):
        produto_obj = self.produto_service.get_produto_by_id(produto_id)
        if not produto_obj:
            return "Produto não encontrado"

        if request.method == 'GET':
            return self.render('produto_cadastro', produto=produto_obj, action=f"/produtos/edit/{produto_id}")
        else:
            try:
                uploaded_file = request.files.get('image_file')
                new_image_url = self._save_uploaded_file(uploaded_file)
                
                final_image_url = new_image_url if new_image_url else produto_obj.image_url
                
                produto_data = {
                    'name': request.forms.get('name'),
                    'description': request.forms.get('description'),
                    'price': float(request.forms.get('price')),
                    'stock_quantity': int(request.forms.get('stock_quantity')),
                    'image_url': final_image_url
                }
                self.produto_service.update_produto(produto_id, produto_data)
                return self.redirect('/produtos')
            except Exception as e:
                error_message = f"Erro: {e}"
                return self.render('produto_cadastro', produto=produto_obj, action=f"/produtos/edit/{produto_id}", error=error_message)

    def view_produto_details(self, produto_id: int):
        produto_obj = self.produto_service.get_produto_by_id(produto_id)
        if not produto_obj:
            return "Produto não encontrado", 404
        return self.render('produto_detalhe', produto=produto_obj)


    def delete_produto(self, produto_id):
        self.produto_service.delete_produto(produto_id)
        self.redirect('/produtos')

produto_routes = Bottle()
produto_controller = ProdutoController(produto_routes)