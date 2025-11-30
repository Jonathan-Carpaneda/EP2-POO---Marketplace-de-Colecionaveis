from bottle import Bottle, request
from .base_controller import BaseController

from services.produto_service import ProdutoService 


class ProdutoController(BaseController): 
    def __init__(self, app):
        super().__init__(app)

        self.setup_routes()
        
        self.produto_service = ProdutoService()


    def setup_routes(self):
        self.app.route('/produtos', method='GET', callback=self.list_produtos)
        self.app.route('/produtos/search', method='GET', callback=self.search_produtos_route) 
        self.app.route('/produtos/add', method=['GET', 'POST'], callback=self.add_produto)
        self.app.route('/produtos/edit/<produto_id:int>', method=['GET', 'POST'], callback=self.edit_produto)
        self.app.route('/produtos/delete/<produto_id:int>', method='POST', callback=self.delete_produto)


    def list_produtos(self):
        produtos = self.produto_service.get_all()
        
        return self.render('produto_lista', produtos=produtos)

    
    def search_produtos_route(self):
        name_query = request.query.get('name')
        
        try:
            price_min = float(request.query.get('min_price')) if request.query.get('min_price') else None
            price_max = float(request.query.get('max_price')) if request.query.get('max_price') else None
        except ValueError:
            produtos = self.produto_service.get_all()
           
            return self.render('produto_lista', produtos=produtos, error="Erro: Preço mínimo ou máximo inválido.", search_query=name_query)

        produtos = self.produto_service.search_produtos(name_query, price_min, price_max)
        
        
        return self.render('produto_lista', produtos=produtos, search_query=name_query, min_price=price_min, max_price=price_max)


    def add_produto(self):
        if request.method == 'GET':
            
            return self.render('produto_cadastro', produto=None, action="/produtos/add")
        else:
           
            success, message = self.produto_service.save()
            if success:
                self.redirect('/produtos')
            else:
               
                return self.render('produto_cadastro', produto=None, action="/produtos/add", error=message)


    def edit_produto(self, produto_id):
        produto = self.produto_service.get_by_id(produto_id)
        if not produto:
            return "Produto não encontrado"

        if request.method == 'GET':
            
            return self.render('produto_cadastro', produto=produto, action=f"/produtos/edit/{produto_id}")
        else:
           
            success, message = self.produto_service.edit_produto(produto)
            if success:
                self.redirect('/produtos')
            else:
               
                return self.render('produto_cadastro', produto=produto, action=f"/produtos/edit/{produto_id}", error=message)


    def delete_produto(self, produto_id):
        self.produto_service.delete_produto(produto_id)
        self.redirect('/produtos')



produto_routes = Bottle()
produto_controller = ProdutoController(produto_routes)