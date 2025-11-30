from bottle import Bottle, request
from .base_controller import BaseController
from services.produto_service import ProductService

class ProductController(BaseController):
    def __init__(self, app):
        super().__init__(app)

        self.setup_routes()
        self.product_service = ProductService()


    # Rotas Produto
    def setup_routes(self):
        self.app.route('/products', method='GET', callback=self.list_products)
        self.app.route('/products/add', method=['GET', 'POST'], callback=self.add_product)
        self.app.route('/products/edit/<product_id:int>', method=['GET', 'POST'], callback=self.edit_product)
        self.app.route('/products/delete/<product_id:int>', method='POST', callback=self.delete_product)


    def list_products(self):
        products = self.product_service.get_all()
        # Assume que você tem um template chamado 'products'
        return self.render('products', products=products)


    def add_product(self):
        if request.method == 'GET':
            # Assume que você tem um template chamado 'product_form'
            return self.render('product_form', product=None, action="/products/add")
        else:
            # POST - salvar produto
            success, message = self.product_service.save()
            if success:
                self.redirect('/products')
            else:
                # Se houver erro, re-renderiza o formulário com a mensagem de erro
                return self.render('product_form', product=None, action="/products/add", error=message)


    def edit_product(self, product_id):
        product = self.product_service.get_by_id(product_id)
        if not product:
            return "Produto não encontrado"

        if request.method == 'GET':
            return self.render('product_form', product=product, action=f"/products/edit/{product_id}")
        else:
            # POST - salvar edição
            success, message = self.product_service.edit_product(product)
            if success:
                self.redirect('/products')
            else:
                # Se houver erro, re-renderiza o formulário com a mensagem de erro
                return self.render('product_form', product=product, action=f"/products/edit/{product_id}", error=message)


    def delete_product(self, product_id):
        self.product_service.delete_product(product_id)
        self.redirect('/products')


# O ponto de entrada para o Bottle
product_routes = Bottle()
product_controller = ProductController(product_routes)