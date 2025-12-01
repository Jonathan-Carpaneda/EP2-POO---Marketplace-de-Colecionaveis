%rebase('layout', title='Gestão de Usuários')

<section class="users-section">
    <div class="section-header">
        <h1 class="section-title"><i class="fas fa-users"></i> Gestão de Usuários</h1>
        <a href="/users/add" class="btn btn-primary">
            <i class="fas fa-plus"></i> Novo Usuário
        </a>
    </div>

    <div class="table-container">
        <table class="styled-table">

            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tipo</th>
                    <th>Nome / Loja</th>
                    <th>CPF / CNPJ</th>
                    <th>Email</th>
                    <th>Telefone</th>
                    <th>Ações</th>
                </tr>
            </thead>

            <tbody>
                % for u in users:
                <tr>
                    <td>{{u.id}}</td>

                    <td>
                        % if u.user_type == 'PF':
                        <span class="user-tag tag-pf">PF</span>
                        % else:
                        <span class="user-tag tag-pj">Lojista</span>
                        % end
                    </td>

                    <td>
                        % if u.user_type == 'PF':
                            {{u.name}}
                        % else:
                            {{u.shop_name if u.shop_name else '-'}}
                        % end
                    </td>

                    <td>
                        % if u.user_type == 'PF':
                            {{u.cpf if u.cpf else '-'}}
                        % else:
                            {{u.cnpj if u.cnpj else '-'}}
                        % end
                    </td>

                    <td><a href="mailto:{{u.email}}">{{u.email}}</a></td>
                    
                    <td>{{u.phone if u.phone else '-'}}</td>

                    <td class="actions">
                        <a href="/users/edit/{{u.id}}" class="btn btn-sm btn-edit">
                            <i class="fas fa-edit"></i> Editar
                        </a>

                        <form action="/users/delete/{{u.id}}" method="post"
                              onsubmit="return confirm('Tem certeza?')">
                            <button type="submit" class="btn btn-sm btn-danger">
                                <i class="fas fa-trash-alt"></i> Excluir
                            </button>
                        </form>
                    </td>
                </tr>
                % end
            </tbody>
        </table>
    </div>
</section>