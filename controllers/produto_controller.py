from bottle import Bottle, request
from .base_controller import BaseController
from services.produto_service import produtoService

class produtoController(BaseController):
    def __init__(self, app):
        super().__init__(app)

        self.setup_routes()
        self.produto_service = produtoService()


    # Rotas Produto
    def setup_routes(self):
        self.app.route('/produtos', method='GET', callback=self.list_produtos)
        self.app.route('/produtos/add', method=['GET', 'POST'], callback=self.add_produto)
        self.app.route('/produtos/edit/<produto_id:int>', method=['GET', 'POST'], callback=self.edit_produto)
        self.app.route('/produtos/delete/<produto_id:int>', method='POST', callback=self.delete_produto)


    def list_produtos(self):
        produtos = self.produto_service.get_all()
        # Assume que você tem um template chamado 'produtos'
        return self.render('produtos', produtos=produtos)


    def add_produto(self):
        if request.method == 'GET':
            # Assume que você tem um template chamado 'produto_form'
            return self.render('produto_form', produto=None, action="/produtos/add")
        else:
            # POST - salvar produto
            success, message = self.produto_service.save()
            if success:
                self.redirect('/produtos')
            else:
                # Se houver erro, re-renderiza o formulário com a mensagem de erro
                return self.render('produto_form', produto=None, action="/produtos/add", error=message)


    def edit_produto(self, produto_id):
        produto = self.produto_service.get_by_id(produto_id)
        if not produto:
            return "Produto não encontrado"

        if request.method == 'GET':
            return self.render('produto_form', produto=produto, action=f"/produtos/edit/{produto_id}")
        else:
            # POST - salvar edição
            success, message = self.produto_service.edit_produto(produto)
            if success:
                self.redirect('/produtos')
            else:
                # Se houver erro, re-renderiza o formulário com a mensagem de erro
                return self.render('produto_form', produto=produto, action=f"/produtos/edit/{produto_id}", error=message)


    def delete_produto(self, produto_id):
        self.produto_service.delete_produto(produto_id)
        self.redirect('/produtos')


# O ponto de entrada para o Bottle
produto_routes = Bottle()
produto_controller = produtoController(produto_routes)