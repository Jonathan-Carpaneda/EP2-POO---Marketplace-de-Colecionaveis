from bottle import Bottle, request
from .base_controller import BaseController
from services.produto_service import produtoervice

class produtoController(BaseController):
    def __init__(self, app):
        super().__init__(app)

        self.setup_routes()
        self.produto_service = produtoervice()


    
    def setup_routes(self):
        self.app.route('/produto', method='GET', callback=self.list_produto)
        self.app.route('/produto/add', method=['GET', 'POST'], callback=self.add_produto)
        self.app.route('/produto/edit/<produto_id:int>', method=['GET', 'POST'], callback=self.edit_produto)
        self.app.route('/produto/delete/<produto_id:int>', method='POST', callback=self.delete_produto)


    def list_produto(self):
        produto = self.produto_service.get_all()
        
        return self.render('produto', produto=produto)


    def add_produto(self):
        if request.method == 'GET':
            
            return self.render('produto_form', produto=None, action="/produto/add")
        else:
           
            success, message = self.produto_service.save()
            if success:
                self.redirect('/produto')
            else:
                
                return self.render('produto_form', produto=None, action="/produto/add", error=message)


    def edit_produto(self, produto_id):
        produto = self.produto_service.get_by_id(produto_id)
        if not produto:
            return "Produto não encontrado"

        if request.method == 'GET':
            return self.render('produto_form', produto=produto, action=f"/produto/edit/{produto_id}")
        else:
           
            success, message = self.produto_service.edit_produto(produto)
            if success:
                self.redirect('/produto')
            else:
               
                return self.render('produto_form', produto=produto, action=f"/produto/edit/{produto_id}", error=message)


    def delete_produto(self, produto_id):
        self.produto_service.delete_produto(produto_id)
        self.redirect('/produto')



produto_routes = Bottle()
produto_controller = produtoController(produto_routes)