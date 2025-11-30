from bottle import Bottle
from controllers.user_controller import user_routes
from controllers.produto_controller import produto_routes

def init_controllers(app: Bottle):
    app.merge(user_routes)
    app.merge(produto_routes)